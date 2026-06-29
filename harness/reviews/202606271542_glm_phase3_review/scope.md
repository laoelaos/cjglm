# 审查范围界定

## 审查对象

`harness/implements/202606271030_glm_phase3_impl` 分支 squash merge 到 `main` 的全部变更。

## 审查依据

- **主依据**：`docs/05_ood_phase3.md`——GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案
- **辅助参考**：`docs/02_roadmap.md`——阶段化路线图（阶段三的范围说明）
- **偏差声明**：`docs/deviations.md`——仓颉 GLM 与 C++ GLM 偏差记录

## 审查范围（按 OOD 包组织划分）

### 1. `glm/detail` 核心实现层（新增）

| 文件 | 职责 |
|------|------|
| `cjglm/src/detail/type_quat.cj` | `Quat<T,Q>` 结构体 + 运算符 + 工厂函数 |
| `cjglm/src/detail/type_quat_cast.cj` | `mat3Cast`/`mat4Cast`/`quatCast` 矩阵-四元数互转 |
| `cjglm/src/detail/scalar_constants.cj` | `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 标量常量 |
| `cjglm/src/detail/scalar_quat_ops.cj` | 标量-四元数运算（`add`/`sub`/`mul`/`div`） |
| `cjglm/src/detail/trigonometric.cj` | 三角函数库空桩 |

### 2. `glm.ext` 扩展函数库（新增）

| 文件 | 职责 |
|------|------|
| `cjglm/src/ext/quaternion_common.cj` | 四元数公共函数（`conjugate`/`inverse`/`lerp`/`mix`/`slerp`） |
| `cjglm/src/ext/quaternion_geometric.cj` | 四元数几何函数（`dot`/`length`/`normalize`/`cross`） |
| `cjglm/src/ext/quaternion_relational.cj` | 四元数关系运算 |
| `cjglm/src/ext/quaternion_trigonometric.cj` | 四元数三角函数 |
| `cjglm/src/ext/quaternion_transform.cj` | 四元数变换函数 |
| `cjglm/src/ext/quaternion_exponential.cj` | 四元数指数函数 |
| `cjglm/src/ext/vector_relational.cj` | 向量关系运算（epsilon + ULP） |
| `cjglm/src/ext/scalar_constants.cj` | 标量常量重导出 |
| `cjglm/src/ext/matrix_projection.cj` | 矩阵投影函数库空桩 |
| `cjglm/src/ext/matrix_clip_space.cj` | 裁剪空间矩阵函数库空桩 |
| `cjglm/src/ext/matrix_transform.cj` | 矩阵变换扩展函数库空桩 |
| `cjglm/src/ext/quaternion_float.cj` | Float32 四元数别名 |
| `cjglm/src/ext/quaternion_double.cj` | Float64 四元数别名 |
| `cjglm/src/ext/quaternion_float_precision.cj` | Float32 精度变体别名 |
| `cjglm/src/ext/quaternion_double_precision.cj` | Float64 精度变体别名 |

### 3. `glm.gtc` GTC 扩展函数库（新增）

| 文件 | 职责 |
|------|------|
| `cjglm/src/gtc/constants.cj` | 数学常量定义（28 个常量） |
| `cjglm/src/gtc/quaternion.cj` | gtc 四元数扩展函数库 |
| `cjglm/src/gtc/matrix_transform.cj` | 矩阵变换函数库（空桩/部分实现） |

### 4. `glm` 顶层（修改）

| 文件 | 变更 |
|------|------|
| `cjglm/src/lib.cj` | 新增 20 个 `public import` 导出 |
| `cjglm/src/fwd.cj` | 新增 9 个 Quat 类型别名 |
| `cjglm/scripts/gen_fwd_aliases.py` | 增加 Quat 家族生成代码 |

### 5. 测试文件（新增）

`cjglm/tests/glm/**/*` 全部新增测试文件。

## 重点审查维度

1. **正确性**：逻辑、边界条件、类型约束、错误处理
2. **设计合理性**：与 OOD §1「核心抽象」/§2「模块划分」/§3「核心抽象」的一致性
3. **包间依赖方向**：`glm.detail` 不依赖上层；`glm.gtc → glm.detail` 单向；无循环依赖（OOD §2「模块间依赖」）
4. **T(0)/T(1) 字面量替代路径**：使用 `T(Float64(n))` 模式而非 `one - one` 演算（除非函数签名含 `one: T`）（OOD §1「系统性设计约束」）
5. **stub 与降级路径**：4 个 ⚠️ 函数（Quat×Vec3/Vec4 + Vec3×Quat/Vec4×Quat）正确抛 `Exception("stub")`；其余 stub 函数标记为占位
6. **Cangjie 语言特性**：extend 块约束、泛型语法、`Number<T>`/`FloatingPoint<T>`/`FloatingPoint<T> & Comparable<T>` 等约束选择
7. **测试覆盖**：每个公开函数至少一个正向测试用例
8. **lib.cj 公共导出**：20 个 import 全部到位
9. **fwd.cj 自动生成脚本**：9 个 Quat 别名（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度），幂等性

## 排除范围

- `harness/implements/202606271030_glm_phase3_impl/` 目录下的过程产物（plan/requirement/task/code/detail/test/verify 系列 md 文件）——这些是审议过程记录，非交付物
- `cjglm/src/fwd.cj.bak` 备份文件——属于应当清理的临时文件，纳入审查但不影响主评价
- 与阶段三无关的阶段一/阶段二已有文件

## 审查轮次计划

按逻辑分组分为 4 轮，每轮启动 3 个 agent 并行审查。

- **R1 核心类型层**：`detail/type_quat.cj`、`detail/type_quat_cast.cj`、`detail/scalar_quat_ops.cj` + `detail/scalar_constants.cj`
- **R2 ext/ 四元数函数库**：`ext/quaternion_common.cj` + `ext/quaternion_geometric.cj`、`ext/quaternion_relational.cj` + `ext/quaternion_trigonometric.cj` + `ext/quaternion_transform.cj` + `ext/quaternion_exponential.cj`、`ext/vector_relational.cj`
- **R3 ext/ 通用 + gtc/ + 顶层**：`gtc/constants.cj` + `gtc/quaternion.cj`、`gtc/matrix_transform.cj` + `ext/matrix_*.cj` + `detail/trigonometric.cj`、`fwd.cj` + `lib.cj` + `gen_fwd_aliases.py`
- **R4 测试与跨模块集成**：`tests/glm/detail/*`、`tests/glm/ext/*` + `tests/glm/gtc/*`、`tests/glm/test_fwd.cj` + `tests/glm/test_lib.cj` + 跨模块依赖方向校验