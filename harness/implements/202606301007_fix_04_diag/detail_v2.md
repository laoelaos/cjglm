# 详细设计（v2）

## 概述

修复 P1 批次 5 个子任务：S1 靶向验证、P1-2（S2+G7）float_distance 溢出+NaN/Inf、P1-3（G10）slerp 公式+最短路径、P1-4（G1）roundEven 分支反转、P1-5（S3+S4）测试期望值修正。覆盖 `docs/diag/impl/04_diag.md` P1 优先级全部问题。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/gtc/ulp.cj:51-57` | 修改 | float_distance 改用 `@OverflowWrapping` + 位重解释 + NaN/Inf 前置检查 |
| `cjglm/src/ext/quaternion_common.cj:42-71` | 修改 | 两参数和四参数 slerp 补充 cosTheta<0 最短路径分支，修正四参数公式 |
| `cjglm/src/detail/common.cj:176-179` | 修改 | roundEven 奇偶分支反转 |
| `cjglm/tests/glm/ext/quaternion_transform_test.cj:68-69` | 修改 | S3 测试期望值修正 |
| `cjglm/tests/glm/gtc/matrix_transform_test.cj:107-108` | 修改 | S4 测试期望值修正 |
| `cjglm/tests/glm/gtc/ulp_test.cj:28` | 修改 | float_distance 改为无符号绝对值后同步修正期望值 |
| `cjglm/tests/glm/ext/matrix_transform_test.cj` | 靶向验证 | S1 靶向编译+运行（P1-1） |
| `docs/diag/impl/04_diag.md` | 修改 | 每完成一个子任务标记对应条目 ✅ 已修复 |

## P1-1: S1 靶向验证

**职责**：验证 ext/matrix_transform.cj rotate/shear 乘法顺序修正（v1 已应用代码变更）。靶向编译并运行 `tests/glm/ext/matrix_transform_test.cj`，确认测试通过。然后更新 `docs/diag/impl/04_diag.md` 中 S1 条目标注为"已修复"。

**操作**：
1. 运行 `cjpm test --file=tests/glm/ext/matrix_transform_test.cj`（或等效靶向命令）
2. 若靶选命令不可用，尝试单文件编译+执行：`cjc tests/glm/ext/matrix_transform_test.cj -o test_s1 && ./test_s1`
3. 若存在超时，简化测试输入（减少矩阵维数或浮点类型变体）

**当前代码状态**（v1 已验证）：
- `ext/matrix_transform.cj:39` ：已改为 `m * Rot`
- `ext/matrix_transform.cj:63` ：已改为 `m * H`
- 测试文件已包含 4 个 S1 验证测试（含左乘语义验证）

**04_diag.md 标记**：在 S1 条目末尾追加 `✅ 已修复`

## P1-2: S2+G7 float_distance 溢出修复 + NaN/Inf 前置检查

### 修改文件
`cjglm/src/gtc/ulp.cj:51-57`

### 当前代码
```cangjie
public func float_distance(x: Float32, y: Float32): Int32 {
    (y.toBits() as Int32).getOrThrow() - (x.toBits() as Int32).getOrThrow()
}

public func float_distance(x: Float64, y: Float64): Int64 {
    (y.toBits() as Int64).getOrThrow() - (x.toBits() as Int64).getOrThrow()
}
```

### 问题
- S2：`(y.toBits() as Int32)` 在 UInt32 值 > Int32.Max（0x80000000-0xFFFFFFFF）时数值转型抛异常。仓颉默认 `@OverflowThrowing`，对负浮点位模式（即 UInt32 >= 2³¹）的 `as Int32` 转型报错
- G7：float_distance 无 NaN/Inf 前置检查，而同文件 next_float/prev_float/ulp 均有 NaN/Inf 检查。负 NaN 位模式 0xFFC00000 = 4290772992 超出 Int32.Max 范围

### 修改方案

使用 `@OverflowWrapping` + `(UInt32 as Int32)` 位重解释替代数值转型，加 `abs()` 返回无符号绝对值。`@OverflowWrapping` 已在同一代码库广泛使用（`quaternion_common.cj:15`、`scalar_quat_ops.cj`、`type_vec2.cj` 等），无需担心编译问题。

**原理**：在 wrapping 语义下 `(UInt32 as Int32)` 对 > Int32.Max 的值回绕（wrap）为对应负值，等价于 IEEE 754 位模式的符号位重解释。GLM 1.0.3 `gtc/ulp.inl:85-99` 使用 `float_t` 联合体实现相同效果。

### 修改后代码

**方案签名与实现**：

```cangjie
// 需要新增 import: import glm.detail.{ abs }

@OverflowWrapping
public func float_distance(x: Float32, y: Float32): Int32 {
    if (x.isNaN() || x.isInf() || y.isNaN() || y.isInf()) { return Int32.Max }
    let a = (x.toBits() as Int32)
    let b = (y.toBits() as Int32)
    abs(a - b)
}

@OverflowWrapping
public func float_distance(x: Float64, y: Float64): Int64 {
    if (x.isNaN() || x.isInf() || y.isNaN() || y.isInf()) { return Int64.Max }
    let a = (x.toBits() as Int64)
    let b = (y.toBits() as Int64)
    abs(a - b)
}
```

**注意**：
- `(x.toBits() as Int32)` 在 `@OverflowWrapping` 下是直接的位重解释（对 UInt32 ≥ 2³¹ 回绕为负 Int32），等价于 C++ `reinterpret_cast<int32_t>(float_bits)`
- `abs(a - b)` 返回无符号绝对值——与 GLM 1.0.3 一致。`abs` 来自 `glm.detail`
- `@OverflowWrapping` 影响函数内所有整数运算：`(UInt32 as Int32)` 的转型回绕、`a - b` 的减法溢出、`abs` 内部的 `-a`
- `abs(Int32.Min)` 在 wrapping 下返回 `Int32.Min`（`-(-2³¹)` 回绕为 `-2³¹`），与 C++ 无符号溢出 UB 行为一致。对于正常浮点输入（非临界跨越），差值不会达到 ±2³¹

### import 变更
`cjglm/src/gtc/ulp.cj` 当前无 import，需要新增：
```cangjie
import glm.detail.{ abs }
```

### 测试影响
`tests/glm/gtc/ulp_test.cj:28`：
```cangjie
// 当前：@Expect(float_distance(nf, x), Int32(-1))
// 修改后返回无符号绝对值：@Expect(float_distance(nf, x), Int32(1))
```

其余 ulp_test 测试用例的期望值不受影响（`float_distance(x, nf)` 已为 `Int32(1)`，`float_distance(pf, x)` 为 `Int32(1)`，`float_distance(0.0, next_float(0.0))` 为 `Int32(1)`）。

## P1-3: G10 slerp 公式 + 最短路径分支

### 修改文件
`cjglm/src/ext/quaternion_common.cj:42-71`

### 当前代码
```cangjie
// 两参数 slerp (line 42-56)
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let cosOmega = clamp(dot(x, y), -one, one)
    let omega = acos(cosOmega)
    let sinOmega = sinT(omega)
    if (sinOmega < epsilon<T>()) {
        x * (one - a) + y * a
    } else {
        let scale0 = sinT((one - a) * omega) / sinOmega
        let scale1 = sinT(a * omega) / sinOmega
        x * scale0 + y * scale1
    }
}

// 四参数 slerp(k) (line 58-71)
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let cosOmega = clamp(dot(x, y), -one, one)
    let omega = acos(cosOmega)
    let sinOmega = sinT(omega)
    if (sinOmega < epsilon<T>()) {
        x * (one - a) + y * a
    } else {
        let scale0 = sinT((one - a) * omega / k) / sinT(omega / k)
        let scale1 = sinT(a * omega / k) / sinT(omega / k)
        x * scale0 + y * scale1
    }
}
```

### 问题
- **G10-①（两参数 slerp）**：缺少 `cosTheta < 0` 最短路径分支。GLM 1.0.3 `ext/quaternion_common.inl:51-55` 当 `cosTheta < 0` 时对 y 取反并将 cosTheta 取反，确保插值走最短路径
- **G10-②（四参数 slerp(k) 公式错误）**：当前使用 `sin((1-a)*ω/k)/sin(ω/k)`，GLM 1.0.3 `ext/quaternion_common.inl:106-108` 使用 `phi = ω + k*π; scale0 = sin(ω - a*phi)/sin(ω); scale1 = sin(a*phi)/sin(ω)`
- **G10-③（四参数 slerp(k) 缺少最短路径）**：同样缺少 `cosTheta < 0` 分支

### import 变更
需要新增 `pi` 到 import 列表：
```cangjie
// 当前 import 行
import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot }
// 修改后
import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot, pi }
```

### 修改后代码

**两参数 slerp**：
```cangjie
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    var z = y
    var cosOmega = dot(x, y)
    if (cosOmega < zero) { z = -y; cosOmega = -cosOmega }
    cosOmega = clamp(cosOmega, -one, one)
    let omega = acos(cosOmega)
    let sinOmega = sinT(omega)
    if (sinOmega < epsilon<T>()) {
        x * (one - a) + z * a
    } else {
        let scale0 = sinT((one - a) * omega) / sinOmega
        let scale1 = sinT(a * omega) / sinOmega
        x * scale0 + z * scale1
    }
}
```

**关键语义澄清**：
- `cosOmega` 声明由 `let` 改为 `var`，因为最短路径分支中需要对它取反
- 执行顺序：(1) `var cosOmega = dot(x, y)`; (2) if `cosOmega < zero`: `z = -y; cosOmega = -cosOmega`; (3) `cosOmega = clamp(cosOmega, -one, one)`
- `z` 用于替代 `y`，便于在最短路径中取反。`y` 参数本身保持不可变
- clamp 在 cosTheta 符号翻转**之后**执行，确保 clamp 作用于翻转后的非负 cosTheta 值

**四参数 slerp(k)**：
```cangjie
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    var z = y
    var cosOmega = dot(x, y)
    if (cosOmega < zero) { z = -y; cosOmega = -cosOmega }
    cosOmega = clamp(cosOmega, -one, one)
    let omega = acos(cosOmega)
    let sinOmega = sinT(omega)
    if (sinOmega < epsilon<T>()) {
        x * (one - a) + z * a
    } else {
        let phi = omega + k * pi<T>()
        let scale0 = sinT(omega - a * phi) / sinOmega
        let scale1 = sinT(a * phi) / sinOmega
        x * scale0 + z * scale1
    }
}
```

**公式依据**：GLM 1.0.3 `ext/quaternion_common.inl:106-108`：
```cpp
T angle = acos(cosTheta);
T phi = angle + static_cast<T>(k) * glm::pi<T>();
return (sin(angle - a * phi) * x + sin(a * phi) * z) / sin(angle);
```

## P1-4: G1 roundEven 分支反转

### 修改文件
`cjglm/src/detail/common.cj:176-179`

### 当前代码
```cangjie
if (rInt % 2 == 0) {
    r - one
} else {
    r
}
```

### 修改后
```cangjie
if (rInt % 2 == 0) {
    r
} else {
    r - one
}
```

### 语义说明
- `round(even)(x)` 要求"round half to even"：当 `frac(x) = 0.5` 时，取最近的偶整数
- 当前代码在 `rInt` 为偶数时返回 `r - 1`（远离偶数），奇数时返回 `r`——行为反向
- 修复后：`rInt` 为偶数时返回 `r`（保持偶数），奇数时返回 `r - 1`（调整为偶数）
- 例：`roundEven(2.5)` → `round(2.5) = 3`（Cangjie round 远离零取整），`rInt = 3`（奇数）→ 返回 `3 - 1 = 2` ✓
- 例：`roundEven(3.5)` → `round(3.5) = 4`，`rInt = 4`（偶数）→ 返回 `4` ✓

## P1-5: S3+S4 测试期望值修正

### S3: `tests/glm/ext/quaternion_transform_test.cj:63-70`

**当前代码**：
```cangjie
@Test
func testRotateNonIdentity(): Unit {
    let q = Quat<Float64, Defaultp>(0.7071067811865476, 0.0, 0.7071067811865476, 0.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let r = rotate(q, 1.5707963267948966, axis)
    @Expect((r.x).abs() < 1e-10, true)
    @Expect((r.z - 1.0).abs() < 1e-10, true)
}
```

**问题**：
- `r.x ≈ 0` 错误——正确值为 0.5
- `r.z ≈ 1.0` 错误——正确值为 0.5

**修改后**：
```cangjie
@Test
func testRotateNonIdentity(): Unit {
    let q = Quat<Float64, Defaultp>(0.7071067811865476, 0.0, 0.7071067811865476, 0.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let r = rotate(q, 1.5707963267948966, axis)
    @Expect((r.x - 0.5).abs() < 1e-10, true)
    @Expect((r.z - 0.5).abs() < 1e-10, true)
}
```

**注意**：此修正基于四元数复合运算的数学推导。若生产代码 `ext/quaternion_transform.cj:rotate` 的实现与 GLM 1.0.3 的四元数初始化约定不一致，修正后的测试可能失败。此时编码者应：
1. 使用 GLM 1.0.3 验证正确的期望值
2. 若测试仍失败，将 rotate 实现问题记录为新的偏差或 task

### S4: `tests/glm/gtc/matrix_transform_test.cj:107-109`

**当前代码**：
```cangjie
@Expect(r.c0.x, 1.5)     // ✓ 正确
@Expect(r.c0.y, 1.0)     // ✗ 应为 0.5
@Expect(r.c1.x, 1.0)     // ✗ 应为 0.5
@Expect(r.c1.y, 1.5)     // ✓ 正确
```

**修改后**：
```cangjie
@Expect(r.c0.x, 1.5)
@Expect(r.c0.y, 0.5)
@Expect(r.c1.x, 0.5)
@Expect(r.c1.y, 1.5)
```

**推导**：`shear_slow(I, n(0.5,0.5,0), s=2.0)` 使用 `H = I + s * n*n^T`，`n=(0.5,0.5,0)` 时 `n*n^T` 矩阵为：
```
[0.25  0.25  0]
[0.25  0.25  0]
[0     0     0]
```
`H = I + 2 * n*n^T` 为：
```
[1.5  0.5  0  0]
[0.5  1.5  0  0]
[0    0    1  0]
[0    0    0  1]
```
因此 c0.y = 0.5, c1.x = 0.5。

## 错误处理

| 函数 | 错误处理方式 |
|------|------------|
| `float_distance` | Nax/Inf 输入返回 `Int32.Max` / `Int64.Max`（哨兵值）。正常浮点输入在 `@OverflowWrapping` 下无异常 |
| `slerp` / `slerp(k)` | sinOmega ≈ 0 时退化到线性插值（lerp），与 GLM 一致。无新增错误路径 |
| `roundEven` | 无变更。现有分支处理 `diffF64 < 0.5` / `> 0.5` / `== 0.5` 三种情况 |

## 行为契约

### float_distance (S2+G7)
- 前置条件：无（NaN/Inf 已保护）
- 后置条件：返回两个浮点值的 ULP 距离（无符号绝对值）
- 对 NaN/Inf 输入：返回 `Int32.Max` / `Int64.Max`

### slerp (G10)
- `cosOmega < 0` 时自动取最短路径（取反 y），与 GLM 1.0.3 一致
- 四参数 slerp(k) 的 k 参数含义从"频率缩放因子"变为"额外圈数"（`phi = ω + k*π`）

### roundEven (G1)
- `x.5` 时取最近的偶整数
- 其他情况等价于 `round(x)`

## 依赖关系

| 修改文件 | 新增依赖 | 暴露给外部 |
|---------|---------|-----------|
| `gtc/ulp.cj` | `glm.detail.abs` | `lib.cj:58` 通过 `public import glm.gtc.{...float_distance...}` 自动暴露 |
| `ext/quaternion_common.cj` | `glm.detail.pi` | `lib.cj:41` 通过 `public import glm.ext.{...slerp...}` 自动暴露 |
| `detail/common.cj` | 无新增 | `lib.cj:24` 通过 `public import glm.detail.{...roundEven...}` 自动暴露 |

## 修订说明（v2 r4）
| 审查意见 | 修改措施 |
|---------|---------|
| **[严重] P1-2: `Int32.fromBits(UInt32)` API 不存在** | 废除 `fromBits` 方案，改用 `@OverflowWrapping` + `(UInt32 as Int32)` 位重解释模式。更新了 P1-2 节的修改方案、代码示例和关键语义澄清 |
| **[一般] P1-3: `cosOmega` 可变性未指明** | 明确将 `cosOmega` 声明为 `var`，补充了完整执行顺序：(1) `var cosOmega = dot(x, y)`; (2) if `cosOmega < zero`: `z = -y; cosOmega = -cosOmega`; (3) `cosOmega = clamp(cosOmega, -one, one)`。新增"关键语义澄清"段落 |
