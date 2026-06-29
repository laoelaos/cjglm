# 设计审查报告（v1 r1）

## 审查结果
REJECTED

## 发现

### **[严重]** — 无

### **[一般]**

1. **三角函数 stub 测试使用不存在的 `assertThrows` 函数**
   - 设计 §测试方案 中指定 `assertThrows(() => sin<Float32>(0.0f), Exception("stub"))` 来验证 stub 函数抛异常
   - 仓颉 `std.unittest` 不提供 `assertThrows` 函数，而是通过 `@AssertThrows[ExType](expr)` 和 `@ExpectThrows[ExType](expr)` 宏实现
   - 此差异将导致测试代码编译失败
   - 期望修正：使用 `@ExpectThrows[Exception](expr)` 宏替换

2. **Int64 编译拒绝测试方案未确认**
   - 设计 §测试方案中标注"待确认 cjpm 支持的验证方式"
   - 任务明确要求"验证 Int64 实例化 scalar_constants 编译拒绝（预期编译错误）"
   - 设计未提供具体实施路径（如：外部编译脚本验证、build.cj 集成、或文档化为已知限制）
   - 期望修正：给出明确的测试策略或替代方案

### **[轻微]**

1. **测试代码片段中 Float32 字面量语法可能无效**
   - 设计测试示例使用 `0.0f` 作为 Float32 字面量
   - 项目中现有代码统一使用 `0.0f32` 语法（参见 `compute_vector_decl_test.cj:314`）
   - 建议统一为 `0.0f32` 避免歧义

2. **测试文件 package 声明未明确**
   - 设计未指定 `test_scalar_constants.cj` 和 `test_trigonometric_stub.cj` 的 package 声明
   - 根据现有测试文件惯例（如 `test_shim_limits.cj:1` 使用 `package glm.detail`），应保持一致

3. **scalar_constants.cj 代码片段 import 不完整**
   - 设计仅展示 `import std.math.FloatingPoint`
   - 实现中依赖 `Float32`/`Float64` 类型和 `epsilonOf` 函数（同包，无需额外 import），但若使用 `match(T(Float64(0)))` 模式，需确保 `Float32`/`Float64` 在作用域内（std.core 自动导入，通常可用）
   - 建议在代码片段或依赖表中明确说明

## 修改要求

1. **[一般]** §测试方案「test_trigonometric_stub.cj」：将 `assertThrows(() => ..., Exception("stub"))` 替换为 `@ExpectThrows[Exception](...)`，并修正 Float32 字面量语法
2. **[一般]** §测试方案「test_scalar_constants.cj」第 5 项：给出 Int64 编译拒绝测试的明确实施策略（例如：单独的 build 脚本验证编译失败、或确认 cjpm 支持的验证方式后写入设计）
