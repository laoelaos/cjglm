# 详细设计（v12）

## 概述

修复 `cjglm/src/gtc/quaternion.cj` 缺失的依赖 import，使其与 OOD §3.15 跨包引用清单一致。仅在现有 import 区域追加前瞻性 `public import` 声明，不修改任何函数体（所有函数均为 stub）。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/gtc/quaternion.cj` | 修改（追加 import） | 补充缺失的 `public import glm.ext.{equal, notEqual, epsilon, pi, cos_one_over_two}` |

## 类型定义

无新增类型。

## 错误处理

无变更。所有函数保持 `throw Exception("stub")`。

## 行为契约

- 文件原有 4 行 import（`package` + `import` ×2 + `public import` ×1）保持不变
- 追加 1 行 `public import glm.ext.{equal, notEqual, epsilon, pi, cos_one_over_two}` 在第 4 行之后、第 5 行空行之前
- 使用 `public import` 而非普通 `import`，因当前所有函数为 stub，符号不会被函数体直接引用，普通 import 会触发"未使用 import"编译警告
- 修改后编译不受影响（stub 函数体不引用新增 import）

## 依赖关系

- 依赖 `glm.ext` 包（`src/ext/vector_relational.cj` 提供 `equal`/`notEqual`，`src/ext/scalar_constants.cj` 提供 `epsilon`/`pi`/`cos_one_over_two`）
- 无新文件创建
- 无 deviations.md 登记需求
