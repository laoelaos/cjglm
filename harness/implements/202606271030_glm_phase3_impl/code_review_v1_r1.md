# 代码审查报告（v1 r1）

## 审查结果
APPROVED

## 发现

### scalar_constants.cj — 实现与设计对比

- **[轻微]** `src/detail/scalar_constants.cj:5,10,24` — 三函数（`epsilon`/`pi`/`cos_one_over_two`）均以 `let hint: T = (Float64(0.0) as T).getOrThrow()` 起始，完全相同的零值获取逻辑重复三次。建议提取为包级私有 helper（如 `func _zero<T>(): T where T <: FloatingPoint<T>`）。不影响正确性。

- **[轻微]** `src/detail/scalar_constants.cj:27` — `cos_one_over_two` 的 Float64 分支使用 `(0.877582561890372716 as T).getOrThrow()`（原始字面量隐式为 Float64），而同函数的 Float32 分支（L30）和 Float16 分支（L33）使用显式 `Float32(...)`/`Float16(...)` 构造器，风格不一致。建议统一为 `(Float64(0.877582561890372716) as T).getOrThrow()`。

- **[轻微]** `src/detail/scalar_constants.cj:18-19,32-33` — `pi` 和 `cos_one_over_two` 中新增了 Float16 分支（设计偏差 #3），但 `tests/glm/detail/test_scalar_constants.cj` 未覆盖 Float16 测试用例。建议补充 `testPiFloat16` 和 `testCosOneOverTwoFloat16` 确保 Float16 路径被测试。

### trigonometric.cj — 实现与设计对比

- 75 个 stub 签名：15 组 × 5 重载（标量 + Vec1~Vec4），数量正确。✓
- 所有函数体 `throw Exception("stub")`，函数名、参数名、约束条件与设计完全一致。✓
- atan2 双参数签名与设计一致（`(y: T, x: T)` 及对应的 VecN 版本）。✓

### ext/scalar_constants.cj

- 完全匹配设计：`package glm.ext` + `public import glm.detail.{epsilon, pi, cos_one_over_two}`。✓

### test_scalar_constants.cj

- 8 个测试覆盖 epsilon 交叉验证（Float32/Float64）、epsilon/pi/cos_one_over_two 精度值验证。与设计一致。✓
- 使用 `@Expect` 宏，风格与项目惯例一致。✓

### test_trigonometric_stub.cj

- 16 个测试：15 个标量函数组各一个 + 1 个 Vec1 代表性测试（`sin<Float32, Defaultp>`）。与设计一致。✓
- 使用 `@ExpectThrows[Exception](...)` 宏，匹配设计规格。✓

### 设计偏差处理

| 偏差 | 描述 | 评估 |
|------|------|------|
| 偏差 1: 零值获取 | `T(Float64(0))` 不编译 → 改用 `(Float64(0.0) as T).getOrThrow()` | 合理，已验证编译通过 |
| 偏差 2: `getPI()` 调用 | `FloatingPoint<T>.getPI()` 不编译 → 改用具体类型运行时分派 | 合理，已验证编译通过 |
| 偏差 3: 增加 Float16 | 在 pi/cos_one_over_two 中增加 Float16 分支 | 合理（完整覆盖 FloatingPoint 约束），但未测试（见上） |

### 依赖验证

- `epsilonOf<T>` 来自同包 `shim_limits.cj:25`（约束 `T <: Number<T>`），由 `FloatingPoint<T> <: Number<T>` 保证编译期兼容。✓
- `Vec1~Vec4`、`Qualifier` 均在同包 `glm.detail`，无需 import。✓
- `Exception` 由 `std.core` 自动导入。✓
- `Float32`/`Float64`/`Float16` 由 `std.core` 自动导入。✓
- 项目中已有 `common.cj`、`geometric.cj` 等同模式使用 `throw Exception("stub")` 的场景，模式一致。✓

## 结论

实现与详细设计高度一致，3 项设计偏差均已在实现报告中记录且理由充分。编译验证通过（422 测试全部 PASSED）。无严重或一般问题，仅有 3 项轻微改进建议。

APPROVED
