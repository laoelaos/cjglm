# 详细设计（v9）

## 概述

为 core 函数库补充测试覆盖，涉及 4 个测试文件、8 个问题（G13-G20）。全部为测试文件变更，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/common_test.cj:382-387` | 修改 | 补充 testFractVec4 的 z/w 断言（G13） |
| `tests/glm/detail/exponential_test.cj` | 新增函数 | 补充 sqrt(-1)→NaN、log(0)→-Inf、log(-1)→NaN 边界测试（G14） |
| `tests/glm/detail/stdmath_shim_test.cj` | 新增函数 | 为 19 个缺失的 stdmath_shim 函数补充 Float16 测试（G15） |
| `tests/glm/detail/stdmath_shim_test.cj` | 修改 | 为 25 个 shim 函数的 Float32 测试补充多组输入值（G16） |
| `tests/glm/detail/trigonometric_test.cj` | 新增函数 | 补充三角恒等式验证（scalar + Vec1~Vec4 × Float64/Float32/Float16）（G17） |
| `tests/glm/detail/trigonometric_test.cj` | 新增函数 | 补充 Float16 asin(±1)/acos(±1) 边界测试（G18） |
| `tests/glm/detail/trigonometric_test.cj` | 新增函数 | 补充 Float16 atan2 第二分支测试（G19） |
| `tests/glm/detail/trigonometric_test.cj` | 新增函数 | 补充 Vec3/Vec4 非零向量 asinh/acosh/atanh 测试（G20） |
| `docs/diag/impl/04_diag.md:246-300` | 修改 | 标记 G13-G20 条目末尾添加 ✅ 已修复 |
| `harness/implements/202606301007_fix_04_diag/plan.md:23` | 修改 | 路线表 P4-1 v9 列标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数和修改既有测试函数。

### G13 — common_test.cj testFractVec4 补充断言

**修改目标**：`tests/glm/detail/common_test.cj:382-387`，函数 `testFractVec4`

在已有 `@Expect(r.x, Float64(0.3))` 和 `@Expect(r.y, Float64(0.7))` 之后，补充：
```cangjie
@Expect(r.z, Float64(0.5))   // fract(-0.5) = 0.5
@Expect(r.w, Float64(0.0))   // fract(0.0) = 0.0
```

### G14 — exponential_test.cj 补充边界测试

**新增函数**：`testSqrtLogEdgeCases`

```cangjie
@Test
func testSqrtLogEdgeCases(): Unit {
    @Expect(isNaN(sqrt(Float64(-1.0))), true)
    @Expect(!isFinite(log(Float64(0.0))), true)   // log(0) = -Inf
    @Expect(isNaN(log(Float64(-1.0))), true)
}
```

依赖：`isNaN` 已 import（line 3: `import std.math.{ isNaN, isInf }`），需补充 `import std.math.{ isNaN, isInf, isFinite }` 或将 `!isFinite` 改为 `isInf(log(Float64(0.0)), true)`。推荐第二种方式避免新增 import：使用已有的 `@Expect(isInf(log(Float64(0.0))), true)`。

### G15 — stdmath_shim_test.cj 补充 Float16 测试

**现状**：25 个 shim 函数中，已有 Float16 测试的 6 个（sqrtT、expT、powT、sinT、sinhT、floorT），需补充剩余 19 个的 Float16 版本。

**新增 19 个测试函数**：

| 测试函数名 | 待测函数 | 输入 | 期望值 |
|-----------|---------|------|--------|
| `testLogTFloat16` | logT | `Float16(1.0)` | `Float16(0.0)` |
| `testExp2TFloat16` | exp2T | `Float16(0.0)`, `Float16(3.0)` | `Float16(1.0)`, `Float16(8.0)` |
| `testLog2TFloat16` | log2T | `Float16(1.0)`, `Float16(8.0)` | `Float16(0.0)`, `Float16(3.0)` |
| `testCosTFloat16` | cosT | `Float16(0.0)` | `Float16(1.0)` |
| `testTanTFloat16` | tanT | `Float16(0.0)` | `Float16(0.0)` |
| `testAsinTFloat16` | asinT | `Float16(0.0)` | `Float16(0.0)` |
| `testAcosTFloat16` | acosT | `Float16(1.0)` | `Float16(0.0)` |
| `testAtanTFloat16` | atanT | `Float16(0.0)` | `Float16(0.0)` |
| `testAtan2TFloat16` | atan2T | `(Float16(0.0), Float16(1.0))` | `Float16(0.0)` |
| `testCoshTFloat16` | coshT | `Float16(0.0)` | `Float16(1.0)` |
| `testTanhTFloat16` | tanhT | `Float16(0.0)` | `Float16(0.0)` |
| `testAsinhTFloat16` | asinhT | `Float16(0.0)` | `Float16(0.0)` |
| `testAcoshTFloat16` | acoshT | `Float16(1.0)` | `Float16(0.0)` |
| `testAtanhTFloat16` | atanhT | `Float16(0.0)` | `Float16(0.0)` |
| `testCeilTFloat16` | ceilT | `Float16(3.2)`, `Float16(-3.2)` | `Float16(4.0)`, `Float16(-3.0)` |
| `testRoundTFloat16` | roundT | `Float16(3.5)`, `Float16(3.2)` | `Float16(4.0)`, `Float16(3.0)` |
| `testTruncTFloat16` | truncT | `Float16(3.7)`, `Float16(-3.7)` | `Float16(3.0)`, `Float16(-3.0)` |
| `testAbsTFloat16` | absT | `Float16(5.0)`, `Float16(-5.0)` | `Float16(5.0)`, `Float16(5.0)` |
| `testFmodTFloat16` | fmodT | `(Float16(5.0), Float16(3.0))`, `(Float16(-5.0), Float16(3.0))` | `Float16(2.0)`, `Float16(-2.0)` |

每个测试函数放一组或两组 @Expect 断言，与既有 Float16 测试风格一致。按 Group 归入对应区域（Group 1 Exponential 区、Group 2 Trigonometric 区、Group 3 Hyperbolic 区、Group 4 Rounding/Absolute 区）。

### G16 — stdmath_shim_test.cj Float32 测试补充多组输入

**修改目标**：为全部 25 个 shim 函数的 Float32 测试函数补充输入值，使每组函数至少覆盖 2-3 组值（含边界），与 Float64 版本深度对齐。

**修改明细（25 个函数逐一定义）**：

| 原测试函数 | 当前仅测 | 需补充 | 参考（Float64 版本） |
|-----------|---------|--------|---------------------|
| `testSqrtTFloat32` | 4.0→2.0 | 补充 `0.0→0.0` | testSqrtTFloat64 有 4.0→2.0, 0.0→0.0 |
| `testExpTFloat32` | 0.0→1.0 | 补充 `1.0→2.718281828459045`（用 Float32 近似） | testExpTFloat64 有 0.0→1.0, 1.0→2.718... |
| `testLogTFloat32` | 1.0→0.0 | 补充 `2.718281828459045→1.0` | testLogTFloat64 有 1.0→0.0, 2.718...→1.0 |
| `testExp2TFloat32` | 0.0→1.0, 3.0→8.0 | 已够（2 组） | 不做补充 |
| `testLog2TFloat32` | 1.0→0.0, 8.0→3.0 | 已够（2 组） | 不做补充 |
| `testPowTFloat32` | (2,3)→8, (4,0.5)→2 | 已够（2 组） | 不做补充 |
| `testSinTFloat32` | 0.0→0.0 | 补充 `pi/6→0.5`、`pi/4→0.7071` 近似、`pi/2→1.0` | testSinTFloat64 有 0.0→0.0, pi/2→1.0 |
| `testCosTFloat32` | 0.0→1.0 | 补充 `pi→-1.0` | testCosTFloat64 有 0.0→1.0, pi→-1.0 |
| `testTanTFloat32` | 0.0→0.0 | 补充 `pi/4→1.0` | testTanTFloat64 有 0.0→0.0, pi/4→1.0 |
| `testAsinTFloat32` | 0.0→0.0 | 补充 `1.0→pi/2`、`-1.0→-pi/2` | testAsinTFloat64 有 0.0→0.0, 1.0→pi/2, -1.0→-pi/2 |
| `testAcosTFloat32` | 1.0→0.0 | 补充 `0.0→pi/2` | testAcosTFloat64 有 1.0→0.0, 0.0→pi/2 |
| `testAtanTFloat32` | 0.0→0.0 | 补充 `1.0→pi/4` | testAtanTFloat64 有 0.0→0.0, 1.0→pi/4 |
| `testAtan2TFloat32` | (0,1)→0 | 补充 `(1,0)→pi/2` | testAtan2TFloat64 有 (0,1)→0, (1,0)→pi/2 |
| `testSinhTFloat32` | 0.0→0.0 | 已够（仅需 0.0 验证恒等对称性，Float64 也仅测 0.0） | 不做补充 |
| `testCoshTFloat32` | 0.0→1.0 | 已够（Float64 也仅测 0.0） | 不做补充 |
| `testTanhTFloat32` | 0.0→0.0 | 已够（Float64 也仅测 0.0） | 不做补充 |
| `testAsinhTFloat32` | 0.0→0.0 | 已够（Float64 也仅测 0.0） | 不做补充 |
| `testAcoshTFloat32` | 1.0→0.0 | 已够（Float64 也仅测 1.0） | 不做补充 |
| `testAtanhTFloat32` | 0.0→0.0 | 已够（Float64 也仅测 0.0） | 不做补充 |
| `testFloorTFloat32` | 3.7→3.0, -3.7→-4.0 | 已够（2 组） | 不做补充 |
| `testCeilTFloat32` | 3.2→4.0, -3.2→-3.0 | 已够（2 组） | 不做补充 |
| `testRoundTFloat32` | 3.5→4.0, 3.2→3.0 | 已够（2 组） | 不做补充 |
| `testTruncTFloat32` | 3.7→3.0, -3.7→-3.0 | 已够（2 组） | 不做补充 |
| `testAbsTFloat32` | 5.0→5.0, -5.0→5.0 | 已够（2 组） | 不做补充 |
| `testFmodTFloat32` | (5,3)→2, (-5,3)→-2 | 已够（2 组） | 不做补充 |

**需实际修改的 9 个函数**：testSqrtTFloat32、testExpTFloat32、testLogTFloat32、testSinTFloat32、testCosTFloat32、testTanTFloat32、testAsinTFloat32、testAcosTFloat32、testAtanTFloat32、testAtan2TFloat32

### G17 — trigonometric_test.cj 三角恒等式验证

**新增测试函数**，每个函数对应一个精度类型（Float64/Float32/Float16）+ 覆盖级别（scalar/Vec1~Vec4）。

恒等式验证方式：
1. **sin² + cos² = 1**：`|sin(a)² + cos(a)² - 1| < epsilon`
2. **tan = sin/cos**：`|sin(a) - tan(a) × cos(a)| < epsilon`
3. **1 + tan² = 1/cos²**：`|1/cos(a)² - (1 + tan(a)²)| < epsilon`

每层精度使用对应的 epsilon：
- Float64：`Float64(1e-12)`
- Float32：`Float32(1e-6)`
- Float16：`Float16(1e-3)`

**多角度抽样值**（对所有 3 种精度通用，使用对应类型的字面量）：
- `0.0`（边界）
- `pi/6`（~0.5236）
- `pi/4`（~0.7854）
- `pi/3`（~1.0472）
- `pi/2`（~1.5708）
- `-pi/4`（~-0.7854，负数验证）

**测试函数计划（9 个）**：

| 测试函数名 | 精度 | 覆盖维度 | 恒等验证 |
|-----------|------|---------|---------|
| `testIdentitySin2Cos2Float64` | Float64 | scalar, Vec1~Vec4 | 全部 3 条 |
| `testIdentitySin2Cos2Float32` | Float32 | scalar, Vec1~Vec4 | 全部 3 条 |
| `testIdentitySin2Cos2Float16` | Float16 | scalar, Vec1~Vec4 | 全部 3 条 |

每个函数中对每个抽样角度和 Vec 维度执行 3 条恒等式检查，使用 `abs(...) < epsilon` 的真值断言：
```cangjie
// 示例模式（scalar 浮点值）：
let v = pi<Float64>() / Float64(6.0)
let s = sin(v); let c = cos(v); let t = tan(v)
let identity1 = s * s + c * c
@Expect(abs(identity1 - Float64(1.0)) < Float64(1e-12), true)
let identity2 = s - t * c
@Expect(abs(identity2) < Float64(1e-12), true)
let identity3 = Float64(1.0) / (c * c) - (Float64(1.0) + t * t)
@Expect(abs(identity3) < Float64(1e-12), true)
```

Vec1~Vec4 版本使用向量元素逐一比较（因仓颉不支持向量整体比较操作符）：
```cangjie
let angles = Vec4<Float64, Defaultp>(0.0, pi<Float64>()/Float64(6.0), pi<Float64>()/Float64(4.0), pi<Float64>()/Float64(3.0))
let s = sin(angles); let c = cos(angles); let t = tan(angles)
let s2c2 = s * s + c * c
@Expect(abs(s2c2.x - Float64(1.0)) < Float64(1e-12), true)
@Expect(abs(s2c2.y - Float64(1.0)) < Float64(1e-12), true)
@Expect(abs(s2c2.z - Float64(1.0)) < Float64(1e-12), true)
@Expect(abs(s2c2.w - Float64(1.0)) < Float64(1e-12), true)
```

### G18 — trigonometric_test.cj Float16 asin/acos ±1 边界测试

**新增 2 个测试函数**：

```cangjie
@Test
func testAsinPlusOneFloat16(): Unit {
    @Expect(asin(Float16(1.0)), Float16(1.5707963267948966))
}

@Test
func testAsinMinusOneFloat16(): Unit {
    @Expect(asin(Float16(-1.0)), Float16(-1.5707963267948966))
}

@Test
func testAcosPlusOneFloat16(): Unit {
    @Expect(acos(Float16(1.0)), Float16(0.0))
}

@Test
func testAcosMinusOneFloat16(): Unit {
    @Expect(acos(Float16(-1.0)), Float16(3.141592653589793))
}
```

置于 `// ── Boundary: asin/acos ──` 区域，在既有的 Float64 边界测试之后。

### G19 — trigonometric_test.cj Float16 atan2 第二分支测试

**新增 1 个测试函数**：

```cangjie
@Test
func testAtan2SecondBranchFloat16(): Unit {
    @Expect(atan2(Float16(1.0), Float16(0.0)), Float16(1.5707963267948966))
    @Expect(atan2(Float16(-1.0), Float16(0.0)), Float16(-1.5707963267948966))
    @Expect(atan2(Float16(0.0), Float16(-1.0)), Float16(3.141592653589793))
}
```

置于 `// ── Scalar Float16 ──` 区域，在 `testAtan2Float16` 之后。

### G20 — trigonometric_test.cj Vec3/Vec4 非零向量 asinh/acosh/atanh 测试

**新增 6 个测试函数**，替换或补充当前的 Vec3/Vec4 全零向量测试。

所有非零分量使用 epsilon 容差断言：`@Expect(abs(r.y - <expected>) < Float64(1e-12), true)`，以避免 `@Expect` 要求 `Equatable<Bool>` 的编译错误。

```cangjie
@Test
func testAsinhVec3NonZero(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 1.0, -1.0)
    let r = asinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.881373587019543)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.881373587019543)) < Float64(1e-12), true)
}

@Test
func testAcoshVec3NonZero(): Unit {
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 1.0)
    let r = acosh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(1.3169578969248166)) < Float64(1e-12), true)
    @Expect(r.z, Float64(0.0))
}

@Test
func testAtanhVec3NonZero(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.5, -0.5)
    let r = atanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.5493061443340549)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.5493061443340549)) < Float64(1e-12), true)
}

@Test
func testAsinhVec4NonZero(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 1.0, -1.0, 2.0)
    let r = asinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.881373587019543)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.881373587019543)) < Float64(1e-12), true)
    @Expect(abs(r.w - Float64(1.4436354751788103)) < Float64(1e-12), true)
}

@Test
func testAcoshVec4NonZero(): Unit {
    let v = Vec4<Float64, Defaultp>(1.0, 2.0, 1.0, 3.0)
    let r = acosh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(1.3169578969248166)) < Float64(1e-12), true)
    @Expect(r.z, Float64(0.0))
    @Expect(abs(r.w - Float64(1.762747174039086)) < Float64(1e-12), true)
}

@Test
func testAtanhVec4NonZero(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.5, -0.5, 0.3)
    let r = atanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.5493061443340549)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.5493061443340549)) < Float64(1e-12), true)
    @Expect(abs(r.w - Float64(0.3095196042031117)) < Float64(1e-12), true)
}
```

**参考值来源**（用于编码时校验）：
- asinh(1.0) = 0.881373587019543, asinh(-1.0) = -0.881373587019543, asinh(2.0) = 1.4436354751788103
- acosh(2.0) ≈ 1.3169578969248166, acosh(3.0) ≈ 1.762747174039086
- atanh(0.5) = 0.5493061443340549, atanh(-0.5) = -0.5493061443340549, atanh(0.3) = 0.3095196042031117

## 错误处理

全部为新增/修改测试，不涉及错误处理逻辑变更。测试框架的 `@ExpectThrows` 等机制保持现有使用方式。

## 行为契约

- 全部变更限于测试文件，不改变生产代码行为
- 测试函数命名遵循既有约定：`test{FunctionName}{Description}`
- 新增测试放在已有测试文件中的对应区域（按 Group 和精度分区）
- 04_diag.md 更新仅修改标记文本，不改变诊断内容结构
- plan.md 路线表更新仅修改 v9 列标记

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `exponential_test.cj` | `import std.math.{ isNaN, isInf }` 不变 | G14 使用 `isInf()` 替代 `isFinite()`，无需新增 import |
| `trigonometric_test.cj` | `import std.math.{ isNaN }` 不变 | G18-G20 无需新增 import；G17 使用 `abs()` 来自 `glm.detail` 包（无需 import） |
| `stdmath_shim_test.cj` | 不变 | 所有 shim 函数均在 `glm.detail` 包中可用 |

## 修订说明（v9 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| G15 Float16 测试计数不一致（"7 个"实为 6 个，"18 个"实为 19 个） | 修正为"已有 6 个"（sqrtT, expT, powT, sinT, sinhT, floorT）、"需补充 19 个"；G15 设计表格已按 19 个函数逐行列出 |
| G17 仅限 Float64，未覆盖任务要求的 Float32/Float16 | 已补充 Float32（epsilon=1e-6）和 Float16（epsilon=1e-3）的三角恒等式测试设计，使用三层精度容差，与任务描述一致 |

## 修订说明（v9 r2）
| 审查意见 | 修改措施 |
|---------|---------|
| G20 asinh 断言 `@Expect(abs(...), true)` 中 `abs()` 返回 `Float64`，`true` 为 `Bool`，`Float64` 未实现 `Equatable<Bool>` 导致编译错误 | 已将 asinh Vec3/Vec4 非零分量断言改为 `@Expect(abs(r.<c> - <expected>) < Float64(1e-12), true)` |
| G20 acosh/atanh 断言不完整——缺少非零分量的实际 `@Expect` 断言，仅有注释 | 已补全 acosh Vec3 (r.y=acosh(2.0)≈1.3169578969248166, r.z=0.0)、atanh Vec3 (r.y=atanh(0.5)≈0.5493061443340549, r.z=atanh(-0.5)≈-0.5493061443340549)，以及 Vec4 版本的全部非零分量断言 |
