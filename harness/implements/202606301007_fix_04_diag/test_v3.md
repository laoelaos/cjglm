# 测试报告（v3）

## 概述

为 `detail/vector_relational.cj` 新增的 5 个函数（`equal`、`notEqual`、`any`、`all`、`not_`）编写单元测试，覆盖 Vec1~Vec4 所有维度。

## 测试文件

| 文件路径 | 说明 |
|---------|------|
| `cjglm/tests/glm/detail/vector_relational_test.cj` | 新增测试文件，package `glm.detail` |

## 测试用例清单

### equal（10 个用例）

| 测试函数 | 维度 | 场景 |
|---------|------|------|
| `testEqualVec1Float64Equal` | Vec1 | 相等 → x=true |
| `testEqualVec1Float64NotEqual` | Vec1 | 不等 → x=false |
| `testEqualVec1Int64Equal` | Vec1 | Int64 相等 → x=true |
| `testEqualVec2AllEqual` | Vec2 | 全等 → xy 均为 true |
| `testEqualVec2Mixed` | Vec2 | 部分相等 → 混合结果 |
| `testEqualVec2AllNotEqual` | Vec2 | 全不等 → xy 均为 false |
| `testEqualVec3AllEqual` | Vec3 | 全等 |
| `testEqualVec3Mixed` | Vec3 | 部分相等 |
| `testEqualVec4AllEqual` | Vec4 | 全等 |
| `testEqualVec4Mixed` | Vec4 | 部分相等 |
| `testEqualVec4AllNotEqual` | Vec4 | 全不等 |

### notEqual（7 个用例）

| 测试函数 | 维度 | 场景 |
|---------|------|------|
| `testNotEqualVec1Float64NotEqual` | Vec1 | 不等 → x=true |
| `testNotEqualVec1Float64Equal` | Vec1 | 相等 → x=false |
| `testNotEqualVec2Mixed` | Vec2 | 部分不等 |
| `testNotEqualVec2AllEqual` | Vec2 | 全等 → 全 false |
| `testNotEqualVec3Mixed` | Vec3 | 部分不等 |
| `testNotEqualVec4Mixed` | Vec4 | 部分不等 |
| `testNotEqualVec4AllNotEqual` | Vec4 | 全不等 → 全 true |

### any（11 个用例）

| 测试函数 | 维度 | 场景 |
|---------|------|------|
| `testAnyVec1False` | Vec1 | false → false |
| `testAnyVec1True` | Vec1 | true → true |
| `testAnyVec2AllFalse` | Vec2 | 全 false → false |
| `testAnyVec2FirstTrue` | Vec2 | 第一个 true → true |
| `testAnyVec2SecondTrue` | Vec2 | 第二个 true → true |
| `testAnyVec3AllFalse` | Vec3 | 全 false → false |
| `testAnyVec3LastTrue` | Vec3 | 最后一个 true → true |
| `testAnyVec4AllFalse` | Vec4 | 全 false → false |
| `testAnyVec4FirstTrue` | Vec4 | 第一个 true → true |
| `testAnyVec4LastTrue` | Vec4 | 最后一个 true → true |
| `testAnyVec4AllTrue` | Vec4 | 全 true → true |

### all（11 个用例）

| 测试函数 | 维度 | 场景 |
|---------|------|------|
| `testAllVec1True` | Vec1 | true → true |
| `testAllVec1False` | Vec1 | false → false |
| `testAllVec2AllTrue` | Vec2 | 全 true → true |
| `testAllVec2FirstFalse` | Vec2 | 第一个 false → false |
| `testAllVec2SecondFalse` | Vec2 | 第二个 false → false |
| `testAllVec3AllTrue` | Vec3 | 全 true → true |
| `testAllVec3MiddleFalse` | Vec3 | 中间 false → false |
| `testAllVec4AllTrue` | Vec4 | 全 true → true |
| `testAllVec4FirstFalse` | Vec4 | 第一个 false → false |
| `testAllVec4LastFalse` | Vec4 | 最后一个 false → false |
| `testAllVec4AllFalse` | Vec4 | 全 false → false |

### not_（7 个用例）

| 测试函数 | 维度 | 场景 |
|---------|------|------|
| `testNotVec1True` | Vec1 | true→false |
| `testNotVec1False` | Vec1 | false→true |
| `testNotVec2Mixed` | Vec2 | 混合 |
| `testNotVec2AllTrue` | Vec2 | 全 true→全 false |
| `testNotVec3Mixed` | Vec3 | 混合 |
| `testNotVec4Mixed` | Vec4 | 混合 |
| `testNotVec4AllFalse` | Vec4 | 全 false→全 true |

## 覆盖矩阵

| 覆盖维度 | equal | notEqual | any | all | not_ |
|---------|-------|----------|-----|-----|------|
| 正常路径 | ✓ | ✓ | ✓ | ✓ | ✓ |
| 边界条件 | Vec1/Int64 | — | — | — | — |
| 错误路径 | N/A（无异常） | N/A | N/A | N/A | N/A |
| 状态交互 | — | — | — | — | — |
| Vec1 | ✓ | ✓ | ✓ | ✓ | ✓ |
| Vec2 | ✓ | ✓ | ✓ | ✓ | ✓ |
| Vec3 | ✓ | ✓ | ✓ | ✓ | ✓ |
| Vec4 | ✓ | ✓ | ✓ | ✓ | ✓ |

## 设计偏差说明

实现报告指出 `equal`/`notEqual` 的实际约束为 `T <: Number<T> & Equatable<T>`（而非设计的 `T <: Number<T>`）。测试用例使用 `Float64` 和 `Int64` 作为类型参数，两者均满足 `Number<T> & Equatable<T>`，因此不受该偏差影响，测试均有效。

## 测试风格

遵循 `tests/glm/detail/` 已有风格（如 `common_test.cj`）：
- 顶层 `@Test` 函数，无测试类
- 使用 `@Expect` 断言
- package `glm.detail`，在包内直接调用被测函数，无需额外 import
- 使用 `Defaultp` 作为 qualifier
