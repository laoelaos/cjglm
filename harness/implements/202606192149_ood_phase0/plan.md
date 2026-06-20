# 实现计划

任务描述：依据 OOD 设计文档 `docs/02_ood_phase0.md`，在 `cjglm/` 项目中实现 GLM 数学库的仓颉迁移首轮代码。包含 Qualifier 体系、Vec1~Vec4 向量类型系统、运算函数、类型别名等。

项目根目录：C:\Develop\Software\cjglm_wp\cjglm

参考项目：C:\Develop\Software\cjglm_wp\references\glm-1.0.3\
设计文档：C:\Develop\Software\cjglm_wp\docs\02_ood_phase0.md

拆解策略：底层依赖优先——基础设施层（无外部依赖）→ 核心抽象层（Qualifier/ComputeVec）→ 向量类型层（Vec1~Vec4）→ 公共 API 与别名层。

---

## R1 PASSED 01-项目基础设施层
结果：setup.cj / shim_cstddef.cj / shim_assert.cj / shim_limits.cj / qualifier.cj + 对应单元测试
测试：23/23 PASSED (glm: 2, glm.detail: 21)

---

## R2 PASSED 02-核心抽象层（ComputeEqual + Functor + ComputeVecDecl）
结果：实现了 compute_vector_relational.cj（ComputeEqual + ComputeEqualNumeric 相等比较策略）、vectorize.cj（Functor1~Functor2VecIntVec4 共 16 个结构体）、compute_vector_decl.cj（compute_vec_add/sub/mul/div/mod/and/or/xor/shift_left/shift_right/equal/nequal/bitwise_not 13 策略族 × 4 分量数 = 52 个结构体）、type_vec_stubs.cj（Vec1~Vec4 最小桩类型，Strategy B）
测试：90/90 PASSED（glm: 2, glm.detail: 88），ComputeEqual/ComputeEqualNumeric 各类型精确/容差比较验证、Functor 一元/二元/向量-标量/向量-整数映射验证、ComputeVec* 逐分量实例化和运算验证

---

## R3 FAILED 03-向量类型层（Vec1~Vec4 + scalar_vec_ops + fromBoolVec）
结果：compile test failed with 112 errors
原因：type_fromBoolVec.cj 中 8 个函数在无约束泛型参数 T 上使用 T(1)/T(0) 构造表达式，仓颉编译器不允许

## R3 RETRY 03-向量类型层 — type_fromBoolVec.cj 约束修正
任务：为 fromBoolVec/fromBoolVecQ2 函数添加 where T <: Number<T> 约束
修正方向：函数签名添加 T <: Number<T> 使 T(1)/T(0) 构造通过编译
测试：type_fromBoolVec_test.cj 中使用 Int64（实现 Number<T>），无需修改

---
任务：实现 type_vec1.cj（Vec1<T,Q> 完整结构体含运算符和构造函数）、type_vec2.cj（Vec2<T,Q> 完整结构体）、type_vec3.cj（Vec3<T,Q> 完整结构体）、type_vec4.cj（Vec4<T,Q> 完整结构体）、scalar_vec_ops.cj（scalar-op-vec 方向辅助函数 add/sub/mul/div/mod × Vec1~Vec4 = 20 个函数）、type_fromBoolVec.cj（fromBoolVec/fromBoolVecQ2 工厂函数 Vec1~Vec4 各 2 个版本 = 8 个函数）。删除 type_vec_stubs.cj。
选择理由：Vec 结构体是 GLM 数学库的核心数据类型，各 Vec 独立定义而非单模板特化。scalar_vec_ops 提供 `add(s,v)` 等标量在左的操作。fromBoolVec 提供 Bool→数值转换。依赖 R1（qualifier/shim_limits/setup）和 R2（ComputeEqual/Functor/ComputeVecDecl）。
上下文：依赖 R1（qualifier/shim_limits/setup）和 R2（ComputeEqual/Functor/ComputeVecDecl）。Vec 结构体需完整实现：构造函数体系（标量填充/逐分量/跨类型转换/Vec1 填充/多元组合/跨分量数截断）、算术运算符（+ - * / % 支持 VecN op VecN 和 VecN op T 两种右操作数类型，标注@OverflowWrapping）、一元运算符（+ -）、比较运算符（== 委托 ComputeEqual.call != 对==取反）、下标运算符（operator[] 和 componentAt）、位运算符（extend 块中 & | ^ << >> bitwiseNot）、具名函数（increment/decrement/logicalAnd/logicalOr/equalExact/equalEpsilon）、length() 静态函数。Vec2~Vec4 需额外支持 Vec1 广播运算符（算术和位运算两个方向）。需要对应的单元测试文件

---

## R3 REJECTED 03-向量类型层 — fromBoolVec Number\<T\> 约束方案（v4 r1）
结果：plan_review_v4_r1.md REJECTED
原因：Number\<T\> 不提供 `()` 构造调用，与 increment/decrement 被移除为同一语言限制（`T(1)` 不可编译）

## R3 RETRY 03-向量类型层 — fromBoolVec zero/one 参数方案（v4 r1 修订）
任务：为 fromBoolVec/fromBoolVecQ2（Vec1~Vec4 × 2 = 8 个函数）增加 `zero: T, one: T` 参数，函数体直接使用参数值替代 `T(1)`/`T(0)`
选择理由：方案 A（审查推荐），完全避免泛型字面量构造，无额外约束要求
上下文：无额外约束，函数体直接使用参数值。测试文件需同步修改调用处

---

## R4 FAILED 04-公共 API 与别名层
结果：验证失败，96 errors 全部来自 type_vec1.cj 的预存 R3 编译错误
原因：R3 的 type_vec1~4.cj 中三类运算符问题：
  1. `%` 运算符放在 `Number<T>` extend 块，但 `Number<T>` 不提供 `%`（仅 `Integer<T>` 提供）
  2. `<<`/`>>` 的右操作数使用 `T`，但 `Integer<T>` 接口要求右操作数为 `Int64`
  3. 一元 `+` 运算符不是仓颉合法的可重载运算符
R4 代码本身（lib.cj / fwd.cj / 测试文件）语法正确，不引入新错误

---

## R5 PASSED 05-修复 type_vec1~4.cj 预存编译错误
结果：type_vec1~4.cj 三类运算符错误（% 移入 Integer<T> / <<>> 右操作数改为 Int64 / 删除一元 +）已修复，共消除 96 个编译错误
测试：type_vec1~4_test.cj 同步删除 test*UnaryPlus 测试，其他测试保持不变

## R6 PASSED 06-修复 scalar_vec_ops.cj const func 编译错误
结果：scalar_vec_ops.cj 中 20 个 `public const func` → `public func` 已修改，50 个 `expected 'const' expression` 错误消除
测试：scalar_vec_ops_test.cj 调用方式不受影响

## R7 PASSED 07-修复 fwd.cj Vec1~Vec4 导入遮蔽导致的多参数错误
结果：src/fwd.cj 中 Vec1~Vec4 名称导入已移除，改用 import glm.detail 命名空间导入，所有 RHS 泛型引用加 detail. 前缀。252 个编译错误全部消除。
测试：301/303 PASSED。2 个失败（testVec1BroadcastShiftLeftVec2 / testVec1BroadcastShiftRightVec2）是 pre-existing 的测试数据错误，与 R7 无关。

---

## R8 FAILED 08-修复 type_vec1_test.cj Vec1 广播移位测试数据错误
结果：testVec1BroadcastShiftRightVec2 已修复通过。但 testVec1BroadcastShiftLeftVec2 仍失败（302/303 通过）
原因：v9 的修复方案将 b=(8,16) 改为 b=(4,6)，但 2<<6=128 ≠ 64。应改为 b.y=5（2<<5=64）。同一错误也存在于新增的 test_type_vec1_broadcast_shift.cj 中

---

## R9 RETRY 08-修正 Vec1 广播左移测试数据 math 错误
任务：修正 testVec1BroadcastShiftLeftVec2 及相关测试的 b.y 值从 6 改为 5（2<<5=64）
选择理由：v9 修复了右移测试，但左移测试的 b.y=6 仍产生 2<<6=128≠64。同一错误存在于两个文件中
上下文：
  - src/detail/type_vec1_test.cj:350 b=Vec2(4, 6) → Vec2(4, 5)
  - tests/glm/detail/test_type_vec1_broadcast_shift.cj:6 b=Vec2(4, 6) → Vec2(4, 5)
  - tests/glm/detail/test_type_vec1_broadcast_shift.cj:114 b=Vec2(4, 6) → Vec2(4, 5)（PackedHighp 版本）
  预期值 (32, 64) 保持不变，b.y=5 时 2<<5=64 正确匹配

