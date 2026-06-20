# 详细设计（v4）

## 概述
修改 `src/detail/type_fromBoolVec.cj` 中全部 8 个 `fromBoolVec`/`fromBoolVecQ2` 函数，将 `T(1)`/`T(0)` 泛型字面量构造替换为 `zero: T` 和 `one: T` 参数传递。同步修改 `type_fromBoolVec_test.cj` 中所有调用处传递 `Int64(0)`/`Int64(1)`。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_fromBoolVec.cj` | 修改 | 8 个函数增加 `zero: T, one: T` 参数，函数体直接使用参数值 |
| `src/detail/type_fromBoolVec_test.cj` | 修改 | 所有 13 处调用增加 `Int64(0), Int64(1)` 参数 |

## 类型定义

### fromBoolVec (Vec1~Vec4 × 2 版本 = 8 个函数)

**形态**：包级独立函数
**包路径**：`glm.detail`
**职责**：Bool→Numeric 转换工厂函数

修改前签名：
```cangjie
public func fromBoolVec<T, Q>(v: VecN<Bool, Q>): VecN<T, Q> where Q <: Qualifier
public func fromBoolVecQ2<T, Q, Q2>(v: VecN<Bool, Q2>): VecN<T, Q> where Q <: Qualifier, Q2 <: Qualifier
```

修改后签名：
```cangjie
public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier {
    return Vec1(if (v.x) { one } else { zero })
}

public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    return Vec1<T, Q>(if (v.x) { one } else { zero })
}
// Vec2~Vec4 同理
```

**修改模式**（8 个函数统一规则）：
1. 参数列表末尾增加 `zero: T, one: T`
2. 函数体中所有 `T(1)` 替换为 `one`，所有 `T(0)` 替换为 `zero`
3. 函数体实现逻辑不变

## 错误处理
无变更。由于不再使用 `T(1)`/`T(0)`，编译器错误 `'()' is not a static member of exposed generic parameter 'T'` 消除。

## 行为契约
- `fromBoolVec(v, zero, one)`：Bool VecN 的每个分量，`true` → `one`，`false` → `zero`
- `fromBoolVecQ2(v, zero, one)`：允许跨 Q 版本的相同转换
- 调用方负责提供合适的 `zero` 和 `one` 值（例如 Int64 类型传 `Int64(0)`/`Int64(1)`）
- T 无任何约束，仅要求 T 与 zero/one 类型相同

## 依赖关系
| 文件 | 依赖 | 说明 |
|------|------|------|
| `type_fromBoolVec.cj` | `type_vec1~4.cj`(VecN 类型), `qualifier.cj`(Qualifier) | 同包可见，无新增依赖 |

## 测试适配规则
每个调用处原为：
```cangjie
let r = fromBoolVec<Int64, Defaultp>(vb)
```
改为：
```cangjie
let r = fromBoolVec(vb, Int64(0), Int64(1))
```

注意：移除类型参数显式标注 `<Int64, Defaultp>`，改为由仓颉编译器通过参数自动推断。若编译器无法推断 Q，则保留显式标注。

## 修订说明（v4 r1 首轮 — 从 v3 审查反馈衍生）
本设计是 v3 轮次编译失败的修正方案。v3 verify 报告显示 112 个编译错误，全部源于 `type_fromBoolVec.cj` 中 8 个函数在无约束泛型参数 T 上使用 `T(1)`/`T(0)`。仓颉编译器禁止对暴露的泛型参数 T 调用 `T(n)` 构造表达式（`'()' is not a static member of exposed generic parameter 'T'`）。

此前 v3 尝试在 v4 中添加 `where T <: Number<T>` 约束的方案被审查驳回（R3 审查 plan_review_v4_r1.md），因为 `Number<T>` 提供算术运算符但不提供 `()` 构造调用，与代码库中 `increment()`/`decrement()` 被移除为同一原因。

本设计采用审查推荐的方案 A：将 `zero: T` 和 `one: T` 作为额外参数传入，完全避免泛型字面量构造。此方案与 D5 延迟检查策略完全兼容，函数体不再依赖 `T(1)`/`T(0)`，直接从参数读取。
