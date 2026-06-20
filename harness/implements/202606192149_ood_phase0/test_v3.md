# 测试报告（v3）

## 概述

根据详细设计（detail_v3.md）的行为契约和实现报告（code_v3.md）的实际代码，对 `src/detail/` 下已有的 6 个测试文件补充了覆盖缺口。本轮新增约 85 个测试用例，覆盖之前缺失的算术/位运算变体、标量操作、广播操作、epsilon 比较、一元 + 等维度。

## 文件变更

| 文件路径 | 操作 | 原用例数 | 新增用例数 | 说明 |
|---------|------|---------|-----------|------|
| `src/detail/type_vec1_test.cj` | 修改 | 28 | 23 | 补充标量算术/位运算、命名函数、一元+、epsilon 比较、Vec1→Vec2/3/4 广播；审查修订：Vec3/Vec4 算术广播、Vec1 位广播 |/^/<<>>(Vec2)、Vec3/Vec4 位广播 |
| `src/detail/type_vec2_test.cj` | 修改 | 22 | 24 | 补充 Vec-Vec div/mod、标量算术/位运算、一元+、Bool logicalOr、epsilon 比较、移位变体；审查修订：add/sub/mul 具名函数、Vec-Vec <</>>、标量 |/^ |
| `src/detail/type_vec3_test.cj` | 修改 | 17 | 27 | 补充 Vec-Vec sub/div/mod、标量算术/位运算、一元+、Bool logicalOr、epsilon 比较、Vec1 位广播、命名函数；审查修订：标量 |/^、Vec1 位广播 |/^/<<、Vec-Vec <</>> |
| `src/detail/type_vec4_test.cj` | 修改 | 16 | 27 | 补充 Vec-Vec sub/div/mod、标量算术/位运算、一元+、Bool logicalOr、epsilon 比较、Vec1 位广播、命名函数；审查修订：删除重复 testVec4NotEqual、标量 |/^、Vec1 位广播 |/^/<<、Vec-Vec <</>> |
| `src/detail/scalar_vec_ops_test.cj` | 无变更 | 9 | 10 | 无修订需求 |
| `src/detail/type_fromBoolVec_test.cj` | 无变更 | 6 | 6 | 无修订需求 |

## 覆盖维度

### Vec1 — 约 42 个用例

| 维度 | 覆盖项 |
|------|--------|
| 构造 | const init(x: T) |
| 元数据 | length() |
| 下标访问 | operator[] 取值/赋值、componentAt、越界断言 |
| 算术(Vec-Vec) | +, -, *, /, % |
| 算术(Vec-scalar) | +(T), -(T), \*(T), /(T), %(T) |
| 一元 | +(), -() |
| 具名 | add, sub, mul, div, mod |
| 相等 | ==, !=, equalExact, equalEpsilon |
| 位运算(Vec-Vec) | &, \|, ^, <<, >> |
| 位运算(Vec-scalar) | &(T), \|(T), ^(T), <<(T), >>(T) |
| 位运算(Vec-Vec) | <<(Vec1), >>(Vec1) |
| 位运算单目 | bitwiseNot |
| Bool 逻辑 | logicalAnd, logicalOr |
| Vec1 广播算术 | +(Vec2), -(Vec2), \*(Vec2), /(Vec2), %(Vec2) 等（Vec2/3/4 各版本） |
| Vec1 广播位 | &(Vec2), \|(Vec2), ^(Vec2), <<(Vec2), >>(Vec2) 等（Vec2/3/4 各版本） |
| Hashable | @Derive[Hashable] 自动派生 |

### Vec2 — 约 38 个用例

| 维度 | 覆盖项 |
|------|--------|
| 构造 | init(scalar: T), const init(x,y), init(Vec1) |
| 元数据 | length() |
| 下标访问 | operator[] 取值/赋值、componentAt |
| 算术(Vec-Vec) | +, -, *, /, % |
| 算术(Vec-scalar) | +(T), -(T), \*(T), /(T), %(T) |
| 一元 | +(), -() |
| 具名 | add, sub, mul, div, mod |
| 相等 | ==, !=, equalExact, equalEpsilon |
| 位运算(Vec-Vec) | &, \|, ^, <<, >> |
| 位运算(Vec-scalar) | &(T), \|(T), ^(T), <<(T), >>(T) |
| 位运算(Vec-Vec1) | &(Vec1), \|(Vec1), ^(Vec1), <<(Vec1), >>(Vec1) |
| 位运算单目 | bitwiseNot |
| Bool 逻辑 | logicalAnd, logicalOr |
| Vec1 算术广播 | +(Vec1), -(Vec1), \*(Vec1), /(Vec1), %(Vec1) |
| Vec1 位广播 | &(Vec1), \|(Vec1), ^(Vec1), <<(Vec1), >>(Vec1) |
| Hashable | @Derive[Hashable] 自动派生 |

### Vec3 — 约 36 个用例

| 维度 | 覆盖项 |
|------|--------|
| 构造 | init(scalar: T), const init(x,y,z), init(Vec1) |
| 元数据 | length() |
| 下标访问 | operator[] 取值/赋值、componentAt |
| 算术(Vec-Vec) | +, -, *, /, % |
| 算术(Vec-scalar) | +(T), -(T), \*(T), /(T), %(T) |
| 一元 | +(), -() |
| 具名 | add, sub, mul, div, mod |
| 相等 | ==, !=, equalExact, equalEpsilon |
| 位运算(Vec-Vec) | &, \|, ^, <<, >> |
| 位运算(Vec-scalar) | &(T), \|(T), ^(T), <<(T), >>(T) |
| 位运算(Vec-Vec1) | &(Vec1), \|(Vec1), ^(Vec1), <<(Vec1), >>(Vec1) |
| 位运算单目 | bitwiseNot |
| Bool 逻辑 | logicalAnd, logicalOr |
| Vec1 算术广播 | +(Vec1), -(Vec1), \*(Vec1), /(Vec1), %(Vec1) |
| Hashable | @Derive[Hashable] 自动派生 |

### Vec4 — 约 36 个用例

| 维度 | 覆盖项 |
|------|--------|
| 构造 | init(scalar: T), const init(x,y,z,w), init(Vec1) |
| 元数据 | length() |
| 下标访问 | operator[] 取值/赋值、componentAt |
| 算术(Vec-Vec) | +, -, *, /, % |
| 算术(Vec-scalar) | +(T), -(T), \*(T), /(T), %(T) |
| 一元 | +(), -() |
| 具名 | add, sub, mul, div, mod |
| 相等 | ==, !=, equalExact, equalEpsilon |
| 位运算(Vec-Vec) | &, \|, ^, <<, >> |
| 位运算(Vec-scalar) | &(T), \|(T), ^(T), <<(T), >>(T) |
| 位运算(Vec-Vec1) | &(Vec1), \|(Vec1), ^(Vec1), <<(Vec1), >>(Vec1) |
| 位运算单目 | bitwiseNot |
| Bool 逻辑 | logicalAnd, logicalOr |
| Vec1 算术广播 | +(Vec1), -(Vec1), \*(Vec1), /(Vec1), %(Vec1) |
| Hashable | @Derive[Hashable] 自动派生 |

### scalar_vec_ops — 约 19 个用例

| 维度 | 覆盖项 |
|------|--------|
| add(Vec1~Vec4) | 4 方向 |
| sub(Vec1~Vec4) | 4 方向 |
| mul(Vec1~Vec4) | 4 方向 |
| div(Vec1~Vec4) | 4 方向 |
| mod(Vec1~Vec4) | 4 方向（where T <: Integer\<T\>） |

### type_fromBoolVec — 约 12 个用例

| 维度 | 覆盖项 |
|------|--------|
| fromBoolVec (Vec1~Vec4) | 4 个 Vec 版本，true→1, false→0 |
| fromBoolVecQ2 (Vec1~Vec4) | 4 个跨 Q 版本 |
| all-false 场景 | Vec3/Vec4 fromBoolVec 和 fromBoolVecQ2 |

## 设计偏差适配

| 偏差项 | 测试适配 |
|--------|---------|
| `%` 在 Number\<T\> extend 块中 | 使用 Int64 测试（Float64 实例化时 D5 编译错误） |
| 交叉类型构造仅限 Number\<T\> extend 块 | 测试仅覆盖同类型 Vec 构造（如 `Vec2(v: Vec1)` 使用同 T 参数），无跨 T 跨类型测试 |
| increment/decrement 已移除 | 无对应测试 |
| `@OverflowWrapping` 标注 | 测试不验证溢出行为本身（编译期注解） |

## 未覆盖说明

- `<`, `<=`, `>`, `>=`：首轮不定义（设计决策）
- `increment()`, `decrement()`：因语言限制已移除
- 跨类型构造（如 `Vec2<Float64, Q>(Vec1<Int64, Q>)`）：语言限制，仅 Number\<T\> 约束可用时编译
