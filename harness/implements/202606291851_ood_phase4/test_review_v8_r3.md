# 测试审查报告（v8 r3）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/detail/geometric_test.cj` — normalize Vec1 零输入→NaN 行为未测试。设计契约明确指定 `normalize Vec1` 零输入产生 NaN（与 Vec2~4 零→零向量的保护行为不同）。测试文件仅包含 `testNormalizeVec1`（正向输入验证），缺失 `testNormalizeVec1Zero` 或等效测试。同一文件内已存在 `testNormalizeVec2/3/4Zero`（零向量保护），且 `quaternion_common_test.cj:72` 已证明可通过 `.isNaN()` 验证 NaN，因此"因精度问题未断言 NaN"的理由不成立。此行为契约未被验证。

## 修改要求

1. `tests/glm/detail/geometric_test.cj` — 补充 normalize Vec1 零输入测试，验证 `normalize(Vec1(0.0)).x.isNaN() == true`。问题：设计契约"零→NaN 自然传播"缺乏测试覆盖。修正方向：新增 `testNormalizeVec1Zero` 测试函数，对零向量调用 normalize 并断言结果为 NaN。
