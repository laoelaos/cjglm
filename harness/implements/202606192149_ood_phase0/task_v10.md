# 任务指令（v10）

## 动作
RETRY

## 任务描述
修正 `testVec1BroadcastShiftLeftVec2` 及其相关测试的测试数据 math 错误：`b.y` 从 `6` 改为 `5`，使 `2 << 5 = 64` 正确匹配 `@Expect(r.y, 64)`。

涉及文件（共 2 个文件，3 处修改）：
1. `src/detail/type_vec1_test.cj:350` — `b = Vec2<Int64, Defaultp>(4, 6)` → `(4, 5)`
2. `tests/glm/detail/test_type_vec1_broadcast_shift.cj:6` — `testVec1BroadcastShiftLeftVec2Fixed` 中 `b = Vec2<Int64, Defaultp>(4, 6)` → `(4, 5)`
3. `tests/glm/detail/test_type_vec1_broadcast_shift.cj:114` — `testVec1BroadcastShiftLeftVec2PackedHighp` 中 `b = Vec2<Int64, PackedHighp>(4, 6)` → `(4, 5)`

## 选择理由
v9 验证报告显示 302/303 通过，唯一失败项为 `testVec1BroadcastShiftLeftVec2`:
- `Expect Failed: (r.y == 64)`, left: 128, right: 64
- 原因：`a=2 << b.y=6 = 128`，但期望 `64`（对应 `2 << 5 = 64`）
- `testVec1BroadcastShiftRightVec2` 已在 v9 修复通过

同一 math 错误存在于新增的 `test_type_vec1_broadcast_shift.cj` 中的 `testVec1BroadcastShiftLeftVec2Fixed` 和 `testVec1BroadcastShiftLeftVec2PackedHighp` 中。

## 任务上下文
- 验证报告 v9: 302/303 PASSED, 1 FAILED
- 失败测试: `testVec1BroadcastShiftLeftVec2` (line 348)
- 失败信息: `Expect Failed: (r.y == 64)` left: 128, right: 64
- 根本原因: `b.y = 6` 计算 `2 << 6 = 128`，但期望 `64 = 2 << 5`

## 已有代码上下文
- `src/detail/type_vec1_test.cj:348-353`: `a=2, b=Vec2(4,6), expects (32,64)`
- `tests/glm/detail/test_type_vec1_broadcast_shift.cj:5-9`: `a=2, b=Vec2(4,6), expects (32,64)` 
- `tests/glm/detail/test_type_vec1_broadcast_shift.cj:113-117`: `a=2, b=Vec2(4,6) with PackedHighp, expects (32,64)`

## RETRY 说明
前次失败原因：`testVec1BroadcastShiftLeftVec2` 的修复方案存在 math 错误：
- v9 将 `b` 从 `(8, 16)` 改为 `(4, 6)`，但 `2 << 6 = 128 ≠ 64`
- 正确值：`b.y = 5` → `2 << 5 = 64` ✓

修正方向：
- 3 处 `b.y` 值从 `6` 改为 `5`
- 预期值 `(32, 64)` 保持不变
- 其他测试不受影响
