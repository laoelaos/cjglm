# 测试报告 (v1)

## 测试文件

`cjglm/tests/glm/ext/matrix_transform_test.cj`

## 审查修复

- **[严重]** `testShearExt` line 84: `@Expect(r.c1.y, 2.0)` → `@Expect(r.c1.y, 1.0)`。原因：构造的剪切矩阵 H 的 c1.y = `one + l_y.y * p.y`，代入测试参数 p.y=0.0、l_y.y=1.0 得 1.0，无论旧代码 `H * m` 或新代码 `m * H`、无论 m 为单位矩阵还是全 1 矩阵，结果均为 1.0。该缺陷与本次修复无关，但使测试不可靠，已修正。

## 新增测试用例

| 测试函数 | 维度 | 说明 |
|---------|------|------|
| `testRotateExtLeftMultiply` | 正常路径 — 左乘语义 | 用平移矩阵做输入 m，旋转 90° 绕 Z，验证 c3 列未被旋转影响（`m * Rot` 时旋转不改变平移列） |
| `testRotateExtZeroAxisNonIdentity` | 边界条件 — 零长度轴 | 用非单位矩阵做输入 m，零长度轴返回 m 本身（c3 应与输入一致） |
| `testShearExtLeftMultiply` | 正常路径 — 左乘语义 | 用平移矩阵做输入 m，施加剪切，验证 c3 列未被剪切影响（`m * H` 时剪切不改变平移列） |

## 覆盖维度

- **正常路径**: 已验证 `rotate` / `shear` 在非单位矩阵输入下的左乘行为
- **边界条件**: 已验证零长度轴保护在非单位矩阵输入下仍正确返回 m
- **错误路径**: 零长度轴分支已覆盖（`testRotateExtZeroAxisNonIdentity`）
- **状态交互**: 组合变换（translate + rotate、translate + shear）验证乘法顺序正确

## 与设计偏差

无偏差。所有测试用例完全基于详细设计 v1 的行为契约编写。
