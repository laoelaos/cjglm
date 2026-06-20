# 详细设计（v11）

## 概述

在 `tests/glm/test_lib.cj` 中追加约 10 个测试函数，覆盖 Vec1/Vec3/Vec4 的重导出验证（#21）和 sub/mul/div/mod 包级函数可达性验证（#22）。所有新测试函数均通过 `package glm` 命名空间直接访问被测试类型和函数（已在 `lib.cj:2-5` 中 `public import`）。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/test_lib.cj` | 追加 | 在文件末尾（第 32 行起）追加约 10 个新测试函数 |

## 测试函数设计

所有新函数遵循已有命名约定 `testLib{Feature}`，使用 `@Test` 标注，返回 `Unit`。

### 组 1：Vec1/Vec3/Vec4 构造测试（参照 `testLibVec2Construct`）

每个 Vec 类型各 1 个函数，验证通过 `package glm` 命名空间可正确构造并访问分量。

| 函数名 | 构造调用 | 断言 |
|--------|---------|------|
| `testLibVec1Construct` | `Vec1<Float32, PackedHighp>(Float32(1.0))` | `@Expect(v.x, Float32(1.0))` |
| `testLibVec3Construct` | `Vec3<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0))` | `@Expect(v.x, Float32(1.0))` |
| `testLibVec4Construct` | `Vec4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))` | `@Expect(v.x, Float32(1.0))` |

### 组 2：Vec1/Vec3/Vec4 分量访问测试

每个 Vec 类型各 1 个函数，验证所有分量字段的访问。

| 函数名 | 构造调用 | 断言 |
|--------|---------|------|
| `testLibVec1Components` | `Vec1<Float32, PackedHighp>(Float32(1.0))` | `@Expect(v.x, Float32(1.0))` |
| `testLibVec3Components` | `Vec3<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0))` | `@Expect(v.x, Float32(1.0))` / `@Expect(v.y, Float32(2.0))` / `@Expect(v.z, Float32(3.0))` |
| `testLibVec4Components` | `Vec4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))` | `@Expect(v.x, Float32(1.0))` / `@Expect(v.y, Float32(2.0))` / `@Expect(v.z, Float32(3.0))` / `@Expect(v.w, Float32(4.0))` |

### 组 3：sub/mul/div/mod 包级函数可达性测试（参照 `testLibAddScalarVec`）

每个函数各 1 个，使用 `Int64` Vec2 验证可通过 `package glm` 命名空间调用。

| 函数名 | 函数调用 | 断言 |
|--------|---------|------|
| `testLibSubScalarVec` | `let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2)); let r = sub(Int64(10), v)` | `@Expect(r.x, Int64(9))` |
| `testLibMulScalarVec` | `let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2)); let r = mul(Int64(10), v)` | `@Expect(r.x, Int64(10))` |
| `testLibDivScalarVec` | `let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2)); let r = div(Int64(10), v)` | `@Expect(r.x, Int64(10))` |
| `testLibModScalarVec` | `let v = Vec2<Int64, PackedHighp>(Int64(3), Int64(2)); let r = mod(Int64(10), v)` | `@Expect(r.x, Int64(1))` |

**说明**：`mod` 函数对 `Integer<T>` 泛型约束使用 `%` 运算，`Int64` 满足约束。使用 `Int64(3)` 作为除数 Vec2 的 .x 分量以产生非零余数验证正确性。

## 命名约定

遵循 `test_lib.cj` 中已有模式：`testLib{Feature}` 驼峰命名，所有函数 `public` 可见性由 `package glm` 作用域决定（同文件已有函数未显式标注 `public`，包级可见即可被测试框架反射发现）。

## 错误处理

无变更。所有断言使用 `@Expect(expected, actual)` 宏。

## 行为契约

- 每个测试函数独立，无状态依赖
- 测试框架通过 `@Test` 标注反射发现所有测试函数，函数名不影响测试执行顺序或结果
- 所有新测试函数通过 `package glm` 间接访问 `glm.detail` 中的类型和函数，验证 `lib.cj` 中 `public import` 的正确性

## 依赖关系

- 依赖 `tests/glm/test_lib.cj`（已有文件，追加内容）
- 依赖 `src/lib.cj` 中定义的 `public import` 导出（所有 Vec 类型 + 标量-向量操作函数已导出）
- 依赖 `src/detail/scalar_vec_ops.cj` 中的 `sub`/`mul`/`div`/`mod` 函数签名
- 无新增外部依赖

## 修订说明（v11 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 组 3 全部 4 个函数中 `v` 在赋值前被引用，且赋值缺少 `let` 关键字，将导致编译失败 | 调整声明顺序：将 `let v = Vec2<Int64, PackedHighp>(...)` 移至 `let r = func(...)` 之前，并为 `v` 补上 `let` 关键字 |
