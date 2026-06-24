# 详细设计（v13）

## 概述

在 `src/detail/geometric.cj` 末尾追加 3 个 `refract` stub 函数（Vec2/Vec3/Vec4 各一），同步创建测试文件 `tests/glm/detail/test_geometric_refract.cj`。T13 是 plan.md 最后一个待办任务，补充文档 §3.7 要求但前序遗漏的 geometric stub。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/geometric.cj | 修改 | 在文件末尾（现有 21 个 stub 函数之后）追加 3 个 `refract` stub |
| tests/glm/detail/test_geometric_refract.cj | 新建 | 每个 Vec 维度至少 1 个测试用例，验证 refract 函数签名正确性 |

## 类型定义

无新类型定义。仅追加 3 个顶层函数。

### refract 函数族

**形态**：函数（public func）
**包路径**：glm.detail
**职责**：计算入射向量 I 在法线 N 下的折射向量，当前为 stub 实现

```cangjie
public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q>
    where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }

public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q>
    where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }

public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q>
    where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
```

**实现方式**：全部为 `throw Exception("stub")`，与 existing geometric.cj 中 21 个 stub 函数完全一致。
**构造方式**：不适用（非类型）
**类型关系**：无

## 错误处理

stub 实现均抛出 `Exception("stub")`，与现有代码一致。无新增错误类型。

## 行为契约

- 所有 3 个 refract 函数体均为 `{ throw Exception("stub") }`，函数体使用 `{ }` 而非分号结尾
- 追加位置位于 `geometric.cj` 文件末尾最后一行（现有第 21 行 `reflect` Vec4 函数之后）

## 依赖关系

- 依赖 `Vec2<T,Q>` / `Vec3<T,Q>` / `Vec4<T,Q>`（定义于 `glm.detail` 包，同包直接可见）
- 依赖 `std.math.Number`（已 import）
- 依赖 `std.unittest` 框架（测试文件）

## 测试设计

新建 `tests/glm/detail/test_geometric_refract.cj`，package 声明为 `glm.detail`。

### 测试策略

- 每个 Vec 维度至少 1 个测试用例
- 使用 `@Test` 标注，`@ExpectThrows[Exception]` 断言
- 使用 `Float64` 类型和 `Defaultp` 限定符，与 `test_geometric.cj` 一致
- 测试函数仅验证函数存在且可调用（stub 状态验证签名正确性）

### 测试用例

```cangjie
@Test
func testRefractVec2Stub(): Unit {
    let I = Vec2<Float64, Defaultp>(1.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    @ExpectThrows[Exception](refract(I, N, 1.5))
}

@Test
func testRefractVec3Stub(): Unit {
    let I = Vec3<Float64, Defaultp>(1.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    @ExpectThrows[Exception](refract(I, N, 1.5))
}

@Test
func testRefractVec4Stub(): Unit {
    let I = Vec4<Float64, Defaultp>(1.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    @ExpectThrows[Exception](refract(I, N, 1.5))
}
```

### 命名约定

`testRefractVec{N}Stub`，其中 N 为 2/3/4。
