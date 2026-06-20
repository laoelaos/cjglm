# 实现报告（v3 r3）

## 概述
根据详细设计 v3 实现 Vec1~Vec4 完整结构体、scalar_vec_ops 独立函数、type_fromBoolVec 工厂函数。本轮修订处理审查反馈 v3 r3。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/type_vec1.cj` | 添加一元 `+()`；`%` 移至 Number\<T\>；移位签名修正为 VecN\<T,Q\>/T；添加 const 交叉构造（仅 Number\<T\> + Number\<T2\> 约束可用） |
| 修改 | `src/detail/type_vec2.cj` | 同上 |
| 修改 | `src/detail/type_vec3.cj` | 同上 |
| 修改 | `src/detail/type_vec4.cj` | 同上 |
| 修改 | `src/detail/scalar_vec_ops.cj` | 全部 20 个函数添加 `const` 限定符 |
| 无变更 | `src/detail/type_fromBoolVec.cj` | 无修订需求 |
| 无变更 | `src/detail/type_fromBoolVec_test.cj` | 无修订需求 |

## 编译验证
仅 `type_fromBoolVec.cj` 因 `T(1)`/`T(0)` 在无约束泛型参数上不可编译（D5 设计策略，已知语言限制）。Vec 核心类型及 scalar_vec_ops 编译通过。

## 设计偏差说明
| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| 交叉类型构造函数 `init<T2, Q2>(v: VecN<T2, Q2>)` 等 | 仓颉语言限制：构造体体内无约束泛型参数 T 无法引用 T2 类型值做转换（`T(v.x)` 不通过，`where T2 <: T` 不通过，extend 块不可定义构造函数） | 在 Number\<T\> extend 块中添加带 `where T2 <: Number<T2>` 约束的构造函数版本（覆盖 T/T2 均为数值类型的场景），语言升级后可扩展至无约束 T |
| 交叉类型构造函数签名缺少非 Number 覆盖 | 仓颉语言不支持无约束泛型参数的跨类型构造 | 对非数值类型 Vec，用户需使用标量分量逐元素构造或 `vectorize.cj` 中的 Functor 模式 |
| `%` 运算符原设计在 Number\<T\> 中 | 匹配设计规格 | 已移回 Number\<T\> extend 块，浮点 T 实例化时报 D5 编译错误（同设计预期） |
| 移位运算符签名改为 `rhs: VecN<T,Q>` / `shift: T` | 匹配设计规格 | 已修正，去除了之前的 `Int64` 硬编码签名 |
| `increment()`/`decrement()` 已移除 | 语言限制，`T(1)` 不可编译 | 此前轮次已移除，待语言支持泛型字面量构造后恢复 |

## 修订说明（v3 r3）
| 审查意见 | 修改措施 |
|---------|---------|
| [严重] 交叉类型转换构造函数完全缺失 | 由于仓颉语言限制（无约束泛型参数不能做类型转换、不能以类型参数为约束上界、extend 块不能定义构造函数），在 struct 体内和 extend 块内均无法实现。已添加 `where T2 <: Number<T2>` 约束的数值类型版本到 Number\<T\> extend 块。对非数值交叉构造，属已知 D5 语言限制 |
| [一般] scalar_vec_ops 缺少 const | 全部 20 个函数添加 `public const func` |
| [一般] 缺少一元 `+()` | 已在各 Vec 的 Number\<T\> extend 块添加 |
| [一般] `%` 约束层级偏离设计 | 已移回 Number\<T\> extend 块，浮点 T 实例化时报 D5 编译错误（设计预期） |
| [一般] 移位运算签名偏离设计 | 已修正为 `<<(rhs: VecN<T,Q>)` / `>>(rhs: VecN<T,Q>)` 和 `<<(shift: T)` / `>>(shift: T)`，匹配设计规格 |
