# 详细设计（v7）

## 概述

修复 `gtc/round.cj` 中 `roundPowerOfTwo`、`ceilPowerOfTwo`、`floorPowerOfTwo` 三个函数的 ±0 输入丢失负零符号问题（G9）。三个函数的零值分支均使用 `(Float64(0) as T).getOrThrow()` 构造返回值，这始终返回 +0，丢失了输入负零的符号位。改为直接返回 `x` 以保留原始符号位。同步更新 `04_diag.md` 修复标记、补充测试、更新 plan.md 路线表。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/gtc/round.cj:10,31,49` | 修改 | 三个函数的零值分支 `return (Float64(0) as T).getOrThrow()` 改为 `return x` |
| `../../docs/diag/impl/04_diag.md:483` | 修改 | G9 条目追加 `✅ 已修复` |
| `cjglm/tests/glm/gtc/round_test.cj` | 修改 | 为每个受影响函数添加 -0.0 输入测试，使用位模式对比验证符号位保留 |
| `plan.md` 路线表 | 修改 | P2-5 行的 v7 列打 ✅ 确认完成 |

## 类型定义

无新增/修改类型。仅修改函数体中的返回值表达式。

### 被修改的函数

| 函数 | 包路径 | 当前零值分支代码 | 改为 | 说明 |
|------|-------|-----------------|------|------|
| `roundPowerOfTwo` | `glm.gtc` | `return (Float64(0) as T).getOrThrow()` | `return x` | 当 `xF64 == 0.0` 时直接返回原始输入 `x`，保留 ±0 符号 |
| `ceilPowerOfTwo` | `glm.gtc` | `return (Float64(0) as T).getOrThrow()` | `return x` | 同上，仅修改 `xF64 == 0.0` 分支（line 30-32），不修改 `xF64 < 0.0` 分支（line 33-35，该分支应返回 +0） |
| `floorPowerOfTwo` | `glm.gtc` | `return (Float64(0) as T).getOrThrow()` | `return x` | 当 `xF64 == 0.0` 时直接返回原始输入 `x` |

## 错误处理

无变更。不涉及错误处理逻辑。

## 行为契约

- **前置条件**：无变更
- **后置条件**：当输入为 `-0.0` 时，三个函数均返回 `-0.0`（而非之前的 +0），与 IEEE 754 和 GLM 1.0.3 行为一致
- **兼容性**：不影响正零行为（`+0.0` 输入仍返回 `+0.0`）。仅修复 -0.0 输入场景，属于正确的行为修正

## 测试方案

### -0.0 符号保留测试

由于 `@Expect` 底层使用 `==`，而 IEEE 754 规定 `-0.0 == 0.0` 为 true，不能直接用 `@Expect(func(-0.0), -0.0)` 验证。

改为使用位模式对比：通过 `toBits()` 将浮点数转为位模式后用 `==` 比较（±0 位模式不同：+0 = `0x0000000000000000`，-0 = `0x8000000000000000`）：

| 测试 | 断言 |
|------|------|
| `testRoundPowerOfTwoNegZero` | `@ExpectTrue(roundPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())` |
| `testCeilPowerOfTwoNegZero` | `@ExpectTrue(ceilPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())` |
| `testFloorPowerOfTwoNegZero` | `@ExpectTrue(floorPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())` |

每个函数应添加独立的 `@Test` 用例，与现有零值测试（使用 `+0.0` 输入）并列，保持测试原子性。

## 依赖关系

| 修改文件 | 新增依赖 | 移除了依赖 |
|---------|---------|-----------|
| `gtc/round.cj` | 无 | 无（仅修改返回值表达式） |
| `04_diag.md` | 无 | 无 |
| `round_test.cj` | 无 | 无（使用已有的 `toBits()` 方法，`FloatingPoint` trait 自带） |
| `plan.md` | 无 | 无 |
