# 实现报告（v3）

## 概述

实现了 `src/detail/type_mat2x2.cj`——Mat2x2<T,Q> 结构体（2列×2行，列向量 Vec2<T,Q>）及完整 extend 块接口：算术运算符（含3个乘法重载、Mat×Vec2）、工厂函数（diagonal/identity）、跨类型构造（fromParts/fromColumns/fromMat 7）、fromMat 6a/6b（各8个重载，共16个）。同步实现 `tests/glm/detail/test_type_mat2x2.cj`。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | src/detail/type_mat2x2.cj | Mat2x2<T,Q> 完整定义（结构体 + 4 个 extend 块） |
| 新建 | tests/glm/detail/test_type_mat2x2.cj | 覆盖全部构造/运算符/工厂/fromMat 系列/越界（43 个测试用例） |

## 编译验证

`cjpm build` 通过。仅产生因设计规格保留未使用参数（`one`/`zero`/`rhs`）导致的预期 warning，以及项目中其他文件的既有 warning。

## 设计偏差说明

### 1. fromMat 6a 的 extend 声明调整

**设计规格**：`extend<T, Q, SrcQ> Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier`
**偏差原因**：仓颉编译器要求 `extend` 块的所有类型参数必须出现在被扩展类型中（`Mat2x2<T,Q>` 不含 `SrcQ`）。
**实际处理**：将 `SrcQ` 移到各 `fromMat` 方法的 `<SrcQ>` 级别。

### 2. fromMat 6b 的 extend 声明调整

**设计规格**：`extend<T, Q, P> Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier, P <: Qualifier`
**偏差原因**：同 1，`P` 未出现在 `Mat2x2<T,Q>` 中。
**实际处理**：将 `P` 合并到各方法的 `<U, P>` 级别。

### 3. 显式泛型参数标注

**设计规格**：使用裸 `Vec2(...)`、`Mat3x2(...)`、`Mat4x2(...)` 构造。
**偏差原因**：仓颉编译器无法推断 `Vec2` 的 qualifier 参数 `Q`，自动退化为 `Interface-Qualifier` 导致类型不匹配。
**实际处理**：所有 `Vec2` 构造改为 `Vec2<T,Q>(...)`，`Mat3x2` 改为 `Mat3x2<T,Q>(...)`，`Mat4x2` 改为 `Mat4x2<T,Q>(...)`。

### 4. fromMat 6a colShrink 直接列传递改为元素提取

**设计规格**（Mat3x2 和 Mat4x2 源）：`Mat2x2(m.c0, m.c1)` — 直接传递 Vec2<T,SrcQ> 列向量。
**偏差原因**：`m.c0` 类型为 `Vec2<T,SrcQ>` 而构造函数要求 `Vec2<T,Q>`，两者 qualifier 不同（`SrcQ ≠ Q`），类型不匹配。
**实际处理**：改为 `Mat2x2(Vec2<T,Q>(m.c0.x, m.c0.y), Vec2<T,Q>(m.c1.x, m.c1.y))` 逐分量提取，语义等价（colShrink 2→2 无行收缩，元素提取与直接传递结果相同）。

### 5. 矩阵除法 `m / rhs` 实现方式

**设计规格**：`this * inverse(rhs)`，其中 `inverse` 是 `matrix.cj` 中的 stub 函数。
**偏差原因**：`matrix.cj` 和 `inverse` 函数尚未实现。
**实际处理**：直接 `throw Exception("stub")`，保持语义一致（运行时抛出 stub 异常）。

### 6. 未使用参数保留

设计规格中 `fromMat 6a/6b` 的 `one` 参数、`zero` 变量以及除法算子的 `rhs` 参数在函数体中未使用，但为保持 API 统一性及设计一致性予以保留，编译器产生预期 warning。
