# 详细设计（v17）

## 概述

完成 P4-4 末批（G35+G36+G37）：为 `tests/glm/gtc/noise_test.cj` 补充 isFinite/零向量/边界输入测试，为 `tests/glm/gtc/ulp_test.cj` 补充 prev_float 的 Float64/±0/NaN/Inf 测试，标记 G36 已覆盖，更新诊断文档和路线表。全部 37 个问题（S1-S4, G1-G37）至此处理完毕。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/gtc/noise_test.cj` | 在 `:130` 后追加 | 新增 18 个测试函数（8 isFinite + 6 零向量 + 4 边界） |
| `tests/glm/gtc/ulp_test.cj` | 在 `:160` 后追加 | 新增 5 个测试函数（Float64/±0/NaN/Inf prev_float） |
| `docs/diag/impl/04_diag.md:416` | 修改 | G35 行末尾追加 `✅ 已修复` |
| `docs/diag/impl/04_diag.md:422` | 修改 | G36 行末尾追加 `✅ 已修复` |
| `docs/diag/impl/04_diag.md:429` | 修改 | G37 行末尾追加 `✅ 已修复` |
| `harness/implements/202606301007_fix_04_diag/plan.md:26` | 修改 | 路线表 v17 列 P4-4 标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数。

## 新增测试函数签名

所有函数位于 `package glm.gtc`，`@Test` 标记，返回 `Unit`。

### G35: noise_test.cj

#### isFinite 验证（perlin1D-4D、simplex1D-4D 各维度）

```
@Test func testPerlin1DIsFinite(): Unit
```
- `perlin1D(Float64(1.5))` → `@Expect(result.isFinite(), true)`

```
@Test func testPerlin2DIsFinite(): Unit
```
- `Vec2<Float64, PackedHighp>(1.5, 2.3)` → `@Expect(result.isFinite(), true)`

```
@Test func testPerlin3DIsFinite(): Unit
```
- `Vec3<Float64, PackedHighp>(1.5, 2.3, 0.7)` → `@Expect(result.isFinite(), true)`

```
@Test func testPerlin4DIsFinite(): Unit
```
- `Vec4<Float64, PackedHighp>(1.5, 2.3, 0.7, 3.1)` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex1DIsFinite(): Unit
```
- `simplex1D(Float64(1.5))` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex2DIsFinite(): Unit
```
- `Vec2<Float64, PackedHighp>(1.5, 2.3)` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex3DIsFinite(): Unit
```
- `Vec3<Float64, PackedHighp>(1.5, 2.3, 0.7)` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex4DIsFinite(): Unit
```
- `Vec4<Float64, PackedHighp>(1.5, 2.3, 0.7, 3.1)` → `@Expect(result.isFinite(), true)`

#### 零向量输入（perlin2D/3D/4D、simplex2D/3D/4D）

```
@Test func testPerlin2DZeroVector(): Unit
```
- `Vec2<Float64, PackedHighp>(0.0, 0.0)` → `@Expect(result.isFinite(), true)`

```
@Test func testPerlin3DZeroVector(): Unit
```
- `Vec3<Float64, PackedHighp>(0.0, 0.0, 0.0)` → `@Expect(result.isFinite(), true)`

```
@Test func testPerlin4DZeroVector(): Unit
```
- `Vec4<Float64, PackedHighp>(0.0, 0.0, 0.0, 0.0)` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex2DZeroVector(): Unit
```
- `Vec2<Float64, PackedHighp>(0.0, 0.0)` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex3DZeroVector(): Unit
```
- `Vec3<Float64, PackedHighp>(0.0, 0.0, 0.0)` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex4DZeroVector(): Unit
```
- `Vec4<Float64, PackedHighp>(0.0, 0.0, 0.0, 0.0)` → `@Expect(result.isFinite(), true)`

#### 边界输入（极小值/极大值）

```
@Test func testPerlin1DMinNormal(): Unit
```
- `perlin1D(Float64(Float32.MinNormal))` → `@Expect(result.isFinite(), true)`

```
@Test func testPerlin1DLargeInput(): Unit
```
- `perlin1D(Float64(1e6))` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex1DMinNormal(): Unit
```
- `simplex1D(Float64(Float32.MinNormal))` → `@Expect(result.isFinite(), true)`

```
@Test func testSimplex1DLargeInput(): Unit
```
- `simplex1D(Float64(1e6))` → `@Expect(result.isFinite(), true)`

### G37: ulp_test.cj prev_float 补充

```
@Test func testPrevFloatFloat64(): Unit
```
- `Float64(1.0)` → `prev_float(x)` → `float_distance(pf, x) == Int64(1)`

```
@Test func testPrevFloatZero(): Unit
```
- `prev_float(Float32(0.0))` 不崩溃、结果 finite
- `prev_float(Float32(-0.0))` 不崩溃、结果 finite

```
@Test func testPrevFloatNaN(): Unit
```
- `prev_float(Float32.nan).isNaN()` → true

```
@Test func testPrevFloatInf(): Unit
```
- `prev_float(Float32.infinity())` 不崩溃、结果 finite 或 Inf

## 错误处理

不涉及错误处理逻辑变更。测试使用 `@Expect` 断言结果有效性。浮点有限性验证使用实例方法 `.isFinite()`（Float32/Float64 自动导入方法）。NaN 检测使用 `.isNaN()`。Infinity 通过 `Float32.infinity()` 静态方法获取。

## 行为契约

- 全部变更限于测试文件（`noise_test.cj`、`ulp_test.cj`）、诊断文档（`04_diag.md`）和计划路线表（`plan.md`），不修改生产代码
- `noise_test.cj` 18 个测试函数追加到文件末尾（`:130` 之后），不修改或移动现有 import
- `ulp_test.cj` 5 个测试函数追加到文件末尾（`:160` 之后），不修改现有 import
- 测试命名：`test{Perlin|Simplex}{N}D{IsFinite|ZeroVector|MinNormal|LargeInput}` 和 `testPrevFloat{Float64|Zero|NaN|Inf}`
- `04_diag.md` 三处标记：G35 `:416`、G36 `:422`、G37 `:429` 各追加 `✅ 已修复`（G36 条目末尾已有 `（与 S2/G7 联动，应在修复后补充）`，追加到该行末尾）
- `plan.md` 路线表 v17 列将 P4-4 从空标记为 ✅
- `Float32.MinNormal` 为 cangjie 标准库 Float32 静态属性（最小正规正浮点数），任务描述中的 `minNormalized` 为示意性写法，实际使用 `MinNormal` 属性

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `noise_test.cj` | 无新增 import | `Float64`/`Float32` 为自动导入；`isFinite`/`isNaN` 为实例方法；`Vec2`/`Vec3`/`Vec4`/`PackedHighp` 已导入 |
| `ulp_test.cj` | 无新增 import | `Float32`/`Float64` 为自动导入；`prev_float`/`float_distance` 为同包函数；`@Test`/`@Expect` 由已有 import 提供 |
| `04_diag.md` | 无 | 纯文本标记 |
| `plan.md` | 无 | 纯文本标记 |
