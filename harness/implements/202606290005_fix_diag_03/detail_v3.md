# 详细设计（v3）

## 概述

修复 `type_quat_cast_s1_test.cj` 中 3 个 W-branch 测试因 Float64 浮点精度略超 `epsilonOf`（2.22e-16）导致的失败。添加包级辅助函数 `mat3EqualEpsilonRelaxed`，将容忍度放宽至 `epsilon<Float64>() * 100.0`（~2.22e-14），既容纳 sqrt+除法+减法乘法链产生的约 2.5e-16 舍入误差，又保持充分的精度验证。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/detail/type_quat_cast_s1_test.cj` | 修改 | 添加 `mat3EqualEpsilonRelaxed` 辅助函数；7 个 `@Test` 断言替换为调用该函数 |

## 新增辅助函数

### `mat3EqualEpsilonRelaxed`

**形态**：包级顶层函数（非 extend）
**包路径**：`glm.detail`（与测试文件同包）

```cangjie
func mat3EqualEpsilonRelaxed(a: Mat3x3<Float64, Defaultp>, b: Mat3x3<Float64, Defaultp>): Bool {
    let eps = epsilon<Float64>() * 100.0
    func comp(x: Float64, y: Float64): Bool {
        let d = x - y
        let z = x - x
        let ad = if (d < z) { -d } else { d }
        ad <= eps
    }
    comp(a.c0.x, b.c0.x) && comp(a.c0.y, b.c0.y) && comp(a.c0.z, b.c0.z) &&
    comp(a.c1.x, b.c1.x) && comp(a.c1.y, b.c1.y) && comp(a.c1.z, b.c1.z) &&
    comp(a.c2.x, b.c2.x) && comp(a.c2.y, b.c2.y) && comp(a.c2.z, b.c2.z)
}
```

**签名推导**：
- 使用 `epsilon<Float64>()` 而非 `epsilonOf` 带参数版本——`epsilon<T>()` 已在 `scalar_constants.cj:5` 中定义为 `T <: FloatingPoint<T>`，无需提供 hint 值
- 使用手动绝对值计算（`if (d < z) { -d } else { d }`）而非调用 `glm.detail.common` 包中的 `abs`——后者是未实现的桩代码（`throw Exception("stub")`）；包级函数 `mat3EqualEpsilonRelaxed` 与测试文件同包 `glm.detail`，若直接写 `abs(...)` 会解析到桩函数导致运行时异常，因此嵌入闭包 `comp` 避免引入额外依赖和 import
- 将绝对值计算封装为局部闭包 `comp`，减少重复代码：对 9 个分量调用 `comp`，而非 9 处独立书写 `if (d < z) { -d } else { d }` 模式
- 固定 `Float64`/`Defaultp` 类型特化（测试中仅为该类型组合），无需泛型化

## 断言替换

所有 7 个 `@Test` 中形如：
```cangjie
@Expect(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2), true)
```
统一替换为：
```cangjie
@Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
```

### 逐测试变更

| 序号 | 测试函数 | 当前断言 | 修改后断言 | 变量调整 |
|------|---------|---------|-----------|---------|
| 1 | `testS1QuatCastScalingXBranch` | `m0.c0.equalEpsilon(m1.c0) && ...` | `mat3EqualEpsilonRelaxed(m0, m1)` | `m1` 已存在，无变化 |
| 2 | `testS1QuatCastScalingYBranch` | 同上 | 同上 | 同上 |
| 3 | `testS1QuatCastScalingZBranch` | 同上 | 同上 | 同上 |
| 4 | `testS1QuatCastScalingWBranch` | 同上 | 同上 | 同上 |
| 5 | `testS1QuatCastUnitRoundTrip` | 同上 | 同上 | 同上 |
| 6 | `testS1QuatCastIdentityRoundTrip` | `m.c0.equalEpsilon(m2.c0) && ...` | `mat3EqualEpsilonRelaxed(m, m2)` | 无 |
| 7 | `testS1QuatCastMat4Delegation` | `m0.c0.equalEpsilon(m1.c0) && ...` | `mat3EqualEpsilonRelaxed(m0, m1)` | `m1` 已存在，无变化 |

## 行为契约

### 前置条件
- 所有测试中 `m0`/`m1`/`m`/`m2` 均为 `Mat3x3<Float64, Defaultp>` 类型
- `epsilon<Float64>()` 返回 `2.220446049250313e-16`
- 辅助函数 `abs` 对 `Float64` 可正常调用

### 后置条件
- 7 个 `@Test` 全部 PASS
- round-trip 等价性断言 `quatCast(mat3Cast(q)) ≈ q` 覆盖所有四元数分量和分支路径
- 容忍度 2.22e-14 远小于使用场景中可接受的精度要求

## 错误处理

本次修改不涉及错误处理。所有断言保持 `@Expect(expr, true)` 形式不变。

## 依赖关系

- **被修改文件**：`cjglm/src/detail/type_quat_cast_s1_test.cj`
- **依赖的已有函数**：
  - `epsilon<T>(): T where T <: FloatingPoint<T>`（`scalar_constants.cj:5`）
  - `Mat3x3<T, Q>` 的 `.c0`/`.c1`/`.c2` 字段及 `.x`/`.y`/`.z` 分量访问
- **本次不依赖**：`glm.detail.common` 中的 `abs`（该函数为桩代码 `throw Exception("stub")`，不可用）；改用内嵌局部闭包 `comp` 中的手动绝对值计算，不引入额外依赖

## 修订说明（v3 R1）

| 审查意见 | 修改措施 |
|---------|---------|
| R2 验证失败：3 个 W-branch 测试因 Float64 浮点精度超 `epsilonOf`（2.22e-16）失败 | 从基于 `Vec3.equalEpsilon`（间接使用 `ComputeEqualNumeric.callConst`，容忍度 = `epsilonOf`）的逐列比较，改为自定义 `mat3EqualEpsilonRelaxed`，使用 `epsilon<Float64>() * 100.0`（2.22e-14）作为容忍度 |

## 修订说明（v3 R1 — 二次修订，回应审查意见）

| 审查意见 | 修改措施 |
|---------|---------|
| 设计使用 `common.cj` 中的 `abs` 函数，但该函数是未实现的桩代码（`throw Exception("stub")`），调用时会抛出异常 | 将 `mat3EqualEpsilonRelaxed` 实现从 `abs(...)` 改为内嵌局部闭包 `comp`，使用 `if (d < z) { -d } else { d }` 手动绝对值计算；更新"签名推导"说明理由；移除依赖关系中 `abs` 的引用并注明不可用原因 |
