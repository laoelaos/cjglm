# 任务指令（v17）

## 动作
NEW

## 任务描述
完成 P4-4 末批（G35+G36✅+G37），全部 37 个问题（S1-S4, G1-G37）处理完毕：

1. **G35**: `tests/glm/gtc/noise_test.cj` — 补充 isFinite 验证、零向量输入、边界输入测试
2. **G36 ✅**: `docs/diag/impl/04_diag.md:418` — G36 条目末尾追加 `✅ 已修复`（ulp_test.cj 已有 float_distance NaN/Inf/负值测试覆盖，testFloatDistanceNaN/Inf/Negative 及其 Float64 版本已存在于文件中）
3. **G37**: `tests/glm/gtc/ulp_test.cj` — 补充 prev_float Float64 版本测试、±0 测试、NaN 测试、Inf 测试
4. `docs/diag/impl/04_diag.md` — 标记 G35/G37 ✅ 已修复
5. 更新 `plan.md` 路线表 v17 列 P4-4 标记 ✅

## 选择理由
v16 完成 G34（packing_test），P4-4 仅余 G35（noise_test 边界）、G36（ulp_test float_distance — 测试已存在仅需标记）、G37（ulp_test prev_float 补充）。三者均集中在 gtc 测试目录，均为小范围测试补充，可合并为一批完成。全部结束后 37 个问题处理完毕，整体项目完成。

## 任务上下文

### G35: noise_test.cj 补充

`tests/glm/gtc/noise_test.cj`（130 行）现有测试：
- range: perlin1D-4D + simplex1D-4D 范围验证（result ∈ [-1.1, 1.1]）
- periodic: perlin1D-4D 周期性验证
- deterministic: perlin1D + simplex1D 确定性验证
- negative: perlin1D(Float64(-2.5))
- zero: simplex1D(Float64(0.0))
- Float32: simplex1D(Float32(1.5))

需要补充：
1. **isFinite 验证**：对 perlin1D-4D、simplex1D-4D 各维度输出调用 `.isFinite()` 断言
2. **零向量输入**：perlin2D/3D/4D、simplex2D/3D/4D 使用 Vec2/Vec3/Vec4 零向量 `<T, Q>(0.0, ...)` 调用，验证输出 finite
3. **边界输入**：极小值（如 `Float32.minNormalized`）、极大值（如 `Float32(1e6)`）输入验证

示例测试格式：
```cangjie
@Test func testPerlin1DIsFinite(): Unit {
    let result = perlin1D(Float64(1.5))
    @Expect(result.isFinite(), true)
}
```

```cangjie
@Test func testPerlin2DZeroVector(): Unit {
    let v = Vec2<Float64, PackedHighp>(0.0, 0.0)
    let result = perlin2D(v)
    @Expect(result.isFinite(), true)
}
```

```cangjie
@Test func testPerlin1DLargeInput(): Unit {
    let result = perlin1D(Float64(1e6))
    @Expect(result.isFinite(), true)
}
```

### G37: ulp_test.cj prev_float 补充

`tests/glm/gtc/ulp_test.cj` 现有 testPrevFloat（:63-68）仅测试 `Float32(1.0) → prev_float(x) → float_distance(pf, x) == Int32(1)`。

需要补充：
1. **Float64 版本**：`testPrevFloatFloat64` — `Float64(1.0)` → `prev_float(x)` → `float_distance(pf, x) == Int64(1)`
2. **±0 测试**：`testPrevFloatZero` — `Float32(0.0)` 和 `Float32(-0.0)` 的 prev_float 不崩溃、结果 finite
3. **NaN 测试**：`testPrevFloatNaN` — `prev_float(Float32.nan).isNaN()` → true
4. **Inf 测试**：`testPrevFloatInf` — `prev_float(Float32.infinity())` 不崩溃、结果有限或 Inf

### G36: 仅标记

`docs/diag/impl/04_diag.md:418` G36 条目末尾追加 `✅ 已修复`。ulp_test.cj 中以下现有测试已覆盖 G36 要求：
- `testFloatDistanceNaN`（:76-80）
- `testFloatDistanceInf`（:82-86）
- `testFloatDistanceNaN64`（:88-92）
- `testFloatDistanceInf64`（:94-98）
- `testFloatDistanceNegative`（:100-106）
- `testFloatDistanceNegative64`（:108-114）

### 04_diag.md 标记位置
- G35: :412-416 末尾追加 `✅ 已修复`
- G36: :418-422 末尾追加 `✅ 已修复`
- G37: :424-429 末尾追加 `✅ 已修复`
