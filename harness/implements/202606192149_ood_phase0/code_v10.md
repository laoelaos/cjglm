# 实现报告（v10）

## 概述
根据详细设计 v10，修复 `testVec1BroadcastShiftLeftVec2` 及相关测试的测试数据数学错误：将 3 处 `b.y` 从 `6` 改为 `5`，使 `2 << 5 = 64` 正确匹配 `@Expect(r.y, 64)`。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/type_vec1_test.cj:350` | `b.y`: `6` → `5` |
| 修改 | `tests/glm/detail/test_type_vec1_broadcast_shift.cj:6` | `b.y`: `6` → `5` |
| 修改 | `tests/glm/detail/test_type_vec1_broadcast_shift.cj:114` | `b.y`: `6` → `5` |

## 编译验证
`cjpm build` 成功，仅含已有 warning（4 个 shadowed import 警告，与本次变更无关）。

## 设计偏差说明
无偏差。
