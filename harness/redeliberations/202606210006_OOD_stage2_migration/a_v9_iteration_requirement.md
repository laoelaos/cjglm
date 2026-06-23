根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 问题 1（严重）：scalar / mat 运算符对非方阵类型的遗漏与事实错误
- §3.5 和 §5 中声称 scalar / mat 除法运算"不依赖 inverse，可本阶段完整实现"但仅提及以 scalar_mat_ops.cj 全局函数形式提供，未明确该运算对所有 9 种矩阵类型均适用。C++ GLM 参考实现中所有 9 种矩阵类型（含 6 种非方阵）均定义了 operator/(T scalar, mat)，如 type_mat2x3.hpp:146 和 type_mat2x3.inl:474-479。§3.5 中仅笼统提及"通过 scalar_mat_ops.cj 中的全局具名函数处理"，未列出非方阵的 scalar / mat 也属于 36 个全局函数的覆盖范围。
- 改进建议：① 在 §3.5 明确列出 scalar_mat_ops.cj 的 36 个函数涵盖范围：add/sub/mul/div 各为 9 种矩阵类型提供重载（包含全部 6 种非方阵）；② 在 §5 补充确认 scalar / mat 对所有 9 种矩阵类型（含非方阵）均可本阶段完整实现；③ 对照 GLM 参考实现确认非方阵的 T/mat 除法确实存在

### 问题 2（一般）：+=mat/-=mat 复合赋值运算符的自动生成条件描述不精确
- §3.5 末尾"复合赋值运算符"段落声明所有矩阵类型的逐元素运算均可自动生成复合赋值，但未区分 +=(mat) 和 +=(U)（泛型标量/矩阵参数）的情况。C++ GLM 中 operator+=(mat) 和 operator*=(scalar) 的签名接受泛型参数 U（如 template<typename U> mat& operator+=(mat<U,Q> const& m)），而仓颉 extend 块中 operator func +(rhs: Mat4x4<T, Q>) 的右操作数类型固定为 Mat4x4<T, Q>，不可能有 U ≠ T 的泛型矩阵类型参数。此差异在 §9 差异声明和 D08 中均未提及。
- 改进建议：① 在 §3.5 复合赋值段落明确说明自动生成的 +=(mat) 仅覆盖同 T 同尺寸类型，不覆盖跨类型矩阵复合赋值（C++ GLM 的 U 类型参数版本）；② 在 §9 差异声明中补充：仓颉复合赋值运算符不支持跨类型矩阵参数；③ 更新 D08 补充此差异说明

### 问题 3（一般）：geometric.cj stub 函数签名中存在输入错误
- §3.7 中 geometric.cj 的 distance 函数签名存在一处输入错误。第 463 行：Q <| Qualifier 应为 Q <: Qualifier，<| 不是仓颉语言的合法子类型关系运算符。编码者直接复制此签名将导致编译失败。
- 改进建议：将 Q <| Qualifier 修正为 Q <: Qualifier

### 问题 4（一般）：matrix.cj stub 中 transpose 函数签名使用了非仓颉语法的伪签名
- §3.7 中 matrix.cj 的 transpose 函数签名写为 func transpose<C, R, T, Q>(m: Mat{C}x{R}<T, Q>): Mat{R}x{C}<T, Q>，其中 Mat{C}x{R} 和 Mat{R}x{C} 是设计文档中的模板记法，不是合法的仓颉类型语法。9 个矩阵类型各自独立命名，不能用泛型参数 C/R 参数化。transpose 不可能是一个接受泛型 C/R 参数的全局函数，而必须为每个矩阵尺寸各提供一个独立重载（共 9 个）。
- 改进建议：将 transpose 的伪签名替换为 9 个具体重载签名的列举，与同清单中 determinant 和 inverse 的具体签名风格一致

### 问题 5（一般）：mat / scalar 运算符作为成员函数定义，但 C++ GLM 中它是全局自由函数
- §3.5 中 mat / scalar 作为矩阵 extend 块中的成员运算符函数定义，而 C++ GLM 中它是全局自由函数。此 API 形态差异未在 §9 差异声明中记录。当用户需要取 m / scalar 的函数引用时，仓颉中无法取成员运算符的函数引用，可能遇到不便。
- 改进建议：在 §9 差异声明中补充说明：C++ GLM 中 mat / scalar 为全局自由运算符，仓颉版本为成员运算符函数——两者运算语义等价，但 API 形态差异导致无法作为高阶函数参数传递

### 问题 6（一般）：operator/=(mat/mat) 的 stub 策略与 operator/(mat/mat) 的 stub 策略不一致，未明确声明
- 方阵类型的 operator/=(mat/mat) 由编译器基于 operator/(mat/mat) 自动生成，因此自动继承 stub 行为，但设计文档中未明确说明。编码者可能困惑于 /= 是否也需要显式声明为 stub。
- 改进建议：在 §3.5 或 §5 中明确说明：方阵类型的 operator/=(mat/mat) 由编译器基于 operator/(mat/mat) 自动生成，因此自动继承 stub 行为；无需单独声明 /= 的 stub 状态；当阶段四 inverse 完整实现后，/= 也会自动成为可用运算符

### 问题 7（轻微）：filled(scalar: T) 中 scalar - scalar 在 scalar=T(0) 时的边界行为未显式确认
- 当 scalar 是 T(0) 时，scalar - scalar = T(0) - T(0) = T(0) 仍然正确，不会产生问题。但文档未显式确认此边界行为。
- 改进建议：补充一条注释或说明：即使 scalar=T(0)，scalar - scalar 仍正确产生 T(0)，filled(0.0f) 产生零矩阵（全部元素为 0），语义上与 C++ GLM 的 mat(0.0f) 一致

### 问题 8（轻微）：ext/ 别名文件中 vec1/dvec1 别名定义未显式列出
- §3.8 向量别名文件列表中，vec1/dvec1 别名虽在文字中提及但未以完整别名定义行的格式显式列出，编码者无法从文档直接得知其完整定义格式。
- 改进建议：在 §3.8 向量别名文件列表中，为 vec1/dvec1 补充完整别名定义行（如 public type vec1 = Vec1<Float32, PackedHighp>），与 mat4x4 的示例格式保持一致

### 问题 9（一般）：identity(one: T) 函数在非方阵类型上的语义未明确
- §3.3 第 8 条声明 identity(one: T) 作为所有矩阵类型的工厂函数，返回"主对角线为 T(1)、其余为 T(0) 的单位矩阵"。但非方阵的"单位矩阵"在数学上不成立，其产生的对角矩阵与 filled(one) 产生的结果完全相同。设计中未明确 identity 在非方阵上的语义是否等同于 filled(one)，也未说明是否应限制 identity 仅对方阵类型提供。
- 改进建议：① 明确声明 identity(one: T) 对所有 9 种矩阵类型均提供，但在非方阵上等价于 filled(one)，记录为有意设计；② 或限制 identity 仅对方阵提供；③ 无论选择哪种方案，在 §9 差异声明中补充非方阵的 identity 语义与 C++ GLM 不一致

### 问题 10（轻微）：matrix.cj stub 中 matrixCompMult 和 outerProduct 不属于方阵 .inl 的依赖闭合
- matrixCompMult 和 outerProduct 在 C++ GLM 中定义于 matrix.hpp/matrix.inl 中，但不被 type_mat2x2.inl、type_mat3x3.inl、type_mat4x4.inl 直接调用——它们是独立的全局函数。当前文档的措辞暗示这些函数是因为方阵 .inl 的依赖闭合而需要 stub，可能误导编码者。
- 改进建议：在 §3.7 matrix.cj 条目中区分"方阵 .inl 依赖闭合所需的函数"（transpose、determinant、inverse）和"随 matrix.cj 附带提供的额外函数"（matrixCompMult、outerProduct），后者纳入是因为同一函数库文件的组织约定，而非 .inl 编排依赖

### 问题 11（轻微）：跨矩阵类型转换工厂函数 6a/6b 调用指导缺失
- 当 SrcT=T 时，6a 和 6b 两个签名均可匹配。编码者需要了解应优先使用 6a（无需 conv），但文档未给出此指导。
- 改进建议：在 §3.3 第 6 条"6a 和 6b 共享的设计属性"中补充调用指导：当源矩阵与目标矩阵元素类型相同（SrcT=T）时，应使用 6a 版本（无需 conv 闭包）；仅在 SrcT≠T 时使用 6b 版本

### 问题 12（轻微）：复合赋值运算符文档措辞未区分方阵和非方阵的不同自动生成行为
- §3.5 复合赋值运算符段落将所有复合赋值合并描述，可能让编码者误以为只有方阵能获得某些复合赋值运算符。
- 改进建议：将复合赋值按类别拆分说明：① 同尺寸矩阵 ± 的复合赋值 +=/-=（所有 9 种类型）；② 标量运算的复合赋值 +=scalar/-=scalar/*=scalar//=scalar（所有 9 种类型）；③ 方阵乘法的复合赋值 *=(same_mat)（仅 3 种方阵）；④ 方阵除法的复合赋值 /=(same_mat)（仅 3 种方阵，stub 依赖）

### 问题 13（一般）：矩阵-向量乘法语义正确性未充分展开
- 路线图阶段二验证标准包括"矩阵-向量乘法语义正确性验证"，但当前设计文档中定义了签名未提供具体的语义验证用例或计算规则。D04 选择"直接内联展开而非委托函数库"意味着编码者需要手动编写每种乘法展开，但对 27 种乘法重载缺乏具体展开公式参照。
- 改进建议：在 §3.5 或 §4 中补充至少 1-2 个跨尺寸乘法的具体计算展开示例（如 Mat2x3 * Vec2 → Vec3 的展开公式），为编码者提供足够明确的计算规则参照

### 问题 14（轻微）：lib.cj 中 mod 函数的重载覆盖范围说明不清
- lib.cj 现有 public import glm.detail.{ add, sub, mul, div, mod } 中 mod 仅覆盖 scalar_vec_ops.cj 提供的标量-向量取模函数，scalar_mat_ops.cj 不提供 mod（矩阵取模无数学意义）。此情况无歧义但文档措辞可能让编码者误解为 mod 也覆盖了 scalar_mat_ops.cj。
- 改进建议：在 lib.cj 条目中补充说明：mod 仅覆盖 scalar_vec_ops.cj 提供的标量-向量取模函数，scalar_mat_ops.cj 不提供 mod（矩阵取模无数学意义）

### 质询报告确认状态
上一轮质询报告结论为 LOCATED，诊断结论全部被确认。质询报告补充了两个覆盖完备性遗漏（均不构成根本性质疑）：
1. 72 个 fromMat 重载的编译可行性未评估（建议酌情补充）
2. cjpm 子包 glm.ext 的构建可行性验证未跟进确认（编码启动前验证已有说明，建议在编码首日执行）

## 历史迭代回顾

### 已解决的问题
- 行向量×矩阵乘法签名错误（迭代第 1 轮问题 1）：已修正为 Vec{R} * Mat{C}x{R} → Vec{C}
- 跨尺寸矩阵乘法运算符未完整定义（迭代第 1 轮问题 2）：已补充完整兼容性表
- ext/ 别名文件数量前后矛盾（迭代第 1 轮问题 4）：已统一为 18 个
- componentAt 语义与 Vec 冲突（迭代第 2 轮问题 4）：已更名为 col()
- row() 成员函数的阶段问题（迭代第 2 轮问题 5/6）：已推迟至阶段四
- init() 默认构造 T(0)/T(1) 不可行（迭代第 5/6 轮）：已改为 identity(one: T) 工厂函数
- 标量填充构造 T(0) 获取不可行（迭代第 6 轮问题 2）：已降级为 filled(scalar: T) 工厂函数
- 72 个跨尺寸转换构造 T(0)/T(1) 不可行（迭代第 6 轮问题 3）：已降级为 fromMat 工厂函数
- [] 赋值版本签名缺少 mut 修饰符（迭代第 6 轮问题 4）：已补全
- 跨类型构造未参考 castVecN 模式（迭代第 6 轮问题 5）：已降级为 conv 闭包模式
- col() 与 [] 行为差异描述不清（迭代第 3 轮问题 3）：已重写为完全等价
- scalar_mat_ops.cj 命名约定冲突（迭代第 3 轮问题 4）：已更新约定（D15）
- 三个 stub 文件函数签名清单不完整（迭代第 7 轮问题 6）：已提供完整签名清单
- fromMat 签名在 SrcT ≠ T 时缺少 conv 闭包（迭代第 7 轮问题 1/2）：已拆分为 6a/6b 两个独立工厂函数
- const init 可用性未分类标注（迭代第 6 轮问题 7）：已新增汇总表

### 持续存在的问题
- scalar / mat 对非方阵类型的支持遗漏（迭代第 4 轮问题 4 首次提及，第 8 轮问题 1 再次提出，本轮问题 1）：**需在本轮彻底解决**
- 复合赋值运算符措辞未区分方阵/非方阵（迭代第 4 轮问题 2 首次提及，第 8 轮问题 10 再次提出，本轮问题 12）：**需在本轮彻底解决**
- identity 在非方阵上的语义未明确（迭代第 6 轮问题 1 相关，本轮问题 9）：**需在本轮彻底解决**
- 72 个 fromMat 重载的编译可行性未评估（迭代第 6 轮问题 3、迭代第 7 轮均提及，质询报告也指出遗漏）：**需补充评估或说明**
- cjpm 子包构建预验证（迭代第 7 轮问题 7 首次提及，质询报告指出跟进确认缺失）：已有预验证段落，编码首日执行即可

### 新发现的问题
- 问题 2：+=mat/-=mat 自动生成条件中跨类型矩阵复合赋值差异未记录（本轮新发现）
- 问题 3：geometric.cj 签名输入错误 Q <| Qualifier（本轮新发现）
- 问题 4：matrix.cj transpose 伪签名不可直接使用（本轮新发现）
- 问题 5：mat / scalar 成员运算符 vs C++ GLM 自由函数的形态差异未记录（本轮新发现）
- 问题 6：方阵 operator/= 自动继承 stub 行为未明确声明（本轮新发现）
- 问题 7：filled(scalar=T(0)) 边界行为未确认（本轮新发现）
- 问题 8：vec1/dvec1 别名定义未显式列出（本轮新发现）
- 问题 10：matrixCompMult/outerProduct 与方阵 .inl 依赖闭合的关系区分不清（本轮新发现）
- 问题 11：6a/6b fromMat 调用优先级指导缺失（本轮新发现）
- 问题 13：矩阵乘法具体展开规则未提供（本轮新发现）
- 问题 14：lib.cj 中 mod 函数覆盖范围说明不清（本轮新发现）

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606210006_OOD_stage2_migration\a_v8_design_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606210006_OOD_stage2_migration\requirement.md