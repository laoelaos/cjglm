# 审查范围界定

## 审查目标
对分支 `harness-implements-202606201432-fix-01-diag` 到 `main` 的全部变更进行代码审查，验证实现与 `docs/02_ood_phase0.md` OOD 设计的一致性。

## 审查依据
1. `docs/02_ood_phase0.md` — GLM 1.0.3 仓颉迁移首轮 OOD 设计方案
2. 参考项目 `references/glm-1.0.3` — C++ GLM 参考实现
3. 前序审查报告 `harness/reviews/202606201155_ood_phase0_code_review/` — 之前发现的 51 个问题

## 审查重点
1. **修复质量验证**：前序审查发现的待办事项是否已在当前分支中正确修复
2. **设计一致性**：实现代码是否遵循 OOD 设计文档的约定（签名、约束、行为）
3. **新增代码质量**：`type_cast.cj`、`compute_vector_decl.cj` 等新增文件的正确性、完整性和可测试性
4. **测试覆盖**：测试用例是否充分覆盖正常路径、边界条件和异常路径

## 排除范围
- `docs/deviations.md` 中已记录的偏差项（IF-01~IF-04, DV-01~DV-06, INT-01~INT-04 等）不应被审查或报告
- 文档类文件（`docs/*.md`、`harness/` 下的过程记录文件）不在代码审查范围内
- 生成脚本 `gen_fwd_aliases.py` 不作为代码审查重点（仅检查是否存在与输出不同步的风险）
