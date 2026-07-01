# 测试报告（v9 r1）

## 文件变更

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修订 | `tests/glm/gtc/ulp_test.cj` | testUlpBoundary 增加 Float32.nan / Float64.nan 断言（审查意见 #1） |
| 修订 | `tests/glm/gtc/round_test.cj` | testRoundMultiple/testCeilMultiple/testFloorMultiple 增加 NaN/Inf/负数用例（审查意见 #2） |
| 新建 | `tests/glm/gtc/packing_test.cj` | 4 个 @Test（packUnorm/packSnorm/packHalf/packDouble 互逆） |

## 审查修订说明

| 审查意见 | 采纳 | 修改措施 |
|---------|------|---------|
| [#1] ulp_test testUlpBoundary 缺少 NaN 边界 | 是 | 增加 `@Expect(ulp(Float32.nan).isNaN(), true)` 和 `@Expect(ulp(Float64.nan).isNaN(), true)` |
| [#2] round_test multiple 系族缺少 NaN/Inf/负数覆盖 | 是 | roundMultiple 增加负数/NaN/Inf；ceilMultiple 增加负数；floorMultiple 增加负数 |
