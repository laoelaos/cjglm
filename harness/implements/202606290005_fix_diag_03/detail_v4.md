# 详细设计（v4）

## 概述

将 `cjglm/tests/` 下所有 `test_*.cj` 文件批量重命名为 `*_test.cj`，使 `cjpm test` 默认测试发现规则（`*_test.cj` 后缀）可找到这些测试文件。纯机械重命名，无逻辑变更。

## 文件规划

| 操作 | 文件路径 | 职责 |
|------|---------|------|
| 重命名 | `tests/glm/detail/test_common.cj` → `common_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_from_mat_contraction.cj` → `from_mat_contraction_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_from_mat_deviation.cj` → `from_mat_deviation_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_geometric.cj` → `geometric_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_geometric_refract.cj` → `geometric_refract_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_matrix.cj` → `matrix_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_qualifier.cj` → `qualifier_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_scalar_constants.cj` → `scalar_constants_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_scalar_mat_ops.cj` → `scalar_mat_ops_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_scalar_quat_ops.cj` → `scalar_quat_ops_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_scalar_vec_ops.cj` → `scalar_vec_ops_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_setup.cj` → `setup_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_shim_assert.cj` → `shim_assert_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_shim_limits.cj` → `shim_limits_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_trigonometric_stub.cj` → `trigonometric_stub_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat2x2.cj` → `type_mat2x2_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat2x3.cj` → `type_mat2x3_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat2x4.cj` → `type_mat2x4_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat3x2.cj` → `type_mat3x2_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat3x3.cj` → `type_mat3x3_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat3x4.cj` → `type_mat3x4_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat4x2.cj` → `type_mat4x2_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat4x3.cj` → `type_mat4x3_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat4x4.cj` → `type_mat4x4_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_mat_compare.cj` → `type_mat_compare_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_quat.cj` → `type_quat_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_quat_cast.cj` → `type_quat_cast_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_type_vec1_broadcast_shift.cj` → `type_vec1_broadcast_shift_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_vec_mat_mul.cj` → `vec_mat_mul_test.cj` | `git mv` |
| 重命名 | `tests/glm/detail/test_vec_mat_mul_comment.cj` → `vec_mat_mul_comment_test.cj` | `git mv` |
| 重命名 | `tests/glm/ext/test_quaternion_common.cj` → `quaternion_common_test.cj` | `git mv` |
| 重命名 | `tests/glm/ext/test_quaternion_geometric.cj` → `quaternion_geometric_test.cj` | `git mv` |
| 重命名 | `tests/glm/ext/test_quaternion_relational.cj` → `quaternion_relational_test.cj` | `git mv` |
| 重命名 | `tests/glm/ext/test_quaternion_trigonometric.cj` → `quaternion_trigonometric_test.cj` | `git mv` |
| 重命名 | `tests/glm/ext/test_vector_relational.cj` → `vector_relational_test.cj` | `git mv` |
| 重命名 | `tests/glm/gtc/test_constants.cj` → `constants_test.cj` | `git mv` |
| 重命名 | `tests/glm/gtc/test_quaternion.cj` → `quaternion_test.cj` | `git mv` |
| 重命名 | `tests/glm/test_ext.cj` → `ext_test.cj` | `git mv` |
| 重命名 | `tests/glm/test_fwd.cj` → `fwd_test.cj` | `git mv` |
| 重命名 | `tests/glm/test_integration_matrix.cj` → `integration_matrix_test.cj` | `git mv` |
| 重命名 | `tests/glm/test_lib.cj` → `lib_test.cj` | `git mv` |
| 修改 | `docs/03_ood_phase1.md` | 更新第 148 行测试发现行为描述，移除"当前 tests/ 下测试文件采用 test_*.cj 前缀命名"的注记 |

## 类型定义

本次任务不涉及类型定义变更。

## 错误处理

本次任务不涉及错误处理变更。

## 行为契约

### 前置条件
- 所有 41 个目标文件在重命名前均以 `test_` 前缀存在于指定目录
- 当前 Git 工作树无未提交的修改（`git status` 干净）
- 测试文件中的 `package` 声明与目录路径匹配，重命名不影响包路径
- `docs/03_ood_phase1.md:148` 包含对 `test_*.cj` 命名约定的描述

### 后置条件
- 41 个文件均以 `*_test.cj` 后缀存在于原目录，无多余/缺失文件
- `cjpm build` 编译通过（0 错误）
- `cjpm test` 发现的测试总数增加（当前 433 PASSED / 2 FAILED，全部来自 `src/detail/*_test.cj`；重命名后 `tests/` 下的 300+ @Test 应被识别）
- `git log` 可追溯重命名历史（`git mv` 保留 rename 记录）
- `docs/03_ood_phase1.md:148` 中关于 `test_*.cj` 命名约定的描述已更新

## 依赖关系

- `git mv`：Windows Git 可用
- `cjpm build` / `cjpm test`：用于验证
- 本次不修改任何 `.cj` 文件内容，不引入新依赖

## 修订说明

（首轮设计，无修订说明）
