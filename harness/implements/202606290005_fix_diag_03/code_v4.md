# 实现报告（v4）

## 概述
将 `cjglm/tests/` 下 41 个 `test_*.cj` 文件批量重命名为 `*_test.cj`，使 `cjpm test` 默认测试发现规则可找到这些测试文件。同时更新 `docs/03_ood_phase1.md:148` 中关于 `test_*.cj` 命名约定的描述。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
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
| 修改 | `docs/03_ood_phase1.md` | 更新第 148 行，移除"当前 tests/ 下测试文件采用 test_*.cj 前缀命名"的注记 |

## 编译验证
`cjpm build` — 成功，0 errors（仅 pre-existing warnings）

## 设计偏差说明
无偏差
