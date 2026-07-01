# 代码审查报告（v4 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/detail/trigonometric_test.cj` — `acos` 函数缺少任何 Vec1~Vec4 版本的测试。详细设计测试覆盖要求明确要求"每个函数至少一个向量类型，逐分量断言"，但 `acos` 仅有标量测试（`testAcos`、`testAcosOutOfRange`、`testAcosPlusOne`、`testAcosMinusOne`），无 Vec 版本测试。其姊妹函数 `asin` 已有 Vec1 测试覆盖，`acos` 应类似补充至少一种 Vec 类型的逐分量断言。

## 修改要求（仅 REJECTED 时）

### 问题 1：`acos` 缺少 Vec 测试

- **文件**：`tests/glm/detail/trigonometric_test.cj`
- **位置**：在 `acosh` Vec 测试位置附近（约第 362 行之后），或独立新增一个测试函数，例如 `testAcosVec1`。
- **问题**：详细设计约定"每个函数至少一个向量类型"，`acos` 是唯一缺失 Vec 覆盖的函数。
- **期望的修正方向**：新增一个 `acos` Vec 测试（建议 Vec1 或 Vec2 即可），逐分量断言已知值（如 `acos(1.0) == 0`、边界 `acos(-1.0) == pi` 或越界 `acos(2.0)` → NaN），模式参考已有的 `testAsinVec1`。
