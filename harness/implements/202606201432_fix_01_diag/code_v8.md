# 实现报告（v8）

## 概述

在 `type_vec1.cj`、`type_vec2.cj`、`type_vec3.cj`、`type_vec4.cj` 的 `Integer<T>` extend 块末尾各追加 `increment()` 和 `decrement()` 两个 `mut` 函数（标注 `@OverflowWrapping`），实现所有分量自增/自减 1。同步追加对应测试用例。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/type_vec1.cj` | Integer\<T\> 块末尾追加 `increment()`、`decrement()` |
| 修改 | `src/detail/type_vec2.cj` | 同上，Vec2 分量 x/y |
| 修改 | `src/detail/type_vec3.cj` | 同上，Vec3 分量 x/y/z |
| 修改 | `src/detail/type_vec4.cj` | 同上，Vec4 分量 x/y/z/w |
| 修改 | `src/detail/type_vec1_test.cj` | 追加 `testVec1Increment`、`testVec1Decrement` |
| 修改 | `src/detail/type_vec2_test.cj` | 追加 `testVec2Increment`、`testVec2Decrement` |
| 修改 | `src/detail/type_vec3_test.cj` | 追加 `testVec3Increment`、`testVec3Decrement` |
| 修改 | `src/detail/type_vec4_test.cj` | 追加 `testVec4Increment`、`testVec4Decrement` |

## 编译验证

`cjpm build` 成功，`cjpm test` 全部 360 个用例 PASSED（含新增 8 个测试用例）。

## 设计偏差说明

**偏差 1：实现演算方式从 `this.x +=/-= Int64(1)` 改为 `this.x = this.x +/- (-(!(this.x - this.x)))`**

- **设计规格**：使用 `this.x += Int64(1)` / `this.x -= Int64(1)`（备选方案为 `this.x = this.x + Int64(1)`）
- **偏差原因**：`Integer<T>` 约束下的泛型上下文无法接受 `Int64(1)` 或字面量 `1`（编译器报"expected 'Generics-T', found 'Int64'"及"cannot convert an integer literal to type 'Generics-T'"）。利用 `Integer<T>` 提供的 `+`/`-`/`!` 运算符，通过 `-(!(this.x - this.x))` 计算出类型 `T` 的值 `1`：`this.x - this.x` → `0` (T)，`!0` → `-1`/`MAX` (T)，`-`(negate) → `1` (T)。
- **实际处理**：使用 `this.x = this.x + (-(!(this.x - this.x)))` 和 `this.x = this.x - (-(!(this.x - this.x)))` 分别实现自增/自减 1。

## 设计偏差说明

无其他偏差。
