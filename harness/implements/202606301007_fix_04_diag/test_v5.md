# 测试报告（v5）

## 测试文件

`cjglm/tests/glm/ext/scalar_common_test.cj`

## 测试策略

基于行为契约编写，验证 `iround`/`uround` 公开接口在 `roundT` 委托路径下的行为等价性。不测实现细节。

## 测试覆盖

| 维度 | 用例 | 说明 |
|------|------|------|
| 正常路径（Float64） | `testIroundUp/Down/Half/Negative/Zero/NegZero`, `testUroundUp/Down/Half/Zero` | 已有，覆盖四舍五入正向/负向/零值 |
| 正常路径（Float32） | `testIroundFloat32Up/Down/Half/Negative/Zero`, `testUroundFloat32Up/Down/Half/Zero` | 新增，验证 `roundT` 泛型对 Float32 正确工作 |
| 正常路径（Float16） | `testIroundFloat16Up/Half/NegativeHalf`, `testUroundFloat16Up/Half/Zero` | 新增，验证 `roundT` 泛型对 Float16 正确工作 |
| 边界条件 | `testIroundZero`, `testIroundNegZero`, `testUroundZero`, `testIroundFloat32Zero`, `testUroundFloat32Zero`, `testIroundFloat16Half`, `testUroundFloat16Half` | 零值/负零/半值边界 |
| 错误路径 | `testUroundNeg`（Float64）, `testUroundFloat32NegThrows` | 负值 `uround` 应抛出 `ArithmeticException` |

## 新增用例清单

共新增 **17** 个测试用例：

| # | 用例名 | 输入 | 预期结果 |
|---|--------|------|---------|
| 1 | testIroundFloat32Up | `iround(Float32(3.7))` | `Int64(4)` |
| 2 | testIroundFloat32Down | `iround(Float32(3.2))` | `Int64(3)` |
| 3 | testIroundFloat32Half | `iround(Float32(3.5))` | `Int64(4)` |
| 4 | testIroundFloat32Negative | `iround(Float32(-2.3))` | `Int64(-2)` |
| 5 | testIroundFloat32Zero | `iround(Float32(0.0))` | `Int64(0)` |
| 6 | testIroundFloat16Up | `iround(Float16(3.7))` | `Int64(4)` |
| 7 | testIroundFloat16Half | `iround(Float16(2.5))` | `Int64(3)` |
| 8 | testIroundFloat16NegativeHalf | `iround(Float16(-2.5))` | `Int64(-2)` |
| 9 | testUroundFloat32Up | `uround(Float32(3.7))` | `UInt64(4)` |
| 10 | testUroundFloat32Down | `uround(Float32(3.2))` | `UInt64(3)` |
| 11 | testUroundFloat32Half | `uround(Float32(3.5))` | `UInt64(4)` |
| 12 | testUroundFloat32Zero | `uround(Float32(0.0))` | `UInt64(0)` |
| 13 | testUroundFloat32NegThrows | `uround(Float32(-1.0))` | `ArithmeticException` |
| 14 | testUroundFloat16Up | `uround(Float16(3.7))` | `UInt64(4)` |
| 15 | testUroundFloat16Half | `uround(Float16(2.5))` | `UInt64(3)` |
| 16 | testUroundFloat16Zero | `uround(Float16(0.0))` | `UInt64(0)` |

## 设计偏差说明

无偏差。所有测试仅基于公开签名和行为契约，不依赖实现细节。
