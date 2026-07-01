# 代码审查报告（v8 r2）

## 审查结果
REJECTED

## 发现

- **[严重]** `src/ext/matrix_clip_space.cj` — 所有 ZO 变体的 depthScale/depthOffset 公式与 NO 变体完全相同，导致 ZO（[0,1] Z 范围）和 NO（[-1,1] Z 范围）在功能上无区别。影响以下 12 个函数：
  - `frustumLH_ZO` vs `frustumLH_NO`（depthScale、depthOffset 相同）
  - `frustumRH_ZO` vs `frustumRH_NO`（depthScale、depthOffset 相同）
  - `perspectiveLH_ZO` vs `perspectiveLH_NO`（depthScale、depthOffset 相同）
  - `perspectiveRH_ZO` vs `perspectiveRH_NO`（depthScale、depthOffset 相同）
  - `perspectiveFovLH_ZO` vs `perspectiveFovLH_NO`（depthScale、depthOffset 相同）
  - `perspectiveFovRH_ZO` vs `perspectiveFovRH_NO`（depthScale、depthOffset 相同）

  设计明确要求（§A.3）ZO 使用 zNear→0,zFar→1 映射、NO 使用 [-1,1] 映射，但代码未推导出正确的 ZO 公式。正确的公式应为：
  - frustumLH_ZO: depthScale = far/(far-near), depthOffset = -near\*far/(far-near)
  - frustumRH_ZO: depthScale = -far/(far-near), depthOffset = -near\*far/(far-near)
  - perspectiveLH_ZO: depthScale = zFar/(zFar-zNear), depthOffset = -zNear\*zFar/(zFar-zNear)
  - perspectiveRH_ZO: depthScale = -zFar/(zFar-zNear), depthOffset = -zNear\*zFar/(zFar-zNear)
  (perspectiveFov 同理)

- **[一般]** 设计 §D 要求的 4 个测试文件缺失：
  - `tests/glm/ext/matrix_clip_space_test.cj`
  - `tests/glm/ext/matrix_projection_test.cj`
  - `tests/glm/gtc/matrix_inverse_test.cj`
  - `tests/glm/gtc/matrix_access_test.cj`

  设计明确要求"为所有变更相应编写/更新测试"，这些文件完全不存在，没有对应的测试覆盖。

## 修改要求（仅 REJECTED 时）

1. **[严重]** `src/ext/matrix_clip_space.cj` — 修正所有 ZO 变体的 depthScale/depthOffset 公式为正确的 ZO 值（见上）。同时验证 `infinitePerspective` 的 ZO/NO 变体是否需要独立公式（当前两者共用同一实现）。修正后需 `cjpm build` 编译通过。

2. **[一般]** 按设计 §D 新建 4 个测试文件，为 matrix_clip_space、matrix_projection、matrix_inverse、matrix_access 提供基本的正确性测试（对每个主要函数至少一个 @Test 用例）。
