# 详细设计（v10）

## 概述
修复 `testVec1BroadcastShiftLeftVec2` 及其相关测试的测试数据 math 错误：将 `b.y` 从 `6` 改为 `5`，使 `2 << 5 = 64` 正确匹配 `@Expect(r.y, 64)`。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_vec1_test.cj` | 修改 | 第 350 行：`b.y` 从 `6` 改为 `5` |
| `tests/glm/detail/test_type_vec1_broadcast_shift.cj` | 修改 | 第 6 行和第 114 行：`b.y` 从 `6` 改为 `5` |

## 修改清单

### 修改 1：`src/detail/type_vec1_test.cj:350`
**当前**：`let b = Vec2<Int64, Defaultp>(4, 6)`
**目标**：`let b = Vec2<Int64, Defaultp>(4, 5)`
**理由**：`2 << 5 = 64` 匹配 `@Expect(r.y, 64)`；`2 << 6 = 128 ≠ 64`

### 修改 2：`tests/glm/detail/test_type_vec1_broadcast_shift.cj:6`
**当前**：`let b = Vec2<Int64, Defaultp>(4, 6)`
**目标**：`let b = Vec2<Int64, Defaultp>(4, 5)`
**理由**：同上。

### 修改 3：`tests/glm/detail/test_type_vec1_broadcast_shift.cj:114`
**当前**：`let b = Vec2<Int64, PackedHighp>(4, 6)`
**目标**：`let b = Vec2<Int64, PackedHighp>(4, 5)`
**理由**：同上。

## 行为契约
- `@Expect(r.x, 32)` 和 `@Expect(r.y, 64)` 保持不变，均为正确值。
- 其他测试不受影响。

## 错误处理
无变更。

## 依赖关系
无新增依赖。

## 修订说明（v10 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| v9 验证报告：testVec1BroadcastShiftLeftVec2 失败，`b.y=6` 导致 `2<<6=128≠64` | 将 3 处 `b.y` 从 `6` 改为 `5`，使 `2<<5=64` 匹配期望值 |
