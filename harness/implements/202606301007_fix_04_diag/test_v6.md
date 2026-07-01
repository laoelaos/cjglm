# 测试报告（v6）

## 测试文件
`cjglm/tests/glm/lib_test.cj`（追加）

## 测试内容

### 新增用例

| 测试函数 | 维度 | 描述 |
|---------|------|------|
| `testLibDquatCompatibleWithGtcType` | 类型兼容性 | 验证 `dquat` 可赋值给 `detail.Quat<Float64, Defaultp>`，证明 gtc 版本类型兼容 |
| `testLibDquatWorksWithExtConjugate` | 正常操作 | 验证 `dquat` 实例调用 `conjugate` 函数结果正确 |
| `testLibDquatWorksWithGtcEulerAngles` | 正常操作 | 验证 `dquat` 实例调用 `eulerAngles` 函数可用（期望抛异常，与已有 `testLibGtcEulerAnglesAccessible` 行为一致） |

### 受覆盖的行为契约

1. **正常路径**: `dquat` 可通过 `lib.cj` 构造（已有 `testLibExtDquatAliasAccessible`）
2. **边界条件**: `dquat` 与 `detail.Quat<Float64, Defaultp>` 类型兼容（新增 `testLibDquatCompatibleWithGtcType`）
3. **状态交互**: `dquat` 实例可用于 ext 和 gtc 操作函数（新增 `testLibDquatWorksWithExtConjugate`、`testLibDquatWorksWithGtcEulerAngles`）
4. **错误路径**: 无（纯类型删除，无运行时错误场景）

### 已有测试影响

`testLibExtDquatAliasAccessible`（`lib_test.cj:425`）— 无影响，因 `lib.cj` 仍通过 gtc 导入导出 `dquat`。

## 审查修订说明

| 审查意见 | 处理方式 | 说明 |
|---------|---------|------|
| **[严重]** `testLibDquatWorksWithExtConjugate` 中 `@Expect(c.x, -Float64(2.0))` 期望值错误 | 已修正 | 改为 `@Expect(c.x, -Float64(1.0))`。`conjugate` 实现为 `Quat(-q.x, -q.y, -q.z, q.w)`，输入 `q.x=1.0` 时 `c.x=-1.0`。 |
| **[轻微]** `testLibDquatWorksWithGtcEulerAngles` 使用 `@Expect(true, true)` 占位断言 | 已修正 | 改为 `@ExpectThrows[Exception](eulerAngles(q))`，与已有 `testLibGtcEulerAnglesAccessible` 一致，验证 `dquat` 类型的 `eulerAngles` 行为与 `Quat<Float64, Defaultp>` 相同。 |
