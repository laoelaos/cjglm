# GLM 1.0.3 仓颉迁移——阶段化路线图

> **基线文档**：`docs/01_roadmap.md`（v13）
> **状态**：阶段 1 已完成；阶段 2~5 为待规划

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
- 矩阵 `.inl` 实现中引用的函数库头文件（`matrix.hpp`、`common.hpp`、`geometric.hpp`）——首版以 stub 占位，后续替换为真实实现
- `ext/` 下的向量/矩阵别名文件（如 `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp` 等），仅含 type alias 和精度变体
- 矩阵类型别名（`fwd.hpp` 中的矩阵别名部分）
- 可选：`type_float.hpp`、`type_half.hpp`（浮点类型标签，仅依赖 `setup.hpp`）

**关键依赖**：
- **前置依赖**：阶段 1 完成（Vec1~Vec4 类型定义就绪）
- 内部依赖：矩阵 `.inl` 实现文件中的函数库头文件需 stub 占位；`.hpp` 声明文件可独立编译

**产出物**：
- 9 个矩阵类型实现文件（`type_mat2x2.cj` ~ `type_mat4x4.cj`）
- 矩阵测试文件
- `ext/` 别名文件（向量/矩阵别名具现化）
- 矩阵类型别名（更新 `fwd.cj`）

**验证标准**：
- 矩阵创建、行列访问、基本算术运算（`+`、`-`、`*`）
- `mat2x2`~`mat4x4` 各基本类型实例化
- `ext/vector_float2.hpp` 等别名文件引用 `Vec2` 成功
- 矩阵-向量乘法语义正确性验证

---

## 阶段 3：四元数类型 + 附带 ext/gtc 依赖

**目标**：迁移四元数类型及其必需的 ext/gtc 依赖文件，使库具备旋转/插值表达能力。

**范围**：
- `type_quat.hpp` + `type_quat.inl`：四元数类型定义、旋转构造、插值运算
- `ext/vector_relational.hpp`：向量关系运算函数（type_quat 完整编译依赖）
- `ext/quaternion_relational.hpp`：四元数关系运算函数
- `gtc/constants.hpp`：数学常量定义
- `gtc/matrix_transform.hpp`：矩阵变换函数（传递依赖最重——覆盖 9 矩阵类型 + 4 向量类型 + 多核心函数库）
- `ext/` 下四元数别名文件（`quaternion_float.hpp`、`quaternion_double.hpp` 等）
- 四元数相关函数库（`ext/quaternion_transform.hpp`、`ext/quaternion_common.hpp` 等）

**关键依赖**：
- **前置依赖**：阶段 1 完成（向量类型）、阶段 2 完成（矩阵类型）
- 内部分层依赖：gtc/matrix_transform.hpp 的传递依赖链覆盖除 qua 和 gtx/ 以外的几乎所有类型层，该文件是阶段 3 中范围最广的依赖项
- 范围弹性：可根据对 ext/gtc 依赖的处理方式（空桩 vs 完整迁移）弹性调整范围大小

**产出物**：
- `type_quat.cj` + `type_quat.inl`
- 四元数相关 ext/gtc 文件（约 4~6 个核心文件 + 若干传递依赖 → 合计约 10~15 文件）
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
  - `common.hpp`：`min`、`max`、`clamp`、`lerp`、`step`、`smoothstep` 等
  - `matrix.hpp`：矩阵运算函数（`transpose`、`determinant`、`inverse` 等）
  - `geometric.hpp`：几何函数（`dot`、`cross`、`normalize`、`reflect`、`refract` 等）
  - `exponential.hpp`：指数函数（`pow`、`exp`、`log`、`sqrt`、`inversesqrt` 等）
  - `trigonometric.hpp`：三角函数（`sin`、`cos`、`tan`、`asin`、`acos`、`atan` 等）
- **ext/ 扩展函数库**：
  - `ext/scalar_common.hpp`：标量公共函数
  - `ext/vector_common.hpp`：向量公共函数
  - `ext/matrix_transform.hpp`、`ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`
  - `ext/scalar_constants.hpp`、`ext/vector_relational.hpp` 等
- **gtc/ 扩展函数库**：
  - `gtc/matrix_transform.hpp`、`gtc/matrix_inverse.hpp`、`gtc/matrix_access.hpp`
  - `gtc/packing.hpp`、`gtc/noise.hpp`、`gtc/random.hpp`
  - `gtc/type_precision.hpp`、`gtc/ulp.hpp`、`gtc/round.hpp`、`gtc/constants.hpp` 等

**关键依赖**：
- **前置依赖**：阶段 1-3 完成（全部核心类型就绪）
- 内部依赖：函数库之间可能存在相互调用（`geometric.hpp` 调用 `common.hpp`、`trigonometric.hpp` 等），需按拓扑顺序分批迁移

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
- `gtx/*` 全部实验性扩展文件（如 `gtx/transform.hpp`、`gtx/quaternion.hpp`、`gtx/matrix_decomposition.hpp` 等）
- 首轮范围中排除的文件重新评估（如 swizzle 功能的替代机制设计）

**关键依赖**：
- **前置依赖**：阶段 1-5 完成
- 按需驱动：无强制迁移要求，根据用户需求选择性实施

**产出物**：
- 选定的 `gtx/` 扩展实现文件
- swizzle 替代 API

**验证标准**：
- 按需验证，无统一强制标准

---

## 阶段依赖总览

```
阶段 1（向量核心） ← 已完成
  └── 阶段 2（矩阵类型）
       └── 阶段 3（四元数）
            └── 阶段 4（函数库）
                 └── 阶段 5（SIMD + 平台）
                      └── 阶段 6（gtx 扩展，按需）
```

| 阶段 | 内容 | 前置依赖 | 状态 | 复杂度评估 |
|------|------|---------|------|-----------|
| 1 | 基础设施 + Vec1~4 + 别名 | 无 | **已完成** | 中 |
| 2 | 9 个矩阵类型 + ext/ 别名 | 阶段 1 | 待启动 | 中（模式重复，量 9×） |
| 3 | 四元数 + ext/gtc 依赖 | 阶段 1-2 | 待启动 | 中高（跨层次、传递依赖链重） |
| 4 | 函数库（core/ext/gtc） | 阶段 1-3 | 待启动 | 高（量大面广，约 20~30 文件） |
| 5 | SIMD 特化 + 平台检测 | 阶段 1-4 | 待启动 | 中（平台相关，需编译器支持确认） |
| 6 | gtx 实验性扩展 | 阶段 1-5 | 按需 | 低（按需选择性迁移） |
