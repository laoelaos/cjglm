# 任务指令（v9）

## 动作
NEW

## 任务描述
在 `src/detail/scalar_vec_ops.cj` 中追加 Float32/Float64/Float16 具体类型的 `mod` 函数重载（Vec1/Vec2/Vec3/Vec4 × 3 浮点类型 = 12 个函数），使用 `std.math.fmod` 实现浮点取模。同步追加对应测试用例。

### 代码变更清单

| 文件 | 操作 | 说明 |
|------|------|------|
| `src/detail/scalar_vec_ops.cj` | 追加 12 个函数 | Float32/Float64/Float16 各 4 个 Vec 重载，使用 `std.math.fmod` |
| `src/detail/scalar_vec_ops_test.cj` | 追加测试 | 对每种浮点类型×Vec维度追加 1 个正向测试 |
| `tests/glm/detail/test_scalar_vec_ops.cj` | 追加测试 | 同 src 测试，额外加边界测试 |

### 函数签名与实现

```cangjie
// Float32 示例（Vec1~Vec4 同理）
public func mod(s: Float32, v: Vec1<Float32, Q>): Vec1<Float32, Q> where Q <: Qualifier {
    return Vec1(std.math.fmod(s, v.x))
}

// Float64 示例
public func mod(s: Float64, v: Vec1<Float64, Q>): Vec1<Float64, Q> where Q <: Qualifier {
    return Vec1(std.math.fmod(s, v.x))
}

// Float16 示例
public func mod(s: Float16, v: Vec1<Float16, Q>): Vec1<Float16, Q> where Q <: Qualifier {
    return Vec1(std.math.fmod(s, v.x))
}
```

完整列表（12 个函数）：

| # | 函数签名 |
|---|---------|
| 1 | `mod(s: Float32, v: Vec1<Float32, Q>) -> Vec1<Float32, Q>` |
| 2 | `mod(s: Float32, v: Vec2<Float32, Q>) -> Vec2<Float32, Q>` |
| 3 | `mod(s: Float32, v: Vec3<Float32, Q>) -> Vec3<Float32, Q>` |
| 4 | `mod(s: Float32, v: Vec4<Float32, Q>) -> Vec4<Float32, Q>` |
| 5 | `mod(s: Float64, v: Vec1<Float64, Q>) -> Vec1<Float64, Q>` |
| 6 | `mod(s: Float64, v: Vec2<Float64, Q>) -> Vec2<Float64, Q>` |
| 7 | `mod(s: Float64, v: Vec3<Float64, Q>) -> Vec3<Float64, Q>` |
| 8 | `mod(s: Float64, v: Vec4<Float64, Q>) -> Vec4<Float64, Q>` |
| 9 | `mod(s: Float16, v: Vec1<Float16, Q>) -> Vec1<Float16, Q>` |
| 10 | `mod(s: Float16, v: Vec2<Float16, Q>) -> Vec2<Float16, Q>` |
| 11 | `mod(s: Float16, v: Vec3<Float16, Q>) -> Vec3<Float16, Q>` |
| 12 | `mod(s: Float16, v: Vec4<Float16, Q>) -> Vec4<Float16, Q>` |

> 每个函数体：`return VecN(std.math.fmod(s, v.x), std.math.fmod(s, v.y), ...)`

注意：需要扩展 `scalar_vec_ops.cj` 顶部的 `import std.math.{ Number, Integer }` 为 `import std.math.{ Number, Integer, fmod }` 以引入 `fmod`。

### 测试要求

每个浮点类型 × Vec 维度组合至少 1 个正向测试。建议测试函数命名模式：

| 测试函数 | 场景 | 验证点 |
|---------|------|--------|
| `testScalarModVec1Float32` | `mod(Float32(7.5), Vec1<Float32,Defaultp>(2.5))` | `@Expect(r.x, Float32(0.0))` |
| `testScalarModVec2Float32` | `mod(Float32(7.5), Vec2<Float32,Defaultp>(2.5, 3.0))` | `@Expect(r.x, 0.0); @Expect(r.y, 1.5)` |
| `testScalarModVec3Float32` | ... | ... |
| `testScalarModVec4Float32` | ... | ... |
| (Float64 同理) | ... | ... |
| (Float16 同理) | ... | ... |

共约 12 个正向测试函数。

**边界测试（推荐在 `tests/glm/detail/test_scalar_vec_ops.cj` 中追加）：**
- `testScalarModVec1Float32ByZero`：`mod(Float32(1.0), Vec1<Float32,Defaultp>(0.0))` — 验证 fmod(y=0) 抛出 `IllegalArgumentException`：`@ExpectThrows[IllegalArgumentException](mod(Float32(1.0), Vec1<Float32,Defaultp>(0.0)))`
- `testScalarModVec1Float32Negative`：`mod(Float32(-7.5), Vec1<Float32,Defaultp>(2.5))` — 负操作数取模，fmod 处理负数与 C++ GLM 一致，可保留正向测试
- `testScalarModVec1Float32InfDividend`：`mod(Float32.Inf, Vec1<Float32,Defaultp>(1.0))` — 验证 fmod(x=Inf) 抛出 `IllegalArgumentException`：`@ExpectThrows[IllegalArgumentException](...)`
- `testScalarModVec1Float64ByZero`：同上 Float64，`@ExpectThrows[IllegalArgumentException]`

### 现有整数 mod 函数（保持不变）

```cangjie
@OverflowWrapping
public func mod<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier { ... }
// ... 其他 Vec 的整数 mod 不变
```

新增浮点重载与现有整数重载无歧义 —— `Float32`/`Float64`/`Float16` 不满足 `Integer<T>` 约束。

## 选择理由
#7 是所有剩余项中唯一的"代码缺失未修复"功能性缺陷。当前浮点 Vec 无法调用 `mod(s, v)`（编译错误："类型不满足 `Integer<T>` 约束"）。其他剩余项（测试改进、文档/风格）均为非功能性问题。优先修复 #7 以补全库的浮点取模功能。

## 任务上下文

### OOD 原设计（§4.3）
OOD §4.3 要求 `mod` 通过编译期 `if (isIec559Of<T>())` 分支实现整数/浮点双路径。因 CL-04（`Number<T>` 无 `%` 运算符）导致编码阶段仅实现整数路径 `where T <: Integer<T>`。OOD 设计的浮点路径使用 `x - y * trunc(x / y)` 算术恒等式。本任务采用替代方案 `std.math.fmod`（标准库原生浮点取模，语义明确）。

### 当前代码位置
`src/detail/scalar_vec_ops.cj:85-103` — 4 个整数 mod 重载。

### 干扰分析
- `scalar_vec_ops.cj` 中已有 `import std.math.{ Number, Integer }`，需追加 `fmod`
- 新增浮点重载函数体使用 `std.math.fmod(s, v.x)` — `fmod` 是重载自由函数，有 Float32/Float64/Float16 三组具体类型重载
- 编译器选择规则：`Float32` 路径匹配 `fmod(Float32, Float32)`，`Float64` 匹配 `fmod(Float64, Float64)` 等，无歧义

### 偏差记录要求
如果新增浮点 mod 函数后需要更新 `docs/deviations.md` 中的 DV-02（`%` 仅对整数类型可用），应将此偏差更新记录到 `docs/deviations.md` 的「五、未验证的偏差删除」章节（因浮点 mod 实施后 DV-02 中的"浮点类型使用 `%` 会触发编译错误"描述将不再准确——`mod(s, v)` 函数本身已可用，只是 `%` 运算符仍仅整数可用）。

## 修订说明（v9 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 边界测试 `testScalarModVec1Float32ByZero` 假设 fmod(y=0) 返回 NaN/Inf，但 std.math.fmod 实际抛出 IllegalArgumentException | 修正为 `@ExpectThrows[IllegalArgumentException]` |
| 未考虑 fmod(x=Inf) 也抛异常 | 新增 `testScalarModVec1Float32InfDividend` 边界测试，`@ExpectThrows[IllegalArgumentException]` |
| `testScalarModVec1Float32Negative`（负操作数）不受影响，fmod 与 C++ GLM 一致 | 保留原描述，明确标注可保留
