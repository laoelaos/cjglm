# GLM 1.0.3 仓颉迁移——阶段化路线图

> **基线文档**：`docs/01_roadmap.md`（v13）
> **状态**：阶段 1 已完成；阶段 2~6 为待规划
> **最终产出路径**：本规划文档最终应写入 `docs/migration_phases.md`
> **过程产物说明**：本文档末尾的"修订说明"章节为审议迭代过程记录，在最终写入 `docs/migration_phases.md` 时将被清除，不作为最终交付物的一部分。

---

## 阶段 1：基础设施 + 向量核心（已完成）

**目标**：实现 GLM 中最基础、被依赖最多的类型层——基础设施配置、精度/对齐策略标记、四个分量数的向量类型及类型别名体系，在仓颉语言下独立可编译运行。

**范围**：
- 配置层（`setup.cj`）：`length_t` 定义、`GLM_CONFIG_*` 常量等效声明（18 项，全部选最保守值）、基础辅助函数
- 精度/对齐策略（`qualifier.cj`）：`Qualifier` 接口 + 6 个实现类型（`PackedHighp`、`PackedMediump`、`PackedLowp`、`AlignedHighp`、`AlignedMediump`、`AlignedLowp`）
- Shim 层（3 文件）：`shim_assert.cj`（断言替代）、`shim_limits.cj`（类型限值查询）、`shim_cstddef.cj`（`SizeT`/`LengthT` 别名）
- 向量辅助模板（3 文件）：`compute_vector_relational.cj`（相等比较策略）、`compute_vector_decl.cj`（运算策略结构体）、`vectorize.cj`（functor 工具集）
- 标量-向量运算辅助：`scalar_vec_ops.cj`（新增 CangJie 适配：对标 GLM 中 `detail/_vectorize.hpp` 的 functor 模式，提供标量与向量分量间的逐分量运算支持，在 GLM 中由模板偏特化隐式实现，仓颉需独立文件显式实现）
- 向量类型（4 文件）：`Vec1<T,Q>` ~ `Vec4<T,Q>` 泛型结构体定义 + 运算符重载 + 分量访问
- 工厂函数：`type_fromBoolVec.cj`（新增 CangJie 适配：对标 GLM 中 `detail/type_vec*.inl` 内联的 `make_vec_from_bool` 构造辅助，仓颉需独立文件提供布尔向量创建功能）
- 类型转换：`type_cast.cj`（新增 CangJie 适配：对标 GLM 中 `detail/type_vec*.inl` 内联的类型转换构造，仓颉需独立文件实现跨类型向量转换）
- 类型别名层（`fwd.cj`）：标量类型别名 10 个基本类型 + 精度变体 + 向量别名（16 家族 × 4 分量数 × 4 精度变体 = 256 个别名）

**关键依赖**：无外部依赖。所有依赖闭合于阶段 1 内部。

**产出物**：
- `detail/setup.cj`
- `detail/qualifier.cj`
- `detail/shim_*.cj`（3 文件）
- `detail/compute_vector_*.cj`（2 文件）
- `detail/vectorize.cj`
- `detail/scalar_vec_ops.cj`
- `detail/type_vec{1,2,3,4}.cj`（4 文件）
- `detail/type_fromBoolVec.cj`、`detail/type_cast.cj`
- `fwd.cj`、`lib.cj`（lib.cj 初始导出向量类型）
- 配套测试文件（各模块 `*_test.cj`）

**验证标准**：
- 依赖闭合性：11 核心文件 + 3 shim 文件编译无缺失引用
- 独立可编译性：`cjpm build` 通过，不依赖任何阶段 1 外的组件
- 基础功能：Vec 类型构造、`[]` 分量访问、算术/比较运算符、类型别名实例化
- 溢出策略：复合赋值运算符标注 `@OverflowWrapping`（~16 处），二元运算符委托继承 wrapping 语义
- SIMD 禁用：`GLM_CONFIG_SIMD=false` 消除 `type_vec_simd.inl` 条件依赖

---

## 阶段 2：矩阵类型 + `ext/` 别名文件

**目标**：在向量类型基础上，迁移全部 9 个矩阵类型及关联别名，使库具备二维/三维/四维矩阵的数学表达能力。

**范围**：
- 9 个矩阵类型（`Mat2x2<T,Q>` ~ `Mat4x4<T,Q>`），内部以向量列为数据成员
- 矩阵运算符重载（构造、行列访问、矩阵-矩阵乘、矩阵-向量乘、算术运算）
- 矩阵 `.inl` 实现中引用的函数库头文件：`type_mat2x2.inl` 引用 `matrix.cj`；`type_mat3x3.inl` 引用 `matrix.cj`、`common.cj`；`type_mat4x4.inl` 引用 `matrix.cj`、`geometric.cj`——本阶段以 stub 占位；其余 6 个非方阵 `.inl`（`type_mat2x3`、`type_mat2x4`、`type_mat3x2`、`type_mat3x4`、`type_mat4x2`、`type_mat4x3`）无此依赖，无需 stub
- `ext/` 下的向量/矩阵别名文件（如 `ext/vector_float2.cj`、`ext/matrix_float4x4.cj` 等），仅含 type alias 和精度变体
- 矩阵类型别名（`fwd.cj` 中的矩阵别名部分）
- 可选：`type_float.cj`、`type_half.cj`（浮点类型标签，仅依赖 `setup.cj`）

**关键依赖**：
- **前置依赖**：阶段 1 完成（Vec1~Vec4 类型定义就绪）
- 内部依赖：`type_mat2x2`/`type_mat3x3`/`type_mat4x4` 的 `.inl` 实现需 `common.cj`/`matrix.cj`/`geometric.cj` stub 占位（本阶段创建）；其余 6 个非方阵 `.inl` 无此依赖；`.cj` 声明文件可独立编译

**产出物**：
- 9 个矩阵类型实现文件（`detail/type_mat2x2.cj` ~ `detail/type_mat4x4.cj`）
- 矩阵测试文件
- `ext/` 别名文件（向量/矩阵别名具现化）
- 矩阵类型别名（更新 `fwd.cj`）
- 函数库 stub 文件（3 个，为方阵 `.inl` 编译提供依赖闭合）：`common.cj`、`matrix.cj`、`geometric.cj`
- **更新 `lib.cj`**：添加矩阵类型和 `ext/` 别名的公共导出

**验证标准**：
- 矩阵创建、行列访问、基本算术运算（`+`、`-`、`*`）
- `mat2x2`~`mat4x4` 各基本类型实例化
- `ext/vector_float2.cj` 等别名文件引用 `Vec2` 成功
- 矩阵-向量乘法语义正确性验证
- `lib.cj` 导出矩阵类型可被外部包正确 import

---

## 阶段 3：四元数类型 + 附带 ext/gtc 依赖

**目标**：迁移四元数类型及其必需的 ext/gtc 依赖文件，使库具备旋转/插值表达能力。

**范围**：
- `type_quat.cj` + `type_quat.inl`：四元数类型定义、旋转构造、插值运算（**完整实现**）
- `ext/vector_relational.cj`：向量关系运算函数（type_quat 完整编译依赖，**完整实现**）
- `ext/quaternion_relational.cj`：四元数关系运算函数（**完整实现**）
- `ext/quaternion_transform.cj`、`ext/quaternion_common.cj`：四元数变换和公共函数库（**大部分实现**，lookRotate 等依赖 `geometric.cj` 的函数以 stub 占位或延迟实现，与 `geometric.cj` 同步就绪）
- `ext/scalar_constants.cj`：标量数学常量（`gtc/constants.cj` 的前置依赖，仅依赖 `setup.cj`，**完整实现**）
- `gtc/constants.cj`：数学常量定义（**完整实现**）
- `gtc/matrix_transform.cj`——**本阶段以空桩占位**（仅提供函数签名空壳），完整实现归入阶段 4
- 承载 `gtc/matrix_transform.cj` 传递依赖的 stub 文件：`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`trigonometric.cj`（4 个本阶段新增空桩）；`geometric.cj`、`matrix.cj`（2 个继承自阶段 2 的 stub）
- `ext/` 下四元数别名文件（`quaternion_float.cj`、`quaternion_double.cj` 等）

**关键依赖**：
- **前置依赖**：阶段 1 完成（向量类型）、阶段 2 完成（矩阵类型）
- 内部分层依赖：`gtc/matrix_transform.cj` 的传递依赖链覆盖除 qua 和 gtx/ 以外的几乎所有类型层，该文件是阶段 3 中范围最广的依赖项。其传递依赖包括 `ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`geometric.cj`、`trigonometric.cj`、`matrix.cj`——其中 `geometric.cj` 和 `matrix.cj` 已在阶段 2 以 stub 占位，本阶段沿用；其余 4 个文件（`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`trigonometric.cj`）**本阶段以空桩占位**
- `ext/scalar_constants.cj` 和 `gtc/constants.cj` 依赖链最浅（均止于 `setup.cj`），可完整实现
- `ext/vector_relational.cj` 依赖链止于 `qualifier.cj`/`setup.cj`，可完整实现
- `ext/quaternion_relational.cj` 依赖链涉及四元数类型（阶段 3 完整实现），可完整实现
- `ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 依赖链除四元数类型和矩阵类型外，还涉及 `geometric.cj`（阶段 3 中为 stub），因 `geometric.cj` 本阶段为 stub 导致为**大部分实现**；其中不依赖 `geometric.cj` 的函数（如 `conjugate`、`inverse`、`angleAxis`、`rotate` 等）可完整实现，依赖 `geometric.cj` 的函数（如 `lookRotate`）以 stub 占位，待阶段 4 `geometric.cj` 完整实现后补齐

**产出物**：
- **完整实现**：
  - `detail/type_quat.cj` + `detail/type_quat.inl`（四元数核心类型）
  - `ext/vector_relational.cj`（向量关系运算）
  - `ext/quaternion_relational.cj`（四元数关系运算）
  - `ext/scalar_constants.cj`（标量常量，`gtc/constants.cj` 前置依赖）
  - `gtc/constants.cj`（数学常量）
- **大部分实现**（lookRotate 等依赖 geometric.cj 的函数以 stub 占位，与 geometric.cj 同步就绪）：
  - `ext/quaternion_transform.cj`（四元数变换函数）
  - `ext/quaternion_common.cj`（四元数公共函数）
- **空桩占位**：
  - `gtc/matrix_transform.cj`
  - `ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`trigonometric.cj`（4 个新增空桩）
- **沿用自阶段 2 的 stub**：`geometric.cj`、`matrix.cj`
- 四元数别名文件（`ext/quaternion_float.cj`、`ext/quaternion_double.cj` 等）
- 四元数测试文件
- **更新 `lib.cj`**：添加四元数类型、ext/gtc 常量和别名文件的公共导出

**验证标准**（标注 `[可验证]` 表示本阶段可完整执行；标注 `[待 Stage 4]` 表示因底层 stub 占位暂时不可执行；标注 `[部分可验证]` 表示部分功能可执行，依赖 stub 的部分待下一阶段）：
- 四元数构造（单位构造、旋转轴-角构造、矩阵-四元数互转）`[可验证]`
- 四元数基本运算（乘法、共轭、逆、归一化）`[可验证]`
- 球面线性插值（slerp）操作 `[可验证]`
- `quat` 类型别名可用性 `[可验证]`
- `ext/vector_relational.cj`：向量关系比较函数（`equal`、`notEqual`、`lessThan` 等）在整数/浮点向量上的正确性 `[可验证]`
- `ext/quaternion_relational.cj`：四元数相等比较和近似比较函数 `[可验证]`
- `ext/quaternion_transform.cj`：四元数旋转构造（`angleAxis`）、旋转变换（`rotate`）的基本功能 `[部分可验证，lookRotate 等依赖 geometric.cj 的函数待 Stage 4]`
- `ext/quaternion_common.cj`：四元数常用函数（`conjugate`、`inverse`、`normalize` 等跨类型运算）`[可验证]`
- `ext/scalar_constants.cj`：标量常量定义的正确性（`epsilon`、`pi` 等数值常量）`[可验证]`
- `gtc/constants.cj`：数学常量（`pi`、`two_pi`、`root_pi`、`half_pi`、`epsilon` 等）定义正确性 `[可验证]`
- `lib.cj` 导出四元数类型和常量可被外部包正确 import `[可验证]`

---

## 阶段 4：函数库（core / ext / gtc）

**目标**：迁移 GLM 全部核心函数库和扩展函数库，使库具备完整的 GLSL 风格数学运算能力。

**范围**：
- **基础函数库**：
  - `common.cj`：`min`、`max`、`clamp`、`lerp`、`step`、`smoothstep` 等
  - `matrix.cj`：矩阵运算函数（`transpose`、`determinant`、`inverse` 等）——**本阶段完整实现**（阶段 2/3 中仅 stub）
  - `geometric.cj`：几何函数（`dot`、`cross`、`normalize`、`reflect`、`refract` 等）——**本阶段完整实现**（阶段 2/3 中仅 stub）
  - `exponential.cj`：指数函数（`pow`、`exp`、`log`、`sqrt`、`inversesqrt` 等）
  - `trigonometric.cj`：三角函数（`sin`、`cos`、`tan`、`asin`、`acos`、`atan` 等）——**本阶段完整实现**（阶段 3 中仅 stub）
- **ext/ 扩展函数库**：
  - `ext/scalar_common.cj`：标量公共函数
  - `ext/vector_common.cj`：向量公共函数
  - `ext/matrix_transform.cj`、`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`——**本阶段完整实现**（阶段 3 中均仅 stub）
  - `ext/quaternion_transform.cj`、`ext/quaternion_common.cj`——**本阶段补齐依赖 `geometric.cj` 的函数的完整实现**（阶段 3 中标注为"大部分实现"，`lookRotate` 等函数在 `geometric.cj` 就绪后在本阶段完成全部实现）
  - `ext/scalar_constants.cj`（阶段 3 已完成，沿用）、`ext/vector_relational.cj`（阶段 3 已完成，沿用）等
- **gtc/ 扩展函数库**：
  - `gtc/matrix_transform.cj`——**本阶段完整实现**（阶段 3 中仅 stub，含其全部传递依赖：`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`geometric.cj`、`trigonometric.cj`、`matrix.cj`）
  - `gtc/matrix_inverse.cj`、`gtc/matrix_access.cj`
  - `gtc/packing.cj`、`gtc/noise.cj`、`gtc/random.cj`
  - `gtc/type_precision.cj`、`gtc/ulp.cj`、`gtc/round.cj`、`gtc/constants.cj`（阶段 3 已完成，沿用）等

**关键依赖**：
- **前置依赖**：阶段 1-3 完成（全部核心类型就绪）
- 内部依赖：函数库之间可能存在相互调用；建议按拓扑依赖分批实施（参见下方实施批次建议）
- **跨阶段遗留处理**：阶段 3 中 `ext/quaternion_transform.cj` 和 `ext/quaternion_common.cj` 因依赖 `geometric.cj` 而未完整实现的函数（如 `lookRotate`），在本阶段 `geometric.cj` 完整实现后一并补齐

**实施批次建议（按拓扑依赖排序）**：
- **第一批（无函数库内部依赖）**：`common.cj`、`exponential.cj`、`ext/scalar_common.cj`——不依赖同阶段其他函数库，可优先独立实现
- **第二批（依赖基础函数库）**：`trigonometric.cj`、`matrix.cj`、`ext/vector_common.cj`——依赖 `common.cj`、`exponential.cj` 提供的基础运算
- **第三批（依赖前两批）**：`geometric.cj`、`ext/matrix_transform.cj`、`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`——依赖三角函数、矩阵运算等
- **第四批（gtc/ 扩展函数库）**：全部 `gtc/` 文件——依赖前序 core/ext 函数库全部就绪

**产出物**：
- **基础函数库（core）**：
  - `exponential.cj`：完整实现（新增，无前序 stub）
  - `common.cj`：完整实现（替换阶段 2 的 stub）
  - `matrix.cj`、`geometric.cj`：完整实现（替换阶段 2 的 stub）
  - `trigonometric.cj`：完整实现（替换阶段 3 的 stub）
- **ext/ 扩展函数库**：
  - `ext/scalar_common.cj`、`ext/vector_common.cj`：完整实现
  - `ext/matrix_transform.cj`、`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`：完整实现（替换阶段 3 的 stub）
  - `ext/quaternion_transform.cj`、`ext/quaternion_common.cj`：完整实现（替换阶段 3 的"大部分实现"，补齐依赖 `geometric.cj` 的函数）
  - `ext/scalar_constants.cj`、`ext/vector_relational.cj`：沿用自阶段 3
- **gtc/ 扩展函数库**：
  - `gtc/matrix_transform.cj`：完整实现（替换阶段 3 的 stub）
  - `gtc/matrix_inverse.cj`、`gtc/matrix_access.cj`、`gtc/packing.cj`、`gtc/noise.cj`、`gtc/random.cj`：完整实现
  - `gtc/type_precision.cj`、`gtc/ulp.cj`、`gtc/round.cj`：完整实现
  - `gtc/constants.cj`：沿用自阶段 3
- 各函数库对应测试文件
- 更新 `lib.cj` 公共 API 重导出

**验证标准**（按实施四批拓扑分组，标注`[替换 stub]`或`[新建]`以区分验证侧重）：

- **第一批（`[替换 stub]` `common.cj`、`[新建]` `exponential.cj`、`[新建]` `ext/scalar_common.cj`）**：
  - 各函数的正确性验证：`min`、`max`、`clamp`、`lerp` 等基础运算在整数/浮点输入下产生正确结果
  - `common.cj` 中 `float` 和 `double` 精度的分支覆盖
  - `exponential.cj` 中 `sqrt`/`inversesqrt` 在零/负输入等边界条件下的正确行为
  - 单元测试覆盖率：每个公开函数至少一个正向测试用例

- **第二批（`[替换 stub]` `trigonometric.cj`、`matrix.cj`、`ext/vector_common.cj`）**：
  - `trigonometric.cj`：三角函数在特殊角度（0、π/2、π、2π）及最常见角度的数值精度抽样
  - `matrix.cj`：`transpose`、`determinant`、`inverse` 在 2x2/3x3/4x4 矩阵上的正确性，`inverse` 在奇异矩阵上的行为（零/不可逆）
  - 验证替换后的 stub 调用点可正确编译和运行（无链接/重定义错误）
  - 与原 GLM 对应函数的数值结果一致性（至少 3 组输入抽样）

- **第三批（`[替换 stub]` `geometric.cj`、`ext/matrix_transform.cj`、`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`；`[补齐]` `ext/quaternion_transform.cj`、`ext/quaternion_common.cj`）**：
  - `geometric.cj`：`dot`、`cross`、`normalize`、`reflect`、`refract` 等几何函数的正确性验证，`normalize` 零向量行为（除以零保护或契约定义）
  - ext 矩阵变换三文件：投影矩阵/视口变换/裁剪空间矩阵的数学正确性（透视/正交投影基本属性验证）
  - `ext/quaternion_transform.cj`：全部函数（含 `lookRotate`等前序 stub）完成实现并验证
  - `ext/quaternion_common.cj`：补齐后全部函数的集成编译与基本功能验证

- **第四批（`[新建]` 全部 `gtc/` 扩展函数库）**：
  - 每个 gtc 模块独立编译通过
  - `gtc/matrix_inverse.cj`、`gtc/matrix_access.cj` 等矩阵相关模块的矩阵运算正确性
  - `gtc/packing.cj`、`gtc/noise.cj`、`gtc/random.cj` 等数值模块的抽样测试
  - 各 gtc 模块对 core/ext 函数库的无缺失引用

- **集成验证**（跨批次）：
  - 函数库间交叉调用场景的集成测试（如 `gtc/matrix_transform.cj` 调用 `geometric.cj` 和 `trigonometric.cj` 的完整调用链）
  - `lib.cj` 更新后外部包可正确 import 所有公开函数
  - 全部 stub 已替换为完整实现——确认无存留空桩文件引用

---

## 阶段 5：SIMD 优化特化 + 平台检测

**目标**：在基础功能稳定后按需添加平台特化代码，提升关键路径性能。

**范围**：
- SIMD 优化特化：为 Vec3/Vec4 等高频类型提供 SIMD 加速路径
- `simd/platform.h` 等效实现：平台检测宏的完整迁移（功能已在阶段 1 `setup.cj` 中以最简形式内联处理；完整实现推迟至此阶段）
- 条件编译路径的宏/编译期配置替代方案验证
- **降级路径定义**（当仓颉编译器不提供 SIMD 基础类型时适用）：本阶段范围缩减为——① `type_vec3.cj`/`type_vec4.cj` 在当前非 SIMD 标量路径下的数值正确性验证（覆盖全部向量运算、几何函数、矩阵运算场景）；② 性能基线数据采集——各关键函数标量路径的执行时间记录并输出，作为后续 SIMD 加速路径的性能对比基线；③ `setup.cj` 平台检测配置扩展按原计划更新（完整性验证）。降级路径不产出 `type_vec_simd.cj`，待仓颉提供 SIMD 支持后重新激活

**关键依赖**：
- **前置依赖**：阶段 1-4 完成（全部功能和函数库就绪）
- 外部依赖：仓颉编译器对 SIMD 基础类型的支持程度。**基线文档（`docs/01_roadmap.md` 第 364 行）已明确记载 "CangJie 当前版本不提供 SIMD 基础类型"**。若无 SIMD 基础类型支持，本阶段范围的 SIMD 加速路径（Vec3/Vec4 特化）整体不可实施，需在实施前确认仓颉版本是否已新增 SIMD 支持；若确认不支持，按本阶段"范围"中定义的降级路径执行

**产出物**：
- SIMD 加速通道实现文件（如 `type_vec_simd.cj`）——**仅在 SIMD 可用时产出**
- 平台检测配置更新（`setup.cj` 扩展）
- 性能基准测试/基线数据

**验证标准**：
- **[前置条件]** 确认当前仓颉编译器版本已提供 SIMD 基础类型——
  - **若已支持**：执行 SIMD 加速路径完整实现，适用"完整路径"验证标准
  - **若不支持**：执行降级路径，适用"降级路径"验证标准（详见"范围"中的降级路径定义）
- **完整路径（SIMD 可用）**：
  - 与标量路径的数值等价性（SIMD 结果与标量结果一致）
  - 性能提升可测量（量化指标，与标量基线对比）
  - 非 SIMD 平台的退化路径仍可编译运行
- **降级路径（SIMD 不可用）**：
  - `type_vec3.cj`/`type_vec4.cj` 在当前标量路径下的数值正确性验证通过（覆盖全部向量运算、几何函数、矩阵运算场景）
  - 性能基线数据采集完成并输出至指定文件：
    - **最少覆盖函数范围**：`Vec3` 5 个核心运算（构造、加法、点积、叉积、归一化），`Vec4` 5 个核心运算（构造、加法、点积、分量乘法、归一化），`Mat4` 2 个核心运算（矩阵乘、行列式），`geometric.cj` `dot`/`normalize`/`reflect` 共 3 个函数——合计约 15 个关键函数
    - **输出格式**：CSV 格式，包含字段 `function_name, input_size, mean_us, median_us, min_us, max_us, stddev_us, sample_count`
    - **最少测量要求**：每个函数至少 1000 次重复测量，记录每次的执行时间并计算统计量
    - **输出目标**：写入 `benchmark/scalar_baseline.csv`，附带简要的可视化汇总报告（至少包含各函数均值的柱状对比图，`.png` 或 `.svg` 格式）
  - `setup.cj` 平台检测配置扩展编译通过
  - 本阶段不产出 SIMD 加速实现文件，标记为待仓颉提供 SIMD 支持后重新激活

---

## 阶段 6：gtx/ 实验性扩展 + 按需补充

**目标**：按实际使用需求选择性迁移 GLM 的 `gtx/` 实验性扩展。

**范围**：
- `gtx/*` 选定的实验性扩展文件（按实际需求选择性迁移，如 `gtx/transform.cj`、`gtx/quaternion.cj`、`gtx/matrix_decomposition.cj` 等）
- 基线文档首轮迁移范围中排除的文件重新评估，其中 `_swizzle.hpp` 的 swizzle 功能替代机制设计（详见 `docs/01_roadmap.md` 第 4.5 节）需明确：
  - **设计路线选择倾向**：推荐成员函数路线（如 `v.swizzle(x, y)`），也可评估操作符路线（如 `v[xyzw]` 语法糖）的可行性，最终需根据仓颉语言特性支持程度确定
  - **设计约束**：兼容 GLM 现有 swizzle API 语义（分量选择、重组、写入），或提供仓颉原生风格的简化 API——需在 OOD 阶段做具体决策
  - **实施前提**：需确认仓颉是否支持编译期分量选择表达式或宏/内联展开机制，否则可能需退化为运行时分量访问模式
- gtx 模块选择优先级参考：
  - ① 被阶段 1-4 已交付组件直接引用的 gtx 模块优先（如 `gtx/quaternion` 被 `ext/quaternion_common` 引用）
  - ② 与已迁移类型（向量/矩阵/四元数）紧密耦合的模块优先（如 `gtx/matrix_decomposition`、`gtx/transform`）
  - ③ 剩余模块按实际项目需求排序，无明确需求时暂缓迁移

**关键依赖**：
- **前置依赖**：阶段 1-4 完成（阶段 5 非前置依赖）
- 按需驱动：无强制迁移要求，根据用户需求选择性实施

**产出物**：
- 选定的 `gtx/` 扩展实现文件
- swizzle 替代 API

**验证标准**：
- 选定的每个 gtx 模块独立编译通过
- 各模块单元测试通过（至少包含构造和核心函数调用）
- 模块之间无循环依赖
- 与阶段 1-5 已有接口无冲突

---

## 阶段依赖总览

```
阶段 1（向量核心） ← 已完成
  └── 阶段 2（矩阵类型，含 3 stub 供方阵 .inl 编译）
       └── 阶段 3（四元数 + 完整实现 ext/scalar_constants/ext/vector_relational/ext/quaternion_*/gtc/constants
            │          + 空桩文件：4 新增 + 2 继承自阶段 2，gtc/matrix_transform 占位）
            └── 阶段 4（函数库，替换全部空桩为完整实现）
                 ├── 阶段 5（SIMD + 平台）
                 └── 阶段 6（gtx 扩展，按需）
```

| 阶段 | 内容 | 前置依赖 | 状态 | 复杂度评估 |
|------|------|---------|------|-----------|
| 1 | 基础设施 + Vec1~4 + 别名 | 无 | **已完成** | 中 |
| 2 | 9 个矩阵类型 + ext/ 别名 + 3 stub + lib.cj 更新 | 阶段 1 | 待启动 | 中（模式重复，量 9×） |
| 3 | 四元数 + ext/gtc 常量/关系/变换函数库 + 4 新增空桩 + 2 继承 stub + lib.cj 更新 | 阶段 1-2 | 待启动 | 中高（跨层次、传递依赖链重） |
| 4 | 函数库（core/ext/gtc，替换全部空桩） | 阶段 1-3 | 待启动 | 高（约 5 个 core 函数库 + 约 5 个 ext/ 函数库 + 约 9 个 gtc/ 函数库，按拓扑分四批实施） |
| 5 | SIMD 特化 + 平台检测 | 阶段 1-4 | 待启动 | 中（平台相关，需编译器支持确认） |
| 6 | gtx 实验性扩展 | 阶段 1-4 | 待启动 | 低（按需选择性迁移） |

## 修订说明（v4）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. **严重**：`ext/scalar_constants.cj` 跨阶段归属错误——Stage 4 标注"阶段 3 已完成，沿用"但 Stage 3 全文未提及该文件 | **修改**——在 Stage 3 的范围、关键依赖和产出物中明确纳入 `ext/scalar_constants.cj`（完整实现）。理由：`ext/scalar_constants` 是 `gtc/constants` 的硬性前置依赖（仅依赖 `setup.cj`，属最轻量级），Stage 3 已将 `gtc/constants.cj` 列为完整实现，必须同步处理其前置依赖以保持一致性 |
| 2. **严重**：`ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 等四元数函数库文件实现状态未定义 | **修改**——在 Stage 3 范围中明确标注为"完整实现"，并补充各文件的最小验证标准。理由：这些函数库依赖四元数类型（Stage 3 完整实现）和矩阵类型（Stage 2 已就绪），依赖链闭合于阶段 3 范围内；部分依赖 `geometric.cj` 的函数（如 `lookRotate`）以 stub 占位或延迟实现 |
| 3. **一般**：Stage 3 验证标准未覆盖全部产出物——仅检验四元数核心类型，未覆盖 `ext/vector_relational.cj`、`ext/quaternion_relational.cj`、`gtc/constants.cj` | **修改**——为 Stage 3 中每个非桩交付物（`ext/vector_relational.cj`、`ext/quaternion_relational.cj`、`ext/quaternion_transform.cj`、`ext/quaternion_common.cj`、`ext/scalar_constants.cj`、`gtc/constants.cj`）补充最少验证标准 |
| 4. **一般**：`lib.cj` 更新未覆盖 Stage 2 和 Stage 3 | **修改**——在 Stage 2 产出物中增加"更新 `lib.cj`：添加矩阵类型和 `ext/` 别名的公共导出"；在 Stage 3 产出物中增加"更新 `lib.cj`：添加四元数类型、ext/gtc 常量和别名文件的公共导出" |

## 修订说明（v5）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. **严重**：Stage 6 "全部" vs "选择性"表述矛盾 | **修改**——将 Stage 6 范围中的"全部实验性扩展文件"改为"选定的实验性扩展文件（按实际需求选择性迁移）"，消除与关键依赖中"按需驱动"的语义矛盾 |
| 2. **一般**：Stage 3 验证标准 stub 影响未标注 | **修改**——为每个验证项添加 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 状态标注，明确区分可执行范围和因 stub 占位暂不可执行的项目 |
| 3. **一般**：Stage 5 SIMD 风险描述过于乐观 | **修改**——将"需在实施时确认"改为明确的风险标注，引用基线文档"仓颉当前版本不提供 SIMD 基础类型"的明确结论，并说明若无 SIMD 支持则本阶段范围不可行 |
| 4. **轻微**：Stage 1 非基线文件来源未说明 | **修改**——为 `scalar_vec_ops.cj`、`type_fromBoolVec.cj`、`type_cast.cj` 补充标注，说明其均为新增 CangJie 适配文件，分别对应 GLM 中各向量类型 `.inl` 内联实现的特定功能 |

## 修订说明（v6）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. **严重**：Stage 6 前置依赖不应包括 Stage 5（第 5 轮问题 1 持续存在） | **修改**——将 Stage 6 前置依赖从"阶段 1-5 完成"修正为"阶段 1-4 完成（阶段 5 非前置依赖）"，依赖关系图中 Stage 5→Stage 6 串行改为并行分支。理由：gtx 扩展为纯数学函数库，仅依赖核心类型和函数库（阶段 1-4），与 SIMD 优化（阶段 5）无技术依赖关系，与基线文档将二者列为同轮次并行可选项的表述一致 |
| 2. **一般**：Stage 4 产出物清单粒度不足（第 5 轮问题 2 持续存在） | **修改**——将 Stage 4 产出物从"约 20~30 个函数库实现文件"扩展为按 core/ext/gtc 分组的具体文件清单，标注各文件实现状态（完整实现/替换 stub/沿用），与 Stage 1-3 的文件清单格式保持一致 |
| 3. **轻微**："首轮范围"指代模糊 | **修改**——将"首轮范围中排除的文件重新评估"替换为"基线文档首轮迁移范围中排除的文件重新评估"，并补充示例（`_swizzle.hpp` 的 swizzle 功能）及引用（`docs/01_roadmap.md` 第 4.5 节） |
| 4. **轻微**：各阶段文件路径表达方式不一致 | **修改**——统一将各阶段产出物中的路径调整为以 `cjglm/src/` 为基准的相对路径：Stage 1 从 `cjglm/src/detail/` 简化为 `detail/`、`cjglm/src/` 简化为直接文件名；Stage 2 矩阵类型文件增加 `detail/` 前缀；Stage 3 四元数类型文件增加 `detail/` 前缀；Stage 4 核心函数库保持与 Stage 2-3 一致的裸文件名表达 |

## 修订说明（v7）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. **一般**：Stage 4 内部拓扑顺序缺失（迭代 6 问题 1，连续三轮提出） | **修改**——在 Stage 4 关键依赖后新增"实施批次建议"小节，按`common.cj`/`exponential.cj`/`scalar_common.cj`→`trigonometric.cj`/`matrix.cj`/`vector_common.cj`→`geometric.cj`/ext 矩阵变换→全部 gtc/ 的四批次拓扑顺序给出指引 |
| 2. **一般**：Stage 5 验证标准缺少 SIMD 前置条件检查（迭代 6 问题 2，连续三轮提出） | **修改**——在 Stage 5 验证标准首条补充`[前置条件]`检查项，要求确认仓颉编译器是否已提供 SIMD 基础类型，否则降级为纯标量路径验证或推迟 |
| 3. **一般**：Stage 6 swizzle 替代 API 范围界定不足（迭代 6 问题 3，连续三轮提出） | **修改**——在 Stage 6 范围中将 swizzle 替代机制条目扩展为设计路线（成员函数/操作符）、设计约束（兼容 GLM API 或新 API）、实施前提（仓颉编译期特性支持）三项明确说明 |
| 4. **轻微**：Stage 4 common.cj 和 trigonometric.cj stub 替换标注不一致 | **修改**——将 `common.cj` 从无标注改为"完整实现（替换阶段 2 的 stub）"；将 `trigonometric.cj` 与 `matrix.cj`/`geometric.cj` 分离，改为"完整实现（替换阶段 3 的 stub）"；`exponential.cj` 独立标注"新增，无前序 stub" |
| 5. **轻微**：Stage 6 gtx 扩展缺少选择准则 | **修改**——在 Stage 6 范围末尾补充 3 条选择优先级参考：被已交付组件引用的模块优先、与已迁移类型紧密耦合的模块优先、剩余模块按项目需求排序 |

## 修订说明（v8）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. **严重**：阶段依赖总览表格中 Stage 4 复杂度描述与正文不一致——正文已按 core/ext/gtc 分组给出精确文件清单，但表格仍维持"高（量大面广，约 20~30 文件）" | **修改**——将表格中 Stage 4 复杂度评估更新为"高（约 5 个 core 函数库 + 约 5 个 ext/ 函数库 + 约 9 个 gtc/ 函数库，按拓扑分四批实施）"，与正文按组分类的文件清单精确对应 |
| 2. **一般**：Stage 3 四元数函数库文件"完整实现"标签与实际交付状态不一致——`ext/quaternion_transform.cj` 和 `ext/quaternion_common.cj` 标为"完整实现"但内部存在 stub 占位 | **修改**——在"范围"中将 `ext/quaternion_transform.cj`/`ext/quaternion_common.cj` 标注从"完整实现"改为"大部分实现"并说明 stub 范围；在"产出物"中将这两个文件从"完整实现"分组移入新增的"大部分实现"分组，消除标签与实际情况的语义冲突 |
| 3. **一般**：Stage 5 SIMD 降级路径缺少可执行判定标准——"降级为纯标量路径验证"未定义具体含义、交付物形态和验证通过标准 | **修改**——在"范围"中新增"降级路径定义"小节，明确降级后的三项工作（标量路径数值正确性验证、性能基线采集、平台检测配置更新）和交付物约束（不产出 SIMD 文件）；在"验证标准"中将前置条件拆分为"完整路径"和"降级路径"两组可执行标准；在"产出物"中标注 SIMD 文件为"仅在 SIMD 可用时产出" |

## 修订说明（v9）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. **严重**：Stage 3 中 `ext/quaternion_transform.cj` 和 `ext/quaternion_common.cj` 标注为"大部分实现"且依赖 `geometric.cj` 的函数以 stub 占位，但 Stage 4 完整实现了 `geometric.cj` 后未涉及对这两个四元数函数库文件的更新，形成跨阶段治理真空 | **修改**——在 Stage 4 "范围"中补充声明：本阶段完成 `ext/quaternion_transform.cj` 和 `ext/quaternion_common.cj` 中依赖 `geometric.cj` 的函数的完整实现（`lookRotate` 等）；在"关键依赖"中新增"跨阶段遗留处理"条目；在"产出物"中将这两个文件从"沿用"改为"完整实现（替换阶段 3 的'大部分实现'）"；在"验证标准"第三批中纳入这两个文件的补齐验证要求 |
| 2. **一般**：Stage 4 验证标准仅有 3 条笼统条目，与全计划最高复杂度的阶段严重不匹配——未按四批拓扑分层制定，未区分"替换 stub"与"新建函数库"的不同验证要求，未对关键数值函数正确性提出具体验证条件 | **修改**——按实施四批拓扑重新组织 Stage 4 验证标准，为每批定义具体验证条件；标注 `[替换 stub]`/`[新建]`/`[补齐]` 三类验证侧重；为关键数值函数补充最少正确性验证条件；新增跨批次集成验证条目 |
| 3. **轻微**：Stage 5 降级路径中性能基线交付物约束不充分——缺少输出格式、输出目标、关键函数范围、测量次数/精度的明确指定 | **修改**——在 Stage 5 降级路径验证标准中补充：最少覆盖约 15 个关键函数的范围定义、CSV 输出格式及其字段规范、最少 1000 次重复测量要求、输出目标路径及附带可视化汇总报告的要求 |

## 修订说明（v10）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. **严重**：Stage 3"关键依赖"（第 100 行）声称 `ext/quaternion_transform.cj` 和 `ext/quaternion_common.cj`"可完整实现"，但同一阶段"范围"（第 88 行）标注为"大部分实现"。判断依据遗漏了 `geometric.cj`（阶段 3 中为 stub）这一实际瓶颈，形成直接逻辑矛盾 | **修改**——将 Stage 3 关键依赖中与这两个文件相关的描述拆分为两条：`ext/quaternion_relational.cj` 单列（依赖链闭合于阶段 3，可完整实现）；`ext/quaternion_transform.cj` 与 `ext/quaternion_common.cj` 合并描述，明确说明因 `geometric.cj` 本阶段为 stub 导致为"大部分实现"，并具体说明不依赖 `geometric.cj` 的函数（`conjugate`、`inverse`、`angleAxis`、`rotate` 等）可完整实现、依赖 `geometric.cj` 的函数（`lookRotate` 等）以 stub 占位待阶段 4 补齐 |
| 2. **轻微**：Stage 5 降级路径性能基线将叉积（cross）列为 Vec4 核心操作，但 GLM 1.0.3 中 cross 仅定义于三维向量，不适用于 vec4 | **修改**——将"Vec3/Vec4 各 5 个核心运算（构造、加法、点积、叉积、归一化）"拆分为 Vec3 与 Vec4 各自独立的运算列表：Vec3 保持"构造、加法、点积、叉积、归一化"；Vec4 将"叉积"替换为"分量乘法"，保持 5 个核心操作不变 |
| 3. **轻微**：文档末尾"修订说明"为审议过程产物，未标注在最终写入 docs/ 时是否需要清理，接收方可能将过程记录误认为最终交付物 | **修改**——在文档头部元信息区新增"过程产物说明"行，明确声明修订说明章节在最终写入 `docs/migration_phases.md` 时将被清除，不作为最终交付物的一部分 |

## 修订说明（v11）

| 审查意见 | 处理方式 |
|---------|---------|
| Stage 4 验证标准第 192 行 `common.cj` 标记为 `[新建]` 但该文件是阶段 2 已创建的 stub，Stage 4 应为替换 stub | **修改**——将 `common.cj` 标签从 `[新建]` 修正为 `[替换 stub]`，`exponential.cj` 和 `ext/scalar_common.cj` 保持 `[新建]` 不变 |
