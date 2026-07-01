# 详细设计（v13）

## 概述

完成 P4-3 首批 quaternion 测试补充（G28/G29/G30）+ G24/G27 ✅ 标记。全部变更限于测试文件和文档标记，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/ext/quaternion_common_test.cj:230` 之后追加 | 新增 5 个测试函数 | G28: 3 个 slerp 新测试; G29: 2 个 mix clamp 新测试 |
| `tests/glm/ext/quaternion_trigonometric_test.cj:74` 之后追加 | 新增 1 个测试函数 | G30: axis round-trip 测试 |
| `docs/diag/impl/04_diag.md:326,346,352,359,366` | 修改 | G24/G27/G28/G29/G30 添加 `✅ 已修复` |
| `harness/implements/202606301007_fix_04_diag/plan.md:25` | 修改 | 路线表 v13 列 P4-3 标记 ✅（已存在，确认无遗漏） |

## 类型定义

无新增/修改类型。仅新增测试函数。

### G28: quaternion_common_test.cj 新增 3 个 slerp 测试

#### testSlerpMidpoint

```cangjie
@Test
func testSlerpMidpoint(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = slerp(x, y, 0.5)
    // 正交单位四元数 dot=0, θ=π/2
    // slerp(a=0.5) 中点 = x/sqrt(2) + y/sqrt(2) = normalize(x+y)
    // x+y = (1,1,0,0), normalize → (1/√2, 1/√2, 0, 0) ≈ (0.70710678, 0.70710678, 0, 0)
    @Expect((r.x - 0.70710678).abs() < 1e-6, true)
    @Expect((r.y - 0.70710678).abs() < 1e-6, true)
    @Expect(r.z.abs() < 1e-6, true)
    @Expect(r.w.abs() < 1e-6, true)
}
```

与已有 testSlerp 的区别：testSlerp 只验证 a=0 和 a=1 端点。此测试验证 a=0.5 中点值与解析解一致。

#### testSlerpDegenerate

```cangjie
@Test
func testSlerpDegenerate(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    // y 为接近 x 的单位四元数: (cos(θ/2), sin(θ/2), 0, 0), θ=0.001
    // dot ≈ cos(0.0005) ≈ 0.999999875, 触发 sinOmega < epsilon 退化分支
    let y = Quat<Float64, Defaultp>(cosT(0.0005), sinT(0.0005), 0.0, 0.0)
    let s = slerp(x, y, 0.5)
    let l = lerp(x, y, 0.5)
    // cosT(0.0005) 和 sinT(0.0005) 需用具体值展开，也可直接计算
    // 退化分支返回 x*(1-a) + y*a，与 lerp 相同公式
    // 验证 slerp 各分量接近 lerp，容差 1e-6
    @Expect((s.x - l.x).abs() < 1e-6, true)
    @Expect((s.y - l.y).abs() < 1e-6, true)
    @Expect((s.z - l.z).abs() < 1e-6, true)
    @Expect((s.w - l.w).abs() < 1e-6, true)
}
```

注意：`cosT`/`sinT` 并非测试文件已有 import 中的直接符号。测试文件中 `slerp`/`lerp` 通过 `package glm.ext` 自动可见，但 `cosT`/`sinT` 不可见。需使用数值字面量构造 y，或补充 import。推荐：直接使用 `cosT`/`sinT` 函数并补充 import，或预计算数值。

**实现方案选择**（由编码 agent 决定）：
- 方案 A：预计算 `cos(0.0005)` 和 `sin(0.0005)` 的 Float64 值作为字面量，无需额外 import
- 方案 B：补充 import of `cosT`/`sinT` from `glm.detail`，在测试函数内计算

#### testSlerpNegateBranch

```cangjie
@Test
func testSlerpNegateBranch(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    // 点积为负的单位四元数: ||(0.6, -0.8, 0, 0)|| = 1, dot = 0.6 > 0
    // 需 dot < 0: 使用 (-0.5, 0.5, 0.5, 0.5), dot = -0.5
    let y = Quat<Float64, Defaultp>(-0.5, 0.5, 0.5, 0.5)
    // cosTheta = dot(x,y) = -0.5 < 0, slerp 应对 y 取反后插值
    // 验证 slerp(x, y, 0.5) == slerp(x, -y, 0.5)
    let r1 = slerp(x, y, 0.5)
    let r2 = slerp(x, Quat<Float64, Defaultp>(0.5, -0.5, -0.5, -0.5), 0.5)
    @Expect((r1.x - r2.x).abs() < 1e-10, true)
    @Expect((r1.y - r2.y).abs() < 1e-10, true)
    @Expect((r1.z - r2.z).abs() < 1e-10, true)
    @Expect((r1.w - r2.w).abs() < 1e-10, true)
}
```

与已有 `testSlerpShortestPath` 的区别：该测试使用 a=0.25，此测试使用 a=0.5（中点），提供了不同插值位置上的验证覆盖。

### G29: quaternion_common_test.cj 新增 2 个 mix clamp 测试

`mix` 实现内含 `clamp(a, zero, one)`，当 a<0 时 clamp 到 0，a>1 时 clamp 到 1。

#### testMixClampBelow

```cangjie
@Test
func testMixClampBelow(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = mix(x, y, -0.5)
    // a=-0.5 clamp to 0, 结果等于 x
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
    @Expect(r.z, 3.0)
    @Expect(r.w, 4.0)
}
```

#### testMixClampAbove

```cangjie
@Test
func testMixClampAbove(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = mix(x, y, 1.5)
    // a=1.5 clamp to 1, 结果等于 y
    @Expect(r.x, 5.0)
    @Expect(r.y, 6.0)
    @Expect(r.z, 7.0)
    @Expect(r.w, 8.0)
}
```

### G30: quaternion_trigonometric_test.cj 新增 1 个 axis round-trip 测试

#### testAxisAngleAxisRoundtrip

```cangjie
@Test
func testAxisAngleAxisRoundtrip(): Unit {
    let theta = 0.7853981633974483
    let axisVec = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let q = angleAxis(theta, axisVec)
    let a = axis(q)
    // 验证 axis(result) 与原始 axisVec 方向一致: 点积 > 1 - eps
    let dotResult = a.x * axisVec.x + a.y * axisVec.y + a.z * axisVec.z
    @Expect(dotResult > 0.999999, true)
}
```

与已有 `testAngleAngleAxisRoundtrip`（验证 angle round-trip）互补。此测试验证 axis round-trip。注意 `axis` 函数（`quaternion_trigonometric.cj` 中）与测试函数同名，但在不同文件中不冲突。

## 错误处理

全部为新增测试，不涉及错误处理逻辑变更。slerp 退化分支测试中的 `cosT`/`sinT` 调用需确保正确的 import 可见性。

## 行为契约

- 全部变更限于测试文件，不改变生产代码行为
- G28 新增 3 个测试函数放在 `quaternion_common_test.cj` 末尾（`:230` 之后）
- G29 新增 2 个测试函数放在 `quaternion_common_test.cj` 末尾，延续 G28 之后
- G30 新增 1 个测试函数放在 `quaternion_trigonometric_test.cj` 末尾（`:74` 之后）
- `04_diag.md` 更新仅修改 G24/G27/G28/G29/G30 行添加 `✅ 已修复`，不改变诊断内容结构
- `plan.md` 路线表 v13 列 P4-3 确认已标记 ✅

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `quaternion_common_test.cj` | 无（可选：`cosT`/`sinT` from `glm.detail`，取决于 testSlerpDegenerate 实现方案） | 现有 import 已覆盖 `Quat`/`Defaultp`，`slerp`/`mix`/`lerp` 通过 `package glm.ext` 自动可见 |
| `quaternion_trigonometric_test.cj` | 无 | 已有 `Vec3`/`Quat`/`Defaultp` import，`angleAxis`/`axis` 通过 `package glm.ext` 自动可见 |
| `04_diag.md` | 无 | 纯文本标记 |
| `plan.md` | 无 | 纯文本标记（v13 列 P4-3 ✅ 已存在） |
