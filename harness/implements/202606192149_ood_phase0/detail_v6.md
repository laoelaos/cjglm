# 详细设计（v6）

## 概述
修复 `type_vec1~4.cj` 中三类预存泛型约束编译错误（`%` 运算符位置错误、`<<`/`>>` 右操作数类型错误、存在非法一元 `+` 运算符），并同步修正测试文件中的无效测试用例（删除 `test*UnaryPlus`）。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_vec1.cj` | 修改 | 修复 Vec1 的 3 类编译错误 |
| `src/detail/type_vec2.cj` | 修改 | 修复 Vec2 的 3 类编译错误 |
| `src/detail/type_vec3.cj` | 修改 | 修复 Vec3 的 3 类编译错误 |
| `src/detail/type_vec4.cj` | 修改 | 修复 Vec4 的 3 类编译错误 |
| `src/detail/type_vec1_test.cj` | 修改 | 删除 `testVec1UnaryPlus` |
| `src/detail/type_vec2_test.cj` | 修改 | 删除 `testVec2UnaryPlus` |
| `src/detail/type_vec3_test.cj` | 修改 | 删除 `testVec3UnaryPlus` |
| `src/detail/type_vec4_test.cj` | 修改 | 删除 `testVec4UnaryPlus` |

## 类型定义（无新类型，仅修改既有 extend 块）

### 修复 1：`%` 运算符移入 `Integer<T>` extend 块

**当前状态**：`%` 运算符和 `mod` 具名函数定义在 `extend<T, Q> VecN<T, Q> where T <: Number<T>` 块中。

**原因**：`Number<T>` 接口不提供 `%`，`Integer<T>` 接口提供 `operator func %(rhs: T): T`。

**修改**：

#### `Number<T>` 块中删除：
- 全部 `public operator func %(...)` 重载（VecN op VecN、VecN op T、广播 Vec2/3/4）
- `public func mod(s: T): VecN<T, Q>` 具名函数

#### `Integer<T>` 块中插入：
所有被删除的 `%` 和 `mod` 定义插入到 `Integer<T>` 块中，置于 `bitwiseNot()` 之后、`&(rhs: T)` 之前。

### 修复 2：`<<`/`>>` 右操作数改为 `Int64`

**原因**：`Integer<T>` 接口中 `<<`/`>>` 定义签名为 `operator func <<(n: Int64): T`，右操作数必须是 `Int64`，不能是 `T`。

**修改范围（Integer<T> 块内）**：

| 当前签名 | 修改后签名 |
|---------|-----------|
| `<<(rhs: Vec1<T, Q>)` | `<<(rhs: Vec1<Int64, Q>)` |
| `<<(shift: T)` | `<<(shift: Int64)` |
| `<<(rhs: Vec2<T, Q>)`（Vec1→Vec2） | `<<(rhs: Vec2<Int64, Q>)` |
| `<<(rhs: Vec3<T, Q>)`（Vec1→Vec3） | `<<(rhs: Vec3<Int64, Q>)` |
| `<<(rhs: Vec4<T, Q>)`（Vec1→Vec4） | `<<(rhs: Vec4<Int64, Q>)` |
| `>>` 所有重载同理 | 同上 |

Vec2/3/4 的 Integer<T> 块中同理修改所有 `<<`/`>>` 重载的参数类型。

### 修复 3：删除一元 `+` 运算符

**原因**：仓颉可重载运算符列表中不包含一元 `+`（仅一元 `-` 合法）。

**修改**：从所有 VecN 的 `Number<T>` extend 块中删除 `public operator func +(): VecN<T, Q> { this }` 行。

## Vec1 修改后 `Number<T>` 块结构

```cangjie
extend<T, Q> Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x + rhs.x) }
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x - rhs.x) }
    @OverflowWrapping
    public operator func *(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x * rhs.x) }
    @OverflowWrapping
    public operator func /(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x / rhs.x) }

    @OverflowWrapping
    public operator func +(rhs: T): Vec1<T, Q> { Vec1(this.x + rhs) }
    @OverflowWrapping
    public operator func -(rhs: T): Vec1<T, Q> { Vec1(this.x - rhs) }
    @OverflowWrapping
    public operator func *(rhs: T): Vec1<T, Q> { Vec1(this.x * rhs) }
    @OverflowWrapping
    public operator func /(rhs: T): Vec1<T, Q> { Vec1(this.x / rhs) }

    public operator func -(): Vec1<T, Q> { Vec1(-this.x) }

    public func add(s: T): Vec1<T, Q> { this + s }
    public func sub(s: T): Vec1<T, Q> { this - s }
    public func mul(s: T): Vec1<T, Q> { this * s }
    public func div(s: T): Vec1<T, Q> { this / s }

    @OverflowWrapping
    public operator func +(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x + rhs.x, this.x + rhs.y) }
    @OverflowWrapping
    public operator func -(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x - rhs.x, this.x - rhs.y) }
    @OverflowWrapping
    public operator func *(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x * rhs.x, this.x * rhs.y) }
    @OverflowWrapping
    public operator func /(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x / rhs.x, this.x / rhs.y) }

    @OverflowWrapping
    public operator func +(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x + rhs.x, this.x + rhs.y, this.x + rhs.z) }
    @OverflowWrapping
    public operator func -(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x - rhs.x, this.x - rhs.y, this.x - rhs.z) }
    @OverflowWrapping
    public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x * rhs.x, this.x * rhs.y, this.x * rhs.z) }
    @OverflowWrapping
    public operator func /(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x / rhs.x, this.x / rhs.y, this.x / rhs.z) }

    @OverflowWrapping
    public operator func +(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x + rhs.x, this.x + rhs.y, this.x + rhs.z, this.x + rhs.w) }
    @OverflowWrapping
    public operator func -(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x - rhs.x, this.x - rhs.y, this.x - rhs.z, this.x - rhs.w) }
    @OverflowWrapping
    public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x * rhs.x, this.x * rhs.y, this.x * rhs.z, this.x * rhs.w) }
    @OverflowWrapping
    public operator func /(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x / rhs.x, this.x / rhs.y, this.x / rhs.z, this.x / rhs.w) }
}
```

## Vec1 修改后 `Integer<T>` 块结构

```cangjie
extend<T, Q> Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x & rhs.x) }
    public operator func |(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x | rhs.x) }
    public operator func ^(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x ^ rhs.x) }
    @OverflowWrapping
    public operator func <<(rhs: Vec1<Int64, Q>): Vec1<T, Q> { Vec1(this.x << rhs.x) }
    public operator func >>(rhs: Vec1<Int64, Q>): Vec1<T, Q> { Vec1(this.x >> rhs.x) }

    public func bitwiseNot(): Vec1<T, Q> { Vec1(!this.x) }

    // --- % from Number<T> moved here ---
    @OverflowWrapping
    public operator func %(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x % rhs.x) }
    @OverflowWrapping
    public operator func %(rhs: T): Vec1<T, Q> { Vec1(this.x % rhs) }
    public func mod(s: T): Vec1<T, Q> { this % s }
    @OverflowWrapping
    public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x % rhs.x, this.x % rhs.y) }
    @OverflowWrapping
    public operator func %(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z) }
    @OverflowWrapping
    public operator func %(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z, this.x % rhs.w) }
    // --- end moved section ---

    public operator func &(rhs: T): Vec1<T, Q> { Vec1(this.x & rhs) }
    public operator func |(rhs: T): Vec1<T, Q> { Vec1(this.x | rhs) }
    public operator func ^(rhs: T): Vec1<T, Q> { Vec1(this.x ^ rhs) }
    @OverflowWrapping
    public operator func <<(shift: Int64): Vec1<T, Q> { Vec1(this.x << shift) }
    public operator func >>(shift: Int64): Vec1<T, Q> { Vec1(this.x >> shift) }

    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x & rhs.x, this.x & rhs.y) }
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x | rhs.x, this.x | rhs.y) }
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x ^ rhs.x, this.x ^ rhs.y) }
    @OverflowWrapping
    public operator func <<(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x << rhs.x, this.x << rhs.y) }
    public operator func >>(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x >> rhs.x, this.x >> rhs.y) }

    public operator func &(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x & rhs.x, this.x & rhs.y, this.x & rhs.z) }
    public operator func |(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x | rhs.x, this.x | rhs.y, this.x | rhs.z) }
    public operator func ^(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x ^ rhs.x, this.x ^ rhs.y, this.x ^ rhs.z) }
    @OverflowWrapping
    public operator func <<(rhs: Vec3<Int64, Q>): Vec3<T, Q> { Vec3(this.x << rhs.x, this.x << rhs.y, this.x << rhs.z) }
    public operator func >>(rhs: Vec3<Int64, Q>): Vec3<T, Q> { Vec3(this.x >> rhs.x, this.x >> rhs.y, this.x >> rhs.z) }

    public operator func &(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x & rhs.x, this.x & rhs.y, this.x & rhs.z, this.x & rhs.w) }
    public operator func |(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x | rhs.x, this.x | rhs.y, this.x | rhs.z, this.x | rhs.w) }
    public operator func ^(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x ^ rhs.x, this.x ^ rhs.y, this.x ^ rhs.z, this.x ^ rhs.w) }
    @OverflowWrapping
    public operator func <<(rhs: Vec4<Int64, Q>): Vec4<T, Q> { Vec4(this.x << rhs.x, this.x << rhs.y, this.x << rhs.z, this.x << rhs.w) }
    public operator func >>(rhs: Vec4<Int64, Q>): Vec4<T, Q> { Vec4(this.x >> rhs.x, this.x >> rhs.y, this.x >> rhs.z, this.x >> rhs.w) }
}
```

## Vec2/3/4 修改规则（与 Vec1 同理）
- `Number<T>` 块：删除所有 `%` 运算符重载 + `mod` + 一元 `+`
- `Integer<T>` 块：删除 `%(rhs: T)` 等行（原已有）——实际上 Vec2/3/4 的 `%` 原本就在 Number 块中，Integer 块中无 `%`。只需将 Number 块中的 `%`/`mod` 移入 Integer 块，`<<`/`>>` 的右操作数从 `T` 改为 `Int64`

## 测试文件修改

### Vec1 测试删除项
```cangjie
@Test
func testVec1UnaryPlus(): Unit {
    let v = Vec1<Int64, Defaultp>(-3)
    let r = +v
    @Expect(r.x, -3)
}
```

### Vec2 测试删除项
```cangjie
@Test
func testVec2UnaryPlus(): Unit {
    let v = Vec2<Int64, Defaultp>(-1, 2)
    let r = +v
    @Expect(r.x, -1)
    @Expect(r.y, 2)
}
```

### Vec3 测试删除项
```cangjie
@Test
func testVec3UnaryPlus(): Unit {
    let v = Vec3<Int64, Defaultp>(-1, 2, -3)
    let r = +v
    @Expect(r.x, -1)
    @Expect(r.y, 2)
    @Expect(r.z, -3)
}
```

### Vec4 测试删除项
```cangjie
@Test
func testVec4UnaryPlus(): Unit {
    let v = Vec4<Int64, Defaultp>(-1, 2, -3, 4)
    let r = +v
    @Expect(r.x, -1)
    @Expect(r.y, 2)
    @Expect(r.z, -3)
    @Expect(r.w, 4)
}
```

### 不需修改的测试
- `%` 运算符测试：`T = Int64`，`Int64 <: Integer<Int64>`，移入 `Integer<T>` 块后继续可用
- `<<`/`>>` 向量移位测试：`T = Int64`，修改后的签名 `<<(rhs: VecN<Int64, Q>)` 仍然匹配 `VecN<Int64, Defaultp>`
- 广播移位测试同理
- 标量移位测试：`<<(shift: Int64)` 签名匹配调用方 `Int64(2)` 参数

## 错误处理
无运行时错误处理变更。编译期错误由仓颉编译器自动捕获。

## 行为契约
- 所有 `%` 运算符和 `mod` 具名函数保留完整语义，仅改变所在 extend 块
- `<<`/`>>` 的右操作数类型改为 `Int64` 后，调用方仍使用 `Int64` 字面量（如 `Int64(2)`）即可
- 一元 `+` 被删除后，`+v` 表达式不再可编译，需从测试中移除
- `Number<T>` 块仅保留 `+`, `-`, `*`, `/`, 一元 `-`, `add/sub/mul/div` 及其广播

## 依赖关系
| 文件 | 依赖 | 说明 |
|------|------|------|
| `src/detail/type_vec1~4.cj` | `std.math.{ Number, Integer }` | 泛型约束仅依赖这两个接口 |
| 测试文件 | 无额外依赖 | 测试使用 `Int64`，满足 `Integer<Int64>` 约束 |
