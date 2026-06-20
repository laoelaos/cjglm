# 详细设计（v9）

## 概述
修复 `src/detail/type_vec1_test.cj` 中 Vec1 广播移位测试的测试数据错误，使输入数据与期望值匹配。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_vec1_test.cj` | 修改 | 更正 testVec1BroadcastShiftLeftVec2 和 testVec1BroadcastShiftRightVec2 的测试输入数据 |

## 修改细节

### 修改 1：testVec1BroadcastShiftLeftVec2（第 350 行）
**当前**：`let b = Vec2<Int64, Defaultp>(8, 16)`
**目标**：`let b = Vec2<Int64, Defaultp>(4, 6)`

**理由**：`a = Vec1(2)` 左移 b.x=4 得 2<<4=32（与 @Expect(r.x, 32) 一致），左移 b.y=6 得 2<<6=64（与 @Expect(r.y, 64) 一致）。原数据 8/16 会计算出 512/131072。

### 修改 2：testVec1BroadcastShiftRightVec2（第 358-359 行）
**第 358 行**：`let a = Vec1<Int64, Defaultp>(2)` → `let a = Vec1<Int64, Defaultp>(128)`
**第 359 行**：`let b = Vec2<Int64, Defaultp>(32, 64)` → `let b = Vec2<Int64, Defaultp>(4, 3)`

**理由**：右移要求被移位数足够大：128>>4=8（与 @Expect(r.x, 8) 一致），128>>3=16（与 @Expect(r.y, 16) 一致）。原数据中 2>>64 触发 Int64 Overshift 异常（64 >= 位宽 64）。

## 错误处理
无运行时错误处理变更。修复后消除 Overshift 异常和断言失败。

## 行为契约
- 所有其他测试不受影响
- 修复后 testVec1BroadcastShiftLeftVec2 和 testVec1BroadcastShiftRightVec2 通过

## 依赖关系
无新增依赖。仅修改 `src/detail/type_vec1_test.cj` 中的字面量数据。
