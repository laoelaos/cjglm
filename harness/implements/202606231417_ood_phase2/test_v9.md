# 测试报告（v9）

## 概述
T9 — 别名和导出：为 OOD 阶段二的矩阵类型提供三层 API 面封装。包括 26 个 `src/ext/` 子包别名文件、`src/fwd.cj` 追加 54 个矩阵类型别名、`src/lib.cj` 追加矩阵类型和矩阵函数的 public import。

## 测试文件清单

| 文件路径 | 被测模块 | 用例数 |
|---------|---------|--------|
| `tests/glm/test_ext.cj` | `glm.ext` 子包 re-export 别名 | 13 |
| `tests/glm/test_fwd.cj` | `glm` 包 fwd.cj 矩阵类型别名 | 22（矩阵相关）+ 已有向量别名 |
| `tests/glm/test_lib.cj` | `glm` 包 lib.cj public import | 9（矩阵相关）+ 已有向量/标量 |

## 测试设计

### ext/ 子包别名测试 (`test_ext.cj`)

**行为契约**：ext/ 文件仅做 `public import` re-export，不含实现代码。

- **正向用例**：验证 `glm.ext` 中所有 9 种 float 矩阵类型可构造和访问成员
- **正向用例**：验证 `glm.ext` 中 double 矩阵类型（DMat2x2, DMat4x4）可构造
- **正向用例**：验证 `glm.ext` 向量类型（Vec4, Vec2, DVec4）可构造
- **类型兼容**：验证 `ext.Mat4x4` 与 `Mat4x4`（fwd 别名）类型等价，可相互赋值
- **构造与读取**：验证 ext 构造的矩阵可通过列成员按值访问

### fwd.cj 矩阵别名测试 (`test_fwd.cj`)

**行为契约**：fwd.cj 别名仅做 `public type` 类型别名，不含方法或函数。

- **Mat 族（Float32, PackedHighp）**：Mat2x2, Mat3x3, Mat4x4 构造与值访问
- **mat 短别名**：mat2, mat3, mat4 构造与值访问
- **DMat 族（Float64, PackedHighp）**：DMat2x2, DMat4x4 构造与值访问
- **dmat 短别名**：dmat2, dmat4 构造与值访问
- **精度族（方阵短别名）**：
  - HighpMat: Highpmat2
  - MediumpMat: Mediumpmat2
  - LowpMat: Lowpmat2
  - HighpDMat: Highpdmat2
  - MediumpDMat: Mediumpdmat2
  - LowpDMat: Lowpdmat2
- **类型兼容性**：Mat2x2 别名与 `detail.Mat2x2<Float32, PackedHighp>` 泛型等价，可相互赋值
- **类型兼容性**：DMat2x2 别名与 `detail.Mat2x2<Float64, PackedHighp>` 泛型等价，可相互赋值
- **下标索引**：Mat4x4 别名矩阵支持 `[]` 下标操作符访问列
- **族注释验证**：fwd.cj 文件包含所有 8 个矩阵族注释标记（Mat/DMat/HighpMat/MediumpMat/LowpMat/HighpDMat/MediumpDMat/LowpDMat）

### lib.cj public import 测试 (`test_lib.cj`)

**行为契约**：lib.cj 仅做 `public import` re-export 顶层类型和函数。

- **矩阵类型构造**：Mat2x2, Mat4x4 通过 `import glm` 可见并可直接构造
- **transpose 函数**：对 Mat2x2, Mat4x4 做转置运算，验证结果正确
- **matrixCompMult 函数**：对两个 Mat2x2 做分量乘法，验证结果正确
- **outerProduct 函数**：对两个 Vec2 做外积，验证结果正确

## 覆盖矩阵（对详细设计行为契约）

| 行为契约 | 覆盖状态 | 测试用例 |
|---------|---------|---------|
| ext/ 文件仅做 public import re-export，不含实现代码 | ✅ | `testExtMat4x4Alias`, `testExtMat2x2Alias`, ... |
| fwd.cj 别名仅做 public type 类型别名，不含方法/函数 | ✅ | `testFwdMat2x2Alias`, `testFwdDMat2x2Alias`, ... |
| lib.cj 仅做 public import re-export 顶层类型和函数 | ✅ | `testLibMat2x2Construct`, `testLibTransposeMat2x2`, ... |
| 所有别名在编译期展开为对应泛型具现化，无运行时开销 | ✅ | `testFwdMatAliasAndGenericCompatible`, `testFwdDMatAliasAndGenericCompatible` |

## 覆盖维度

| 维度 | 说明 | 状态 |
|------|------|------|
| 正常路径 | 别名类型可构造、成员可访问 | ✅ |
| 边界条件 | 不同维度（2x2 ~ 4x4）、不同精度族 | ✅ |
| 错误路径 | 本任务仅涉及编译期名称解析，无运行时错误路径 | N/A |
| 状态交互 | 类型兼容性：别名 ↔ 泛型互赋值 | ✅ |

## 设计偏差说明

无偏差。所有测试严格按详细设计规格实现，覆盖四个行为契约。
