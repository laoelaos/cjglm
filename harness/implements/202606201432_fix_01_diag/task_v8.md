# 任务指令（v8）

## 动作
NEW

## 任务描述
在 `type_vec1.cj`、`type_vec2.cj`、`type_vec3.cj`、`type_vec4.cj` 的 `Integer<T>` extend 块中，各追加 `increment()` 和 `decrement()` 具名函数（均标注 `@OverflowWrapping`）。同步追加对应测试用例到各 Vec 的测试文件。

### 代码变更清单

| 文件 | 操作 | 说明 |
|------|------|------|
| `src/detail/type_vec1.cj` | 追加 2 个函数 | `Integer<T>` extend 块末尾（第 144 行前） |
| `src/detail/type_vec2.cj` | 追加 2 个函数 | `Integer<T>` extend 块末尾（第 123 行前） |
| `src/detail/type_vec3.cj` | 追加 2 个函数 | `Integer<T>` extend 块末尾（第 130 行前） |
| `src/detail/type_vec3_test.cj` | 追加测试 | increment + decrement 各 1 个测试函数 |
| `src/detail/type_vec4.cj` | 追加 2 个函数 | `Integer<T>` extend 块末尾（第 137 行前） |
| `src/detail/type_vec4_test.cj` | 追加测试 | increment + decrement 各 1 个测试函数 |
| `src/detail/type_vec1_test.cj` | 追加测试 | increment + decrement 各 1 个测试函数 |
| `src/detail/type_vec2_test.cj` | 追加测试 | increment + decrement 各 1 个测试函数 |

> 共 4 个源文件各 2 个函数（8 个函数），4 个测试文件各 2 个测试（8 个测试函数）。

### 函数签名与行为（Vec1 示例）

```cangjie
@OverflowWrapping
public mut func increment(): Unit {
    this.x += Int64(1)
}

@OverflowWrapping
public mut func decrement(): Unit {
    this.x -= Int64(1)
}
```

| Vec 类型 | increment 操作 | decrement 操作 |
|----------|---------------|---------------|
| Vec1 | `this.x += 1` | `this.x -= 1` |
| Vec2 | `this.x += 1; this.y += 1` | `this.x -= 1; this.y -= 1` |
| Vec3 | `this.x += 1; this.y += 1; this.z += 1` | `this.x -= 1; this.y -= 1; this.z -= 1` |
| Vec4 | `this.x += 1; this.y += 1; this.z += 1; this.w += 1` | `this.x -= 1; this.y -= 1; this.z -= 1; this.w -= 1` |

注：如 `this.x += Int64(1)` 因 `Integer<T>` 的 `+=` 操作符对 `Int64` 不支持，可改用 `this.x = this.x + (Int64(1) as T)` 或 `this.x + Int64(1)` 模式。实际 Cangjie 编译器行为需编译验证，可灵活调整实现细节（如改用返回新 Vec 的不可变方案 `func increment(): VecN<T,Q>`）。

### 测试要求

每个 Vec 的测试文件追加以下 2 个测试函数（以 Vec1 为例）：

| 测试函数 | 场景 | 验证点 |
|---------|------|--------|
| `testVec1Increment` | `var v = Vec1<Int64,Defaultp>(5); v.increment()` | `@Expect(v.x, 6)` |
| `testVec1Decrement` | `var v = Vec1<Int64,Defaultp>(5); v.decrement()` | `@Expect(v.x, 4)` |

如果选择不可变方案（返回新 Vec），对应调整为：
- `let v = Vec1<Int64,Defaultp>(5); let r = v.increment()` → `@Expect(r.x, 6)`
- 验证原 v 不变

Vec2/3/4 同理验证所有分量的自增/自减。

### 跨类型验证（可选）

对 Vec2/3/4 可追加一个跨类型测试（如 `Int32` 或跨 Q），例如：
- `testVec2IncrementInt32`：`Vec2<Int32,Defaultp>(5,10)` → increment → (6,11)
- `testVec2IncrementCrossQ`：`Vec2<Int64,PackedHighp>(5,10)` → increment → (6,11)

## 选择理由
R7 完成后所有高优先级的构造函数/类型转换绕过/脚本同步任务已完成。increment/decrement 是 OOD §3.2/§4.6 要求的 `Integer<T>` 扩展功能，实现模式统一（分量级自加/自减 1），是"尚未覆盖"项中最优先的。

## 任务上下文

### OOD 设计要求（§3.2 / §4.6）
- `increment()` — 所有分量 +1
- `decrement()` — 所有分量 -1
- 标注 `@OverflowWrapping`
- 定义在 `extend<T, Q> VecN<T, Q> where T <: Integer<T>, Q <: Qualifier` 块中

### 现有代码模式参考

已有 `add(s: T)` / `sub(s: T)` 模式（不可变、返回新 Vec）：
```cangjie
public func add(s: T): Vec1<T, Q> { this + s }
public func sub(s: T): Vec1<T, Q> { this - s }
```

### Integer<T> extend 块末尾位置

Vec1 (`type_vec1.cj:144`):
```cangjie
    public operator func >>(rhs: Vec4<Int64, Q>): Vec4<T, Q> { Vec4(this.x >> rhs.x, this.x >> rhs.y, this.x >> rhs.z, this.x >> rhs.w) }
}
// ↑ 在此 } 前追加 increment/decrement
```

Vec2 (`type_vec2.cj:123`):
```cangjie
    public operator func >>(rhs: Vec1<Int64, Q>): Vec2<T, Q> { Vec2(this.x >> rhs.x, this.y >> rhs.x) }
}
// ↑ 在此 } 前追加
```

Vec3 (`type_vec3.cj:130`):
```cangjie
    public operator func >>(rhs: Vec1<Int64, Q>): Vec3<T, Q> { Vec3(this.x >> rhs.x, this.y >> rhs.x, this.z >> rhs.x) }
}
// ↑ 在此 } 前追加
```

Vec4 (`type_vec4.cj:137`):
```cangjie
    public operator func >>(rhs: Vec1<Int64, Q>): Vec4<T, Q> { Vec4(this.x >> rhs.x, this.y >> rhs.x, this.z >> rhs.x, this.w >> rhs.x) }
}
// ↑ 在此 } 前追加
```

### 测试文件路径
- `src/detail/type_vec1_test.cj`
- `src/detail/type_vec2_test.cj`
- `src/detail/type_vec3_test.cj`
- `src/detail/type_vec4_test.cj`

### 偏差记录要求
本次实现属于 OOD §3.2/§4.6 的正常编码实现。如因仓颉语言限制导致实现方式与 OOD 偏差（如不可用 `mut` 模式），需记录到 `code_v{N}.md` 的"设计偏差说明"章节。
