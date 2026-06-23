# GLM 1.0.3 仓颉迁移——阶段化路线图

> **基线文档**：`docs/01_roadmap.md`（v13）
> **状态**：阶段 1 已完成；阶段 2~6 为待规划
> **最终产出路径**：本规划文档最终应写入 `docs/migration_phases.md`

---

## 阶段 1：基础设施 + 向量核心（已完成）

**目标**：实现 GLM 中最基础、被依赖最多的类型层——基础设施配置、精度/对齐策略标记、四个分量数的向量类型及类型别名体系，在仓颉语言下独立可编译运行。

**范围**：
- 配置层（`setup.cj`）：`length_t` 定义、`GLM_CONFIG_*` 常量等效声明（18 项，全部选最保守值）、基础辅助函数
- 精度/对齐策略（`qualifier.cj`）：`Qualifier` 接口 + 6 个实现类型（`PackedHighp`、`PackedMediump`、`PackedLowp`、`AlignedHighp`、`AlignedMediump`、`AlignedLowp`）
- Shim 层（3 文件）：`shim_assert.cj`（断言替代）、`shim_limits.cj`（类型限值查询）、`shim_cstddef.cj`（`SizeT`/`LengthT` 别名）
- 向量辅助模板（3 文件）：`compute_vector_relational.cj`（相等比较策略）、`compute_vector_decl.cj`（运算策略结构体）、`vectorize.cj`（functor 工具集）
- 标量-向量运算辅助：`scalar_vec_ops.cj`
- 向量类型（4 文件）：`Vec1<T,Q>` ~ `Vec4<T,Q>` 泛型结构体定义 + 运算符重载 + 分量访问
- 工厂函数：`type_fromBoolVec.cj`
- 类型转换：`type_cast.cj`
- 类型别名层（`fwd.cj`）：标量类型别名 10 个基本类型 + 精度变体 + 向量别名（16 家族 × 4 分量数 × 4 精度变体 = 256 个别名）

**关键依赖**：无外部依赖。所有依赖闭合于阶段 1 内部。

**产出物**：
- `cjglm/src/detail/setup.cj`
- `cjglm/src/detail/qualifier.cj`
- `cjglm/src/detail/shim_*.cj`（3 文件）
- `cjglm/src/detail/compute_vector_*.cj`（2 文件）
- `cjglm/src/detail/vectorize.cj`
- `cjglm/src/detail/scalar_vec_ops.cj`
- `cjglm/src/detail/type_vec{1,2,3,4}.cj`（4 文件）
- `cjglm/src/detail/type_fromBoolVec.cj`、`type_cast.cj`
- `cjglm/src/fwd.cj`、`cjglm/src/lib.cj`
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
- 9 个矩阵类型实现文件（`type_mat2x2.cj` ~ `type_mat4x4.cj`）
- 矩阵测试文件
- `ext/` 别名文件（向量/矩阵别名具现化）
- 矩阵类型别名（更新 `fwd.cj`）
- 函数库 stub 文件（3 个，为方阵 `.inl` 编译提供依赖闭合）：`common.cj`、`matrix.cj`、`geometric.cj`

**验证标准**：
- 矩阵创建、行列访问、基本算术运算（`+`、`-`、`*`）
- `mat2x2`~`mat4x4` 各基本类型实例化
- `ext/vector_float2.cj` 等别名文件引用 `Vec2` 成功
- 矩阵-向量乘法语义正确性验证

---

## 阶段 3：四元数类型 + 附带 ext/gtc 依赖

**目标**：迁移四元数类型及其必需的 ext/gtc 依赖文件，使库具备旋转/插值表达能力。

**范围**：
- `type_quat.cj` + `type_quat.inl`：四元数类型定义、旋转构造、插值运算
- `ext/vector_relational.cj`：向量关系运算函数（type_quat 完整编译依赖）
- `ext/quaternion_relational.cj`：四元数关系运算函数
- `gtc/constants.cj`：数学常量定义
- `gtc/matrix_transform.cj`——**本阶段以空桩占位**（仅提供函数签名空壳），完整实现归入阶段 4
- 承载 `gtc/matrix_transform.cj` 传递依赖的 stub 文件：`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`trigonometric.cj`（4 个本阶段新增空桩）；`geometric.cj`、`matrix.cj`（2 个继承自阶段 2 的 stub）
- `ext/` 下四元数别名文件（`quaternion_float.cj`、`quaternion_double.cj` 等）
- 四元数相关函数库（`ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 等）

**关键依赖**：
- **前置依赖**：阶段 1 完成（向量类型）、阶段 2 完成（矩阵类型）
- 内部分层依赖：`gtc/matrix_transform.cj` 的传递依赖链覆盖除 qua 和 gtx/ 以外的几乎所有类型层，该文件是阶段 3 中范围最广的依赖项。其传递依赖包括 `ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`geometric.cj`、`trigonometric.cj`、`matrix.cj`——其中 `geometric.cj` 和 `matrix.cj` 已在阶段 2 以 stub 占位，本阶段沿用；其余 4 个文件（`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`trigonometric.cj`）**本阶段以空桩占位**
- `ext/vector_relational.cj` 和 `gtc/constants.cj` 依赖链最浅（均止于 `qualifier.cj`/`setup.cj`），可完整实现
- `ext/quaternion_relational.cj` 依赖链涉及函数库层，可完整实现

**产出物**：
- `type_quat.cj` + `type_quat.inl`（四元数核心类型，完整实现）
- `ext/vector_relational.cj`（完整实现）
- `ext/quaternion_relational.cj`（完整实现）
- `gtc/constants.cj`（完整实现）
- `gtc/matrix_transform.cj`（空桩占位）
- 空桩文件（4 个新增）：`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`trigonometric.cj`
- 继承自阶段 2 的 stub 文件（2 个，沿用）：`geometric.cj`、`matrix.cj`
- 四元数别名文件（`ext/quaternion_float.cj`、`ext/quaternion_double.cj` 等）
- 四元数相关函数库文件（`ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 等）
- 四元数测试文件

**验证标准**：
- 四元数构造（单位构造、旋转轴-角构造、矩阵-四元数互转）
- 四元数基本运算（乘法、共轭、逆、归一化）
- 球面线性插值（slerp）操作
- `quat` 类型别名可用性

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
  - `ext/scalar_constants.cj`、`ext/vector_relational.cj`（阶段 3 已完成，沿用）等
- **gtc/ 扩展函数库**：
  - `gtc/matrix_transform.cj`——**本阶段完整实现**（阶段 3 中仅 stub，含其全部传递依赖：`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`geometric.cj`、`trigonometric.cj`、`matrix.cj`）
  - `gtc/matrix_inverse.cj`、`gtc/matrix_access.cj`
  - `gtc/packing.cj`、`gtc/noise.cj`、`gtc/random.cj`
  - `gtc/type_precision.cj`、`gtc/ulp.cj`、`gtc/round.cj`、`gtc/constants.cj`（阶段 3 已完成，沿用）等

**关键依赖**：
- **前置依赖**：阶段 1-3 完成（全部核心类型就绪）
- 内部依赖：函数库之间可能存在相互调用（`geometric.cj` 调用 `common.cj`、`trigonometric.cj` 等），需按拓扑顺序分批迁移

**产出物**：
- 约 20~30 个函数库实现文件（`*.cj`）
- 对应测试文件
- 更新 `lib.cj` 公共 API 重导出

**验证标准**：
- 各函数库单元测试通过
- 数值精度与原 GLM 一致性的抽样验证
- 函数库间交叉调用场景的集成测试

---

## 阶段 5：SIMD 优化特化 + 平台检测

**目标**：在基础功能稳定后按需添加平台特化代码，提升关键路径性能。

**范围**：
- SIMD 优化特化：为 Vec3/Vec4 等高频类型提供 SIMD 加速路径
- `simd/platform.h` 等效实现：平台检测宏的完整迁移（功能已在阶段 1 `setup.cj` 中以最简形式内联处理；完整实现推迟至此阶段）
- 条件编译路径的宏/编译期配置替代方案验证

**关键依赖**：
- **前置依赖**：阶段 1-4 完成（全部功能和函数库就绪）
- 外部依赖：仓颉编译器对 SIMD 基础类型的支持程度（需在实施时确认）

**产出物**：
- SIMD 加速通道实现文件（如 `type_vec_simd.cj`）
- 平台检测配置更新（`setup.cj` 扩展）
- 性能基准测试

**验证标准**：
- 与标量路径的数值等价性（结果一致）
- 性能提升可测量（量化指标）
- 非 SIMD 平台的退化路径仍可编译运行

---

## 阶段 6：gtx/ 实验性扩展 + 按需补充

**目标**：按实际使用需求选择性迁移 GLM 的 `gtx/` 实验性扩展。

**范围**：
- `gtx/*` 全部实验性扩展文件（如 `gtx/transform.cj`、`gtx/quaternion.cj`、`gtx/matrix_decomposition.cj` 等）
- 首轮范围中排除的文件重新评估（如 swizzle 功能的替代机制设计）

**关键依赖**：
- **前置依赖**：阶段 1-5 完成
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
       └── 阶段 3（四元数 + 空桩文件：4 新增 + 2 继承自阶段 2，gtc/matrix_transform 占位）
            └── 阶段 4（函数库，替换全部空桩为完整实现）
                 └── 阶段 5（SIMD + 平台）
                      └── 阶段 6（gtx 扩展，按需）
```

| 阶段 | 内容 | 前置依赖 | 状态 | 复杂度评估 |
|------|------|---------|------|-----------|
| 1 | 基础设施 + Vec1~4 + 别名 | 无 | **已完成** | 中 |
| 2 | 9 个矩阵类型 + ext/ 别名 + 3 stub | 阶段 1 | 待启动 | 中（模式重复，量 9×） |
| 3 | 四元数 + ext/gtc 依赖（4 新增空桩 + 2 继承 stub） | 阶段 1-2 | 待启动 | 中高（跨层次、传递依赖链重） |
| 4 | 函数库（core/ext/gtc，替换全部空桩） | 阶段 1-3 | 待启动 | 高（量大面广，约 20~30 文件） |
| 5 | SIMD 特化 + 平台检测 | 阶段 1-4 | 待启动 | 中（平台相关，需编译器支持确认） |
| 6 | gtx 实验性扩展 | 阶段 1-5 | 待启动 | 低（按需选择性迁移） |

## 修订说明（v3）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. Stage 2 矩阵 `.inl` 函数库依赖描述不精确——方阵与非方阵的依赖差异未区分 | **修改**——在 Stage 2 "范围"中明确区分：仅 `type_mat2x2`/`type_mat3x3`/`type_mat4x4` 的 `.inl` 引用函数库头文件，其余 6 个非方阵 `.inl` 无此依赖。方阵具体依赖路径：`type_mat2x2.inl` → `matrix.cj`；`type_mat3x3.inl` → `matrix.cj`、`common.cj`；`type_mat4x4.inl` → `matrix.cj`、`geometric.cj` |
| 2. Stage 2 与 Stage 3 之间 stub 文件归属存在逻辑矛盾——Stage 2 范围提及 stub 但产出物未包含，`common.cj` stub 悬空 | **修改（方案 A）**——将 3 个 stub（`common.cj`、`matrix.cj`、`geometric.cj`）明确纳入 Stage 2 产出物清单，确保 Stage 2 编译验证的依赖闭合性。Stage 3 对应调整：从 6 新空桩中移除 `geometric.cj` 和 `matrix.cj`（改为注明"阶段 2 已创建，沿用"），新增 4 个独立空桩。`common.cj` stub 归属问题消除——由 Stage 2 创建后供全部后续阶段沿用。 |
| 3. 跨阶段文件归属标注不完整——Stage 3 已完成文件在 Stage 4 中未加沿用标注 | **修改**——在 Stage 4 `ext/` 文件清单中标注 `ext/vector_relational.cj` 为"（阶段 3 已完成，沿用）"；在 `gtc/` 文件清单中标注 `gtc/constants.cj` 为"（阶段 3 已完成，沿用）"。 |
| 4. 缺少最终产出物写入目的地的说明 | **修改**——在文件头部添加"最终产出路径：本规划文档最终应写入 `docs/migration_phases.md`"。 |
