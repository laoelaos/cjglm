# 详细设计（v9）

## 概述

在 `src/detail/scalar_vec_ops.cj` 中追加 12 个浮点具体类型的 `mod` 函数重载（Float32/Float64/Float16 × Vec1/Vec2/Vec3/Vec4），使用 `std.math.fmod` 实现浮点取模。同步追加对应测试用例。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/scalar_vec_ops.cj` | 修改 | 追加 12 个浮点类型 `mod` 重载函数；将 `import std.math.{ Number, Integer }` 扩展为 `import std.math.{ Number, Integer, fmod }` |
| `src/detail/scalar_vec_ops_test.cj` | 修改 | 追加 12 个正向测试函数（每浮点类型×Vec 维度各 1 个） |
| `tests/glm/detail/test_scalar_vec_ops.cj` | 修改 | 追加 12 个正向测试 + 边界测试（除零、负操作数、Inf 被除数） |

## 函数定义

### 新增 import

`src/detail/scalar_vec_ops.cj` 第 3 行：

```cangjie
import std.math.{ Number, Integer, fmod }
```

### 新增函数（12 个，接在整数 mod 重载之后）

所有新增函数**不标注** `@OverflowWrapping`（浮点类型溢出表现为 Inf/NaN，不适用回绕语义）。函数体直接使用 `std.math.fmod` 进行逐分量浮点取模。

#### Float32 组（4 个）

```cangjie
public func mod(s: Float32, v: Vec1<Float32, Q>): Vec1<Float32, Q> where Q <: Qualifier {
    return Vec1(std.math.fmod(s, v.x))
}

public func mod(s: Float32, v: Vec2<Float32, Q>): Vec2<Float32, Q> where Q <: Qualifier {
    return Vec2(std.math.fmod(s, v.x), std.math.fmod(s, v.y))
}

public func mod(s: Float32, v: Vec3<Float32, Q>): Vec3<Float32, Q> where Q <: Qualifier {
    return Vec3(std.math.fmod(s, v.x), std.math.fmod(s, v.y), std.math.fmod(s, v.z))
}

public func mod(s: Float32, v: Vec4<Float32, Q>): Vec4<Float32, Q> where Q <: Qualifier {
    return Vec4(std.math.fmod(s, v.x), std.math.fmod(s, v.y), std.math.fmod(s, v.z), std.math.fmod(s, v.w))
}
```

#### Float64 组（4 个）

```cangjie
public func mod(s: Float64, v: Vec1<Float64, Q>): Vec1<Float64, Q> where Q <: Qualifier {
    return Vec1(std.math.fmod(s, v.x))
}

public func mod(s: Float64, v: Vec2<Float64, Q>): Vec2<Float64, Q> where Q <: Qualifier {
    return Vec2(std.math.fmod(s, v.x), std.math.fmod(s, v.y))
}

public func mod(s: Float64, v: Vec3<Float64, Q>): Vec3<Float64, Q> where Q <: Qualifier {
    return Vec3(std.math.fmod(s, v.x), std.math.fmod(s, v.y), std.math.fmod(s, v.z))
}

public func mod(s: Float64, v: Vec4<Float64, Q>): Vec4<Float64, Q> where Q <: Qualifier {
    return Vec4(std.math.fmod(s, v.x), std.math.fmod(s, v.y), std.math.fmod(s, v.z), std.math.fmod(s, v.w))
}
```

#### Float16 组（4 个）

```cangjie
public func mod(s: Float16, v: Vec1<Float16, Q>): Vec1<Float16, Q> where Q <: Qualifier {
    return Vec1(std.math.fmod(s, v.x))
}

public func mod(s: Float16, v: Vec2<Float16, Q>): Vec2<Float16, Q> where Q <: Qualifier {
    return Vec2(std.math.fmod(s, v.x), std.math.fmod(s, v.y))
}

public func mod(s: Float16, v: Vec3<Float16, Q>): Vec3<Float16, Q> where Q <: Qualifier {
    return Vec3(std.math.fmod(s, v.x), std.math.fmod(s, v.y), std.math.fmod(s, v.z))
}

public func mod(s: Float16, v: Vec4<Float16, Q>): Vec4<Float16, Q> where Q <: Qualifier {
    return Vec4(std.math.fmod(s, v.x), std.math.fmod(s, v.y), std.math.fmod(s, v.z), std.math.fmod(s, v.w))
}
```

### 插入位置

所有 12 个新增函数接在现有整数 `mod` 重载块之后（`scalar_vec_ops.cj` 第 103 行 `}` 后，即文件末尾）。

### 重载解析说明

- 编译器根据 `s` 和 `v` 的具体类型选择重载：`Float32` 参数匹配 Float32 组，`Float64` 匹配 Float64 组，`Float16` 匹配 Float16 组
- 现有整数 `mod` 使用 `where T <: Integer<T>` 约束，新增浮点重载使用具体类型（无 `Integer<T>` 约束），因 `Float32`/`Float64`/`Float16` 不满足 `Integer<T>` 约束，两组重载无歧义

## 测试定义

### `src/detail/scalar_vec_ops_test.cj` — 正向测试（12 个）

遵循现有测试命名模式 `testScalarModVec{N}{FloatType}`。

```cangjie
// Float32 正向测试
@Test
func testScalarModVec1Float32(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(2.5))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
}

@Test
func testScalarModVec2Float32(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(2.5), Float32(3.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
}

@Test
func testScalarModVec3Float32(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
    @Expect(r.z, Float32(3.5))
}

@Test
func testScalarModVec4Float32(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0), Float32(5.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
    @Expect(r.z, Float32(3.5))
    @Expect(r.w, Float32(2.5))
}

// Float64 正向测试
@Test
func testScalarModVec1Float64(): Unit {
    let v = Vec1<Float64, Defaultp>(Float64(2.5))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testScalarModVec2Float64(): Unit {
    let v = Vec2<Float64, Defaultp>(Float64(2.5), Float64(3.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
}

@Test
func testScalarModVec3Float64(): Unit {
    let v = Vec3<Float64, Defaultp>(Float64(2.5), Float64(3.0), Float64(4.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
    @Expect(r.z, Float64(3.5))
}

@Test
func testScalarModVec4Float64(): Unit {
    let v = Vec4<Float64, Defaultp>(Float64(2.5), Float64(3.0), Float64(4.0), Float64(5.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
    @Expect(r.z, Float64(3.5))
    @Expect(r.w, Float64(2.5))
}

// Float16 正向测试
@Test
func testScalarModVec1Float16(): Unit {
    let v = Vec1<Float16, Defaultp>(Float16(2.5))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
}

@Test
func testScalarModVec2Float16(): Unit {
    let v = Vec2<Float16, Defaultp>(Float16(2.5), Float16(3.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
}

@Test
func testScalarModVec3Float16(): Unit {
    let v = Vec3<Float16, Defaultp>(Float16(2.5), Float16(3.0), Float16(4.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
    @Expect(r.z, Float16(3.5))
}

@Test
func testScalarModVec4Float16(): Unit {
    let v = Vec4<Float16, Defaultp>(Float16(2.5), Float16(3.0), Float16(4.0), Float16(5.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
    @Expect(r.z, Float16(3.5))
    @Expect(r.w, Float16(2.5))
}
```

### `tests/glm/detail/test_scalar_vec_ops.cj` — 正向测试 + 边界测试

**正向测试（12 个）**：与 `src/detail/scalar_vec_ops_test.cj` 中的正向测试函数体相同。

**边界测试（6 个）**：

```cangjie
@Test
func testScalarModVec1Float32ByZero(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float32(1.0), Vec1<Float32, Defaultp>(Float32(0.0))))
}

@Test
func testScalarModVec1Float32Negative(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(2.5))
    let r = mod(Float32(-7.5), v)
    @Expect(r.x, Float32(-0.0))  // fmod 保留被除数符号
}

@Test
func testScalarModVec1Float32InfDividend(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float32.Inf, Vec1<Float32, Defaultp>(Float32(1.0))))
}

@Test
func testScalarModVec1Float64ByZero(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float64(1.0), Vec1<Float64, Defaultp>(Float64(0.0))))
}

@Test
func testScalarModVec1Float16ByZero(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float16(1.0), Vec1<Float16, Defaultp>(Float16(0.0))))
}

@Test
func testScalarModVec1Float16InfDividend(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float16.Inf, Vec1<Float16, Defaultp>(Float16(1.0))))
}
```

## 偏差文档更新

### 分析

新增浮点 `mod` 函数后，`docs/deviations.md` 中 DV-02（`%` 仅对整数类型可用）的描述需更新：

| 项目 | 当前 DV-02 表述 | 修正后状态 |
|------|----------------|-----------|
| `%` 运算符仅 `Integer<T>` | 仍准确 | 不变 |
| `mod` 具名函数仅 `Integer<T>` | **不再准确**——`mod(s, v)` 标量-向量函数已追加 float 重载 | 需更新 |
| "浮点类型使用 `%` 会触发编译错误" | `%` 运算符仍仅整数可用；但 `mod(s, v)` 函数对浮点类型已可用 | 需澄清 |
| 迁移建议（手写 fmod） | `mod(s, v)` 已可直接使用，不再需要手写 | 建议更新 |

### 操作

在 `docs/deviations.md` 的「五、未验证的偏差删除」中追加一条记录，说明 DV-02 中关于 `mod` 函数可用性的描述需修订：

```
### DEV-05: DV-02 中 `mod` 函数可用性描述不再准确

**拟添加原因**

新增 12 个浮点具体类型 `mod(s, v)` 重载后，DV-02 中`mod 具名函数仅在 Integer<T> 约束的 extend 块中提供` 的描述不再完全准确。标量-向量函数 `mod(s, v)` 现已支持 Float32/Float64/Float16。但 `%` 运算符和 Vec 成员函数 `mod(s: T)` 仍仅整数可用。

| 项目 | 内容 |
|------|------|
| **建议分类** | 二、接口/行为有偏差（修订现有 DV-02） |
| **涉及文件** | `docs/deviations.md` DV-02、`src/detail/scalar_vec_ops.cj` |
| **关联偏差** | DV-02 |
| **表现** | DV-02 中`mod 具名函数`的描述需补充 float 重载存在的说明 |
| **影响** | 用户迁移建议可简化——不再需要手写 fmod，直接调用 `mod(s, v)` 即可 |
| **证据** | `src/detail/scalar_vec_ops.cj` 中 12 个浮点 `mod` 重载。fmod 语义与手工公式等价 |
| **验证次数** | 0 |
```

## 错误处理

- 新增浮点 `mod` 函数依赖 `std.math.fmod` 的标准库异常行为：除零（除数 y=0）抛出 `IllegalArgumentException`，被除数为 Inf 抛出 `IllegalArgumentException`
- 不使用 `@OverflowWrapping`（浮点溢出行为为 Inf/NaN）

## 行为契约

- 对每个分量 `v_i`，执行 `result_i = std.math.fmod(s, v_i)`
- `fmod` 语义：返回 `s - n * v_i`，其中 `n` 为 `s / v_i` 截断到零方向的整数部分
- 结果符号与被除数 `s` 相同
- 输入 `v_i = 0` 时抛出 `IllegalArgumentException`
- 输入 `s = Inf` 时抛出 `IllegalArgumentException`

## 依赖关系

- 新增依赖 `std.math.fmod`（重载自由函数，提供 Float32/Float64/Float16 三组具体类型重载）
- 依赖 Vec1/Vec2/Vec3/Vec4 struct 的构造函数
- 依赖 Qualifier 接口
- 无其他新依赖

## 与现有重载的关系

- 现有整数 `mod`：`mod<T, Q>(s: T, v: VecN<T, Q>) where T <: Integer<T>, Q <: Qualifier`（4 个重载，标注 `@OverflowWrapping`）
- 新增浮点 `mod`：具体类型重载，不标注 `@OverflowWrapping`，使用 `std.math.fmod` 而非 `%` 运算符
- 两组的类型约束互斥（`Integer<T>` vs 具体浮点类型），编译器重载解析无歧义

## 修订说明（v9 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 未处理任务要求的偏差文档更新——设计未分析 `deviations.md` DV-02 是否需要更新 | 新增「偏差文档更新」章节，分析 DV-02 的准确性问题，并给出具体操作：在「五、未验证的偏差删除」追加 DEV-05 记录，说明 `mod` 函数可用性描述需修订 |
| 边界测试仅覆盖 Float32/Float64，未包含 Float16 | 追加 `testScalarModVec1Float16ByZero` 和 `testScalarModVec1Float16InfDividend` 两个 Float16 边界测试，与 Float32/Float64 行为保持一致（fmod 对 Float16 同样在 y=0 和 x=Inf 时抛出 `IllegalArgumentException`） |
