# 详细设计（v1）

## 概述

修复 `cjglm/src/ext/matrix_transform.cj` 中 `rotate` 和 `shear` 函数的矩阵乘法顺序错误（S1），使其与 GLM 1.0.3 的左乘语义一致。修改仅涉及同一文件中的两个表达式。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/ext/matrix_transform.cj:39` | 修改 | rotate 函数返回表达式：`Rot * m` → `m * Rot` |
| `cjglm/src/ext/matrix_transform.cj:63` | 修改 | shear 函数返回表达式：`H * m` → `m * H` |

## 类型定义

无新增类型。修改仅涉及现有 `rotate` 和 `shear` 泛型函数的返回表达式。

## 修改细节

### rotate 函数（line 18-40）

**当前代码**（`:39`）：
```cangjie
Rot * m
```

**修改后**：
```cangjie
m * Rot
```

**依据**：GLM 1.0.3 `ext/matrix_transform.inl:40-45` 中通过 `m[0]*Rotate[0][0] + m[1]*Rotate[0][1] + m[2]*Rotate[0][2]` 等价于左乘 `m * Rot`。采用 `m * Rot` 时，m 的变换在左边先应用，Rot 在右边后应用，与 GLM 行为一致。

**现有函数签名保持不变**：
```cangjie
public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

### shear 函数（line 53-64）

**当前代码**（`:63`）：
```cangjie
H * m
```

**修改后**：
```cangjie
m * H
```

**依据**：GLM 1.0.3 `ext/matrix_transform.inl:119-124` 中通过 `m[0]*Shear[0][0] + m[1]*Shear[0][1] + m[2]*Shear[0][2] + m[3]*Shear[0][3]` 等价于左乘 `m * H`。

**现有函数签名保持不变**：
```cangjie
public func shear<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

## 乘法语义说明

- `Mat4x4.operator*(rhs: Mat4x4)`（`type_mat4x4.cj:114-121`）：实现标准矩阵乘法，`this` 为左乘矩阵，`rhs` 为右乘矩阵
- 当前代码 `Rot * m`：旋转矩阵左乘输入矩阵 m → 旋转应用在 m 之前（全局/世界空间旋转）
- 修复后 `m * Rot`：输入矩阵 m 左乘旋转矩阵 → 旋转应用在 m 之后（局部/对象空间旋转），与 GLM 1.0.3 语义一致

## 测试影响

现有测试均使用单位矩阵作为输入 m（`Mat4x4<Float64, Defaultp>(1.0)`），因此 `Rot * I = I * Rot = Rot` 且 `H * I = I * H = H`，测试期望值无需修改。测试用例已验证通过：

| 测试函数 | 输入 m | 影响 |
|---------|--------|------|
| `testRotateExt90Z`（`:54-62`） | 单位矩阵 I | 无影响（`Rot * I = I * Rot = Rot`） |
| `testRotateExtZeroAngle`（`:64-73`） | 单位矩阵 I | 无影响（零角旋转返回 m） |
| `testShearExt`（`:75-87`） | 单位矩阵 I | 无影响（`H * I = I * H = H`） |

## 错误处理

无变更。`rotate` 和 `shear` 均使用 `@OverflowWrapping` 的 `Mat4x4.operator*`，零长度轴保护（`:25-28`）已存在。

## 行为契约

- `rotate`：当 `axis` 长度 ≤ 0 时返回 `m`（`:26-28`），否则返回 `m * Rot`
- `shear`：始终返回 `m * H`
- 修改后两个函数均为左乘变换，与 `translate`（`:11-15` 直接构造列向量）和 `scale`（`:42-50` 直接层乘列向量）的左乘语义一致

## 依赖关系

- 修改仅涉及 `cjglm/src/ext/matrix_transform.cj` 单个文件
- `gtc/matrix_transform.cj:3` 通过 `public import glm.ext.*` 自动继承修复后的行为
- `lib.cj:43` 的 `public import glm.ext.{translate, rotate, scale, shear, ...}` 自动暴露修复后的版本
