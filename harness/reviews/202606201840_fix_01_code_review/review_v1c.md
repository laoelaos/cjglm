# R1C: Vec3/Vec4 + 公共API + 测试 修复质量验证

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/type_vec3.cj`
- `cjglm/src/detail/type_vec4.cj`
- `cjglm/tests/glm/detail/test_qualifier.cj`
- `cjglm/tests/glm/detail/test_setup.cj`
- `cjglm/tests/glm/test_fwd.cj`
- `cjglm/tests/glm/test_lib.cj`
- `cjglm/src/fwd.cj`

### 审查依据

- `docs/02_ood_phase0.md` — OOD 设计文档（§4.1 构造函数、§2 公共API面、§3.8 fwd别名）
- `harness/reviews/202606201155_ood_phase0_code_review/todo.md` — 前序 51 项待办
- `docs/deviations.md` — 已记录偏差（IF-01~IF-04, DV-01~DV-06, INT-01~INT-04）

### 待办项逐项验证

#### 1. type_vec3.cj — Vec3 修复验证

##### [一般] Vec3/Vec4 缺失跨类型转换构造函数 `init<T2,Q2>`（todo.md:91）
- **位置**：`type_vec3.cj:12-28`
- **状态**：**未修复**
- **描述**：OOD §4.1 要求 `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier` 跨类型转换构造函数。当前仅定义了 `init(scalar: T)`、`const init(x,y,z)`、`init(v: Vec1<T,Q>)`，三个跨类型版本（Vec3→Vec3、Vec4→Vec3 截断、Vec2+标量组合等）全部缺失。`Vec3<Float32,Defaultp>(Vec3<Int32,Defaultp>(1,2,3))` 等跨类型转换无法编译。

##### [一般] Vec3/Vec4 缺失多元组合构造函数（todo.md:96）
- **位置**：`type_vec3.cj:12-28`
- **状态**：**未修复**
- **描述**：OOD §4.1 为 Vec3 定义了 12 个多元组合构造函数（Vec2+标量、Vec1x3、Vec2+Vec1 等），当前全部缺失。限制了 `glm::vec3(glm::vec2(a,b), c)` 等常见 GLM 构造模式的迁移。

##### [一般] Vec3 缺少 Vec4 截断构造函数（todo.md:116）
- **位置**：`type_vec3.cj:12-28`
- **状态**：**未修复**
- **描述**：OOD §4.1 要求 `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`，截取 x/y/z。当前缺失。

##### [一般] `componentAt()` 未声明为 `const`（todo.md:106）
- **位置**：`type_vec3.cj:52`
- **状态**：**未修复**
- **描述**：仍为 `public func componentAt(i: Int64): T`，缺失 `const` 修饰符。无法在 const 实例成员函数体内通过索引访问分量。

##### [一般] `==` 运算符未使用 `ComputeEqual.callConst`（todo.md:111）
- **位置**：`type_vec3.cj:147`
- **状态**：**被设计取代**
- **说明**：OOD §3.5 修订后已明确"首轮不再将 `==` 设计为浮点自动容差比较"，`==` 统一使用 `ComputeEqual<T>.call`（精确比较）。当前代码与 OOD §3.5 一致，且 DV-05 已将此偏差记录。非待修复项。

##### [一般] Vec3/Vec4 缺失 increment/decrement 具名函数（todo.md:101）
- **位置**：`type_vec3.cj:132-143`
- **状态**：**部分修复**
- **描述**：函数已添加，但签名与设计不一致：
  - 设计（OOD §4.3 第(6)条）：`increment(): Vec3<T,Q>` 和 `decrement(): Vec3<T,Q>` — 返回新向量
  - 实现：`public mut func increment(): Unit` 和 `public mut func decrement(): Unit` — 原位修改返回 Unit
  - 此差异导致 C++ 迁移指南中的 `v = v.increment()` 模式无法编译。

#### 2. type_vec4.cj — Vec4 修复验证

##### [一般] Vec4 缺失跨类型转换构造函数（todo.md:91）
- **位置**：`type_vec4.cj:13-32`
- **状态**：**未修复**
- **描述**：同 Vec3。OOD §4.1 要求 `public init<T2, Q2>(v: Vec4<T2, Q2>)`，当前仅定义了三个基本构造函数。

##### [一般] Vec4 缺失多元组合构造函数（todo.md:96）
- **位置**：`type_vec4.cj:13-32`
- **状态**：**未修复**
- **描述**：OOD §4.1 为 Vec4 定义了约 30 个多元组合构造函数（Vec3+标量、Vec2+Vec2、Vec1x4 等），全部缺失。限制了 `glm::vec4(glm::vec3(a,b,c), d)` 等常见模式的迁移。

##### [一般] `componentAt()` 未声明为 `const`（todo.md:106）
- **位置**：`type_vec4.cj:58`
- **状态**：**未修复**
- **描述**：仍为 `public func componentAt(i: Int64): T`，缺失 `const` 修饰符。

##### [一般] Vec4 缺失 increment/decrement（todo.md:101）
- **位置**：`type_vec4.cj:138-152`
- **状态**：**部分修复**
- **描述**：函数已添加但与 Vec3 相同的问题——`mut func(): Unit` 而非 `func(): Vec4<T,Q>`。

#### 3. test_qualifier.cj — 测试文件修复验证

##### [严重] tests/glm/detail/ 下测试文件缺少必要 import（todo.md:17）
- **位置**：`test_qualifier.cj:1`
- **状态**：**未修复**
- **描述**：仍无任何 import 语句。使用 `@Test` 和 `@Expect` 宏但未导入 `std.unittest.*` 及 `std.unittest.testmacro.*`，与 `tests/glm/test_fwd.cj` 和 `test_lib.cj` 的行为不一致。

##### [轻微] testPackedHighpCrossAssign 名不符实（todo.md:161）
- **位置**：`test_qualifier.cj:28-34`
- **状态**：**已修复**
- **描述**：函数已重命名为 `testPackedQualifierInstantiation`，名称准确反映实际行为（仅实例化三个 Qualifier 类型变量，不进行跨类型赋值）。

#### 4. test_setup.cj — 测试文件修复验证

##### [严重] tests/glm/detail/ 下测试文件缺少必要 import（todo.md:17）
- **位置**：`test_setup.cj:1`
- **状态**：**未修复**
- **描述**：同 test_qualifier.cj，仍无 import 语句，使用 `@Test`/`@Expect` 但未导入 unittest 模块。

#### 5. test_fwd.cj — 测试文件修复验证

##### [一般] test_fwd.cj 使用了 detail.VecN 但未导入 glm.detail（todo.md:156）
- **位置**：`test_fwd.cj:1-5`，使用点在 `:201-228`
- **状态**：**未修复**
- **描述**：文件仅有 `package glm` 及 `std.unittest.*`/`std.fs.*` 导入，缺少 `import glm.detail`。4 个测试函数（`testFwdGenericVec1Accessible` 等）使用 `detail.VecN<...>` 限定名，另 2 个新增测试（`testFwdAliasAndGenericCompatible`、`testFwdAliasAndGenericVec2Compatible`）也使用了 `detail.VecN`，若编译器要求显式子包导入则风险扩大。

#### 6. test_lib.cj — 测试覆盖修复验证

##### [一般] test_lib.cj 仅覆盖 Vec2，未覆盖 Vec1/Vec3/Vec4（todo.md:126）
- **位置**：`test_lib.cj:7-72`
- **状态**：**已修复**
- **描述**：已添加 `testLibVec1Construct`、`testLibVec3Construct`、`testLibVec4Construct` 以及 Vec1/Vec3/Vec4 分量访问测试，覆盖全部四个 Vec 类型。

##### [一般] test_lib.cj 未覆盖 sub/mul/div/mod 包级函数（todo.md:131）
- **位置**：`test_lib.cj:74-100`
- **状态**：**已修复**
- **描述**：已添加 `testLibSubScalarVec`、`testLibMulScalarVec`、`testLibDivScalarVec`、`testLibModScalarVec`，覆盖全部四个标量-向量运算函数。

##### [轻微] test_lib.cj 在 package glm 内无法验证下游 import glm.* 可达性（todo.md:136）
- **位置**：`test_lib.cj:1`
- **状态**：**本质限制**
- **描述**：test_lib.cj 与 lib.cj 同属 `package glm`，无法验证下游消费者通过 `import glm.*` 的可访问性。需独立包测试文件完成验证，非本文件修复可解决。

#### 7. fwd.cj — 别名文件修复验证

##### [轻微] fwd.cj 缺少文件头部注释（todo.md:146）
- **位置**：`fwd.cj:1-2`
- **状态**：**已修复**
- **描述**：已添加 `// fwd.cj — GLM 兼容类型别名（自动生成）` 和 `// 注意：此文件由脚本自动生成，手动修改请谨慎`，与 OOD §3.8 一致。新增的 `testFwdHeaderComments` 测试（`test_fwd.cj:239-245`）动态验证了此修复。

##### [轻微] fwd.cj 缺少家族分组注释（todo.md:151）
- **位置**：`fwd.cj:53,70,87,104,121,138,155,172,189,206,223,240,257,274,291,308`
- **状态**：**已修复**
- **描述**：已添加 `// === {FamilyName} family ===` 分组注释覆盖全部 16 个家族。新增的 `testFwdFamilyComments` 测试（`test_fwd.cj:247-255`）动态扫描验证了所有家族分组的存在。

### 新发现

#### [一般] Vec3/Vec4 increment/decrement 签名与设计不一致

- **位置**：`type_vec3.cj:132-143`、`type_vec4.cj:138-152`
- **描述**：OOD §4.3 第(6)条明确规定 `increment()` 和 `decrement()` 应"返回逐分量加/减 1 的新向量"，签名应为 `func(): VecN<T,Q>`。当前实现使用 `mut func(): Unit`（原位修改），与设计不符。此差异影响 C++ 迁移指南中的 `v = v.increment()` 模式——用户无法通过返回值方式使用。Vec1 和 Vec2 的 increment/decrement 存在相同问题（`type_vec1.cj:146-153`、`type_vec2.cj:125-134`）。
- **建议**：将 increment/decrement 签名改为 `public func increment(): Vec3<T,Q>`，函数体内使用 `Vec3(this.x + T(1), ...)` 表达式直接构造新向量返回。`@OverflowWrapping` 标注应保留在构造函数调用中（通过 `+` 运算符继承或在算术表达式中标注）。注意 `T(1)` 构造在 `Integer<T>` 约束下是否可用——若不可用，保留 `-(!(this.x - this.x))` 技巧但改为返回新向量而非原位修改。

#### [轻微] increment/decrement 实现使用过度复杂表达式

- **位置**：`type_vec3.cj:133-135`、`type_vec4.cj:139-143` 等
- **描述**：增量 1 的获取使用 `this.x + (-(!(this.x - this.x)))` 技巧。此表达式虽然对 `Integer<T>` 约束下的所有类型均有效（利用 `T(0)` → `!T(0)` → `-T(-1)` → `T(1)`），但可读性差。若 `Integer<T>` 支持字面量 `1`（仓颉整数类型普遍支持，即使泛型上下文也可能通过隐式转换生效），可简化为 `this.x + 1`。
- **建议**：验证 `Integer<T>` 在泛型函数中是否支持 `1` 字面量的隐式转换，若支持则简化表达式。

#### [一般] test_fwd.cj 的 `testFwdHeaderComments` 和 `testFwdFamilyComments` 使用硬编码相对路径

- **位置**：`test_fwd.cj:240,249`
- **描述**：两测试通过 `File.readFrom(Path("src/fwd.cj"))` 读取文件，路径相对于测试运行工作目录。在 `cjpm test` 从项目根目录执行时正常工作，但若测试运行器从其他目录启动则导致误报。
- **建议**：考虑使用 `__FILE__` 路径组合或通过 cjpm 配置传递项目根路径，使测试路径更健壮。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 8 |
| 轻微 | 3 |

### 总评

本轮审查覆盖 7 个文件、14 项待办验证 + 3 项新发现。**修复进展参差不齐**：

- **已完成修复（4 项）**：testPackedHighpCrossAssign 重命名、test_lib.cj Vec1/Vec3/Vec4 和 sub/mul/div/mod 测试覆盖追加、fwd.cj 头部注释和家族分组注释
- **部分修复（2 项）**：Vec3/Vec4 increment/decrement — 函数已添加但签名与设计不符（`mut func(): Unit` 应为 `func(): VecN<T,Q>`）
- **未修复（6 项）**：Vec3/Vec4 跨类型转换构造函数、多元组合构造函数、Vec4 截断构造函数、componentAt const 标注，以上四个关键构造函数和 API 缺口全部未补充。tests/glm/detail/ 下两测试文件仍缺少 unittest import。test_fwd.cj 仍缺少 glm.detail 导入。
- **被设计取代（1 项）**：`==` 使用 `ComputeEqual.callConst` 已被 OOD §3.5 修订为精确比较

**关键缺口**：Vec3/Vec4 的构造函数体系（跨类型 + 多元组合 + Vec4 截断）和 `componentAt` const 标注在前序审查中列为一般待办，本轮仍完全未被触及。这些是影响下游代码跨类型转换和 const 使用场景的基础功能缺陷。建议明确这些是否属于当前修复分支的范围——若属于，需补全；若不属于，应在后续轮次/分支中优先处理。
