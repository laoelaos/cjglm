# 实现报告（v9）

## 概述

为 core 函数库补充测试覆盖，涉及 4 个测试文件、8 个问题（G13-G20）。全部为测试文件变更，未修改生产代码。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `tests/glm/detail/common_test.cj:382-387` | G13: testFractVec4 补充 z/w 断言 |
| 新增 | `tests/glm/detail/exponential_test.cj` | G14: 新增 testSqrtLogEdgeCases 边界测试函数 |
| 新增 | `tests/glm/detail/stdmath_shim_test.cj` | G15: 新增 19 个 Float16 测试函数（logT/exp2T/log2T/cosT/tanT/asinT/acosT/atanT/atan2T/coshT/tanhT/asinhT/acoshT/atanhT/ceilT/roundT/truncT/absT/fmodT） |
| 修改 | `tests/glm/detail/stdmath_shim_test.cj` | G16: 为 10 个 Float32 测试函数补充多组输入值 |
| 新增 | `tests/glm/detail/trigonometric_test.cj` | G17: 新增 3 个三角恒等式验证函数（Float64/Float32/Float16） |
| 新增 | `tests/glm/detail/trigonometric_test.cj` | G18: 新增 4 个 Float16 asin/acos ±1 边界测试函数 |
| 新增 | `tests/glm/detail/trigonometric_test.cj` | G19: 新增 testAtan2SecondBranchFloat16 函数 |
| 修改 | `tests/glm/detail/trigonometric_test.cj` | G20: 将 Vec3/Vec4 全零 asinh/acosh/atanh 测试替换为非零向量测试（6 个函数） |
| 修改 | `docs/diag/impl/04_diag.md:246-300` | 标记 G13-G20 条目末尾添加 ✅ 已修复 |
| 修改 | `harness/implements/202606301007_fix_04_diag/plan.md:10,23` | 路线表添加 v9 列，P4-1 标记 ✅ |

## 编译验证

`cjpm build` 编译通过（仅预存 warnings，无 errors）；`cjpm test` 全部 435 测试通过，0 失败。

## 设计偏差说明

无偏差。发现并标注一处设计细节：
- **G17** 恒等式验证中 pi/2 角度的 identity2 (tan=sin/cos) 和 identity3 (1+tan²=1/cos²) 因 cos(pi/2)≈6.12e-17 和 tan(pi/2)≈1.63e16 的浮点误差可能导致 |identity| < epsilon 断言不稳定。实现中仅对 pi/2 保留了 identity1 (sin²+cos²=1) 的验证，跳过了 identity2/3。此处理已在代码中体现，若测试通过则可确认浮点消去行为符合预期。
