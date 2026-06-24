# 详细设计（v8）

## 概述

在已有文件 `tests/glm/detail/test_type_mat_compare.cj` 末尾追加矩阵类型 Hashable 运行时测试，验证 `@Derive[Hashable]` 在矩阵结构体上正确展开。选取 Mat4x4（4 列 Vec4 成员）和 Mat2x3（2 列 Vec3 成员）两个代表性类型，覆盖相同性一致性和不同值差异性两类场景，每类以 Int64 和 Float32 两种元素类型实例化。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/test_type_mat_compare.cj` | 追加（文件末尾） | 追加 8 个 `@Test` 标注的 hash 测试函数 |

## 测试函数设计

所有测试函数放在文件末尾已有 `package glm.detail` 作用域内，分割已有的 Bool 矩阵测试与新增 hash 测试之间添加空行。

### Mat4x4 系列（4 个函数）

#### testHashMat4x4Int64SameValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat4x4Int64SameValue(): Unit`
**场景**：相同性一致性 + Int64
**构造**：
- `let a = Mat4x4<Int64, Defaultp>(Int64(1))`
- `let b = Mat4x4<Int64, Defaultp>(Int64(1))`
**断言**：`@Expect(a.hashCode() == b.hashCode(), true)`

#### testHashMat4x4Int64DiffValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat4x4Int64DiffValue(): Unit`
**场景**：不同值差异性 + Int64
**构造**：
- `let a = Mat4x4<Int64, Defaultp>(Int64(1))`
- `let b = Mat4x4<Int64, Defaultp>(Int64(2))`
**断言**：`@Expect(a.hashCode() != b.hashCode(), true)`

#### testHashMat4x4Float32SameValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat4x4Float32SameValue(): Unit`
**场景**：相同性一致性 + Float32
**构造**：
- `let a = Mat4x4<Float32, Defaultp>(Float32(1.0))`
- `let b = Mat4x4<Float32, Defaultp>(Float32(1.0))`
**断言**：`@Expect(a.hashCode() == b.hashCode(), true)`

#### testHashMat4x4Float32DiffValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat4x4Float32DiffValue(): Unit`
**场景**：不同值差异性 + Float32
**构造**：
- `let a = Mat4x4<Float32, Defaultp>(Float32(1.0))`
- `let b = Mat4x4<Float32, Defaultp>(Float32(2.0))`
**断言**：`@Expect(a.hashCode() != b.hashCode(), true)`

### Mat2x3 系列（4 个函数）

#### testHashMat2x3Int64SameValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat2x3Int64SameValue(): Unit`
**场景**：相同性一致性 + Int64
**构造**：
- `let a = Mat2x3<Int64, Defaultp>(Int64(1))`
- `let b = Mat2x3<Int64, Defaultp>(Int64(1))`
**断言**：`@Expect(a.hashCode() == b.hashCode(), true)`

#### testHashMat2x3Int64DiffValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat2x3Int64DiffValue(): Unit`
**场景**：不同值差异性 + Int64
**构造**：
- `let a = Mat2x3<Int64, Defaultp>(Int64(1))`
- `let b = Mat2x3<Int64, Defaultp>(Int64(2))`
**断言**：`@Expect(a.hashCode() != b.hashCode(), true)`

#### testHashMat2x3Float32SameValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat2x3Float32SameValue(): Unit`
**场景**：相同性一致性 + Float32
**构造**：
- `let a = Mat2x3<Float32, Defaultp>(Float32(1.0))`
- `let b = Mat2x3<Float32, Defaultp>(Float32(1.0))`
**断言**：`@Expect(a.hashCode() == b.hashCode(), true)`

#### testHashMat2x3Float32DiffValue
**形态**：`@Test` 函数
**包路径**：`glm.detail`
**签名**：`func testHashMat2x3Float32DiffValue(): Unit`
**场景**：不同值差异性 + Float32
**构造**：
- `let a = Mat2x3<Float32, Defaultp>(Float32(1.0))`
- `let b = Mat2x3<Float32, Defaultp>(Float32(2.0))`
**断言**：`@Expect(a.hashCode() != b.hashCode(), true)`

## 行为契约

1. 所有测试函数追加在 `test_type_mat_compare.cj` 文件末尾，不修改已有代码。
2. 每个测试函数之间以空行分隔，Hashable 测试组的首个函数前以注释 `// Hashable tests` 标识分组。
3. 使用 `init(scalar: T)` 构造函数保证矩阵所有分量相同，减少构造复杂度且避免测试数据选择争议。
4. 相同值测试使用完全相同的标量值构造两个矩阵；不同值测试使用不同的标量值。
5. 对于 Float32 类型，`Float32(1.0)` 和 `Float32(2.0)` 属于不同的可表示浮点值，其按位表示必然不同，`@Derive` 生成的 `hashCode()` 应对不同的浮点位模式产生不同哈希值——此断言成立的前提是 `@Derive[Hashable]` 正确包含了所有字段的哈希计算。若断言失败，则 `@Derive[Hashable]` 的宏展开存在缺陷。
6. 不测试 Bool 矩阵的 Hashable（Bool 已实现 Hashable，派生无风险，按诊断要求跳过）。
7. 不验证哈希冲突概率或分布质量。

## 依赖关系

- 依赖 `glm.detail` 包中 `Mat4x4`、`Mat2x3`、`Defaultp` 类型
- 依赖 `std.unittest` 的 `@Test` 注解和 `@Expect` 宏
- 依赖 `@Derive[Hashable]` 在矩阵 struct 上正确展开生成 `hashCode(): Int64` 方法
- 跨类型编译通过（Int64 + Float32）已隐含在两组实例化中，无需独立验证
