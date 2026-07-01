# 测试审查报告（v8 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/detail/geometric_test.cj` — 缺少 `normalize Vec1` 测试（约束 FloatingPoint<T>，无零保护，零→NaN 自然传播），缺少 `normalize Vec4` 零向量测试（Vec2 和 Vec3 有零向量测试，Vec4 缺失），缺少 `faceforward Vec4` 测试（仅 Vec2/Vec3 有测试）

- **[一般]** `tests/glm/ext/quaternion_trigonometric_test.cj` — 缺少 `angle(angleAxis(θ, axis)) = θ` 互逆验证（task_v8.md D 节明确要求此验证模式）

- **[一般]** `tests/glm/ext/matrix_transform_test.cj` — 缺少 rotate 和 shear 的测试（task_v8.md 要求 "translate/rotate/scale/shear/lookAt 各选典型用例"），仅测试了 translate/scale/lookAtRH/LH

- **[一般]** `tests/glm/ext/matrix_clip_space_test.cj` — perspective、infinitePerspective、tweakedInfinitePerspective 和全部 4 个 frustum 测试仅断言 `m.c2.w == 1.0`（该元素恒为 1.0，不验证公式正确性），缺少 task_v8.md 要求的 "ortho/perspective/frustum 各选一个互逆验证"

- **[一般]** `tests/glm/ext/matrix_projection_test.cj` — 全部 project/unProject 测试使用单位 model/proj 矩阵，z 分量不做透视除法（w=1），仅为视口变换的浅层测试；缺少 project/unProject 互逆验证（task_v8.md 要求）

- **[一般]** `tests/glm/gtc/matrix_inverse_test.cj` — `affineInverse` 仅使用对角矩阵（逆矩阵等于原矩阵），未使用一般仿射矩阵（含旋转/缩放组合的非对角 3x3 块）验证

- **[一般]** `tests/glm/gtc/matrix_access_test.cj` — 仅测试了 9 种矩阵类型中的 2 种（Mat4x4、Mat2x3），row 和 column 的非方阵重载（Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3 等）均无测试覆盖

## 修改要求（仅 REJECTED 时）

1. **`tests/glm/detail/geometric_test.cj`** — 补充 `testNormalizeVec1`（验证 Vec1 零→NaN 传播）、`testNormalizeVec4Zero`（验证零向量保护）、`testFaceforwardVec4`。参考 detail_v8.md §A.1 中 normalize 和 faceforward 的行为规格。

2. **`tests/glm/ext/quaternion_trigonometric_test.cj`** — 补充互逆测试：构造一个角度 θ 和轴，调用 `angleAxis(θ, axis)` 得到 q，再断言 `angle(q)` 近似等于 θ。参考 detail_v8.md §A.6 angle/angleAxis 公式。

3. **`tests/glm/ext/matrix_transform_test.cj`** — 补充 `testRotate`（绕 Z 轴旋转 90° 验证列主序旋转矩阵）和 `testShear`（验证剪切后特定分量的偏移）。参考 detail_v8.md §A.2。

4. **`tests/glm/ext/matrix_clip_space_test.cj`** — 为 perspective 和 frustum 至少各选一个变体做数值验证（如已知输入→已知输出的前向验证或互逆验证），替换当前仅检查 `c2.w == 1.0` 的弱断言。参考 detail_v8.md §A.3 的列主序矩阵公式。

5. **`tests/glm/ext/matrix_projection_test.cj`** — 使用非单位 model/proj 矩阵构造 project/unProject 互逆验证：`unProject(project(obj, model, proj, vp), model, proj, vp) ≈ obj`。参考 detail_v8.md §A.4。

6. **`tests/glm/gtc/matrix_inverse_test.cj`** — 在 `testAffineInverse` 中使用带旋转（非对角 3x3 块）的仿射矩阵验证 `m * affineInverse(m) ≈ I`。参考 detail_v8.md §B.2。

7. **`tests/glm/gtc/matrix_access_test.cj`** — 补充 Mat3x3、Mat4x2、Mat2x4 等至少一个非方阵变体的 row/column 测试，确保返回向量维度符合设计规格。参考 detail_v8.md §B.3。
