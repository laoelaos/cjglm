# 详细设计（v4）

## 概述

在 `src/detail/type_cast.cj` 中将已有 4 个 `cast` 函数重命名为 `castVec1`，并追加 4 个 `castVec2` 重载（Vec1/Vec2/Vec3/Vec4 → Vec2）。同步重命名 `type_cast_test.cj` 中所有 `cast(` 调用为 `castVec1(`，并追加 Vec2-target 测试。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_cast.cj` | 重命名 + 追加 | `cast` → `castVec1`（4 处函数名），新增 `castVec2` 重载（4 个） |
| `src/detail/type_cast_test.cj` | 重命名 + 追加 | `cast(` → `castVec1(`（13 处调用），新增 Vec2-target 测试用例 |

## 类型定义

无新增类型。仅涉及函数重命名和新增重载。

## 函数签名

### castVec1（R3 cast 重命名）

**形态**：顶层函数
**包路径**：`glm.detail`
**变更**：函数名 `cast` → `castVec1`，参数和函数体不变

```cangjie
public func castVec1<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec1<T, Q>(conv(v.x))

public func castVec1<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec1<T, Q>(conv(v.x))

public func castVec1<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec1<T, Q>(conv(v.x))

public func castVec1<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec1<T, Q>(conv(v.x))
```

### castVec2（新增）

**形态**：顶层函数
**包路径**：`glm.detail`
**职责**：Vec1/Vec2/Vec3/Vec4 → Vec2 跨类型分量转换

```cangjie
// Vec1→Vec2：单分量 conv(v.x) 填充 x 和 y
public func castVec2<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec2<T, Q>(conv(v.x), conv(v.x))

// Vec2→Vec2：逐分量映射
public func castVec2<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec2<T, Q>(conv(v.x), conv(v.y))

// Vec3→Vec2：截取 x, y 分量
public func castVec2<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec2<T, Q>(conv(v.x), conv(v.y))

// Vec4→Vec2：截取 x, y 分量
public func castVec2<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec2<T, Q>(conv(v.x), conv(v.y))
```

## 转换规则

| 源类型 | 目标类型 | 取分量 | 函数体 |
|--------|---------|--------|--------|
| `Vec1<T2, Q2>` | `Vec2<T, Q>` | `.x` 单分量填充 xy | `Vec2<T, Q>(conv(v.x), conv(v.x))` |
| `Vec2<T2, Q2>` | `Vec2<T, Q>` | `.x`, `.y` 逐分量映射 | `Vec2<T, Q>(conv(v.x), conv(v.y))` |
| `Vec3<T2, Q2>` | `Vec2<T, Q>` | `.x`, `.y` 截取前两分量 | `Vec2<T, Q>(conv(v.x), conv(v.y))` |
| `Vec4<T2, Q2>` | `Vec2<T, Q>` | `.x`, `.y` 截取前两分量 | `Vec2<T, Q>(conv(v.x), conv(v.y))` |

## 重载分析

- 4 个 `castVec2` 重载之间通过参数类型 `Vec1<T2,Q2>`/`Vec2<T2,Q2>`/`Vec3<T2,Q2>`/`Vec4<T2,Q2>` 区分，无歧义
- `castVec2` 与 `castVec1` 通过不同函数名区分，无歧义
- 8 个函数共存于同一包 `glm.detail`，函数名和参数类型组合唯一

## 类型设计决策

- **T2 无约束**：T2 签名层面可为任意类型（含 Bool）。`conv` 闭包的类型兼容性由调用方保证
- **Q2 <: Qualifier**：允许任意 Qualifier 之间的跨 Q 转换
- **跨 Q 显式类型参数**：所有函数体使用 `Vec2<T, Q>(...)` 而非 `Vec2(...)`，与 R3 `cast`（`castVec1`）一致。原因：编译器无法从 `v: VecN<T2, Q2>` 推断 `Vec2` 构造函数的 `Q` 类型参数，必须显式指定
- **函数名 `castVec1`/`castVec2`**：目标类型编码到函数名，避免仓颉不支持返回类型重载的限制

## 错误处理

无新增错误处理逻辑。`conv(v.x)`/`conv(v.y)` 返回类型不匹配时由编译器报告类型错误，为 D5 延迟检查的预期行为。

## 行为契约

- 各函数仅读取源 Vec 的分量（不修改源 Vec）
- 通过 `conv` 闭包完成 `T2`→`T` 的分量值转换
- 结果通过 `Vec2<T, Q>(...)` 构造函数构造
- Vec1→Vec2 时，xy 分量均为 `conv(v.x)` 的结果（GLM 兼容：单分量扩展填充所有目标分量）
- Vec3/Vec4→Vec2 时，仅取前两分量，后续分量被静默丢弃

## 依赖关系

- 依赖 `Vec1`/`Vec2`/`Vec3`/`Vec4` 类型的定义（仅在签名中使用，不依赖内部实现）
- 被依赖方：无（新增函数为纯新增，不影响已有调用代码）

## 偏差记录

`castVec1`/`castVec2` 函数以顶层函数替代跨类型构造函数，属于**接口/行为有偏差**（类别二）。原因：
1. 仓颉不支持构造函数的独立泛型参数 `init<T2, Q2>`
2. 仓颉不支持以类型参数作为构造函数调用 `T(v.x)`
3. 仓颉重载解析按参数类型而非返回类型判定，因此需将目标类型编码到函数名

根据 `deviations.md` 头部说明，尚未验证的偏差写入 §四。此偏差需在编码阶段或之后以草案形式写入 `docs/deviations.md` §四（未验证的偏差添加），格式参考 `DV-01` 或 `DEV-04`。

## 已有代码参考

R3 已验证的顶层泛型函数模式（`type_cast.cj` 即将重命名）：

```cangjie
public func cast<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}
```

## 测试设计

### 重命名 R3 测试
`type_cast_test.cj` 中 13 处 `cast<...>(...)` 调用逐一替换为 `castVec1<...>(...)`。测试函数名保持不变。

### 新增 Vec2-target 测试

| 测试函数 | 场景 | 断言 |
|---------|------|------|
| `testCastVec2Vec1ToVec2IntToFloat` | Vec1<Int64> → Vec2<Float64> | `.x`=Float32(42.0), `.y`=Float32(42.0) |
| `testCastVec2Vec2ToVec2Identity` | Vec2<Int64>(10,20) → Vec2<Int64> | `.x`=10, `.y`=20 |
| `testCastVec2Vec3ToVec2TakesOnlyXY` | Vec3<Int64>(10,20,30) → Vec2<Int64> | `.x`=10, `.y`=20 |
| `testCastVec2Vec4ToVec2TakesOnlyXY` | Vec4<Int64>(10,20,30,40) → Vec2<Int64> | `.x`=10, `.y`=20 |
| `testCastVec2SameTypeIdentity` | Vec2<Int64>(7,8) → Vec2<Int64>, conv={x=>x} | `.x`=7, `.y`=8 |
| `testCastVec2Int32ToInt64` | Vec2<Int32> → Vec2<Int64> | `.x`=Int64(99), `.y`=Int64(88) |
| `testCastVec2FloatToIntTruncation` | Vec2<Float32>(3.7, 5.2) → Vec2<Int64> | `.x`=3, `.y`=5 |
| `testCastVec2CrossQualifierPackedHighpToDefaultp` | Vec2<Int64,PackedHighp> → Vec2<Int64,Defaultp> | `.x`=5, `.y`=6 |
| `testCastVec2DoesNotModifySource` | Vec2<Int64>(42,43) → Vec2<Int64> | 转换后源.x=42, 源.y=43 |
| `testCastVec2Vec1ToVec2SameValueBothComponents` | Vec1<Int64>(7) → Vec2<Int64> | `.x`=7, `.y`=7（验证 xy 值相同） |
