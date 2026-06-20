# 设计审查报告（v9 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** — 待定
- **[一般]** — 待分析
- **[轻微]** — 待分析

## 发现详情

### 1. [一般] 未处理任务要求的偏差文档更新

**问题**：任务指令（`task_v9.md`）"偏差记录要求"章节明确要求评估新增浮点 `mod` 后是否需要更新 `docs/deviations.md` 中的 DV-02 记录（因浮点 `mod` 实施后 DV-02 中"浮点类型使用 `%` 会触发编译错误"的描述将不再准确——`mod(s, v)` 函数本身已可用，只是 `%` 运算符仍仅整数可用）。但详细设计（`detail_v9.md`）完全未提及偏差记录更新事宜。

**为什么是问题**：设计文档必须覆盖任务的所有要求。遗漏此要求会导致编码阶段忽略偏差记录更新，进而导致项目偏差文档（`docs/deviations.md`）与代码实际状态不一致，为后续维护和审计留下隐患。

**期望的修正方向**：在详细设计中增加一节，分析是否需要更新 `docs/deviations.md`，如需要则明确更新内容（如将 DV-02 相关记录移至「五、未验证的偏差删除」章节并更新描述）。

### 2. [轻微] 边界测试仅覆盖 Float32/Float64，未包含 Float16

**问题**：边界测试（`tests/glm/detail/test_scalar_vec_ops.cj`）仅包含 `testScalarModVec1Float32ByZero`、`testScalarModVec1Float32Negative`、`testScalarModVec1Float32InfDividend`、`testScalarModVec1Float64ByZero` 四个用例，未覆盖 Float16 的除零或 Inf 被除数场景。

**为什么是问题**：Float16 类型在 `std.math.fmod` 中同样对 x=Inf 和 y=0 抛出 `IllegalArgumentException`（文档已确认），遗漏边界测试意味着 Float16 的异常路径在测试中未被覆盖。

**期望的修正方向**：考虑补充 Float16 的对应边界测试用例，或至少在设计中说明为何不覆盖（例如"参考 GLM 仅对常用类型加边界测试"）。

## 修改要求

1. **偏差记录** - 分析并明确是否更新 `docs/deviations.md`，在设计中增加对应章节
2. **Float16 边界测试** - 考虑补充或说明省略理由

## 备注
- `std.math.fmod` 的存在与行为已通过仓颉原始文档确认：`fmod(Float16/Float32/Float64)` 三个重载均存在，当 x=Inf 或 y=0 时抛出 `IllegalArgumentException`。设计方案在此依赖项上的假设完全正确。
- 所有 12 个正向测试的算术正确性已逐分量验证，所有预期值与 `fmod` 计算结果一致。
- 函数签名、重载解析、插入位置指向均清晰无误。
