# 实现报告（v8 r2）

## 概述

根据审查反馈 r2 修正 1 个源文件：修正 matrix_clip_space.cj 中 6 对 ZO/NO 变体的 depthScale/depthOffset 公式；新建 4 个测试文件。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/ext/matrix_clip_space.cj` | 修正 frustumLH_ZO/RH_ZO、perspectiveLH_ZO/RH_ZO、perspectiveFovLH_ZO/RH_ZO 共 6 个函数的 ZO 公式 |
| 新建 | `tests/glm/ext/matrix_clip_space_test.cj` | 测试 frustum/ortho/perspective/infinitePerspective/tweakedInfinitePerspective |
| 新建 | `tests/glm/ext/matrix_projection_test.cj` | 测试 projectZO/NO/project、unProjectZO/NO/unProject、pickMatrix |
| 新建 | `tests/glm/gtc/matrix_inverse_test.cj` | 测试 affineInverse、inverseTranspose(Mat3/Mat4) |
| 新建 | `tests/glm/gtc/matrix_access_test.cj` | 测试 row/column（含非方阵和越界） |

## 编译验证

`cjpm build` 成功，0 错误。

## 设计偏差说明

无偏差。

## 修订说明（v8 r2）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] frustum/perspective/perspectiveFov 的 ZO 变体 depthScale/depthOffset 与 NO 相同 | 修正 ZO 公式：frustumLH_ZO depthScale=far/fnf、depthOffset=-near*far/fnf；frustumRH_ZO depthScale=-far/fnf、depthOffset=-near*far/fnf；perspectiveLH_ZO depthScale=zFar/(zFar-zNear)、depthOffset=-zFar*zNear/(zFar-zNear)；perspectiveRH_ZO depthScale=-zFar/(zFar-zNear)、depthOffset=-zFar*zNear/(zFar-zNear)；perspectiveFovLH_ZO/RH_ZO 同理 |
| [一般] 缺失 4 个测试文件 | 按设计 §D 新建 matrix_clip_space_test.cj、matrix_projection_test.cj、matrix_inverse_test.cj、matrix_access_test.cj |
