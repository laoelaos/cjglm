# 实现报告（v9）

## 概述
实现 T9 — 别名和导出：为 OOD 阶段二的矩阵类型提供三层 API 面封装。包括 26 个 `src/ext/` 子包别名文件、`src/fwd.cj` 追加 54 个矩阵类型别名、`src/lib.cj` 追加矩阵类型和矩阵函数的 public import。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | src/ext/matrix_float2x2.cj | public import glm.detail.Mat2x2 |
| 新建 | src/ext/matrix_float2x3.cj | public import glm.detail.Mat2x3 |
| 新建 | src/ext/matrix_float2x4.cj | public import glm.detail.Mat2x4 |
| 新建 | src/ext/matrix_float3x2.cj | public import glm.detail.Mat3x2 |
| 新建 | src/ext/matrix_float3x3.cj | public import glm.detail.Mat3x3 |
| 新建 | src/ext/matrix_float3x4.cj | public import glm.detail.Mat3x4 |
| 新建 | src/ext/matrix_float4x2.cj | public import glm.detail.Mat4x2 |
| 新建 | src/ext/matrix_float4x3.cj | public import glm.detail.Mat4x3 |
| 新建 | src/ext/matrix_float4x4.cj | public import glm.detail.Mat4x4 |
| 新建 | src/ext/matrix_double2x2.cj | public import glm.detail.Mat2x2 |
| 新建 | src/ext/matrix_double2x3.cj | public import glm.detail.Mat2x3 |
| 新建 | src/ext/matrix_double2x4.cj | public import glm.detail.Mat2x4 |
| 新建 | src/ext/matrix_double3x2.cj | public import glm.detail.Mat3x2 |
| 新建 | src/ext/matrix_double3x3.cj | public import glm.detail.Mat3x3 |
| 新建 | src/ext/matrix_double3x4.cj | public import glm.detail.Mat3x4 |
| 新建 | src/ext/matrix_double4x2.cj | public import glm.detail.Mat4x2 |
| 新建 | src/ext/matrix_double4x3.cj | public import glm.detail.Mat4x3 |
| 新建 | src/ext/matrix_double4x4.cj | public import glm.detail.Mat4x4 |
| 新建 | src/ext/vector_float1.cj | public import glm.detail.Vec1 |
| 新建 | src/ext/vector_float2.cj | public import glm.detail.Vec2 |
| 新建 | src/ext/vector_float3.cj | public import glm.detail.Vec3 |
| 新建 | src/ext/vector_float4.cj | public import glm.detail.Vec4 |
| 新建 | src/ext/vector_double1.cj | public import glm.detail.Vec1 |
| 新建 | src/ext/vector_double2.cj | public import glm.detail.Vec2 |
| 新建 | src/ext/vector_double3.cj | public import glm.detail.Vec3 |
| 新建 | src/ext/vector_double4.cj | public import glm.detail.Vec4 |
| 修改 | src/fwd.cj | 追加 54 个矩阵类型别名（Mat/DMat/HighpMat/MediumpMat/LowpMat/HighpDMat/MediumpDMat/LowpDMat 族） |
| 修改 | src/lib.cj | 追加 public import Mat2x2~Mat4x4 和 transpose/matrixCompMult/outerProduct |

## 编译验证
`cjpm build` 成功。预期内的 warnings：
- ext/ 文件中 float/double 同名重导出引发的 `imported decl ... is conflicted with other import`（13 条，因同一 detail 类型被不同文件 public import）
- lib.cj 中 import 被 fwd.cj 的 type alias 覆盖引发的 `imported decl ... is shadowed`（13 条，因 fwd.cj 的 public type 与 lib.cj 的 public import 同名）

## 设计偏差说明
无偏差。所有别名和 re-export 严格按详细设计规格实现。
