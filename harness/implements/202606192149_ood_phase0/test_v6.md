# 测试报告（v6）

## 概述
验证 `type_vec1~4.cj` 中三类预存泛型约束编译错误的修复。基于详细设计定义的行为契约编写/确认测试覆盖。

## 行为契约与测试覆盖

### 契约 1：`%` 运算符和 `mod` 具名函数保留完整语义
- Vec1: `testVec1Mod`、`testVec1ScalarMod`、`testVec1ModNamed` ✓
- Vec2: `testVec2Mod`、`testVec2ScalarMod`、`testVec2ModNamed` ✓
- Vec3: `testVec3Mod`、`testVec3ScalarMod` + 新增 `testVec3ModNamed` ✓
- Vec4: `testVec4Mod`、`testVec4ScalarMod` + 新增 `testVec4ModNamed` ✓
- Vec1 广播 `%` 到 Vec2/3/4: 新增 `testVec1BroadcastModVec2/3/4` ✓

### 契约 2：`<<`/`>>` 右操作数类型改为 `Int64`
- 标量移位测试（`<< Int64(2)`）保持可用 ✓
- 向量移位测试（`<< VecN<Int64, Q>`）保持可用 ✓

### 契约 3：一元 `+` 被删除
- `testVec1UnaryPlus` 等四个测试已从测试文件中删除 ✓

### 契约 4：`Number<T>` 块保持内容
- `+`/`-`/`*`/`/`/一元 `-`/`add/sub/mul/div` 及广播测试均存在 ✓

## 测试文件变更

| 文件 | 变更 |
|------|------|
| `src/detail/type_vec1_test.cj` | 删除 `testVec1UnaryPlus`；新增 `testVec1BroadcastModVec2/3/4` |
| `src/detail/type_vec2_test.cj` | 删除 `testVec2UnaryPlus` |
| `src/detail/type_vec3_test.cj` | 删除 `testVec3UnaryPlus`；新增 `testVec3ModNamed` |
| `src/detail/type_vec4_test.cj` | 删除 `testVec4UnaryPlus`；新增 `testVec4ModNamed` |
