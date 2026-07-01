# 测试审查报告（v1 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `cjglm/tests/glm/ext/matrix_transform_test.cj:84` — 预存在测试 `testShearExt` 期望值错误：`@Expect(r.c1.y, 2.0)` 应为 `1.0`。原因：代码构造的剪切矩阵 H 的 c1.y = `one + l_y.y * p.y`，代入测试参数 p.y=0.0、l_y.y=1.0 得 1.0，无论旧代码 `H * m` 或新代码 `m * H`、无论 m 为单位矩阵还是全 1 矩阵，结果均为 1.0。该缺陷与本次修复无关，但使测试不可靠。

- **[一般]** `detail_v1.md:68` — 设计文档声称 `Mat4x4<Float64, Defaultp>(1.0)` 创建"单位矩阵 I"（`type_mat4x4.cj:27-32` 将所有 16 个元素置为标量，并非仅对角线为 1）。所幸 `testRotateExt90Z` 中被检查的特定元素（c0.y、c1.x、c2.z、c3.w）在 `Rot * I` 与 `Rot * all1s` 下值一致，测试结果未受影响，但描述有误。

## 修改要求

1. `cjglm/tests/glm/ext/matrix_transform_test.cj:84`：将 `@Expect(r.c1.y, 2.0)` 修正为 `@Expect(r.c1.y, 1.0)`，或重新验证该测试的预期值。
2. `detail_v1.md:68`：修正对 `Mat4x4(1.0)` 的表述——该构造函数生成的并非单位矩阵。

## 新增测试用例评价

3 个新增测试（`testRotateExtLeftMultiply`、`testRotateExtZeroAxisNonIdentity`、`testShearExtLeftMultiply`）设计正确，使用非单位矩阵输入（平移矩阵）验证左乘语义，期望值与 `m * Rot` / `m * H` 的数学计算结果一致，覆盖正常路径和零轴边界条件。
