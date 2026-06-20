# 详细设计（v13）

## 概述

在 `src/detail/scalar_vec_ops_test.cj` 末尾追加 8 个跨 Qualifier 测试函数，验证 `sub`/`mul`/`div`/`mod` 四个操作在 `PackedMediump` 和 `PackedLowp` Qualifier 上的泛型兼容性（使用 Vec2 Int64）。对应 01_diag.md #30。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/scalar_vec_ops_test.cj` | 追加 | 在第 276 行（文件末尾）后追加 8 个新测试函数 |

## 类型定义

本设计不引入新类型。所有测试函数为包级函数，使用已有的泛型函数 `sub<T, Q>` / `mul<T, Q>` / `div<T, Q>` / `mod<T, Q>`（定义见 `src/detail/scalar_vec_ops.cj`），类型参数 `T = Int64`，`Q = PackedMediump` / `PackedLowp`。

Qualifier 类型（定义见 `src/detail/qualifier.cj`）：
- `PackedMediump <: Qualifier` — 空结构体，行为与 `Defaultp` 等价
- `PackedLowp <: Qualifier` — 空结构体，行为与 `Defaultp` 等价

## 测试函数设计

所有新函数遵循文件内已有模式：`@Test` 标注，返回 `Unit`，使用 `@Expect(expected, actual)` 断言。

### 追加函数清单

参照 `testScalarAddVec2`（`~14` 行）模式，将 Vec2 的 Qualifier 从 `Defaultp` 替换为 `PackedMediump` / `PackedLowp`：

| 函数名 | 构造 Vec2 | 操作调用 | 期望 (x, y) |
|--------|----------|---------|------------|
| `testScalarSubVec2PackedMediump` | `Vec2<Int64, PackedMediump>(10, 20)` | `sub(Int64(3), v)` | `(-7, -17)` |
| `testScalarSubVec2PackedLowp` | `Vec2<Int64, PackedLowp>(10, 20)` | `sub(Int64(3), v)` | `(-7, -17)` |
| `testScalarMulVec2PackedMediump` | `Vec2<Int64, PackedMediump>(2, 3)` | `mul(Int64(5), v)` | `(10, 15)` |
| `testScalarMulVec2PackedLowp` | `Vec2<Int64, PackedLowp>(2, 3)` | `mul(Int64(5), v)` | `(10, 15)` |
| `testScalarDivVec2PackedMediump` | `Vec2<Int64, PackedMediump>(10, 15)` | `div(Int64(30), v)` | `(3, 2)` |
| `testScalarDivVec2PackedLowp` | `Vec2<Int64, PackedLowp>(10, 15)` | `div(Int64(30), v)` | `(3, 2)` |
| `testScalarModVec2PackedMediump` | `Vec2<Int64, PackedMediump>(10, 15)` | `mod(Int64(33), v)` | `(3, 3)` |
| `testScalarModVec2PackedLowp` | `Vec2<Int64, PackedLowp>(10, 15)` | `mod(Int64(33), v)` | `(3, 3)` |

### 函数签名模板

```cangjie
@Test
func testScalar{Op}Vec2Packed{Qual}(): Unit {
    let v = Vec2<Int64, Packed{Qual}>({a}, {b})
    let r = {op}(Int64({s}), v)
    @Expect(r.x, {ex})
    @Expect(r.y, {ey})
}
```

具体参数对照已有 `testScalarSubVec2`、`testScalarMulVec2`、`testScalarDivVec2`、`testScalarModVec2` 的数值（`~68-155` 行）。

## 命名约定

遵循 `scalar_vec_ops_test.cj` 中已有模式：`testScalar{Op}Vec2Packed{Qual}`，其中 `{Op}` 为 PascalCase 操作名（Sub/Mul/Div/Mod），`{Qual}` 为 Qualifier 名（Mediump/Lowp）。

## 错误处理

无变更。所有断言使用 `@Expect(expected, actual)` 宏。

## 行为契约

- 每个测试函数独立，无状态依赖
- `PackedMediump` 和 `PackedLowp` 为空结构体，行为与 `Defaultp` 完全等价，预期值与对应 Defaultp 版本相同
- 所有函数使用 `@Test` 标注，测试框架通过反射发现

## 依赖关系

- 依赖 `src/detail/scalar_vec_ops_test.cj`（已有文件，末尾追加）
- 依赖 `src/detail/scalar_vec_ops.cj` 中 `sub`/`mul`/`div`/`mod` 泛型函数（`Q <: Qualifier`）
- 依赖 `src/detail/qualifier.cj` 中 `PackedMediump` / `PackedLowp` 类型定义
- 依赖 `src/detail/type_vec2.cj` 中 `Vec2<T, Q>` 类型
- 隐式依赖 `std.core` 中的 `Int64` 类型
- 无新增外部依赖
