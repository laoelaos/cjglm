# 实现计划

任务描述：基于 OOD 设计文档 `docs/05_ood_phase3.md` 实现 GLM Phase 3 四元数类型及关联 ext/gtc 依赖库
项目根目录：`C:\Develop\Software\cjglm_wp\cjglm`

## 实施路线

| 轮次 | 任务 | 源文件 | 测试文件 | 状态 |
|------|------|--------|---------|------|
| R1 | detail 基础层（scalar_constants + trigonometric 75 stub） | `src/detail/scalar_constants.cj`, `src/ext/scalar_constants.cj`, `src/detail/trigonometric.cj` | `tests/glm/detail/test_scalar_constants.cj`, `tests/glm/detail/test_trigonometric_stub.cj` | ✅ |
| R2 | 四元数类型体系（type_quat + type_quat_cast + scalar_quat_ops） | `src/detail/type_quat.cj`, `src/detail/type_quat_cast.cj`, `src/detail/scalar_quat_ops.cj` | `tests/glm/detail/test_type_quat.cj`, `tests/glm/detail/test_type_quat_cast.cj`, `tests/glm/detail/test_scalar_quat_ops.cj` | ✅ |
| R3 | ext/ 函数库（四元数几何/关系/向量/通用/三角函数 + stub/别名，共 ~14 文件） | `src/ext/quaternion_geometric.cj`, `src/ext/quaternion_relational.cj`, `src/ext/vector_relational.cj`, `src/ext/quaternion_common.cj`, `src/ext/quaternion_trigonometric.cj`, `src/ext/quaternion_transform.cj`, `src/ext/quaternion_exponential.cj`, `src/ext/matrix_projection.cj`, `src/ext/matrix_clip_space.cj`, `src/ext/matrix_transform.cj`, `src/ext/quaternion_float.cj`, `src/ext/quaternion_double.cj`, `src/ext/quaternion_float_precision.cj`, `src/ext/quaternion_double_precision.cj` | `tests/glm/ext/test_quaternion_geometric.cj`, `tests/glm/ext/test_quaternion_relational.cj`, `tests/glm/ext/test_vector_relational.cj`, `tests/glm/ext/test_quaternion_common.cj`, `tests/glm/ext/test_quaternion_trigonometric.cj` | ✅ |
| R4 | gtc/ 子包（构建验证 + constants + quaternion + matrix_transform） | `src/gtc/proto_gtc.cj`, `src/gtc/proto_export.cj`, `src/gtc/constants.cj`, `src/gtc/quaternion.cj`, `src/gtc/matrix_transform.cj` | `tests/glm/gtc/test_constants.cj`, `tests/glm/gtc/test_quaternion.cj` | ✅ |
| R5 | lib.cj + fwd.cj 生成脚本 + 全库构建验证 | `src/lib.cj`, `scripts/gen_fwd_aliases.py` | `tests/glm/test_lib.cj`, `tests/glm/test_fwd.cj` | ✅ |

---

## R1 NEW detail 基础层
任务：实现 (a) `detail/scalar_constants.cj` 中 3 个标量常量函数 epsilon/pi/cos_one_over_two + `ext/scalar_constants.cj` 重导出；(b) `detail/trigonometric.cj` 中 75 个 stub 函数签名
选择理由：底层依赖优先——scalar_constants 是 gtc/constants.cj、四元数三角函数的前置依赖；trigonometric stubs 是 slerp/angle/angleAxis 的传递依赖。两者均仅依赖已有 `setup.cj`，无交叉依赖，可合并为一轮实现
上下文：
- scalar_constants: `epsilon<T>()` 委托 `epsilonOf<T>(T(Float64(0)))`（复用 shim_limits.cj）；`pi<T>()` 使用 `FloatingPoint<T>.getPI()` 静态方法；`cos_one_over_two<T>()` 使用硬编码值策略（OOD §3.12 line 806），通过 `match (T(Float64(0)))` 运行时分派，Float32 返回 `Float32(0.877582561890372716)`，Float64 返回 `Float64(0.877582561890372716)`
- trigonometric: OOD §3.13.1 完整 75 签名模板，所有函数体统一 `throw Exception("stub")`。含 14 个单参数三角函数 × 5 签名（标量 + Vec1~Vec4）+ 1 个 atan2 × 5 签名，合计 75 函数签名

---

## R2 NEW 四元数类型体系
任务：实现 (a) `detail/type_quat.cj` Quat<T,Q> 泛型结构体（4 public var x/y/z/w + 逐分量/标量+向量/跨 Qualifier 构造 + fromQuat/fromMat3/fromMat4/identity 工厂 + 一元/二元运算符 + 下标 + length 查询）；(b) `detail/type_quat_cast.cj` mat3Cast/mat4Cast/quatCast 四个包级转换函数；(c) `detail/scalar_quat_ops.cj` add/sub/mul/div 四个标量-四元数全局运算函数
选择理由：四元数类型是阶段三所有 ext/gtc 模块的数据基础。type_quat.cj 的 fromMat3/fromMat4 工厂函数依赖同包 type_quat_cast.cj，合并为同一轮消除编译依赖缺失问题（review r5 方案 C）。scalar_quat_ops.cj 紧耦合于 Quat 类型一并实现
上下文：
- type_quat: OOD §3.1-§3.4。依赖阶段二的 Vec3/Vec4/Mat3x3/Mat4x4。`T(0)/T(1)` 通过 `T(Float64(n))` 字面量替代路径。`@Derive[Hashable]`
- type_quat_cast: OOD §3.2.1。逐元素填充策略，非 Mat3x3(T(1)) 单参数构造
- scalar_quat_ops: OOD §3.4。约束 `where T <: Number<T>, Q <: Qualifier`

---

## R3 NEW ext/ 函数库
任务：实现全部 ~14 个 ext/ 文件——(a) 完整实现文件：`quaternion_geometric.cj`（dot/length/normalize/cross）、`quaternion_relational.cj`（equal/notEqual 精确+epsilon）、`vector_relational.cj`（16 epsilon 完整 + 8 ULP stub）、`quaternion_common.cj`（conjugate/inverse/lerp/isnan/isinf 完整 + mix/slerp×2 stub）、`quaternion_trigonometric.cj`（axis 完整 + angle/angleAxis stub）；(b) stub 文件：`quaternion_transform.cj`（rotate 1 stub）、`quaternion_exponential.cj`（exp/log/pow/sqrt 4 stub）、`matrix_projection.cj` / `matrix_clip_space.cj` / `matrix_transform.cj`（空桩）；(c) 别名文件：`quaternion_float.cj` / `quaternion_double.cj` / `quaternion_float_precision.cj` / `quaternion_double_precision.cj`
选择理由：全部 ext/ 文件同属 `glm.ext` 包，相互依赖链在同一包内可编译时解析。每个文件仅数行至数十行代码，合并为一批次大幅减少轮次循环开销。quaternion_geometric 和 vector_relational 无 stub 依赖先行完整实现，其产出供给 quaternion_common 使用
上下文：
- geometric: OOD §3.7。normalize 零四元数保护返回 `Quat(T(0), T(0), T(0), T(1))`
- relational: OOD §3.6。epsilon 比较使用内联 abs 模式避免 common.cj stub 依赖
- vector_relational: OOD §3.5。ULP 8 重载因仓颉无浮点位级 API 标记 stub
- common: OOD §3.11。conjugate 声明为 const func。inverse 约束 `where T <: FloatingPoint<T>`（整数 T 编译拒绝）。lerp 含 `assert(a >= 0 && a <= 1)`
- trigonometric: OOD §3.9。axis 公式 `tmp1 = T(Float64(1)) - x.w*x.w` + `tmp2 = T(Float64(1)) / std.math.sqrt(tmp1)`
- stub 文件: OOD §3.13。`throw Exception("stub")`
- 别名文件: OOD §3.14。1-3 行 type alias 声明

---

## R4 NEW gtc/ 子包
任务：实现 (a) gtc 子包 cjpm 构建原型验证（`proto_gtc.cj` + `proto_export.cj`，验证通过后删除）；(b) `gtc/constants.cj` 28 个数学常量完整实现；(c) `gtc/quaternion.cj` 4 重导出（mat3Cast/mat4Cast/quatCast）+ 4 比较函数完整实现（lessThan/lessThanEqual/greaterThan/greaterThanEqual）+ 7 stub（eulerAngles/roll/pitch/yaw/quatLookAt 系列）；(d) `gtc/matrix_transform.cj` 64 个 stub 签名
选择理由：gtc/ 子包全部文件位于 `glm.gtc`，相互无交叉依赖，可批量创建。构建原型验证前置确认 cjpm 对子包支持性（不通过则整体降级至 `package glm`）。constants 无外部依赖；quaternion 依赖 detail 转换函数（R2）+ ext 比较函数（R3）；matrix_transform 仅为 stub 签名
上下文：
- 构建验证: OOD §2 验证项 1+2。**回退方案**：若 `cjpm build` 无法识别 `package glm.gtc`，将 gtc/ 文件迁移至 `src/` 根目录降级为 `package glm`，lib.cj import 路径同步变更
- constants: OOD §3.12。全部 `func xxx<T>(): T where T <: FloatingPoint<T>`，硬编码值直接返回
- quaternion: OOD §3.15。import 清单：`import glm.detail.*` + `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` + `import glm.ext.vector_relational.*` + `import glm.ext.scalar_constants.*`
- matrix_transform: OOD §3.13。64 函数签名，约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体 `throw Exception("stub")`

---

## R5 NEW lib.cj + fwd.cj 生成脚本 + 全库构建验证
任务：(a) `lib.cj` 末尾追加 20 个 public import（四元数类型/转换函数、ext 函数库、gtc 函数库）；(b) `scripts/gen_fwd_aliases.py` 新增 Quat 家族 type alias 生成（Quat/FQuat/DQuat + 精度变体）；(c) `cjpm build` 全库编译验证
选择理由：lib.cj 和 fwd.cj 是库的公共 API 面，必须在所有模块实现后统一更新。OOD §2 给出了完整的 lib.cj 新增 import 清单和 fwd.cj 生成脚本修改方案
上下文：OOD §2 lib.cj/fwd.cj 段落。gen_fwd_aliases.py 需新增 Quat 家族独立循环（与 Vec 家族独立，避免生成 Quat1/Quat2 误别名）。测试文件验证 lib.cj 和 fwd.cj 中的类型/函数可正确访问

---

---

## R2 PASSED R1 detail 基础层
结果：实现了 `detail/scalar_constants.cj`（epsilon/pi/cos_one_over_two 泛型函数完整实现）、`ext/scalar_constants.cj`（public import 重导出）、`detail/trigonometric.cj`（75 个三角函数 stub 签名）
测试：`tests/glm/detail/test_scalar_constants.cj`（8 用例）、`tests/glm/detail/test_trigonometric_stub.cj`（16 用例）。`cjpm test` 422 PASSED，0 FAILED。

## R2 NEW 四元数类型体系
任务：(a) `detail/type_quat.cj` Quat<T,Q> 泛型结构体（4 public var x/y/z/w + const init 逐分量/标量+向量构造 + fromQuat/fromMat3/fromMat4/identity/wxyz 工厂 + 跨 Qualifier 构造 + 一元/二元运算符 + 下标 + length 查询 + Quat×Vec3/Vec4 + Vec3×Quat/Vec4×Quat）; (b) `detail/type_quat_cast.cj` mat3Cast/mat4Cast/quatCast(Mat3)/quatCast(Mat4) 四个包级转换函数; (c) `detail/scalar_quat_ops.cj` add/sub/mul/div 四个标量-四元数全局运算函数
选择理由：四元数类型是阶段三所有 ext/gtc 模块的数据基础。type_quat.cj 的 fromMat3/fromMat4 工厂函数依赖同包 type_quat_cast.cj，合并为同一轮消除编译依赖缺失问题。scalar_quat_ops.cj 紧耦合于 Quat 类型一并实现
上下文：
- type_quat: OOD §3.1-§3.4。依赖阶段二的 Vec3/Vec4/Mat3x3/Mat4x4。`T(0)/T(1)` 通过 `T(Float64(n))` 字面量替代路径。`@Derive[Hashable]`。conjugate 声明为 const func
- type_quat_cast: OOD §3.2.1。逐元素填充策略，非 Mat3x3(T(1)) 单参数构造。`where T <: FloatingPoint<T>`
- scalar_quat_ops: OOD §3.4。约束 `where T <: Number<T>, Q <: Qualifier`

## R2 PASSED 四元数类型体系
结果：实现了 `detail/type_quat.cj`（Quat<T,Q> 泛型结构体 + 运算符/工厂/下标/length）、`detail/type_quat_cast.cj`（mat3Cast/mat4Cast/quatCast 4 个包级转换函数）、`detail/scalar_quat_ops.cj`（add/sub/mul/div 4 个标量-四元数全局运算函数）
测试：`tests/glm/detail/test_type_quat.cj`（25 用例）、`tests/glm/detail/test_type_quat_cast.cj`（8 用例）、`tests/glm/detail/test_scalar_quat_ops.cj`（9 用例）。`cjpm test` 422 PASSED，0 FAILED。

## R3 PASSED ext/ 函数库
结果：实现了全部 14 个 ext/ 文件（5 完整实现：quaternion_geometric/quaternion_relational/vector_relational/quaternion_common/quaternion_trigonometric；5 stub：quaternion_transform/quaternion_exponential/matrix_projection/matrix_clip_space/matrix_transform；4 别名：quaternion_float/quaternion_double/quaternion_float_precision/quaternion_double_precision）+ 5 个测试文件
测试：`tests/glm/ext/test_quaternion_geometric.cj`/`test_quaternion_relational.cj`/`test_vector_relational.cj`/`test_quaternion_common.cj`/`test_quaternion_trigonometric.cj`。`cjpm test` 422 PASSED，0 FAILED。

## R4 NEW gtc/ 子包
任务：(a) 构建原型验证（`proto_gtc.cj` + `proto_export.cj`，验证后删除）；(b) `gtc/constants.cj` 28 个数学常量完整实现；(c) `gtc/quaternion.cj` 4 重导出（mat3Cast/mat4Cast/quatCast×2）+ 4 比较函数完整实现（lessThan/lessThanEqual/greaterThan/greaterThanEqual）+ 7 stub（eulerAngles/roll/pitch/yaw/quatLookAt×3）；(d) `gtc/matrix_transform.cj` 64 个 stub 签名
选择理由：gtc/ 子包全部文件位于 `glm.gtc` 包，相互无交叉依赖，可批量创建。构建原型验证前置确认 cjpm 对子包支持性（不通过则整体降级至 `package glm`）。constants 无外部依赖；quaternion 依赖 detail 转换函数（R2）+ ext 比较函数（R3）；matrix_transform 仅为 stub 签名
上下文：
- 构建验证：OOD §2 验证项 1+2。回退方案：若 cjpm build 无法识别 `package glm.gtc`，将 gtc/ 文件迁移至 `src/` 根目录降级为 `package glm`
- constants: OOD §3.12。28 个函数 `func xxx<T>(): T where T <: FloatingPoint<T>`，硬编码值直接返回
- quaternion 比较函数：OOD §3.15。`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`，约束 `where T <: Comparable<T>, Q <: Qualifier`
- quaternion 重导出：`public import glm.detail.{mat3Cast, mat4Cast, quatCast}`
- quaternion stub 函数：OOD §3.15。7 个函数，约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体 `throw Exception("stub")`
- matrix_transform: OOD §3.13。64 函数签名，约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体 `throw Exception("stub")`

## R4 PASSED gtc/ 子包
结果：实现了 gtc 子包——`gtc/constants.cj`（28 个数学常量函数完整实现）、`gtc/quaternion.cj`（4 重导出 + 4 比较完整实现 + 7 stub）、`gtc/matrix_transform.cj`（64 个 stub 签名），以及构建原型验证文件（`proto_gtc.cj` + `proto_export.cj`，验证后已删除）
测试：`tests/glm/gtc/test_constants.cj`（56 用例）、`tests/glm/gtc/test_quaternion.cj`（12 用例）。`cjpm test` 422 PASSED，0 FAILED。

## R5 NEW lib.cj + fwd.cj 生成脚本 + 全库构建验证
任务：(a) `lib.cj` 末尾追加 20 个 public import（四元数类型/转换函数、ext 函数库、gtc 函数库）；(b) `scripts/gen_fwd_aliases.py` 新增 Quat 家族 type alias 独立生成循环（Quat/FQuat/DQuat + 4 精度变体，固定 4 维无 Vec1/Vec2/Vec3 误产物），重新生成 `fwd.cj`；(c) `cjpm build` 全库编译验证并通过所有测试
选择理由：lib.cj 和 fwd.cj 是库的公共 API 面，必须在所有模块实现后统一更新。R5 为阶段三最终轮次，完成后计划全部实现
上下文：
- lib.cj 20 个 import：1 个 detail 类型/转换函数 + 1 个 detail trigonometric + 15 个 ext 子模块 + 3 个 gtc 子模块（详见 OOD §2 lib.cj/fwd.cj 段落）
- gen_fwd_aliases.py：新增独立 `QUAT_FAMILIES` 字典 + `QUAT_PRECISIONS` 列表 + 独立循环（与 `VEC_FAMILIES` 分离避免生成 Quat1/Quat2/Quat3）
- 验证：`cjpm build` 编译通过 + `cjpm test` 全部 PASSED

## R5 PASSED lib.cj + fwd.cj 生成脚本 + 全库构建验证
结果：`src/lib.cj` 末尾追加 import（移除 Quat 名称冲突，添加 trigonometric 命名 import）、`scripts/gen_fwd_aliases.py` 修正 Quat 家族生成循环（9 个 alias，去掉 FQuat 精度前缀变体）、重新生成 `src/fwd.cj`
测试：`tests/glm/test_fwd.cj`。`cjpm build` 编译通过，`cjpm test` 422 PASSED，0 FAILED。

## R3 NEW ext/ 函数库（原有记录，保留为历史存档）
任务：实现全部 ~14 个 ext/ 文件。(a) 完整实现文件：`quaternion_geometric.cj`（dot/length/normalize/cross）、`quaternion_relational.cj`（equal/notEqual 精确+epsilon）、`vector_relational.cj`（16 epsilon 完整 + 8 ULP stub）、`quaternion_common.cj`（conjugate/inverse/lerp/isnan/isinf 完整 + mix/slerp×2 stub）、`quaternion_trigonometric.cj`（axis 完整 + angle/angleAxis stub）；(b) stub 文件：`quaternion_transform.cj`（rotate 1 stub）、`quaternion_exponential.cj`（exp/log/pow/sqrt 4 stub）、`matrix_projection.cj`/`matrix_clip_space.cj`/`matrix_transform.cj`（空桩）；(c) 别名文件：`quaternion_float.cj`/`quaternion_double.cj`/`quaternion_float_precision.cj`/`quaternion_double_precision.cj`
选择理由：全部 ext/ 文件同属 `glm.ext` 包，相互依赖链在同一包内可编译时解析。quaternion_geometric 和 vector_relational 无 stub 依赖先行完整实现，其产出供给 quaternion_common 使用。别名文件仅 1-3 行 type alias 声明，可批量创建
上下文：
- geometric: OOD §3.7。normalize 零四元数保护返回 `Quat(T(0), T(0), T(0), T(1))`。约束 `where T <: FloatingPoint<T>`。dot/cross 纯算术可直接实现。length 依赖 std.math.sqrt
- relational: OOD §3.6。epsilon 比较使用内联 abs 模式避免 common.cj stub 依赖
- vector_relational: OOD §3.5。ULP 8 重载因仓颉无浮点位级 API 标记 stub。epsilon 16 重载完整实现，内部 abs 内联
- common: OOD §3.11。conjugate 声明为 const func。inverse 约束 `where T <: FloatingPoint<T>`。lerp 含 `assert(a >= 0 && a <= 1)`
- trigonometric: OOD §3.9。axis 公式 `tmp1 = T(Float64(1)) - x.w*x.w` + `tmp2 = T(Float64(1)) / std.math.sqrt(tmp1)`
- stub 文件: OOD §3.8/§3.10/§3.13。`throw Exception("stub")`
- 别名文件: OOD §3.14。1-3 行 type alias 声明

## 修订说明（v1 r5）
| 审查意见 | 修改措施 |
|---------|---------|
| [一般] R3(type_quat.cj)→R4(type_quat_cast.cj) 依赖顺序问题：fromMat3/fromMat4 工厂函数依赖同包转换函数 | 方案 C：合并 R3/R4 为同一轮 R2，消除跨轮次同包符号缺失 |
| [用户反馈] 轮次粒度太细（14 轮），需要更粗粒度 | 合并 14 轮为 5 轮：R1 detail 基础层（原 R1+R2）、R2 四元数类型体系（原 R3+R4+R5）、R3 ext 函数库（原 R6+R7+R8+R9）、R4 gtc 子包（原 R10+R11+R12+R13）、R5 最终构建（原 R14） |
| [用户反馈] ext/*.cj 每文件可能仅几行代码，可合并 | ext/ ~14 个文件全部合并至 R3 同一批次 |
| [要求] 实施路线表格 | 已添加至 plan.md 开头，后续每次进展打勾确认 |
