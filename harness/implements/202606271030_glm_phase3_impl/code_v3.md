# 实现报告（v3）

## 概述
实现 GLM Phase 3 ext 函数库层：`glm.ext` 包下 14 个源文件 + 5 个测试文件。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `src/ext/quaternion_geometric.cj` | dot/length/normalize/cross 四元数几何函数 |
| 新建 | `src/ext/quaternion_relational.cj` | equal/notEqual 精确+epsilon 比较 |
| 新建 | `src/ext/vector_relational.cj` | 16 epsilon 重载 + 16 ULP stub |
| 新建 | `src/ext/quaternion_common.cj` | conjugate/inverse/lerp/isnan/isinf + mix/slerp stub |
| 新建 | `src/ext/quaternion_trigonometric.cj` | axis 完整 + angle/angleAxis stub |
| 新建 | `src/ext/quaternion_transform.cj` | rotate stub |
| 新建 | `src/ext/quaternion_exponential.cj` | exp/log/pow/sqrt stub |
| 新建 | `src/ext/matrix_projection.cj` | perspective stub |
| 新建 | `src/ext/matrix_clip_space.cj` | ortho stub |
| 新建 | `src/ext/matrix_transform.cj` | translate stub |
| 新建 | `src/ext/quaternion_float.cj` | type quat alias |
| 新建 | `src/ext/quaternion_double.cj` | type dquat alias |
| 新建 | `src/ext/quaternion_float_precision.cj` | highp/mediump/lowp_quat 别名 |
| 新建 | `src/ext/quaternion_double_precision.cj` | highp/mediump/lowp_dquat 别名 |
| 新建 | `tests/glm/ext/test_quaternion_geometric.cj` | dot/length/normalize/cross 测试 |
| 新建 | `tests/glm/ext/test_quaternion_relational.cj` | equal/notEqual 精确+epsilon 测试 |
| 新建 | `tests/glm/ext/test_vector_relational.cj` | 16 epsilon 重载测试 + ULP stub 测试 |
| 新建 | `tests/glm/ext/test_quaternion_common.cj` | conjugate/inverse/lerp/isnan/isinf + stub 测试 |
| 新建 | `tests/glm/ext/test_quaternion_trigonometric.cj` | axis/angle/angleAxis 测试 |

## 编译验证
`cjpm build` 成功。仅有变量未使用的 warnings（stub 函数预期行为），无 errors。

## 设计偏差说明
| 项目 | 设计规格 | 实际处理 | 原因 |
|------|---------|---------|------|
| `conjugate` | `public const func` | `public func`（移除 const） | Cangjie 泛型 `const func` 函数体内 `-q.x`/`-q.y`/`-q.z` 不被视为 const 表达式，编译器报错 |
| 三元表达式 | `? :` 语法 | `if else` 表达式 + `{ }` 括号 | Cangjie 不支持 `? :` 三元运算符，需用 `if (cond) { a } else { b }` |
| `assert` 导入 | 假定内置 | 从 `glm.detail` 导入 | `assert` 定义在 `glm.detail` 包中，非 Cangjie 内置函数 |
| `Number`/`Comparable` 导入 | 部分假定内置 | 显式导入或依赖自动解析 | `Number`/`FloatingPoint` 从 `std.math` 导入；`Comparable`/`Equatable` 为自动导入无需显式 |
