# 计划审查报告（v1 r2）

## 审查结果
REJECTED

## 发现

### **[严重] 空占位文件缺少 package 声明将导致编译失败**
`lib.cj`、`fwd.cj`、`test_lib.cj`、`test_fwd.cj` 被描述为 "(空占位)"，但仓颉编译器要求每个 `.cj` 源文件必须以 `package` 声明开头。完全空文件会导致编译错误，`cjpm build` 无法通过。此问题直接影响验证标准"所有文件编写完成后，在项目根目录执行 `cjpm build` 编译通过"。

### **[一般] 基础设施层缺少单元测试**
需求明确要求"编写单元测试确保实现正确"，但 R1 仅在 `tests/` 目录下放置了空占位文件，未为 `setup.cj`、`qualifier.cj`、`shim_assert.cj`、`shim_limits.cj`、`shim_cstddef.cj` 编写任何实际测试。底层基础设施的质量隐患无法在 R1 被及时发现。

### **[一般] `plan.md` 未枚举完整轮次规划**
`plan.md` 仅描述 R1 任务，未定义 R2~R4 的具体任务边界（核心抽象层/向量类型层/公共 API 层）。轮次间依赖关系和交付物边界不清晰，可能导致后续轮次规划与 R1 产出脱节。

### **[一般] 未验证 `NumericLimits<T>.max()`/`.min()` 在泛型约束下的可编译性**
`shim_limits.cj` 使用 `T.Max` 和 `T.Min`（`where T <: Number<T>`），但未确认 `Number<T>` 接口是否声明了 `Max`/`Min` 静态成员。若未声明，`T.Max`/`T.Min` 将在泛型实例化处编译失败，影响整个 shim 层的稳定性。

## 修改要求

1. **[严重]** 明确规范"空占位"文件的实际内容：`lib.cj` 和 `fwd.cj` 至少包含 `package glm`，`tests/glm/test_lib.cj` 和 `tests/glm/test_fwd.cj` 至少包含对应 `package` 声明。可以在 task 文件中对"空占位"给出明确的最小内容定义。

2. **[一般]** 为基础设施层补充单元测试：至少为 `qualifier.cj`（验证接口实现正确性）、`shim_assert.cj`（验证 `assert(false)` 抛出异常）、`shim_limits.cj`（验证 `NumericLimits` 对 `Float32`/`Float64` 的 epsilon 值正确性）编写测试用例。

3. **[一般]** 扩展 `plan.md` 补充 R2~R4 的概要任务定义，明确各轮次的交付物边界和轮次间的依赖关系，确保整体规划可追溯。

4. **[一般]** 在 R1 任务开始前或任务中加入验证项：编写原型代码确认 `Number<T>` 接口支持 `T.Max`/`T.Min` 静态属性访问，或提供回退方案（如直接返回具象类型的常数值）。
