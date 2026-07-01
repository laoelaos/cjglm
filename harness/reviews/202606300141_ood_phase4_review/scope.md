# 审查范围界定

## 审查目标

对 OOD 阶段四（Phase 4）代码实现进行审查，确认代码实现与设计文档 `docs/06_ood_phase4.md` 的一致性，以及代码质量、正确性和可维护性。

## 审查依据

- **OOD 设计文档**：`docs/06_ood_phase4.md` — GLM 1.0.3 仓颉迁移阶段四 OOD 设计方案
- **路线图**：`docs/02_roadmap.md` — 阶段化路线图（阶段 4 部分）
- **偏差记录**：`docs/deviations.md` — 已知偏差与实现偏差记录
- **项目规范**：`cangjie-regulations` skill

## 审查范围

暂存区全部变更（`git diff --cached`），总计 51 个源文件约 8000+ 行变更。

### 源文件分组

#### 组 A：Core detail 核心函数库（glm.detail）
| 文件 | 变更类型 |
|------|---------|
| `cjglm/src/detail/common.cj` | 替换 stub → 完整实现 |
| `cjglm/src/detail/exponential.cj` | 新建完整实现 |
| `cjglm/src/detail/trigonometric.cj` | 替换 stub → 完整实现 |
| `cjglm/src/detail/geometric.cj` | 替换 stub → 完整实现 |
| `cjglm/src/detail/matrix.cj` | 替换 stub → 完整实现（determinant/inverse） |
| `cjglm/src/detail/stdmath_shim.cj` | 新建 |
| `cjglm/src/detail/vector_relational.cj` | 新建 |
| `cjglm/src/detail/type_quat_cast.cj` | 修改 |

#### 组 B：Ext 扩展函数库（glm.ext）
| 文件 | 变更类型 |
|------|---------|
| `cjglm/src/ext/scalar_common.cj` | 新建完整实现 |
| `cjglm/src/ext/vector_common.cj` | 新建完整实现 |
| `cjglm/src/ext/matrix_transform.cj` | 替换 stub → 完整实现 |
| `cjglm/src/ext/matrix_projection.cj` | 替换 stub → 完整实现 |
| `cjglm/src/ext/matrix_clip_space.cj` | 替换 stub → 完整实现 |
| `cjglm/src/ext/quaternion_common.cj` | 补齐 stub → 完整实现 |
| `cjglm/src/ext/quaternion_transform.cj` | 补齐 stub → 完整实现 |
| `cjglm/src/ext/quaternion_trigonometric.cj` | 补齐 stub → 完整实现 |
| `cjglm/src/ext/quaternion_geometric.cj` | 修改 |

#### 组 C：GTC 扩展函数库（glm.gtc）
| 文件 | 变更类型 |
|------|---------|
| `cjglm/src/gtc/matrix_transform.cj` | 替换 stub → 完整实现 |
| `cjglm/src/gtc/matrix_inverse.cj` | 新建完整实现 |
| `cjglm/src/gtc/matrix_access.cj` | 新建完整实现 |
| `cjglm/src/gtc/packing.cj` | 新建完整实现 |
| `cjglm/src/gtc/noise.cj` | 新建完整实现 |
| `cjglm/src/gtc/random.cj` | 新建完整实现 |
| `cjglm/src/gtc/type_precision.cj` | 新建完整实现 |
| `cjglm/src/gtc/ulp.cj` | 新建完整实现 |
| `cjglm/src/gtc/round.cj` | 新建完整实现 |

#### 组 D：公共 API
| 文件 | 变更类型 |
|------|---------|
| `cjglm/src/lib.cj` | 新增阶段四函数库 public import |

#### 组 E：测试文件
| 文件 | 变更类型 |
|------|---------|
| `cjglm/tests/glm/detail/common_test.cj` | 扩展 |
| `cjglm/tests/glm/detail/exponential_test.cj` | 新建 |
| `cjglm/tests/glm/detail/stdmath_shim_test.cj` | 新建 |
| `cjglm/tests/glm/detail/trigonometric_test.cj` | 新建（替换 stub test） |
| `cjglm/tests/glm/detail/geometric_test.cj` | 扩展 |
| `cjglm/tests/glm/detail/geometric_refract_test.cj` | 扩展 |
| `cjglm/tests/glm/detail/matrix_test.cj` | 扩展 |
| `cjglm/tests/glm/detail/trigonometric_stub_test.cj` | 删除 |
| `cjglm/tests/glm/ext/matrix_clip_space_test.cj` | 新建 |
| `cjglm/tests/glm/ext/matrix_projection_test.cj` | 新建 |
| `cjglm/tests/glm/ext/matrix_transform_test.cj` | 新建 |
| `cjglm/tests/glm/ext/quaternion_common_test.cj` | 扩展 |
| `cjglm/tests/glm/ext/quaternion_transform_test.cj` | 新建 |
| `cjglm/tests/glm/ext/quaternion_trigonometric_test.cj` | 扩展 |
| `cjglm/tests/glm/ext/scalar_common_test.cj` | 新建 |
| `cjglm/tests/glm/ext/vector_common_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/matrix_access_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/matrix_inverse_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/matrix_transform_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/noise_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/packing_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/random_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/round_test.cj` | 新建 |
| `cjglm/tests/glm/gtc/ulp_test.cj` | 新建 |

## 审查重点

1. **设计一致性**：实现是否遵循 OOD 设计文档的签名、约束、行为规范
2. **数学正确性**：核心数学函数的公式实现是否正确（尤其是三角函数越界保护、slerp 退化、matrix inverse 等）
3. **仓颉语言特性**：泛型约束、Option/Result 使用、类型转换模式是否正确
4. **边界处理**：零输入、奇异矩阵、NaN/Inf 传播、越界保护、浮点比较
5. **测试覆盖**：测试用例是否覆盖正向/边界场景

## 排除范围

- `docs/deviations.md` 中已记录并接受的已知偏差（如 DV-01~DV-11、IF-01~IF-05、IMPL-01~IMPL-07）不做重复审查
- `ext/quaternion_exponential.cj`（设计文档 §1.5 明确本阶段不覆盖）
