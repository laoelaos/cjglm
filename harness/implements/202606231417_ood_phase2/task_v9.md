# 任务指令（v9）

## 动作
NEW

## 任务描述
实现 T9 — 别名和导出：

1. **ext/ 目录 26 个别名文件**（`src/ext/`，package `glm.ext`）：
   - 18 个矩阵别名文件：`matrix_float2x2.cj` ~ `matrix_float4x4.cj`（9 文件，Float32）+ `matrix_double2x2.cj` ~ `matrix_double4x4.cj`（9 文件，Float64）
   - 8 个向量别名文件：`vector_float1.cj` ~ `vector_float4.cj`（4 文件，Float32）+ `vector_double1.cj` ~ `vector_double4.cj`（4 文件，Float64）
   - 每个文件声明 `package glm.ext`，import `glm.detail.*`，通过 public type 别名 re-export 对应类型

2. **fwd.cj 更新**（`src/fwd.cj`）：新增 54 个矩阵类型别名：
   - **Mat 家族**（Float32, PackedHighp）：9 PascalCase（Mat2x2~Mat4x4）+ 3 方阵短别名（mat2/3/4）+ 6 非方阵 camelCase（mat2x3~mat4x3）= 18
   - **DMat 家族**（Float64, PackedHighp）：9 PascalCase（DMat2x2~DMat4x4）+ 3 方阵短别名（dmat2/3/4）+ 6 非方阵 camelCase（dmat2x3~dmat4x3）= 18
   - 其余 6 精度族仅方阵短别名（3 各）= 18：
     - HighpMat（Float32,Highp）：Highpmat2/3/4
     - MediumpMat（Float32,Mediump）：Mediumpmat2/3/4
     - LowpMat（Float32,Lowp）：Lowpmat2/3/4
     - HighpDMat（Float64,Highp）：Highpdmat2/3/4
     - MediumpDMat（Float64,Mediump）：Mediumpdmat2/3/4
     - LowpDMat（Float64,Lowp）：Lowpdmat2/3/4

3. **lib.cj 更新**（`src/lib.cj`）：新增：
   - 9 个矩阵类型 public import：`Mat2x2`, `Mat2x3`, `Mat2x4`, `Mat3x2`, `Mat3x3`, `Mat3x4`, `Mat4x2`, `Mat4x3`, `Mat4x4`
   - 3 个 matrix.cj 函数 public import：`transpose`, `matrixCompMult`, `outerProduct`
   - scalar_mat_ops.cj 的全局函数已有同名导出（add/sub/mul/div），无需重复添加

## 选择理由
T8（Vec extend 块）已完成验证。T9 是 OOD 阶段二的 API 面封装层——ext/ 提供兼容 GLM 的具现化别名组织形式，fwd.cj 提供便捷类型别名供 package glm 用户直接使用，lib.cj 提供包级公共导出。完成 T9 后方可进行 T10 测试编写（需验证别名可被正确解析）。

## 任务上下文
### ext/ 别名文件格式
每个文件使用标准模板，例如 `src/ext/matrix_float4x4.cj`：
```
package glm.ext
public import glm.detail.Mat4x4
```
所有 ext/ 文件声明 `package glm.ext`，仅做 import + public re-export。不包含任何实现代码。参考 GLM 1.0.3 的 ext/ 目录组织模式。

### fwd.cj 别名格式
遵循现有 fwd.cj 中向量别名的命名模式：
```cangjie
// Mat 家族
public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>
public type mat2 = Mat2x2
public type mat2x3 = detail.Mat2x3<Float32, detail.PackedHighp>
// ... 以此类推
```

### lib.cj 更新
在现有 public import 后追加：
```
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
public import glm.detail.{ transpose, matrixCompMult, outerProduct }
```

### 现有代码上下文
- `src/fwd.cj`：已包含 324 行向量 + 标量类型别名，import `glm.detail` 已存在，可直接使用 `detail.MatNxN<...>` 限定访问
- `src/lib.cj`：当前 6 行，导出 Vec1~Vec4 等
- `src/detail/`：所有 9 个矩阵类型已完整实现（含所有 extend 块）
- 不存在 `src/ext/` 目录（需新建）

### 编译验证
- 首次 cjpm build 验证 ext/ 子包（package glm.ext）能否被 cjpm 自动发现
- 若构建失败（子包未发现），fallback：将 ext/ 文件移至 `src/` 根目录改为 `package glm`
- 若 fallback 也失败，明确记录为偏差
