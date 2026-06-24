# 审查范围界定

## 审查目标
将 `implements/202606231417_ood_phase2` 的全部变更 squash merge 到 `main` 之前的代码质量审查。

## 依据
- **OOD 设计**：`docs/04_ood_phase2.md`（仓颉阶段二矩阵类型设计方案）
- **路线图参考**：`docs/02_roadmap.md` 阶段 2
- **偏差说明**：`docs/deviations.md`

## 范围
审查暂存区（`git diff --cached`）中全部 164 个变更文件，涵盖：

### 核心代码（`cjglm/src/`）
- 9 个矩阵类型文件：`detail/type_mat2x2.cj` ~ `detail/type_mat4x4.cj`
- 3 个函数库文件：`detail/common.cj`、`detail/matrix.cj`（混合型：27 实 + 6 stub）、`detail/geometric.cj`
- 标量-矩阵运算：`detail/scalar_mat_ops.cj`
- Vec 类型扩展：`detail/type_vec2.cj`、`type_vec3.cj`、`type_vec4.cj`（新增行向量×矩阵运算符）
- 公共 API：`fwd.cj`（新增矩阵类型别名）、`lib.cj`（公共导出）
- `ext/` 子包 24 个别名文件（8 个矩阵 float + 8 个矩阵 double + 4 个 vector float + 4 个 vector double）

### 测试（`cjglm/tests/`）
- 矩阵单元测试 9 个：`test_type_mat2x2.cj` ~ `test_type_mat4x4.cj`
- 矩阵相关：`test_type_mat_compare.cj`、`test_vec_mat_mul.cj`、`test_scalar_mat_ops.cj`、`test_matrix.cj`、`test_common.cj`、`test_geometric.cj`、`test_geometric_refract.cj`
- 集成与 API：`test_integration_matrix.cj`、`test_fwd.cj`、`test_lib.cj`、`test_ext.cj`

### 文档与过程产物
- `docs/prompt.md`、`harness/implements/202606231417_ood_phase2/`（过程产物）
- **审查时重点关注**：核心实现代码与测试代码；过程产物作为背景参考不审查细节

## 排除范围
- harness/implements/202606231417_ood_phase2/ 下的过程性 v*_review / v*_plan / v*_code / v*_test / v*_detail / v*_verify / v*_design_review 文件（实现过程的中间产物）
- docs/01_tech_decision.md、docs/03_ood_phase1.md（阶段一已完成）

## 重点审查维度
1. **正确性**：矩阵乘法语义、对角线/单位矩阵填充、跨尺寸转换正确性、Mat4x4←Mat4x2 已知偏差是否被正确实现
2. **设计合理性**：9 个独立结构体的代码重复模式是否合理、extend 块约束设计、T(0)/T(1) 演算策略一致性
3. **仓颉语言特性**：extend 块使用、@OverflowWrapping 标注、@Derive[Hashable]、结构体/运算符规范用法
4. **可读性/可维护性**：命名约定（a{col}{row} 参数、c0~c{C-1} 列向量）、结构清晰度
5. **测试完整性**：测试覆盖率、边界条件（NaN、零、负数、对角线溢出）、特殊偏差方向测试

## 审查轮次规划

| 轮次 | Agent | 范围 |
|------|-------|------|
| Round 1 | A1 | 9 个 type_mat*.cj 结构体定义 + 构造函数 + 行列访问 |
| Round 1 | A2 | 9 个 type_mat*.cj 中的算术运算符 + scalar_mat_ops.cj |
| Round 1 | A3 | 9 个 type_mat*.cj 中的跨类型转换（fromParts/fromColumns/fromMat 6a/6b/同尺寸） |
| Round 2 | A1 | stub 文件（common.cj/matrix.cj/geometric.cj）+ 测试 |
| Round 2 | A2 | type_vec2/3/4.cj 的行向量×矩阵运算符 + test_vec_mat_mul.cj |
| Round 2 | A3 | ext/ 别名文件 + fwd.cj + lib.cj + 集成测试 |
| Round 3 | A1 | 已知偏差处理：Mat4x4←Mat4x2、Bool 矩阵、NaN 传播 |
| Round 3 | A2 | 测试质量与覆盖率审查 |
| Round 3 | A3 | deviations.md 交叉验证：实现是否引入新偏差 / 是否解决了已有未验证偏差 |

## 审查范围文件清单

详见 `git diff --cached --name-only` 输出，共 164 文件，42800 行变更。