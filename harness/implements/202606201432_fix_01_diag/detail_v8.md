# 详细设计（v8）

## 概述

在 `type_vec1.cj`、`type_vec2.cj`、`type_vec3.cj`、`type_vec4.cj` 的 `Integer<T>` extend 块末尾各追加 `increment()` 和 `decrement()` 两个 `mut` 函数（标注 `@OverflowWrapping`），实现所有分量自增/自减 1。同步追加对应测试用例。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_vec1.cj` | 修改 | `Integer<T>` extend 块末尾追加 `increment()`、`decrement()` |
| `src/detail/type_vec2.cj` | 修改 | `Integer<T>` extend 块末尾追加 `increment()`、`decrement()` |
| `src/detail/type_vec3.cj` | 修改 | `Integer<T>` extend 块末尾追加 `increment()`、`decrement()` |
| `src/detail/type_vec4.cj` | 修改 | `Integer<T>` extend 块末尾追加 `increment()`、`decrement()` |
| `src/detail/type_vec1_test.cj` | 修改 | 追加 `testVec1Increment`、`testVec1Decrement` |
| `src/detail/type_vec2_test.cj` | 修改 | 追加 `testVec2Increment`、`testVec2Decrement` |
| `src/detail/type_vec3_test.cj` | 修改 | 追加 `testVec3Increment`、`testVec3Decrement` |
| `src/detail/type_vec4_test.cj` | 修改 | 追加 `testVec4Increment`、`testVec4Decrement` |

## 函数定义

### `increment()`

**形态**：`mut` 成员函数（在 extend 块中定义）
**包路径**：`glm.detail`
**职责**：所有分量 +1，原地修改

```cangjie
@OverflowWrapping
public mut func increment(): Unit
```

### `decrement()`

```cangjie
@OverflowWrapping
public mut func decrement(): Unit
```

### 分量操作对照

| Vec 类型 | increment 操作 | decrement 操作 |
|----------|---------------|---------------|
| Vec1 | `this.x += Int64(1)` | `this.x -= Int64(1)` |
| Vec2 | `this.x += Int64(1); this.y += Int64(1)` | `this.x -= Int64(1); this.y -= Int64(1)` |
| Vec3 | `this.x += Int64(1); this.y += Int64(1); this.z += Int64(1)` | `this.x -= Int64(1); this.y -= Int64(1); this.z -= Int64(1)` |
| Vec4 | `this.x += Int64(1); this.y += Int64(1); this.z += Int64(1); this.w += Int64(1)` | `this.x -= Int64(1); this.y -= Int64(1); this.z -= Int64(1); this.w -= Int64(1)` |

**实现备选**：若 `Integer<T>` 不支持 `+=`/`-=` 复合赋值操作符（编译器报错），改用等价的 `this.x = this.x + Int64(1)` / `this.x = this.x - Int64(1)` 表达式赋值模式。两种写法均依赖 `Integer<T>` 约束提供的 `+`/`-` 操作符以及 `var` 字段的可赋值性。编码阶段需编译验证后择一。

### 插入位置

各文件中 `Integer<T>` extend 块的末尾闭花括号 `}` 前：

| 文件 | Integer<T> 块范围 | 插入前最后一行 |
|------|-------------------|--------------|
| `type_vec1.cj` | 第 95 行 `extend<T, Q> Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier {` ~ 第 144 行 `}` | 第 143 行 `public operator func >>(...)` |
| `type_vec2.cj` | 第 92 行 ~ 第 123 行 `}` | 第 122 行 `public operator func >>(...)` |
| `type_vec3.cj` | 第 99 行 ~ 第 130 行 `}` | 第 129 行 `public operator func >>(...)` |
| `type_vec4.cj` | 第 106 行 ~ 第 137 行 `}` | 第 136 行 `public operator func >>(...)` |

## 测试定义

### Vec1 测试

```cangjie
@Test
func testVec1Increment(): Unit {
    var v = Vec1<Int64, Defaultp>(5)
    v.increment()
    @Expect(v.x, 6)
}

@Test
func testVec1Decrement(): Unit {
    var v = Vec1<Int64, Defaultp>(5)
    v.decrement()
    @Expect(v.x, 4)
}
```

### Vec2 测试

```cangjie
@Test
func testVec2Increment(): Unit {
    var v = Vec2<Int64, Defaultp>(5, 10)
    v.increment()
    @Expect(v.x, 6)
    @Expect(v.y, 11)
}

@Test
func testVec2Decrement(): Unit {
    var v = Vec2<Int64, Defaultp>(5, 10)
    v.decrement()
    @Expect(v.x, 4)
    @Expect(v.y, 9)
}
```

### Vec3 测试

```cangjie
@Test
func testVec3Increment(): Unit {
    var v = Vec3<Int64, Defaultp>(5, 10, 15)
    v.increment()
    @Expect(v.x, 6)
    @Expect(v.y, 11)
    @Expect(v.z, 16)
}

@Test
func testVec3Decrement(): Unit {
    var v = Vec3<Int64, Defaultp>(5, 10, 15)
    v.decrement()
    @Expect(v.x, 4)
    @Expect(v.y, 9)
    @Expect(v.z, 14)
}
```

### Vec4 测试

```cangjie
@Test
func testVec4Increment(): Unit {
    var v = Vec4<Int64, Defaultp>(5, 10, 15, 20)
    v.increment()
    @Expect(v.x, 6)
    @Expect(v.y, 11)
    @Expect(v.z, 16)
    @Expect(v.w, 21)
}

@Test
func testVec4Decrement(): Unit {
    var v = Vec4<Int64, Defaultp>(5, 10, 15, 20)
    v.decrement()
    @Expect(v.x, 4)
    @Expect(v.y, 9)
    @Expect(v.z, 14)
    @Expect(v.w, 19)
}
```

测试遵循已有命名约定（`testVec1Add`, `testVec2Increment` 等模式均采用 PascalCase），每个测试函数以 `var v = VecN<Int64, Defaultp>(...)` 初始化可变 Vec，调用 `v.increment()`/`v.decrement()` 后 `@Expect` 验证各分量。

## 错误处理

- `@OverflowWrapping` 确保溢出时回绕而非抛出异常
- 无自定义错误类型

## 行为契约

- `increment()`：各分量加 1，原地修改
- `decrement()`：各分量减 1，原地修改
- 均标注 `@OverflowWrapping`，溢出行为为回绕
- 调用前需要调用者声明 `var` 变量而非 `let`

## 依赖关系

- 依赖 `Vec1`/`Vec2`/`Vec3`/`Vec4` struct 的 `public var` 字段
- 依赖 `Integer<T>` 约束提供的 `+`/`-` 操作符（通过 `extend` 块的 `where` 约束保证）
- 无外部新依赖
