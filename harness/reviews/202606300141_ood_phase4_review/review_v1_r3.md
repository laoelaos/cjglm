# R1-R3: OOD 阶段四 stdmath_shim/type_quat_cast/lib.cj 审查

审查时间：2026-06-30

### 审查范围

- `cjglm/src/detail/stdmath_shim.cj`
- `cjglm/src/detail/type_quat_cast.cj`
- `cjglm/src/lib.cj`

### 发现

#### [轻微] lib.cj: `mod` 符号从 `glm.detail` 重复导入

- **位置**：`cjglm/src/lib.cj:5` 和 `cjglm/src/lib.cj:30`
- **描述**：`mod` 被两次从 `glm.detail` 导入——行 5（阶段二 scalar_vec_ops 导入`{add, sub, mul, div, mod}`）和行 30-33（阶段四 common.cj 导入列表包含`mod`）。两次导入源均为同一包 `glm.detail`，第二次 import 不引入新符号，属于冗余操作。不影响编译或运行（已通过 `cjpm build`），但降低代码整洁度。
- **建议**：去除行 30 的 `mod` 导入（该符号已通过行 5 导入），或统一将阶段二的 `mod` 导入合并到阶段四的 common.cj 导入行中。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 0 |
| 轻微 | 1 |

### 总评

三个审查文件质量良好，与 `docs/06_ood_phase4.md` 设计高度一致。

**stdmath_shim.cj**（新建，104 行）：25 个包装函数全部实现，无一遗漏或多余。每个函数均正确遵循 `(x as Float64).getOrThrow()` → `math.<func>(...)` → `(result as T).getOrThrow()` 三步骤模式，泛型约束统一为 `T <: FloatingPoint<T>`。`import std.math as math` 别名用法正确（对标 IMPL-06 决议）。`inversesqrtT` 未包含在该文件中（符合设计——它属于 `exponential.cj` 而非 stdmath_shim）。

**type_quat_cast.cj**（修改，132 行）：IMPL-01 命名冲突已正确解决。`private func sqrtT`（原第 129-132 行）已删除，`import std.math.{ Number, FloatingPoint, sqrt }` 中的 `sqrt` 已移除，`sqrtT` 调用通过同包自动可见性使用 `stdmath_shim.cj` 的包级公共函数。其余代码结构不变，`quatCast`/`mat3Cast`/`mat4Cast` 实现正确。

**lib.cj**（修改，70 行）：阶段四新增的 public import 覆盖完整，无遗漏：
- `glm.detail`：common.cj（26 个函数）、exponential.cj（7 个）、geometric.cj（8 个）、matrix.cj（2 个）、vector_relational.cj（4 个）——全部齐全
- `glm.ext`：scalar_common/vector_common（11 个符号）、matrix_transform/projection/clip_space（translate/rotate/scale/shear/lookAt 系 7 个）——全部齐全
- `glm.gtc`：matrix_inverse、matrix_access、packing、noise、random、type_precision、ulp、round——全部齐全
- 跨包同名符号导入（如 `detail.min` vs `ext.min`、`detail.dot` vs `ext.dot`、`detail.inverse` vs `ext.inverse`）遵循设计 §1.4 H6 约定，依赖编译器按参数类型重载决议

仅有 1 个轻微问题：`mod` 符号从 `glm.detail` 重复导入（行 5 和行 30），不影响功能但属于整洁度问题。
