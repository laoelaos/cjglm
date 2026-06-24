# 详细设计（v9）

## 概述

T9 — 别名和导出：为 OOD 阶段二的矩阵类型提供三层 API 面封装。包括：
1. `src/ext/` 子包 `glm.ext` 的 26 个别名文件（re-export detail 核心类型）
2. `src/fwd.cj` 新增 54 个矩阵类型别名
3. `src/lib.cj` 新增矩阵类型和矩阵函数的 public import

完成后 T9 可在 T10 测试编写阶段验证别名可被正确解析。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/ext/` | 新建目录 | `package glm.ext` 子包目录 |
| `src/ext/matrix_float2x2.cj` | 新建 | 声明 `glm.ext`，public import `glm.detail.Mat2x2` |
| `src/ext/matrix_float2x3.cj` | 新建 | public import `glm.detail.Mat2x3` |
| `src/ext/matrix_float2x4.cj` | 新建 | public import `glm.detail.Mat2x4` |
| `src/ext/matrix_float3x2.cj` | 新建 | public import `glm.detail.Mat3x2` |
| `src/ext/matrix_float3x3.cj` | 新建 | public import `glm.detail.Mat3x3` |
| `src/ext/matrix_float3x4.cj` | 新建 | public import `glm.detail.Mat3x4` |
| `src/ext/matrix_float4x2.cj` | 新建 | public import `glm.detail.Mat4x2` |
| `src/ext/matrix_float4x3.cj` | 新建 | public import `glm.detail.Mat4x3` |
| `src/ext/matrix_float4x4.cj` | 新建 | public import `glm.detail.Mat4x4` |
| `src/ext/matrix_double2x2.cj` | 新建 | public import `glm.detail.Mat2x2` |
| `src/ext/matrix_double2x3.cj` | 新建 | public import `glm.detail.Mat2x3` |
| `src/ext/matrix_double2x4.cj` | 新建 | public import `glm.detail.Mat2x4` |
| `src/ext/matrix_double3x2.cj` | 新建 | public import `glm.detail.Mat3x2` |
| `src/ext/matrix_double3x3.cj` | 新建 | public import `glm.detail.Mat3x3` |
| `src/ext/matrix_double3x4.cj` | 新建 | public import `glm.detail.Mat3x4` |
| `src/ext/matrix_double4x2.cj` | 新建 | public import `glm.detail.Mat4x2` |
| `src/ext/matrix_double4x3.cj` | 新建 | public import `glm.detail.Mat4x3` |
| `src/ext/matrix_double4x4.cj` | 新建 | public import `glm.detail.Mat4x4` |
| `src/ext/vector_float1.cj` | 新建 | public import `glm.detail.Vec1` |
| `src/ext/vector_float2.cj` | 新建 | public import `glm.detail.Vec2` |
| `src/ext/vector_float3.cj` | 新建 | public import `glm.detail.Vec3` |
| `src/ext/vector_float4.cj` | 新建 | public import `glm.detail.Vec4` |
| `src/ext/vector_double1.cj` | 新建 | public import `glm.detail.Vec1` |
| `src/ext/vector_double2.cj` | 新建 | public import `glm.detail.Vec2` |
| `src/ext/vector_double3.cj` | 新建 | public import `glm.detail.Vec3` |
| `src/ext/vector_double4.cj` | 新建 | public import `glm.detail.Vec4` |
| `src/fwd.cj` | 修改 | 追加 54 个矩阵类型别名 |
| `src/lib.cj` | 修改 | 追加矩阵类型和函数 public import |

## 类型定义

### ext/ 别名文件格式

**形态**：源文件（纯 re-export）
**包路径**：`glm.ext`
**职责**：每个文件通过 `public import` 将 `glm.detail` 中的对应类型 re-export 到 `glm.ext` 包

每个文件使用标准模板，例如 `src/ext/matrix_float4x4.cj`：

```cangjie
package glm.ext
public import glm.detail.Mat4x4
```

所有 26 个文件仅做 `package glm.ext` + `public import` 一行 re-export，不包含任何实现代码。

### fwd.cj 矩阵别名

**包路径**：`glm`

以下 54 个 `public type` 别名追加到 `src/fwd.cj` 末尾（现有 324 行向量/标量别名之后）。

**Mat 家族（Float32, PackedHighp）— 18 个**：

```cangjie
// === Mat matrix family ===
public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>
public type Mat2x3 = detail.Mat2x3<Float32, detail.PackedHighp>
public type Mat2x4 = detail.Mat2x4<Float32, detail.PackedHighp>
public type Mat3x2 = detail.Mat3x2<Float32, detail.PackedHighp>
public type Mat3x3 = detail.Mat3x3<Float32, detail.PackedHighp>
public type Mat3x4 = detail.Mat3x4<Float32, detail.PackedHighp>
public type Mat4x2 = detail.Mat4x2<Float32, detail.PackedHighp>
public type Mat4x3 = detail.Mat4x3<Float32, detail.PackedHighp>
public type Mat4x4 = detail.Mat4x4<Float32, detail.PackedHighp>
public type mat2 = Mat2x2
public type mat3 = Mat3x3
public type mat4 = Mat4x4
public type mat2x3 = Mat2x3
public type mat2x4 = Mat2x4
public type mat3x2 = Mat3x2
public type mat3x4 = Mat3x4
public type mat4x2 = Mat4x2
public type mat4x3 = Mat4x3
```

**DMat 家族（Float64, PackedHighp）— 18 个**：

```cangjie
// === DMat matrix family ===
public type DMat2x2 = detail.Mat2x2<Float64, detail.PackedHighp>
public type DMat2x3 = detail.Mat2x3<Float64, detail.PackedHighp>
public type DMat2x4 = detail.Mat2x4<Float64, detail.PackedHighp>
public type DMat3x2 = detail.Mat3x2<Float64, detail.PackedHighp>
public type DMat3x3 = detail.Mat3x3<Float64, detail.PackedHighp>
public type DMat3x4 = detail.Mat3x4<Float64, detail.PackedHighp>
public type DMat4x2 = detail.Mat4x2<Float64, detail.PackedHighp>
public type DMat4x3 = detail.Mat4x3<Float64, detail.PackedHighp>
public type DMat4x4 = detail.Mat4x4<Float64, detail.PackedHighp>
public type dmat2 = DMat2x2
public type dmat3 = DMat3x3
public type dmat4 = DMat4x4
public type dmat2x3 = DMat2x3
public type dmat2x4 = DMat2x4
public type dmat3x2 = DMat3x2
public type dmat3x4 = DMat3x4
public type dmat4x2 = DMat4x2
public type dmat4x3 = DMat4x3
```

**剩余精度族（仅方阵短别名）— 18 个**：

```cangjie
// === HighpMat family (Float32, Highp) ===
public type Highpmat2 = detail.Mat2x2<Float32, detail.PackedHighp>
public type Highpmat3 = detail.Mat3x3<Float32, detail.PackedHighp>
public type Highpmat4 = detail.Mat4x4<Float32, detail.PackedHighp>

// === MediumpMat family (Float32, Mediump) ===
public type Mediumpmat2 = detail.Mat2x2<Float32, detail.PackedMediump>
public type Mediumpmat3 = detail.Mat3x3<Float32, detail.PackedMediump>
public type Mediumpmat4 = detail.Mat4x4<Float32, detail.PackedMediump>

// === LowpMat family (Float32, Lowp) ===
public type Lowpmat2 = detail.Mat2x2<Float32, detail.PackedLowp>
public type Lowpmat3 = detail.Mat3x3<Float32, detail.PackedLowp>
public type Lowpmat4 = detail.Mat4x4<Float32, detail.PackedLowp>

// === HighpDMat family (Float64, Highp) ===
public type Highpdmat2 = detail.Mat2x2<Float64, detail.PackedHighp>
public type Highpdmat3 = detail.Mat3x3<Float64, detail.PackedHighp>
public type Highpdmat4 = detail.Mat4x4<Float64, detail.PackedHighp>

// === MediumpDMat family (Float64, Mediump) ===
public type Mediumpdmat2 = detail.Mat2x2<Float64, detail.PackedMediump>
public type Mediumpdmat3 = detail.Mat3x3<Float64, detail.PackedMediump>
public type Mediumpdmat4 = detail.Mat4x4<Float64, detail.PackedMediump>

// === LowpDMat family (Float64, Lowp) ===
public type Lowpdmat2 = detail.Mat2x2<Float64, detail.PackedLowp>
public type Lowpdmat3 = detail.Mat3x3<Float64, detail.PackedLowp>
public type Lowpdmat4 = detail.Mat4x4<Float64, detail.PackedLowp>
```

**总计**：18 + 18 + 18 = **54 个别名**。

### lib.cj 更新

**包路径**：`glm`

在现有 public import 后追加（现有 6 行，`package glm` + 5 个 public import 行）：

```cangjie
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
public import glm.detail.{ transpose, matrixCompMult, outerProduct }
```

**追加后 lib.cj 完整内容**：

```cangjie
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
public import glm.detail.{ transpose, matrixCompMult, outerProduct }
```

**注意**：`scalar_mat_ops.cj` 的全局函数（`add/sub/mul/div`）已有同名导出，无需重复添加。

## 错误处理

本任务仅涉及别名和 re-export，不涉及运行时错误处理逻辑。所有别名都是编译期名称解析行为。

## 行为契约

- ext/ 文件仅做 `public import` re-export，不含实现代码
- fwd.cj 别名仅做 `public type` 类型别名，不含方法或函数
- lib.cj 仅做 `public import` re-export 顶层类型和函数
- 所有别名在编译期展开为对应的泛型具现化，无运行时开销

## 依赖关系

### 依赖的已有类型
- `glm.detail.Mat2x2` ~ `glm.detail.Mat4x4`（9 个矩阵结构体）
- `glm.detail.Vec1` ~ `glm.detail.Vec4`（4 个向量结构体）
- `glm.detail.{transpose, matrixCompMult, outerProduct}`（各 9 个重载，共 27 个函数）
- `glm.detail.{PackedHighp, PackedMediump, PackedLowp}`（精度限定符）

### 暴露给后续任务的公开接口
- T10 测试编写可通过 `import glm` 使用所有矩阵别名（`Mat2x2` ~ `Mat4x4`）和函数（`transpose` 等）
- T10 测试编写可通过 `import glm.ext` 使用 re-export 的核心类型

### ext/ 子包构建风险

`src/ext/` 声明 `package glm.ext` 的构建可行性取决于 cjpm 对子包的自动发现机制。按任务指令的分步验证策略：

1. **首选**：`cjpm build` 验证 `glm.ext` 子包自动发现
2. **备选**：若构建失败，将 ext/ 文件移至 `src/` 根目录改为 `package glm`
3. 若备选也失败，记录为偏差到 `docs/deviations.md`
