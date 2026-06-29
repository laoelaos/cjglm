# 任务指令（v4）

## 动作
NEW

## 任务描述
修复 S2: tests/ 目录测试文件不被 cjpm 发现的问题。将 `cjglm/tests/` 目录下所有 `test_*.cj` 文件批量重命名为 `*_test.cj`，使 cjpm 默认测试发现规则（识别 `*_test.cj` 后缀）可找到这些测试文件。

具体文件清单（按诊断报告 §S2）：

**tests/glm/detail/（30 个文件）：**
`test_common.cj`, `test_from_mat_contraction.cj`, `test_from_mat_deviation.cj`,
`test_geometric.cj`, `test_geometric_refract.cj`, `test_matrix.cj`, `test_qualifier.cj`,
`test_scalar_constants.cj`, `test_scalar_mat_ops.cj`, `test_scalar_quat_ops.cj`,
`test_scalar_vec_ops.cj`, `test_setup.cj`, `test_shim_assert.cj`, `test_shim_limits.cj`,
`test_trigonometric_stub.cj`, `test_type_mat2x2.cj`, `test_type_mat2x3.cj`,
`test_type_mat2x4.cj`, `test_type_mat3x2.cj`, `test_type_mat3x3.cj`,
`test_type_mat3x4.cj`, `test_type_mat4x2.cj`, `test_type_mat4x3.cj`,
`test_type_mat4x4.cj`, `test_type_mat_compare.cj`, `test_type_quat.cj`,
`test_type_quat_cast.cj`, `test_type_vec1_broadcast_shift.cj`,
`test_vec_mat_mul.cj`, `test_vec_mat_mul_comment.cj`

**tests/glm/ext/（5 个文件）：**
`test_quaternion_common.cj`, `test_quaternion_geometric.cj`,
`test_quaternion_relational.cj`, `test_quaternion_trigonometric.cj`,
`test_vector_relational.cj`

**tests/glm/gtc/（2 个文件）：**
`test_constants.cj`, `test_quaternion.cj`

**tests/glm/（4 个文件）：**
`test_ext.cj`, `test_fwd.cj`, `test_integration_matrix.cj`, `test_lib.cj`

**同步更新文档：** `docs/03_ood_phase1.md:148` 中关于 `cjpm test` 测试发现行为的描述。

约束：
1. 必须使用 `git mv` 而非手动移动+删除，保留 git rename 历史记录
2. 仅重命名文件，不修改包声明（`package`）或 `import` 语句
3. 重命名后执行 `cjpm build` 验证编译通过
4. 重命名后执行 `cjpm test` 验证测试总数增加

## 选择理由
S1 同一任务连续失败 3 次已标记 BLOCKED，需绕过至下一个独立任务。S2 优先级 Critical：
- tests/ 目录 300+ @Test 因命名规则不符被 cjpm 静默跳过
- 阻塞 S3/S4/G5/G6 等测试覆盖问题的修复验证
- 纯机械重命名，无逻辑变更，风险低
- 不依赖 S1 或其他未完成任务

## 任务上下文
- 诊断报告：`docs/diag/impl/03_diag.md:74-158`（§S2 完整分析）
- 风险评估：§S2 表（git 历史可追溯、测试文件间依赖不受影响、CI 配置需检查）
- cjpm 测试发现规则：仅识别 `*_test.cj` 后缀的文件
- 当前 `cjpm test` 输出：433 PASSED / 2 FAILED，全部来自 `src/detail/*_test.cj`

## 已有代码上下文
- `cjglm/tests/` 目录结构：`tests/glm/{detail/,ext/,gtc/}` + `tests/glm/` 根目录
- 测试文件均声明 `package glm.detail` / `glm.ext` / `glm.gtc`，重命名不影响
- 同步更新文档：`docs/03_ood_phase1.md` 第 148 行附近
