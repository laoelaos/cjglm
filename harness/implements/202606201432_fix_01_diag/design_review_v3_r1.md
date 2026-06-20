# 设计审查报告（v3 r1）

## 审查结果
REJECTED

## 发现

### **[严重]** 所有 4 个重载的函数体使用了错误的构造函数调用形式

**问题**：设计将 4 个 `cast` 重载的函数体写作 `Vec1(conv(v.x))`（无显式类型参数），但所有 4 个重载均为跨 Q 模式（`where Q <: Qualifier, Q2 <: Qualifier`）。

**为什么是问题**：代码库已建立的模式明确区分两种形式：
- **同 Q**（`fromBoolVec`，只有 `Q` 一个限定符参数）：使用 `Vec1(conv(v.x))`——`Q` 可以从输入参数 `v: Vec1<Bool, Q>` 推断
- **跨 Q**（`fromBoolVecQ2`，有 `Q` 和 `Q2` 两个限定符参数）：使用 `Vec1<T, Q>(conv(v.x))`——`Q` **无法**从输入参数推断（输入使用 `Q2`）

现有代码（`src/detail/type_fromBoolVec.cj:7-8`）明确展示了此模式：
```cangjie
// 同 Q — 无需显式类型参数
public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier {
    return Vec1(if (v.x) { one } else { zero })
}

// 跨 Q — 需要显式类型参数
public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    return Vec1<T, Q>(if (v.x) { one } else { zero })
}
```

所有 4 个 `cast` 重载都有 `Q <: Qualifier, Q2 <: Qualifier`（与 `fromBoolVecQ2` 模式匹配），但函数体使用 `Vec1(conv(v.x))`（与 `fromBoolVec` 模式匹配）。这会导致当 `Q != Q2`（即跨 Q 调用的主要用例）时编译失败，因为编译器无法推断 `Vec1` 构造函数的 `Q` 类型参数。

**期望修正方向**：将所有 4 个重载的函数体从 `Vec1(conv(v.x))` 改为 `Vec1<T, Q>(conv(v.x))`。

---

### **[一般]** `cast` 函数名与 GLM 原始设计方案中的转换语义可能有命名歧义

**问题**：设计选择 `cast` 作为函数名，而 C++ GLM 中跨类型转换是通过构造函数实现的（`glm::vec1<T>(v)`），没有独立的 `cast` 函数。`cast` 在 C++ 语境中通常与 `static_cast`/`reinterpret_cast` 等关联。

**为什么是问题**：这属于 API 设计层面的偏差——调用方需要使用 `cast` 函数而非构造函数语法。虽然这是仓颉限制下的合理 bypass，但设计文档未提及此偏差是否需要记录到 `deviations.md`。根据 `requirement.md` 要求"本次实施中的偏差需要依据偏差文档开头的指示添加到相应位置"。

**期望修正方向**：评估是否需要在 `deviations.md` 中记录此偏差（`Vec1 cast` 以顶层函数替代跨类型构造函数），或至少在设计中说明此决策。

## 修改要求

1. **[严重]** 修复所有 4 个重载的函数体：将 `Vec1(conv(v.x))` 改为 `Vec1<T, Q>(conv(v.x))`
2. **[一般]** 评估 `deviation.md` 记录需求：`cast` 函数作为构造函数 bypass 是否需要记录为偏差
