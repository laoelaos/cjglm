# 任务指令（v15）

## 动作
NEW

## 任务描述
补充 `tests/glm/gtc/matrix_transform_test.cj` 中 ext 重导出函数的 gtc 入口委托路径测试（G31），覆盖以下 9 个函数：`rotate`、`scale`、`shear`（ext 三 Vec2 版本）、`lookAt`、`lookAtRH`、`lookAtLH`、`frustum`、`perspective`、`pickMatrix`

完成后更新 `docs/diag/impl/04_diag.md` 标记 G31 为 ✅ 已修复，并更新 `plan.md` 路线表 v15 列标记 P4-3 ✅

## 选择理由
v14 已完成 P4-3 次批（G25/G26 vector_common_test 维度补全）。P4-3（ext 测试补充）剩余 G31 未完成——这是 ext 测试补充批次的最后一环，验证 gtc 命名空间下的 ext 重导出函数能正确委托到 ext 实现。修改范围集中在单个测试文件，风险低、自包含。

## 任务上下文
- 04_diag.md:368-377 描述了 G31 问题：gtc/matrix_transform_test.cj 中 ext 重导出函数缺乏 gtc 入口测试
- 当前只有 `testTranslateViaExt`（:124-131）和 `testOrthoViaExt`（:134-138）两个 gtc 入口测试
- gtc 层自有实现（非重导出）的 5 个函数已有独立测试：`identity`、`shear`（n+s 版本）、`rotate_slow`、`scale_slow`、`shear_slow`
- 每新增一个测试函数都应通过 gtc 命名空间调用（如 `rotate(m, angle, axis)`、`scale(m, v)` 等），验证结果矩阵关键元素

## 已有代码上下文
- `cjglm/src/gtc/matrix_transform.cj:3`：`public import glm.ext.*`
- 当前测试文件 `tests/glm/gtc/matrix_transform_test.cj` 已包含 gtc 自有实现的测试和 translate/ortho 两个 gtc 入口委托测试
- 参考已有测试写法：`testTranslateViaExt` 使用 `let r = translate(m, v)` 直接在 gtc 包级调用，验证结果矩阵的特定元素
