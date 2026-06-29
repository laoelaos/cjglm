# R2 R2: 阶段三 ext/ 四元数关系/三角/变换/指数函数库审查

审查时间：2026-06-27 16:35

### 审查范围

- `cjglm/src/ext/quaternion_relational.cj`（43 行）
- `cjglm/src/ext/quaternion_trigonometric.cj`（27 行）
- `cjglm/src/ext/quaternion_transform.cj`（5 行）
- `cjglm/src/ext/quaternion_exponential.cj`（11 行）

合计 86 行，全部位于 `package glm.ext`，依赖 `glm.detail` 单向。

### 审查依据

- `docs/05_ood_phase3.md` §1（系统性设计约束）/§3.6（四元数关系运算）/§3.9（三角函数）/§3.8（四元数变换）/§3.10（指数函数）/§3.13.2（审计表）
- `docs/deviations.md` DV-05（`==` 精确比较与 `equalEpsilon` const 真空）
- 风格参照 `cjglm/src/ext/vector_relational.cj` + 阶段一 `ComputeEqual<T>` / `ComputeEqualNumeric<T>` 模式

### 整体评价

四个文件实现符合 OOD 阶段三设计意图：

- `quaternion_relational.cj` 完整实现 4 个函数（精确 + epsilon），与 OOD §3.6 完全对齐；与 `vector_relational.cj` 策略一致（内联 abs 模式，避免依赖 `common.cj` stub）；约束选择 (`Equatable<T>` / `Number<T> & Comparable<T>`) 与 OOD §3.6 一致；返回类型 `Vec4<Bool, Q>` 与 OOD §3.6 / GLM 语义一致；与阶段一 `Vec` 的 `==` / `equalEpsilon` 行为对齐（DV-05 行为契约：`epsilon=0` 时严格小于语义返回 `false`）。
- `quaternion_trigonometric.cj` `axis` 函数 GLM 公式、零保护分支、`T(0)/T(1)` 字面量替代均与 OOD §3.9 一致；`angle` / `angleAxis` stub 正确抛 `Exception("stub")`。**存在 1 处与 OOD §1 方案 A 的偏差**（`sqrtT` 私有助手函数走 Float64 转换路径，未直接调用 `std.math.sqrt` 的 T 重载）。
- `quaternion_transform.cj` 仅含 `rotate` stub，与 OOD §3.8 / §3.13 表格一致；约束 `FloatingPoint<T>` 合理。
- `quaternion_exponential.cj` 4 个函数全部 stub，与 OOD §3.10 标注「全部 stub」一致；约束与依赖描述（trigonometric.cj + common.cj + scalar_constants）一致；自身不引用任何 stub（`throw Exception("stub")` 编译期不触发依赖）。

整体代码质量良好，逻辑正确，仅 1 处需关注的设计偏差（见下）。

### 发现

#### [一般] `quaternion_trigonometric.cj:5-8` `sqrtT` 私有助手走 Float64 转换路径，偏离 OOD §1 方案 A「直接调用」策略

- **位置**：`cjglm/src/ext/quaternion_trigonometric.cj:5-8`、`:18`（`sqrtT(tmp1)` 调用）
- **描述**：`axis` 函数体内通过 `sqrtT` 私有助手将 `T` 转 `Float64`、调用 `sqrt(x64)`、再转回 `T`。OOD §3.9 明确指出「`std.math.sqrt` 提供 Float16/Float32/Float64 重载，`tmp1` 类型为 T 时编译器按实例化类型自动选择对应重载，**无需显式 Float64 转换**」、「方案 A 推荐直接调用」；OOD §1「Float32 与 std.math 的交互约束」段亦明确「T=Float32 实例化时直接调用 std.math 对应重载即可」「`std.math.sqrt` 自身已提供 Float32 重载，直接调用即可」。当前实现为 `Float32` 实例化时丢掉了 `std.math.sqrt(Float32)` 的原生 `Float32` 路径（精度与 GLM 行为一致性问题）。
  - 补充：同一 `sqrtT` 模式也出现在同包 `quaternion_geometric.cj:5-8` (`length(q)` 中 `sqrtT(dot(q, q))`)，OOD §3.7 `length` 函数段亦明确指出「T=Float32 实例化时直接调用 `std.math.sqrt(dot_qq)`（直接利用 Float32 重载，无需显式 Float64 转换）。两处共同构成同包级设计模式，建议在阶段四整体修订。
- **建议**：在阶段四实现 trigonometric.cj 时，将 `axis` 函数体改为 `let tmp2 = one / std.math.sqrt(tmp1)`（直接调用，依赖 `import std.math.{ FloatingPoint, sqrt }` 中已有的 `sqrt` 符号；编译器对 `FloatingPoint<T>` 类型 `T` 的 `tmp1` 实例化时按 T 类型选择对应重载）。如 `std.math.sqrt` 对 `FloatingPoint<T>` 泛型调用存在编译兼容性顾虑，可保留 `sqrtT` 助手但应改用 `match (x) { case x32: Float32 => sqrt(x32) as T case x64: Float64 => sqrt(x64) as T }` 模式按 T 实际类型分派调用，保留 Float32 精度路径。本阶段三本审查范围内不阻塞，但应在 review 报告中向阶段四实现者明确传递此偏差。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 1 |
| 轻微 | 0 |

### 总评

四个文件 86 行的实现与 OOD §3.6 / §3.8 / §3.9 / §3.10 设计意图高度一致。`quaternion_relational.cj` 在不依赖 `common.cj` stub 的前提下完整实现 4 个关系函数，约束选择、内联 abs 模式、返回类型 `Vec4<Bool, Q>`、`epsilon=0` 时严格小于语义返回 `false` 的边界契约均与 OOD §3.6 / DV-05 对齐，与 `vector_relational.cj` 策略同源。`quaternion_trigonometric.cj` 的 `axis` 函数 GLM 公式、零保护分支（`1 - x.w*x.w <= 0` 返回 `Vec3(T(0), T(0), T(1))`）、`T(Float64(0))` / `T(Float64(1))` 字面量替代路径与 OOD §3.9 / §1 策略一致；唯一的偏差是 `sqrtT` 助手走 Float64 转换（OOD §1 方案 A 偏好直接调用），但功能正确、阶段三不阻塞。`quaternion_transform.cj` 与 `quaternion_exponential.cj` 的 stub 函数体与约束均与 OOD 一致，依赖项（trigonometric.cj / common.cj / scalar_constants）均为下游阶段四完整实现后再激活，不存在本阶段的 stub 递归依赖问题。代码风格紧凑、命名一致、控制流清晰、错误处理符合 OOD 约定（`throw Exception("stub")`）。本轮唯一需关注的是 `sqrtT` 助手的设计偏差，建议阶段四实施 trigonometric.cj 完整函数体时同步修订 `quaternion_geometric.cj:length` 中的同模式问题。
