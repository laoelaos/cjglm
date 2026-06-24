# 测试报告（v3 r1）

## 测试文件

`tests/glm/detail/test_type_mat2x2.cj`

## 测试用例清单

| # | 测试函数 | 类别 | 状态 |
|---|---------|------|------|
| 1 | testMat2x2ScalarInit | 构造-标量填充 | PASS |
| 2 | testMat2x2ConstInitElementwise | 构造-逐分量 | PASS |
| 3 | testMat2x2ConstInitColumn | 构造-列向量 | PASS |
| 4 | testMat2x2Length | length() | PASS |
| 5 | testMat2x2IndexAccess | 下标访问 | PASS |
| 6 | testMat2x2IndexMutate | 下标赋值 | PASS |
| 7 | testMat2x2ColAccess | col() | PASS |
| 8 | testMat2x2IndexOutOfBounds | 越界-正索引 | PASS |
| 9 | testMat2x2NegativeIndex | 越界-负索引 | PASS |
| 10 | testMat2x2ColOutOfBounds | 越界-col正索引 | PASS |
| 11 | testMat2x2ColNegative | 越界-col负索引 | PASS |
| 12 | testMat2x2UnaryNegate | 一元负号 | PASS |
| 13 | testMat2x2ScalarAdd | 矩阵-标量+ | PASS |
| 14 | testMat2x2ScalarSub | 矩阵-标量- | PASS |
| 15 | testMat2x2ScalarMul | 矩阵-标量* | PASS |
| 16 | testMat2x2ScalarDiv | 矩阵-标量/ | PASS |
| 17 | testMat2x2MatrixAdd | 矩阵-矩阵+ | PASS |
| 18 | testMat2x2MatrixSub | 矩阵-矩阵- | PASS |
| 19 | testMat2x2MatrixMul | 矩阵-矩阵*(同尺寸) | PASS |
| 20 | testMat2x2MulMat3x2 | 矩阵-矩阵*(→Mat3x2) | PASS |
| 21 | testMat2x2MulMat4x2 | 矩阵-矩阵*(→Mat4x2) | PASS |
| 22 | testMat2x2MatrixDivStub | 矩阵-矩阵/ (stub异常) | PASS |
| 23 | testMat2x2MulVec2 | 矩阵×Vec2 | PASS |
| 24 | testMat2x2Diagonal | diagonal工厂 | PASS |
| 25 | testMat2x2Identity | identity工厂 | PASS |
| 26 | testMat2x2FromParts | fromParts | PASS |
| 27 | testMat2x2FromColumns | fromColumns | PASS |
| 28 | testMat2x2FromMat7 | fromMat 7 | PASS |
| 29 | testMat2x2FromMat6aMat2x3 | fromMat 6a Mat2x3 | PASS |
| 30 | testMat2x2FromMat6aMat2x4 | fromMat 6a Mat2x4 | PASS |
| 31 | testMat2x2FromMat6aMat3x2 | fromMat 6a Mat3x2 | PASS |
| 32 | testMat2x2FromMat6aMat3x3 | fromMat 6a Mat3x3 | PASS |
| 33 | testMat2x2FromMat6aMat3x4 | fromMat 6a Mat3x4 | PASS |
| 34 | testMat2x2FromMat6aMat4x2 | fromMat 6a Mat4x2 | PASS |
| 35 | testMat2x2FromMat6aMat4x3 | fromMat 6a Mat4x3 | FIXED |
| 36 | testMat2x2FromMat6aMat4x4 | fromMat 6a Mat4x4 | PASS |
| 37 | testMat2x2FromMat6bMat2x3 | fromMat 6b Mat2x3 | PASS |
| 38 | testMat2x2FromMat6bMat2x4 | fromMat 6b Mat2x4 | PASS |
| 39 | testMat2x2FromMat6bMat3x2 | fromMat 6b Mat3x2 | PASS |
| 40 | testMat2x2FromMat6bMat3x3 | fromMat 6b Mat3x3 | PASS |
| 41 | testMat2x2FromMat6bMat3x4 | fromMat 6b Mat3x4 | PASS |
| 42 | testMat2x2FromMat6bMat4x2 | fromMat 6b Mat4x2 | PASS |
| 43 | testMat2x2FromMat6bMat4x3 | fromMat 6b Mat4x3 | FIXED |
| 44 | testMat2x2FromMat6bMat4x4 | fromMat 6b Mat4x4 | PASS |

## 审查修复记录

审查文件：test_review_v3_r1.md，结果：REJECTED

### 修复项

1. **testMat2x2FromMat6aMat4x3**：Mat4x3 的 c1 = Vec3(4,5,6)，期望值 `m.c1.x` 从 `5` 修正为 `4`，`m.c1.y` 从 `6` 修正为 `5`。

2. **testMat2x2FromMat6bMat4x3**：同上，`m.c1.x` 从 `Float64(5)` 修正为 `Float64(4)`，`m.c1.y` 从 `Float64(6)` 修正为 `Float64(5)`。

## 覆盖分析

- 构造方式：3 种（标量/逐分量/列向量）— 全覆盖
- 算术运算符：9 个（负号/±×/标量4种/矩阵3种/Vec2×）— 全覆盖
- 工厂函数：2 个（diagonal/identity）— 全覆盖
- 跨类型构造：3 个（fromParts/fromColumns/fromMat7）— 全覆盖
- fromMat 6a：8 个方向 — 全代表
- fromMat 6b：8 个方向 + 跨类型 conv — 全代表
- 越界/错误路径：4 个（正/负索引、正/负col）— 全覆盖
