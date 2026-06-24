# 测试审查报告（v3 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `tests/glm/detail/test_type_mat2x2.cj:352-358` — `testMat2x2FromMat6aMat4x3` 期望值错误。Mat4x3 以 Vec3 为列向量，`Mat4x3<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12)` 中 c1 = Vec3(4,5,6)，因此 fromMat 提取 c1.x=4、c1.y=5。但测试断言 `@Expect(m.c1.x, 5)` 和 `@Expect(m.c1.y, 6)`，与实际不符，测试必然失败。

- **[严重]** `tests/glm/detail/test_type_mat2x2.cj:440-446` — `testMat2x2FromMat6bMat4x3` 期望值错误。与上述 6a 同类问题，c1.x 应预期 Float64(4) 而非 Float64(5)，c1.y 应预期 Float64(5) 而非 Float64(6)。

## 修改要求（仅 REJECTED 时）

1. **testMat2x2FromMat6aMat4x3** — `tests/glm/detail/test_type_mat2x2.cj:355-356` 行：Mat4x3 的 c1 = Vec3(4,5,6)，因此 c1.x=4、c1.y=5。将 `@Expect(m.c1.x, 5)` 改为 `@Expect(m.c1.x, 4)`，将 `@Expect(m.c1.y, 6)` 改为 `@Expect(m.c1.y, 5)`。

2. **testMat2x2FromMat6bMat4x3** — `tests/glm/detail/test_type_mat2x2.cj:444-445` 行：同类问题。将 `@Expect(m.c1.x, Float64(5))` 改为 `@Expect(m.c1.x, Float64(4))`，将 `@Expect(m.c1.y, Float64(6))` 改为 `@Expect(m.c1.y, Float64(5))`。
