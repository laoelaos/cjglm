# 实现报告（v1）

## 概述
实现了 GLM Phase 3 detail 基础层：scalar_constants（3 个标量常量函数完整实现）和 trigonometric（75 个 stub 函数签名），以及对应的测试文件。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `src/detail/scalar_constants.cj` | 实现 epsilon/pi/cos_one_over_two 泛型函数 |
| 新建 | `src/ext/scalar_constants.cj` | public import 重导出 epsilon/pi/cos_one_over_two |
| 新建 | `src/detail/trigonometric.cj` | 75 个三角函数 stub 签名（sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees/atan2 各 5 个重载） |
| 新建 | `tests/glm/detail/test_scalar_constants.cj` | 8 个测试：epsilon 交叉验证、精度值验证、pi 精度验证、cos_one_over_two 值验证 |
| 新建 | `tests/glm/detail/test_trigonometric_stub.cj` | 16 个测试：15 组标量函数 + 1 个 Vec1 代表性测试，验证均抛出 Exception |

## 编译验证
`cjpm build` 和 `cjpm test` 均通过。422 个测试全部 PASSED，0 FAILED。

## 设计偏差说明

### 设计偏差 1：获取泛型 T 的零值方式
- **设计规格**：使用 `T(Float64(0))` 构造泛型 T 的零值，或使用 `let hint: T = 0.0` 利用字面量自适应
- **偏差原因**：Cangjie 编译器不支持通过泛型类型参数构造实例（`T(Float64(0))`），也不支持浮点数字面量自适应到泛型类型参数（`let hint: T = 0.0`）
- **实际处理**：采用 `let hint: T = (Float64(0.0) as T).getOrThrow()` 获取 T 类型零值

### 设计偏差 2：pi 函数中 FloatingPoint.getPI() 的调用方式
- **设计规格**：直接调用 `FloatingPoint<T>.getPI()`
- **偏差原因**：Cangjie 编译器报错"static invocation contains unimplemented static function 'getPI'"，无法通过接口类型参数调用静态方法
- **实际处理**：通过运行时类型派发，对 Float64/Float32/Float16 分别调用其具体类型的 `getPI()` 方法，结果通过 `as T` 转换返回

### 设计偏差 3：cos_one_over_two 增加了 Float16 分支
- **设计规格**：仅处理 Float32 和 Float64
- **实际处理**：增加 Float16 分支以保持与 FloatingPoint 约束的完整覆盖，值使用 `Float16(0.877582561890372716)` 构造

### 无偏差项
- 类型形态、方法签名、错误处理方式、包路径、函数分组与设计完全一致
- 测试方案按设计实现，使用 `@Expect` 和 `@ExpectThrows[Exception]` 宏
<｜｜DSML｜｜parameter name="end">true