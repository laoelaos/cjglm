# 计划审查报告（v9 r1）

## 审查结果
REJECTED

## 发现

### **[一般]** task_v9.md 中边界测试用例假设与 `std.math.fmod` 实际行为不符

task_v9.md 第 73 行建议的 `testScalarModVec1Float32ByZero` 测试：
```
testScalarModVec1Float32ByZero：mod(Float32(1.0), Vec1<Float32,Defaultp>(0.0)) — 验证 fmod 返回 NaN 或 Inf（标准库定义行为）
```

但根据 `std.math.fmod` 标准库文档（`math_package_funcs.md:2633`），`fmod` 在 y 为 0 或 x 为 Inf 时抛出 `IllegalArgumentException`，而非返回 NaN 或 Inf。这意味着：
1. `mod(Float32(1.0), Vec1<Float32,Defaultp>(0.0))` 会抛出异常，而不是返回包含 NaN/Inf 的 Vec
2. 若按 task_v9.md 建议的原样实现该测试（假设返回 NaN/Inf），测试将失败
3. 正确做法应是 `@ExpectThrows[IllegalArgumentException]`

此外，测试还要考虑 `fmod` 对 `Inf` 也抛异常的行为，现有的 `testScalarDivVec1Float32ByZero`（第 233-237 行, `div` 使用 `/` 返回 Inf）与 `mod` 不同——`mod` 对零除和 Inf 均抛异常，不能沿用 div 的测试模式。

这属于 Planner 产出的任务文件中测试设计的错误假设，若直接实施会导致测试阶段失败。

## 修改要求（仅 REJECTED 时）

1. **修正边界测试设计**：task_v9.md 第 72-76 行的边界测试建议需要修正：
   - `testScalarModVec1Float32ByZero` 应改为验证抛出 `IllegalArgumentException`：`@ExpectThrows[IllegalArgumentException](mod(Float32(1.0), Vec1<Float32,Defaultp>(0.0)))`
   - `testScalarModVec1Float32Negative`（负操作数取模）不受影响，fmod 处理负数与 C++ GLM 一致，可保留
   - `testScalarModVec1Float64ByZero` 同上，应改为 `@ExpectThrows[IllegalArgumentException]`
   - 新增 `testScalarModVec1Float32InfDividend`：`mod(Float32.Inf, Vec1<Float32,Defaultp>(1.0))` 也抛出 `IllegalArgumentException`
