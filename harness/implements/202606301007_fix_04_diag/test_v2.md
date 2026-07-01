# 测试报告（v2）

## 概述

按 `detail_v2.md` 行为契约编写单元测试。覆盖 P1-2（float_distance NaN/Inf + 负浮点边界）、P1-3（slerp 最短路径 + 四参数公式）行为契约。

## 新增测试

### ulp_test.cj（P1-2: float_distance）

| 测试函数 | 契约 | 覆盖维度 |
|---------|------|---------|
| `testFloatDistanceNaN` | NaN 输入返回 `Int32.Max` | 错误路径（Float32） |
| `testFloatDistanceInf` | Inf 输入返回 `Int32.Max` | 错误路径（Float32） |
| `testFloatDistanceNaN64` | NaN 输入返回 `Int64.Max` | 错误路径（Float64） |
| `testFloatDistanceInf64` | Inf 输入返回 `Int64.Max` | 错误路径（Float64） |
| `testFloatDistanceNegative` | 负浮点 ULP 距离=1（无符号绝对值） | 边界条件（Float32，位模式 > Int32.Max） |
| `testFloatDistanceNegative64` | 负浮点 ULP 距离=1（无符号绝对值） | 边界条件（Float64） |

### quaternion_common_test.cj（P1-3: slerp）

| 测试函数 | 契约 | 覆盖维度 |
|---------|------|---------|
| `testSlerpShortestPath` | `cosOmega < 0` 时等价于 `slerp(x, -y, a)` | 正常路径（两参数最短路径） |
| `testSlerp4ArgsKZero` | `slerp(x, y, a, 0) == slerp(x, y, a)` | 正常路径（四参数 k=0 退化） |
| `testSlerp4ArgsShortestPath` | `cosOmega < 0` 时等价于 `slerp(x, -y, a, k)` | 正常路径（四参数最短路径） |

## 未新增测试的合约说明

- **P1-4 roundEven**：现有 `common_test.cj` 中 `testRoundEvenToEven`（2.5→2.0）、`testRoundEvenToOdd`（3.5→4.0）已覆盖正确行为，分支反转不改变行为契约，无需新增。
- **P1-1 S1 靶向验证**：靶向编译+运行为 CI 步骤，非单元测试范围。
- **P1-5 S3/S4 期望值修正**：已在首次实现中修正测试文件，无需新增。
- **float_distance 正常路径**：现有 `testFloatDistanceAdjacent` 已覆盖。
- **slerp 正常路径**：现有 `testSlerp` / `testSlerp4ArgsK` 已覆盖端点行为。

## 修订说明

| 审查意见 | 修改措施 |
|---------|---------|
| （首轮） | — |
