# 测试审查报告（v8 r2）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/ext/matrix_clip_space_test.cj` — 测试覆盖矩阵中缺失 perspectiveFov（9 个函数）、infinitePerspective（7 个函数）、tweakedInfinitePerspective（2 个函数）共 18 个函数的测试。设计文档（A.3 节）明确将这些列为独立函数族，各有独立的 depthScale/depthOffset 公式。零覆盖意味着这些函数中的公式错误、符号错误或类型转换问题均无法被检测到。

- **[轻微]** `tests/glm/ext/matrix_projection_test.cj` — 缺少对 `project`（通用版本）和 `unProject`（通用版本）的测试。虽然它们分别委托给 ZO 变体，但作为独立公开 API 仍应验证委托正确性。

## 修改要求

1. `tests/glm/ext/matrix_clip_space_test.cj`：至少为 perspectiveFov、infinitePerspective、tweakedInfinitePerspective 各新增一个正向测试用例，验证返回值结构正确（4x4 矩阵不包含 NaN/Inf）、关键元素符号和大小符合预期。可参考已有 perspective_RH_NO 测试的断言方式。
2. `tests/glm/ext/matrix_projection_test.cj`：为 `project` 和 `unProject`（通用版本）各新增一个基本正向测试，验证与对应 ZO 变体的等价性。
