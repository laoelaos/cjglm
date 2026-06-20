# 任务指令（v4）

## 动作
RETRY

## 任务描述
修正 `src/detail/type_fromBoolVec.cj`：将全部 8 个 `fromBoolVec`/`fromBoolVecQ2` 函数改为接受 `zero: T` 和 `one: T` 参数，避免使用 `T(1)`/`T(0)` 泛型字面量构造。

## 选择理由
R3 审查（plan_review_v4_r1.md）指出：`T(1)` 在泛型上下文中不可编译是仓颉编译器的已知语言限制（与之前 `increment()`/`decrement()` 被移除为同一原因），即使添加 `where T <: Number<T>` 约束也无法解决。`Number<T>` 提供算术运算符但不提供 `()` 构造调用。

**方案 A（审查推荐）**：将 `zero: T` 和 `one: T` 作为额外参数传入，完全避免泛型字面量构造。这是最小改动方案：
- 无任何约束要求（移除 `where T <: Number<T>` 的需求）
- 与 D5 延迟检查策略完全兼容
- 函数体不再依赖 `T(1)`/`T(0)`，直接从参数读取

## 任务上下文
| 项 | 值 |
|------|------|
| 目标文件 | `src/detail/type_fromBoolVec.cj` |
| 影响范围 | 8 个函数签名 |
| 编译器错误 | `'()' is not a static member of exposed generic parameter 'T'` |
| 根本原因 | 仓颉编译器禁止对暴露的泛型参数 T 调用 `T(n)` 构造表达式 |
| 修复方法 | 增加 `zero: T` 和 `one: T` 参数，函数体直接使用参数值 |
| 测试适配 | 每个调用处传递 `Int64(0)` 和 `Int64(1)` |

## 已有代码上下文

### 当前 type_fromBoolVec.cj 签名
```cangjie
public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>): Vec1<T, Q> where Q <: Qualifier
public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>): Vec1<T, Q> where Q <: Qualifier, Q2 <: Qualifier
// 同理 Vec2~Vec4
```

### 修改后的签名
```cangjie
public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier {
    return Vec1(if (v.x) { one } else { zero })
}

public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    return Vec1<T, Q>(if (v.x) { one } else { zero })
}
// 同理 Vec2~Vec4
```

### 当前测试文件调用方式
```cangjie
let r = fromBoolVec<Int64, Defaultp>(vb)
```
### 修改后的调用方式
```cangjie
let r = fromBoolVec(vb, Int64(0), Int64(1))
```

## RETRY 说明
- **失败原因**：type_fromBoolVec.cj 中无约束泛型参数 T 上调用 `T(1)`/`T(0)` 不被仓颉编译器允许。此前尝试添加 `where T <: Number<T>` 约束的方案被审查驳回（`Number<T>` 不提供 `()` 构造调用）。
- **修正方向**：采用审查推荐的方案 A——将 `zero: T` 和 `one: T` 作为额外参数传递，函数体直接使用参数值，完全避免泛型字面量构造。
- **测试适配**：每个 `fromBoolVec` 调用处传入 `Int64(0), Int64(1)`；`fromBoolVecQ2` 同理。

## 测试注意事项
- 修改 `type_fromBoolVec_test.cj` 中所有调用，添加 `Int64(0), Int64(1)` 参数
- 修改后应重新跑 `cjpm test` 验证

## 修订说明（v4 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| [严重] `where T <: Number<T>` 约束不能解决 `T(1)` 编译错误（`Number<T>` 不提供 `()` 构造调用，代码库已有 `increment()`/`decrement()` 被移除的先例） | 更换为方案 A：移除约束方案，改为为 `fromBoolVec`/`fromBoolVecQ2` 函数增加 `zero: T` 和 `one: T` 参数，完全避免泛型字面量构造。函数体直接使用参数值 |
| [严重] 任务 v4 修正方向与 v3 轮次已验证的结论矛盾 | 一致化处理：与 `increment()`/`decrement()` 相同的处理策略——不尝试在泛型上下文中使用 `T(1)`。改用参数传递方式 |
