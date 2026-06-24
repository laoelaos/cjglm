# 详细设计（v10）

## 概述

T10 — 编写矩阵集成测试 `tests/glm/test_integration_matrix.cj`，通过 `glm` 包的 public API（fwd.cj 别名 + lib.cj re-export）验证全部 9 种矩阵类型（Mat2x2~Mat4x4）的跨类型组合操作一致性。

遵循现有测试模式：`package glm`、`@Test` 独立函数、`@Expect` 断言。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/test_integration_matrix.cj` | 新建 | 矩阵集成测试，~40 用例，覆盖 7 个维度 |

## 测试函数规划（40 tests）

### 1. 矩阵构造（通过 fwd 别名）— 6 tests

使用 `package glm` 下的类型别名（`Mat2x2` ~ `Mat4x4`、`DMat2x2` ~ `DMat4x4`、短别名 `mat2`/`mat3`/`mat4`/`dmat2`/`dmat4`）构造并读取列成员。

| 测试函数 | 覆盖 | 断言 |
|---------|------|------|
| `testIntegrationAll9FloatMatAliasConstruct` | 全部 9 种 Mat 类型别名构造 | 每个类型 c0.x c_{C-1}.{last comp} |
| `testIntegrationAll9DMatAliasConstruct` | 全部 9 种 DMat 类型别名构造 | 同上，Float64 |
| `testIntegrationShortAliasMat2` | mat2/mat3/mat4 构造 | c0.x, c1.y |
| `testIntegrationShortAliasDMat` | dmat2/dmat3/dmat4 构造 | c0.x, c1.y |
| `testIntegrationFwdAliasGenericCompatible` | 别名→泛型赋值兼容 | 类型兼容 |
| `testIntegrationMatAliasIdentity` | 别名类型调用 identity() | 单位矩阵 |

### 2. 算术运算（通过 fwd 别名）— 12 tests

每种方阵类型至少一个运算测试，其余跨尺寸类型随机选择覆盖。

| 测试函数 | 覆盖 | 断言 |
|---------|------|------|
| `testIntegrationMat2x2AddSub` | Mat2x2 + - | 结果正确 |
| `testIntegrationMat3x3AddSub` | Mat3x3 + - | 结果正确 |
| `testIntegrationMat4x4AddSub` | Mat4x4 + - | 结果正确 |
| `testIntegrationNonSquareAddSub` | 非方阵 Mat2x3 + -、Mat3x2 + - | 结果正确 |
| `testIntegrationMatScalarMulDiv` | Mat2x2/Mat3x3/Mat4x4 ×标量、/标量 | 结果正确 |
| `testIntegrationScalarLeftMul` | 标量×Mat（成员运算符） | 结果正确 |
| `testIntegrationMatVecMul` | Mat2x2×Vec2、Mat3x3×Vec3、Mat4x4×Vec4 | 结果正确 |
| `testIntegrationCrossSizeMatMul` | Mat2x2×Mat2x4→Mat2x4、Mat3x3×Mat3x2→Mat3x2 等 3 组 | 结果正确 |
| `testIntegrationNonSquareMatVecMul` | Mat2x3×Vec2→Vec3、Mat4x2×Vec4→Vec2 | 结果正确 |
| `testIntegrationMatMulChain` | 连续乘法：Mat2x2×Mat2x4×Mat4x2 | 结果正确 |
| `testIntegrationMatFromMatExpandChain` | Mat2x2←Mat2x3←Mat2x4 逐级构造+值检查 | 值正确 |
| `testIntegrationMatFromMatShrinkChain` | Mat4x4←Mat3x3←Mat2x2 逐级收缩+值检查 | 值正确 |

### 3. fromMat 跨尺寸转换 — 6 tests

| 测试函数 | 覆盖 | 断言 |
|---------|------|------|
| `testIntegrationFromMatBClass` | B 类方向：Mat2x2→Mat2x3→Mat2x4 | 行扩展正确 |
| `testIntegrationFromMatColExtRowExt` | 列+行双扩展：Mat2x2→Mat3x3 | 正确 |
| `testIntegrationFromMatColShrink` | 收缩：Mat4x4→Mat3x3→Mat2x2 | 截断正确 |
| `testIntegrationFromMatColExtRowShrink` | 混合：Mat2x4→Mat3x2（colExt→rowSh） | 正确 |
| `testIntegrationFromMatColShrinkRowExt` | 混合：Mat3x2→Mat2x3（colSh→rowExt） | 正确 |
| `testIntegrationFromMatDeviation` | Mat4x4←Mat4x2 偏差方向 | 列2/3 按 GLM 行为 |

### 4. 矩阵函数（通过 lib.cj）— 4 tests

| 测试函数 | 覆盖 | 断言 |
|---------|------|------|
| `testIntegrationTransposeAll` | transpose 对 Mat2x2/Mat3x3/Mat4x4 | 行列交换 |
| `testIntegrationTransposeNonSquare` | transpose 对 Mat2x3/Mat3x2/Mat4x2 | 行列交换 |
| `testIntegrationMatrixCompMult` | matrixCompMult 对 Mat2x2/Mat3x3/Mat4x4 | 分量乘法 |
| `testIntegrationOuterProduct` | outerProduct 对 Vec2/Vec3/Vec4 组合 | 外积结果 |

### 5. 行向量×矩阵 — 3 tests

| 测试函数 | 覆盖 | 断言 |
|---------|------|------|
| `testIntegrationRowVecMatMulVec2` | Vec2×Mat2x2/Mat3x2/Mat4x2 | 结果 Vec2/Vec3/Vec4 |
| `testIntegrationRowVecMatMulVec3` | Vec3×Mat2x3/Mat3x3/Mat4x3 | 结果 Vec2/Vec3/Vec4 |
| `testIntegrationRowVecMatMulVec4` | Vec4×Mat2x4/Mat3x4/Mat4x4 | 结果 Vec2/Vec3/Vec4 |

### 6. 标量-矩阵运算（通过 lib.cj）— 5 tests

| 测试函数 | 覆盖 | 断言 |
|---------|------|------|
| `testIntegrationScalarAddSubMat` | add/sub 对标量×矩阵组合 | 结果正确 |
| `testIntegrationScalarMulDivMat` | mul/div 对标量×矩阵组合 | 结果正确 |
| `testIntegrationScalarOpsAllTypes` | 方阵+非方阵各 1 组标量运算 | 结果正确 |
| `testIntegrationScalarOpsConsistency` | 标量运算与 Vec 标量运算一致性 | 行为一致 |
| `testIntegrationScalarOpsEdgeCases` | 标量×Mat 边界（零标量、负标量） | 结果正确 |

### 7. Double 精度验证 — 4 tests

| 测试函数 | 覆盖 | 断言 |
|---------|------|------|
| `testIntegrationDMatConstructArithmetic` | DMat2x2/DMat4x4 构造+运算 | Float64 精度 |
| `testIntegrationDMatFromMat` | DMat 间的 fromMat 转换 | 精度保持 |
| `testIntegrationDMatTranspose` | DMat 的 transpose | 正确 |
| `testIntegrationDMatFwdAlias` | dmat2/dmat4 别名使用 | 类型兼容 |

## 测试代码模板

### 导入和包

```cangjie
package glm

import std.unittest.*
import std.unittest.testmacro.*
```

### 测试函数模式

```cangjie
@Test
func testIntegrationMat2x2AddSub(): Unit {
    let a = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let b = Mat2x2(Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let r = a + b
    @Expect(r.c0.x, Float32(6.0))
    @Expect(r.c0.y, Float32(8.0))
    @Expect(r.c1.x, Float32(10.0))
    @Expect(r.c1.y, Float32(12.0))
}
```

## 错误处理

所有测试通过 `@Expect` 断言验证结果正确性。不涉及异常传播（仅 fromMat 偏差方向涉及特殊行为验证，不产生 Exception）。

## 行为契约

- 每个测试函数独立可运行，无互相依赖
- 通过 `package glm` 访问所有别名和函数（无需 import detail 包）
- 所有测试使用 Float32 别名类型（`Mat2x2` 等）而非泛型具现化
- Double 精度测试使用 `DMat2x2` / `DMat4x4` 别名类型
- 浮点数比较使用 `@Expect` 直接比较（不涉及 epsilon 比较，测试选择整数精度可表示的浮点值）

## 依赖关系

### 依赖的已有类型
- `glm.Mat2x2` ~ `glm.Mat4x4`（fwd.cj 别名）
- `glm.DMat2x2` ~ `glm.DMat4x4`（fwd.cj 别名）
- `glm.mat2`/`glm.mat3`/`glm.mat4`（短别名）
- `glm.dmat2`/`glm.dmat3`/`glm.dmat4`（短别名）
- `glm.transpose`/`glm.matrixCompMult`/`glm.outerProduct`（lib.cj re-export）
- `glm.add`/`glm.sub`/`glm.mul`/`glm.div`（lib.cj re-export）
- `glm.Vec2`/`glm.Vec3`/`glm.Vec4`（lib.cj re-export）

### 验证标准
- `cjpm test` 全部通过
- 新增用例数 ≥ 30（本设计 40 tests）
- 所有 9 种矩阵类型被覆盖
- 算术运算/fromMat/函数/行向量×矩阵/标量-矩阵 5 个维度均覆盖
