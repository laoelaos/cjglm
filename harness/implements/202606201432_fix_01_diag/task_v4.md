# 任务指令（v4）

## 动作
NEW

## 任务描述
在 `src/detail/type_cast.cj` 中将已有 4 个 `cast` 函数重命名为 `castVec1`，并追加 4 个 `castVec2` 重载（Vec1/Vec2/Vec3/Vec4 → Vec2）。同步更新 `type_cast_test.cj`。

### 变更清单

| 文件 | 操作 | 说明 |
|------|------|------|
| `src/detail/type_cast.cj` | 重命名 + 追加 | `cast` → `castVec1`（4 处），新增 `castVec2`（4 个重载） |
| `src/detail/type_cast_test.cj` | 重命名 + 追加 | `cast(` → `castVec1(`（所有调用处），新增 Vec2-target 测试 |

### 重命名方案

已有 4 个 R3 函数（参数不变，仅改名）：

```cangjie
// before (R3):
public func cast<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...
public func cast<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...
public func cast<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...
public func cast<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...

// after:
public func castVec1<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...
public func castVec1<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...
public func castVec1<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...
public func castVec1<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec1<T, Q> ...
```

### 新增函数签名

```cangjie
// Vec1 → Vec2：单分量 conv(v.x) 填充 x 和 y
public func castVec2<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.x))
}

// Vec2 → Vec2：逐分量映射
public func castVec2<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.y))
}

// Vec3 → Vec2：截取 x, y 分量
public func castVec2<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.y))
}

// Vec4 → Vec2：截取 x, y 分量
public func castVec2<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.y))
}
```

### 转换规则

| 源类型 | 取分量 | 函数体 |
|--------|--------|--------|
| `Vec1<T2, Q2>` | `.x`（单分量填充 xy） | `Vec2<T, Q>(conv(v.x), conv(v.x))` |
| `Vec2<T2, Q2>` | `.x`, `.y`（逐分量映射） | `Vec2<T, Q>(conv(v.x), conv(v.y))` |
| `Vec3<T2, Q2>` | `.x`, `.y`（截取前两分量） | `Vec2<T, Q>(conv(v.x), conv(v.y))` |
| `Vec4<T2, Q2>` | `.x`, `.y`（截取前两分量） | `Vec2<T, Q>(conv(v.x), conv(v.y))` |

### 新增测试要求

在 `src/detail/type_cast_test.cj` 中追加以下测试（参照 R3 已通过的 `cast`（现名 `castVec1`）测试模式）：

| 测试函数 | 场景 | 验证点 |
|---------|------|--------|
| `testCastVec2Vec1ToVec2IntToFloat` | Vec1<Int64> → Vec2<Float64> | 结果 x 和 y 均为 `conv(v.x)` 的 Float64 值 |
| `testCastVec2Vec2ToVec2Identity` | Vec2<Int64> → Vec2<Int64> | x→x, y→y，值不变 |
| `testCastVec2Vec3ToVec2TakesOnlyXY` | Vec3<Int64> → Vec2<Int64> | 结果 x/y 等于源 x/y，z 被丢弃 |
| `testCastVec2Vec4ToVec2TakesOnlyXY` | Vec4<Int64> → Vec2<Int64> | 结果 x/y 等于源 x/y，z/w 被丢弃 |
| `testCastVec2SameTypeIdentity` | Vec2<Int64,Defaultp> → Vec2<Int64,Defaultp> | `conv = {x => x}` 验证不变 |
| `testCastVec2Int32ToInt64` | Vec2<Int32> → Vec2<Int64> | 类型提升正确 |
| `testCastVec2FloatToIntTruncation` | Vec2<Float64> → Vec2<Int64> | 浮点→整数截断（如 `3.9` → `3`） |
| `testCastVec2CrossQualifierPackedHighpToDefaultp` | Vec2<Int64,PackedHighp> → Vec2<Int64,Defaultp> | 跨 Q 转换 |
| `testCastVec2DoesNotModifySource` | Vec2<Int64> → Vec2<Int64> | 转换后源 Vec 分量不变 |
| `testCastVec2Vec1ToVec2SameValueBothComponents` | Vec1<Int64> → Vec2<Int64> | xy 两个分量值相同（均为 `v.x` 的 conv 结果） |

## 选择理由
仓颉重载解析按参数类型而非返回类型判断（`function/README.md` §7.1），Vec2-target 与 Vec1-target 参数签名完全相同导致重定义错误。将目标类型编码到函数名 `castVec1`/`castVec2` 彻底消除歧义，同时函数名自描述目标类型便于用户使用。

Vec2 是下一个目标类型（对应 #10 Vec2 跨类型转换构造函数的 bypass）。R3 已验证跨 Q 显式泛型 + 转换闭包模式可编译通过且测试通过，扩展至 Vec2 无新增技术风险。

## 任务上下文

### 现有 type_cast.cj（R3）

```cangjie
package glm.detail

public func cast<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}

public func cast<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}

public func cast<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}

public func cast<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}
```

### 现有 type_cast_test.cj（R3 测试）
需读取实际文件确认已有测试模式，重命名所有 `cast(` 为 `castVec1(`。

### Vec2 构造函数引用
```cangjie
// Vec2<T, Q> 已有
public const init(x: T, y: T)
```

## 重命名 R3 测试说明

`type_cast_test.cj` 中所有调用 `cast(...)` 的地方必须改为 `castVec1(...)`。R3 已通过的测试函数名不变，内部调用的函数名更新即可。

## 重载歧义声明

所有 `castVec2` 重载通过参数类型 `Vec1<T2,Q2>`/`Vec2<T2,Q2>`/`Vec3<T2,Q2>`/`Vec4<T2,Q2>` 区分，与已有的 `castVec1` 通过不同函数名区分，无任何重载歧义。

## 偏差记录要求

本次实现属于对 #10（Vec2 跨类型转换构造函数缺失）的 bypass 方案，与 R3 #9-bypass 相同性质。需在 `code_v4.md` 的"设计偏差说明"章节记录此偏差：
- 类别：接口/行为有偏差（类别二）
- 原因：仓颉不支持构造函数的独立泛型参数 `init<T2, Q2>`，且不支持以类型参数作为构造函数调用 `T(v.x)`；仓颉重载解析按参数类型而非返回类型判定，因此需将目标类型编码到函数名
- 替代方案：顶层 `castVec1`/`castVec2` 函数 + 转换闭包参数
- 关联原问题：#9（已绕过）、#10（本次）
- 草案格式参考 `DV-01` 或 `DEV-04`，待编码阶段或之后写入 `docs/deviations.md` §四
