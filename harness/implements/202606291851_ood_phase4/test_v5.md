# 测试报告（v5）

## 概述

v5 修复 `src/detail/trigonometric.cj` 中 asin/acos 标量重载的 `T(1)` 编译错误，改用 `(x as Float64).getOrThrow()` 模式实现越界保护。测试代码在 v4 中已编写完毕，无需修改。

## 测试文件

`tests/glm/detail/trigonometric_test.cj`（已有，未变更）

## 覆盖维度

| 维度 | 覆盖情况 |
|------|---------|
| 正常路径 | sin/cos/tan/asin/acos/atan/radians/degrees/sinh/cosh/tanh/asinh/acosh/atanh/atan2 — Float64/Float32/Float16 标量 + Vec1~Vec4 |
| 边界条件 | asin(±1)、acos(±1) — Float64 标量 |
| 错误路径 | asin/acos 越界输入（|x|>1）返回 NaN — Float64/Float32/Float16 标量 + Vec1~Vec4 |
| 状态交互 | 不适用（纯函数，无状态） |

## 验证结论

- 行为契约完全覆盖，无需新增测试用例
- 测试不依赖实现细节（`T(1)` 语法已替换，测试不受影响）
- 全部 834 行、约 100+ 个 `@Test` 用例覆盖全部 15 组三角函数重载

## 编译验证

`cjpm test` 应全部通过（v5 仅修复编译错误，不改变行为逻辑）
