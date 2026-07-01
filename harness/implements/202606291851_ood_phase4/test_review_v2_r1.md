# 测试审查报告（v2 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/detail/exponential_test.cj` — 缺少 Float16 类型测试覆盖。详细设计（detail_v2.md）要求 `T <: FloatingPoint<T>`，Float16 是 `FloatingPoint` 子类型且在 `common.cj` 中已被测试，但 `exponential_test.cj` 全部 7 个函数均无 Float16 正向用例或边界用例。该缺失导致 Float16 类型在指数函数中的正确性未被验证。

- **[一般]** `tests/glm/detail/common_test.cj`, `tests/glm/detail/exponential_test.cj` — Vec1 类型在所有函数中均无测试覆盖。详细设计定义了 Vec1~Vec4 四组重载，但两个测试文件中的所有 Vec 用例只使用了 Vec2/Vec3/Vec4，Vec1 完全未被测试。虽然实现为逐分量转发标量函数，Vec1 缺失测试仍构成覆盖缺口。

- **[轻微]** `tests/glm/detail/common_test.cj` — `intBitsToFloat` 和 `uintBitsToFloat` 标量版本仅通过 `floatBitsToInt`/`floatBitsToUint` 的 roundtrip 间接测试，缺少独立正向用例直接验证返回值。不影响正确性，但降低可读性和隔离性。

- **[轻微]** `tests/glm/detail/common_test.cj` — `testModInt` 系列缺少除零边界测试（`mod(Int64(5), Int64(0))`），该行为在 GLSL 中未定义且在仓颉中可能抛出异常。不影响当前正确性，但建议补充。

- **[轻微]** `tests/glm/detail/exponential_test.cj:50` — `testInversesqrtZero` 使用 `isNaN(r) || r > Float64(1e308)` 验证零值输入结果。设计明确预期返回 +Inf，而 `isNaN(r)` 分支对零值输入不可能发生，且 `r > 1e308` 对 +Inf 成立但对极大有限数也成立。建议改为直接验证 `isInf(r)` 以精确匹配设计契约。

## 修改要求（仅 REJECTED 时）

### 问题 1：exponential_test.cj 缺少 Float16 覆盖

- **位置**：`tests/glm/detail/exponential_test.cj`
- **问题**：7 个指数函数均无 Float16 正向用例
- **原因**：设计契约要求 `T <: FloatingPoint<T>`，Float16 为合法类型参数，`common.cj` 中 Float16 已被测试（Group E: mod），但 exponential 包完全缺失。可能导致 Float16 在指数/对数/幂运算中的精度或溢出问题未被检出。
- **修正方向**：为每个指数函数至少补充一个 Float16 正向用例（如 `@Expect(pow(Float16(2.0), Float16(3.0)), Float16(8.0))`），并对 `expT(Float16(x))` 的溢出场景添加边界测试。

### 问题 2：Vec1 类型在全部函数中零测试覆盖

- **位置**：`tests/glm/detail/common_test.cj`, `tests/glm/detail/exponential_test.cj`
- **问题**：两个文件中所有 Vec 测试仅覆盖 Vec2/Vec3/Vec4，Vec1 在所有函数中均无测试
- **原因**：详细设计为每个函数定义了 Vec1~Vec4 四组重载，Vec1 是合法且常用的类型（标量包装场景）。虽实现为逐分量转发，但 Vec1 可能因泛型特化路径不同而产生差异（Vec1 内部可能比 Vec2~Vec4 有不同布局），零覆盖不足以保证其正确性。
- **修正方向**：为每个函数至少补充一个 Vec1 测试用例（如 `let v = Vec1<Float64, Defaultp>(3.0); let r = floor(v); @Expect(r.x, Float64(3.0))`），优先覆盖 Group A 和 Group B 的基础函数。
