# 实现报告（v6）

## 概述

修复 G2.1：将 `quaternion_common.cj:40` 中 `slerp` 第 4 参数从 `spin: Bool` 改为 `k: Int64`，并在测试文件中追加 3 个 `@Test` 用例覆盖该签名的 stub 异常路径。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `cjglm/src/ext/quaternion_common.cj:40` | `slerp` 第 4 参数 `spin: Bool` → `k: Int64` |
| 追加 | `cjglm/tests/glm/ext/quaternion_common_test.cj` | 添加 `testSlerp4ArgsK0`、`testSlerp4ArgsK1`、`testSlerp4ArgsKMinus1` |

## 编译验证

`cjpm build` 成功（0 errors，仅有已有 warnings）。

## 设计偏差说明

无偏差。
