# 测试报告（v6）

## 概述

对标详细设计 `detail_v6.md`，在已有 44 个测试用例基础上补充 14 个，覆盖边界条件和错误路径。共 58 个测试用例覆盖全部 17 个函数。

## 文件变更

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `tests/glm/ext/scalar_common_test.cj` | 58 个测试用例（原 44 + 新增 14） |

## 测试覆盖矩阵

| 分组 | 函数 | 已有用例数 | 新增用例数 | 总用例数 | 覆盖维度 |
|------|------|-----------|-----------|---------|---------|
| 1 | `min<T>(a,b,c)` | 1 | 1 | 2 | 正常 + 等值边界 |
| 1 | `min<T>(a,b,c,d)` | 1 | 1 | 2 | 正常 + 等值边界 |
| 1 | `max<T>(a,b,c)` | 1 | 1 | 2 | 正常 + 等值边界 |
| 1 | `max<T>(a,b,c,d)` | 1 | 1 | 2 | 正常 + 等值边界 |
| 2 | `fmin<T>(a,b)` | 3 | 0 | 3 | 正常 + NaN 首/次 |
| 2 | `fmin<T>(a,b,c)` | 3 | 0 | 3 | NaN 首/中/尾 |
| 2 | `fmin<T>(a,b,c,d)` | 4 | 0 | 4 | 混合 NaN + 全 NaN + 仅首正常 |
| 3 | `fmax<T>(a,b)` | 3 | 0 | 3 | 正常 + NaN 首/次 |
| 3 | `fmax<T>(a,b,c)` | 3 | 0 | 3 | NaN 首/中/尾 |
| 3 | `fmax<T>(a,b,c,d)` | 4 | 0 | 4 | 混合 NaN + 全 NaN + 仅首正常 |
| 4 | `fclamp<T>(x,min,max)` | 3 | 2 | 5 | 正常上/中/下 + NaN minVal + NaN maxVal |
| 5 | `clamp<T>(Texcoord)` | 3 | 2 | 5 | 正常上/中/下 + 边界 0 + 边界 1 |
| 5 | `repeat<T>(Texcoord)` | 2 | 1 | 3 | 正/负 + 零边界 |
| 5 | `mirrorClamp<T>(Texcoord)` | 2 | 0 | 2 | 正/负 |
| 5 | `mirrorRepeat<T>(Texcoord)` | 3 | 1 | 4 | 正内/正镜/负 + 零边界 |
| 6 | `iround<T>(x)` | 4 | 2 | 6 | 上/下/半/负 + 零 + 负零 |
| 6 | `uround<T>(x)` | 3 | 2 | 5 | 上/下/半 + 零 + 负数抛异常 |

## 新增测试用例说明

| 测试函数 | 被测函数 | 覆盖场景 | 设计依据 |
|---------|---------|---------|---------|
| `testMin3Tie` | `min(a,b,c)` | 等值输入——前两个相等 | 行为契约：等值时返回第一个最小 |
| `testMax3Tie` | `max(a,b,c)` | 等值输入——前两个相等 | 行为契约：等值时返回第一个最大 |
| `testMin4Tie` | `min(a,b,c,d)` | 等值输入——前两个相等 | 行为契约：等值时返回第一个最小 |
| `testMax4Tie` | `max(a,b,c,d)` | 等值输入——前两个相等 | 行为契约：等值时返回第一个最大 |
| `testIroundZero` | `iround(x)` | 正零输入 | 行为契约：正负零边界均正确 |
| `testIroundNegZero` | `iround(x)` | 负零输入 | 行为契约：正负零边界均正确 |
| `testUroundZero` | `uround(x)` | 正零输入 | 行为契约：正负零边界均正确 |
| `testUroundNeg` | `uround(x)` | 负数输入 | 错误处理：抛出 ArithmeticException |
| `testFclampNaNMinVal` | `fclamp(x,min,max)` | minVal 为 NaN | 错误处理：经 fmin/fmax 链传播 NaN |
| `testFclampNaNMaxVal` | `fclamp(x,min,max)` | maxVal 为 NaN | 错误处理：经 fmin/fmax 链传播 NaN |
| `testRepeatZero` | `repeat(x)` | 零输入 | 边界条件 |
| `testClampTexcoordAtZero` | `clamp(x)` | 恰好为 0 | 边界条件 |
| `testClampTexcoordAtOne` | `clamp(x)` | 恰好为 1 | 边界条件 |
| `testMirrorRepeatZero` | `mirrorRepeat(x)` | 零输入 | 边界条件 |

## 修订说明（v6 r3）

| 审查意见 | 修改措施 |
|---------|---------|
| 新增 14 个测试用例覆盖：等值 min/max、fclamp NaN 传播、iround/uround 零边界、uround 负数抛异常、纹理环绕零边界 | `tests/glm/ext/scalar_common_test.cj` — 追加 14 个 `@Test` 函数，不修改已有测试和源码 |
