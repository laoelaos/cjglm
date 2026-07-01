# 任务指令（v4）

## 动作
NEW

## 任务描述
在 `ext/vector_common.cj` 补齐 `fmin`/`fmax` 缺失的 3/4 输入向量版本（G5），每函数 8 个重载（Vec1~Vec4 × 3输入 + 4输入），共 16 个。标记 `04_diag.md` G5 条目为已修复。

### 预期文件修改
| 文件 | 操作 | 说明 |
|------|------|------|
| `cjglm/src/ext/vector_common.cj` | 修改 | 新增 16 个函数重载（在现有 fmin/fmax 2-输入版本之后追加） |
| `docs/diag/impl/04_diag.md` | 修改 | G5 修改方向行（:135）追加 `✅ 已修复` |

> **注**：`lib.cj:41` 已通过 `public import glm.ext.{fmin, fmax, ...}` 覆盖新增重载，无需额外修改。

### 新增的 16 个函数

#### fmin 3-输入 (a, b, c) — Vec1~Vec4 × 4 个
| 签名 | 实现 |
|------|------|
| `fmin<T, Q>(a: Vec1, b: Vec1, c: Vec1): Vec1 where T<:FloatingPoint<T>&Comparable<T>, Q<:Qualifier` | `Vec1(fmin(a.x, b.x, c.x))` |
| `fmin<T, Q>(a: Vec2, b: Vec2, c: Vec2): Vec2 where ...` | `Vec2(fmin(a.x,b.x,c.x), fmin(a.y,b.y,c.y))` |
| `fmin<T, Q>(a: Vec3, b: Vec3, c: Vec3): Vec3 where ...` | `Vec3(fmin(a.x,b.x,c.x), fmin(a.y,b.y,c.y), fmin(a.z,b.z,c.z))` |
| `fmin<T, Q>(a: Vec4, b: Vec4, c: Vec4): Vec4 where ...` | `Vec4(fmin(a.x,b.x,c.x), fmin(a.y,b.y,c.y), fmin(a.z,b.z,c.z), fmin(a.w,b.w,c.w))` |

#### fmin 4-输入 (a, b, c, d) — Vec1~Vec4 × 4 个
| 签名 | 实现 |
|------|------|
| `fmin<T, Q>(a: Vec1, b: Vec1, c: Vec1, d: Vec1): Vec1` | `Vec1(fmin(a.x, b.x, c.x, d.x))` |
| `fmin<T, Q>(a: Vec2, b: Vec2, c: Vec2, d: Vec2): Vec2` | `Vec2(fmin(a.x,b.x,c.x,d.x), fmin(a.y,b.y,c.y,d.y))` |
| `fmin<T, Q>(a: Vec3, b: Vec3, c: Vec3, d: Vec3): Vec3` | `Vec3(fmin(a.x,b.x,c.x,d.x), fmin(a.y,b.y,c.y,d.y), fmin(a.z,b.z,c.z,d.z))` |
| `fmin<T, Q>(a: Vec4, b: Vec4, c: Vec4, d: Vec4): Vec4` | `Vec4(fmin(a.x,b.x,c.x,d.x), fmin(a.y,b.y,c.y,d.y), fmin(a.z,b.z,c.z,d.z), fmin(a.w,b.w,c.w,d.w))` |

#### fmax 3-输入 (a, b, c) — Vec1~Vec4 × 4 个
模式同上，`fmin` 替换为 `fmax`。

#### fmax 4-输入 (a, b, c, d) — Vec1~Vec4 × 4 个
模式同上，`fmin` 替换为 `fmax`。

## 选择理由
P2-1（G2 vector_relational 补全）已通过验证。P2-2（G5 fmin/fmax 补齐）是 P2 批次中模式最接近的后续任务——同为 API 完整性补全，均为新增简单委托重载，且无 lib.cj 修改需求（已有 public import 覆盖）。fmin/fmax 是浮点向量函数，3/4 输入版本直接委托到对应标量函数，编码简单、风险低。

## 任务上下文

### G5 诊断摘要（来自 04_diag.md:126-140）
- **真实性**：真实问题
- **根因**：实现不完整（OOD 设计了但未编码）
- **证据**：OOD 文档 §3.2 明确列出 4 组 fmin 重载，代码仅实现了 `fmin(a,b)` 的 2 输入版本，缺失 3/4 输入版本（fmax 同理）
- **修改方向**：补齐缺失的 16 个 fmin/fmax 向量重载
- **副作用**：新增重载自动被 public import 覆盖，无兼容性问题

### 已有代码结构
`ext/vector_common.cj:59-107` 现有 fmin/fmax 2-输入版本模式（标量扩展 + 同维向量各 4 个）：
```cangjie
public func fmin<T, Q>(a: Vec1<T, Q>, b: T): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b))
}
public func fmin<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b.x))
}
```

新函数放在 2-输入版本之后（`:107` 之后），遵循相同的 `FloatingPoint<T> & Comparable<T>` 约束和 `Qualifier` 泛型模式。

### 对照参考
同一文件中已有 `min`/`max` 的 3/4 输入向量版本（`:7-55`），模式完全一致：
```cangjie
public func min<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(min(a.x, b.x, c.x))
}
```

只需将 `min`/`max` 替换为 `fmin`/`fmax`，约束从 `Number<T>` 改为 `FloatingPoint<T>`。

### 04_diag.md 标记位置
G5 条目在 `04_diag.md:126-140`，修改方向行（`:135`）追加 `✅ 已修复`。
