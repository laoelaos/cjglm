# 任务指令（v10）

## 动作
NEW

## 任务描述
编写集成测试文件，通过 `glm` 包的 public API（fwd.cj 别名 + lib.cj re-export）验证全部 9 种矩阵类型（Mat2x2~Mat4x4）的跨类型组合操作一致性。

预期文件：
- `tests/glm/test_integration_matrix.cj` — 矩阵集成测试（约 30~60 用例）

## 选择理由
T9 已完成全部矩阵类型的 API 面封装层（ext/fwd/lib）。现有模块级测试已验证各类型独立正确性（T3~T8）。T10 通过公共 API 别名执行跨类型集成测试，补齐模块测试未覆盖的组合路径（如 Mat2x2→Mat3x3→Mat4x4 fromMat 链、跨尺寸乘法矩阵链等），确保完整 API surface 的一致性后进入 T11 最终构建验证。

## 任务上下文
- 通过 `import glm`（public import from `src/lib.cj`）可访问：
  - 9 个矩阵类型：`Mat2x2`, `Mat2x3`, `Mat2x4`, `Mat3x2`, `Mat3x3`, `Mat3x4`, `Mat4x2`, `Mat4x3`, `Mat4x4`
  - 3 个矩阵函数：`transpose`, `matrixCompMult`, `outerProduct`
  - 4 个向量类型：`Vec1`, `Vec2`, `Vec3`, `Vec4`
  - 标量函数：`add`, `sub`, `mul`, `div`, `mod`
- 通过 fwd.cj 别名额外访问：`mat2`~`mat4`, `dmat2`~`dmat4`, `DMat2x2`~`DMat4x4` 等

## 集成测试覆盖范围

### 1. 矩阵构造（通过 fwd 别名）
- 全部 9 种 float 矩阵类型（Mat2x2~Mat4x4）通过 fwd 别名构造 + 列成员读取
- Double 精度矩阵（DMat2x2~DMat4x4）构造 + 读取
- 短别名（mat2, mat3, mat4, dmat2, dmat4 等）构造 + 读取

### 2. 算术运算（通过 fwd 别名）
- 每种矩阵类型的加法/减法：构造 2 个同尺寸矩阵，加法后验证结果
- 标量乘/除：矩阵×标量、标量×矩阵、矩阵/标量
- 矩阵×向量（左乘）：Mat×Vec2/3/4 行向量乘法
- 跨尺寸乘法：例如 Mat2x2×Mat2x4→Mat2x4, Mat3x3×Mat3x2→Mat3x2

### 3. fromMat 跨尺寸转换
- 展开链：Mat2x2→Mat2x3→Mat2x4→Mat3x4→Mat4x4（逐级构造 + 值检查）
- 收缩链：Mat4x4→Mat3x3→Mat2x2（逐级构造 + 值检查）

### 4. 矩阵函数（通过 lib.cj）
- transpose：对 Mat2x2, Mat3x3, Mat4x4 做转置，验证行列交换正确
- matrixCompMult：两个同尺寸矩阵分量乘法
- outerProduct：两个向量外积

### 5. 行向量×矩阵
- Vec2×Mat2x2, Vec3×Mat3x3, Vec4×Mat4x4
- 结果正确性验证

### 6. 标量-矩阵运算（通过 lib.cj）
- add/sub/mul/div 对标量×矩阵组合

### 7. Double 精度验证
- DMat2x2, DMat4x4 的构造和基本运算

## 已有代码上下文
- `src/lib.cj` — public import 所有矩阵类型 + transpose/matrixCompMult/outerProduct
- `src/fwd.cj` — 54 个矩阵类型别名（Mat/DMat/HighpMat/MediumpMat/LowpMat/HighpDMat/MediumpDMat/LowpDMat 族）
- 现有 23 个测试文件共 476 用例全部通过
- 测试框架：仓颉 `@Test` 注解，`@Testable` 导入被测模块

## 测试文件模板参考

参考现有测试文件 `tests/glm/detail/test_type_mat2x2.cj` 的结构：
```
package glm.detail
import glm.detail.*
@Testable
class TestTypeMat2x2 {
    @Test
    public func test_xxx(): Unit { ... }
}
```

集成测试文件 `tests/glm/test_integration_matrix.cj`：
```
package glm
import glm.*
@Testable
class TestIntegrationMatrix {
    @Test
    public func test_xxx(): Unit { ... }
}
```

## 验证标准
- `cjpm test` 全部通过
- 新增用例数 ≥ 30
- 所有 9 种矩阵类型被覆盖
- 算术运算/fromMat/函数/行向量×矩阵/标量-矩阵 5 个维度均覆盖
