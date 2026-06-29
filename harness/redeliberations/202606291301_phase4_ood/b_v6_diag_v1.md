# 质量审查报告 — a_v6_design_v2.md

## 审查维度

本次审查作为第 6 次迭代的外部质量审查，侧重内部审议（设计-验证循环）未充分覆盖的维度：需求响应充分度、整体深度和完整性、可落地性。内部审议已确认的维度（如技术可行性、函数签名正确性等）不在本审查中重复验证。

---

## 发现的问题

### P1（严重）— geometric.cj 的 Vec 几何函数未纳入 lib.cj 导出

**所在位置**：§8 lib.cj 更新（第 883-906 行）

**问题描述**：`detail/geometric.cj` 的 `dot/cross/normalize/length/distance/reflect/refract/faceforward` 是阶段四替换 stub 为完整实现的 Vec 类型几何函数。但 §8 的 lib.cj 增量导出方案中完全未包含这些函数的 `public import`。

当前 `lib.cj`（`cjglm/src/lib.cj:15`）仅导入了 `glm.ext.{dot, length, normalize, cross}`，这些都是 **Quat** 版本的几何函数（来自 `ext/quaternion_geometric.cj`）。Vec 版本的几何函数从未被导出，用户无法通过 `glm` 包访问。

`trigonometric.cj` 的 `sin/cos/...` 已在 `lib.cj:12` 预先导入（阶段三遗留），因此设计认为"已有 import 自动生效"。但 `geometric.cj` 的函数从未被导入，不适用此推理。

**改进建议**：在 §8 lib.cj 更新代码块中增加 `public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}`。注意需要确认这些符号与 `lib.cj:15` 的 `glm.ext.{dot, length, normalize, cross}`（Quat 版本）在仓颉重载解析下不会歧义——Vec 参数与 Quat 参数类型不同，应可自动区分。

---

### P2（严重）— matrix.cj 的 determinant/inverse 未纳入 lib.cj 导出

**所在位置**：§8 lib.cj 更新（第 883-906 行）

**问题描述**：`detail/matrix.cj` 的 `determinant`（Mat2x2/Mat3x3/Mat4x4）和 `inverse`（Mat2x2/Mat3x3/Mat4x4）是阶段四替换 stub 为完整实现的核心能力。§8 lib.cj 更新未包含任何 matrix.cj 相关导出。

当前 `lib.cj:14` 已导入 `glm.ext.{inverse}`，这是 **Quat** 版本的 `inverse`（来自 `ext/quaternion_common.cj`）。Mat 版本的 `determinant` 和 `inverse` 均无法通过 `glm` 包访问。用户如需调用 `glm.inverse(mat4)` 将无法编译，或者虽然可编译但解析到 Quat 版本而类型不匹配报错。

**改进建议**：在 §8 lib.cj 更新中增加 `public import glm.detail.{determinant, inverse}`。确认 `detail.inverse`（Mat 参数）与 `ext.inverse`（Quat 参数）的重载解析无歧义。

---

### P3（严重）— ext/matrix_projection.cj 函数计数与清单不一致

**所在位置**：§3.2 ext/matrix_projection.cj 职责（第 444 行）

**问题描述**：设计声称呼应 GLM 1.0.3 `ext/matrix_projection.hpp` 的"全部 8 个函数"，但紧接其后的函数签名清单仅列出 7 个函数（projectZO/projectNO/project/unProjectZO/unProjectNO/unProject/pickMatrix）。计数（8）与清单（7）自相矛盾。

若第 8 个函数确实存在，则设计遗漏了该函数的签名定义，编码阶段将导致函数缺失。若实际为 7 个，则计数错误会误导后续实施。

**改进建议**：核对 GLM 1.0.3 `ext/matrix_projection.hpp` 的实际函数数量，修正为正确值，并确保清单与计数一致。

---

### P4（一般）— Vec1 normalize 在职责清单中缺失，形成内部矛盾

**所在位置**：§3.1 geometric.cj 职责（第 291-294 行）vs. §5 错误表（第 781 行）

**问题描述**：§3.1 geometric.cj 的 `normalize` 职责明确限定为"Vec2~Vec4 版本"（第 291 行），排除 Vec1。但紧接着第 293-294 行详细描述了"Vec1 normalize 的零值行为"（使用通式 `v * inversesqrt(dot(v, v))`，零值返回 NaN）。§5 错误表第 781 行也包含了"Vec1 零向量 normalize 返回 NaN"的条目。

设计在此处自相矛盾：职责清单未定义 Vec1 normalize 函数，但行为描述和错误表均假设 Vec1 normalize 存在。实现者无法判断需不需要实现 Vec1 normalize。

GLM 1.0.3 支持所有 dimension 的 normalize，包括 Vec1。因此预期结果应是补充 Vec1 版本到职责清单中，而非删除行为描述。

**改进建议**：在 §3.1 geometric.cj 的 `normalize` 职责中补充 Vec1 版本，使职责清单、行为描述和错误表三方一致。同时确认 `dot` 是否有 Vec1 重载（`dot` 的职责描述涵盖 Vec1~Vec4）。

---

### P5（一般）— ext/scalar_common.cj 和 ext/vector_common.cj 的公共函数未纳入 lib.cj 导出

**所在位置**：§8 lib.cj 更新（第 883-906 行）

**问题描述**：`ext/scalar_common.cj`（17 个函数）和 `ext/vector_common.cj`（20 个函数）是本阶段新建的公共扩展函数库。前者提供 `fmin/fmax/fclamp/iround/uround/纹理环绕` 等标量函数，后者提供对应的向量逐分量版本。但这些新增的公共 API 函数完全未出现在 §8 lib.cj 导出清单中。

下游消费者无法通过 `glm.fmin(a,b)`、`glm.fclamp(x,min,max)`、`glm.iround(x)` 等调用这些函数，而需要直接 `import glm.ext.fmin`，与 lib.cj 作为"公共 API 面"的设计定位矛盾。

§8 仅导入了 ext 的矩阵变换函数（translate/rotate/scale/shear/lookAt 系族），未覆盖 scalar_common 和 vector_common。

**改进建议**：在 §8 lib.cj 更新中补充 ext/scalar_common.cj 和 ext/vector_common.cj 的公共函数导出。注意：`ext/scalar_common.cj` 的单参数 `clamp(Texcoord)` 与 `detail/common.cj` 的三参数 `clamp(a, min, max)` 签名不同，重载解析可自动区分，但需在设计中注明此差异。

---

### P6（一般）— slerp 退化条件阈值未定义，编码阶段不可直接实现

**所在位置**：§3.2 ext/quaternion_common.cj（第 475 行）、§7 D09（第 811 行）

**问题描述**：设计声明 slerp 在 sinOmega 接近零时退化为 lerp，但仅给出 `epsilon<T>() * T(10)` 或类似经验值的模糊建议，未定义具体阈值。编码阶段需要明确的数值判断条件而非"类似经验值"。

GLM 1.0.3 中使用了明确的 epsilon 比较（`sinOmega < ...`），设计应引用或直接给出仓颉实现中的等价条件。

**改进建议**：在 §3.2 slerp 实现路径或 D09 中明确定义退化阈值表达式，例如直接指定 `if sinOmega < epsilon<T>()` 或引用 GLM 1.0.3 源码中的精确条件（包括具体的 epsilon 倍数）。

---

### P7（一般）— mod 浮点重载的处理策略未明确

**所在位置**：§3.1 common.cj（第 239 行）、§7 D15（第 817 行）

**问题描述**：D15 声明 `mod` 当前约束为 `Integer<T>`，"未来可考虑补充 FloatingPoint<T> 浮点重载"。但实际已有代码（`cjglm/src/detail/scalar_vec_ops.cj`）中，已存在 `mod<T, Q>(s: Float32, v: Vec1/2/3/4<Float32, Q>)` 等 12 个具体浮点类型向量重载（每个 Float32/Float64/Float16 各 4 个 Vec 维度）。设计未阐明这些既有浮点重载在阶段四的处理策略——是保留、迁移到 `common.cj`，还是删除以使约束统一？

若保留，则 `mod` 的约束策略不仅是 `Integer<T>`，而是"标量 Integer<T> + 向量 Float32/64/16 具体重载混合"，与设计描述不完全一致。若删除或重构，则应标注为向后不兼容变更。

**改进建议**：在 D15 中补充 `scalar_vec_ops.cj` 中既有浮点重载的处理策略说明，对齐描述与实际代码状态。

---

## 整体质量评价

设计文档经 6 轮迭代后，在事实准确性、一致性、深度方面有显著提升。核心函数设计（common/exponential/trigonometric/geometric/matrix）的接口定义清晰，实现路径明确，异常和边界条件已覆盖。模块划分和依赖关系合理，实施批次拓扑排序正确。

**主要薄弱环节在 lib.cj 导出策略**：设计对 geometric.cj、matrix.cj(determinant/inverse)、ext/scalar_common.cj、ext/vector_common.cj 的公共 API 导出存在系统性遗漏。这些函数在 §3.1/§3.2/§3.3 中有完善的设计，但未被纳入 lib.cj 的 `public import` 清单中，导致下游消费者无法通过 `glm` 包访问。此问题直接影响设计的可落地性和完整性。

修复 P1/P2/P5 后，本设计可达到直接指导编码实现的程度。
