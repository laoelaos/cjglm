# 测试报告（v1）

## 概述
为阶段二的 stub 函数库（common.cj 和 geometric.cj）编写单元测试，验证所有 29 个 stub 函数在被调用时抛出 `Exception("stub")`。

## 测试文件清单

| 文件路径 | 用途 |
|---------|------|
| tests/glm/detail/test_common.cj | 验证 12 个 common 数学 stub 函数 |
| tests/glm/detail/test_geometric.cj | 验证 17 个 geometric 几何 stub 函数 |

## 测试设计

### test_common.cj（12 个用例）

每个函数一个正向用例，验证其作为 stub 的行为契约——调用时抛出 `Exception("stub")`。

| # | 测试函数 | 被测函数 | 类型参数 |
|---|---------|---------|---------|
| 1 | testMinStub | min(Float64, Float64) | T=Float64（满足 Number & Comparable） |
| 2 | testMaxStub | max(Float64, Float64) | T=Float64 |
| 3 | testAbsStub | abs(Float64) | T=Float64 |
| 4 | testSignStub | sign(Float64) | T=Float64 |
| 5 | testFloorStub | floor(Float64) | T=Float64（满足 Number） |
| 6 | testCeilStub | ceil(Float64) | T=Float64 |
| 7 | testFractStub | fract(Float64) | T=Float64 |
| 8 | testModStub | mod(Int64, Int64) | T=Int64（满足 Integer） |
| 9 | testClampStub | clamp(Float64, Float64, Float64) | T=Float64（满足 Number & Comparable） |
| 10 | testMixStub | mix(Float64, Float64, Float64) | T=Float64（满足 Number） |
| 11 | testStepStub | step(Float64, Float64) | T=Float64（满足 Number & Comparable） |
| 12 | testSmoothstepStub | smoothstep(Float64, Float64, Float64) | T=Float64（满足 Number & Comparable） |

### test_geometric.cj（17 个用例）

每个重载一个用例，统一使用 `Float64` 和 `Defaultp` 作为类型参数，验证行为契约——调用时抛出 `Exception("stub")`。

| # | 测试函数 | 被测函数 | 维度 |
|---|---------|---------|------|
| 1 | testDotVec1Stub | dot(Vec1, Vec1) | Vec1 |
| 2 | testDotVec2Stub | dot(Vec2, Vec2) | Vec2 |
| 3 | testDotVec3Stub | dot(Vec3, Vec3) | Vec3 |
| 4 | testDotVec4Stub | dot(Vec4, Vec4) | Vec4 |
| 5 | testCrossStub | cross(Vec3, Vec3) | Vec3 |
| 6 | testNormalizeVec2Stub | normalize(Vec2) | Vec2 |
| 7 | testNormalizeVec3Stub | normalize(Vec3) | Vec3 |
| 8 | testNormalizeVec4Stub | normalize(Vec4) | Vec4 |
| 9 | testLengthVec2Stub | length(Vec2) | Vec2 |
| 10 | testLengthVec3Stub | length(Vec3) | Vec3 |
| 11 | testLengthVec4Stub | length(Vec4) | Vec4 |
| 12 | testDistanceVec2Stub | distance(Vec2, Vec2) | Vec2 |
| 13 | testDistanceVec3Stub | distance(Vec3, Vec3) | Vec3 |
| 14 | testDistanceVec4Stub | distance(Vec4, Vec4) | Vec4 |
| 15 | testReflectVec2Stub | reflect(Vec2, Vec2) | Vec2 |
| 16 | testReflectVec3Stub | reflect(Vec3, Vec3) | Vec3 |
| 17 | testReflectVec4Stub | reflect(Vec4, Vec4) | Vec4 |

## 覆盖维度

- **正常路径**：每个函数至少一个正向用例，验证可调用性
- **边界条件**：N/A（stub 函数无实际计算逻辑）
- **错误路径**：所有用例验证 `Exception("stub")` 被抛出
- **状态交互**：N/A（所有函数为无状态纯函数）

## 测试方法

全部使用 `@ExpectThrows[Exception]` 断言，验证调用 stub 函数时抛出 `Exception`（与设计约定一致）。
