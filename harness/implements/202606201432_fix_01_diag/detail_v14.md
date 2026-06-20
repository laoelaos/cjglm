# 详细设计（v14）

## 概述

修改 `src/fwd.cj`，追加文件头部注释和家族分组注释，对应 `01_diag.md` #25/#26。纯注释变更，不涉及代码逻辑。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/fwd.cj` | 编辑 | 插入 2 行头部注释 + 16 行分组注释 |

## 变更详情

### #25 — 文件头部注释

在第 1 行 `package glm` 前插入 2 行：

```
// fwd.cj — GLM 兼容类型别名（自动生成）
// 注意：此文件由脚本自动生成，手动修改请谨慎
```

插入后文件起始变为：
```
// fwd.cj — GLM 兼容类型别名（自动生成）
// 注意：此文件由脚本自动生成，手动修改请谨慎
package glm

import glm.detail
...
```

### #26 — 家族分组注释

在以下 16 个家族的第一个别名定义行前，各插入一行 `// === {FamilyName} family ===` 注释：

| 插入位置（行号） | 前一行为 | 插入到（首个别名前） | 注释内容 |
|-----------------|---------|-------------------|---------|
| 当前第 51 行前 | 空行（第 50 行） | `public type BVec1` | `// === B family ===` |
| 当前第 67 行前 | `LowpBVec4`（第 66 行） | `public type IVec1` | `// === I family ===` |
| 当前第 83 行前 | `LowpIVec4`（第 82 行） | `public type UVec1` | `// === U family ===` |
| 当前第 99 行前 | `LowpUVec4`（第 98 行） | `public type Vec1` | `// === Vec family ===` |
| 当前第 115 行前 | `LowpVec4`（第 114 行） | `public type DVec1` | `// === DVec family ===` |
| 当前第 131 行前 | `LowpDVec4`（第 130 行） | `public type I8Vec1` | `// === I8 family ===` |
| 当前第 147 行前 | `LowpI8Vec4`（第 146 行） | `public type I16Vec1` | `// === I16 family ===` |
| 当前第 163 行前 | `LowpI16Vec4`（第 162 行） | `public type I32Vec1` | `// === I32 family ===` |
| 当前第 179 行前 | `LowpI32Vec4`（第 178 行） | `public type I64Vec1` | `// === I64 family ===` |
| 当前第 195 行前 | `LowpI64Vec4`（第 194 行） | `public type U8Vec1` | `// === U8 family ===` |
| 当前第 211 行前 | `LowpU8Vec4`（第 210 行） | `public type U16Vec1` | `// === U16 family ===` |
| 当前第 227 行前 | `LowpU16Vec4`（第 226 行） | `public type U32Vec1` | `// === U32 family ===` |
| 当前第 243 行前 | `LowpU32Vec4`（第 242 行） | `public type U64Vec1` | `// === U64 family ===` |
| 当前第 259 行前 | `LowpU64Vec4`（第 258 行） | `public type FVec1` | `// === FVec family ===` |
| 当前第 275 行前 | `LowpFVec4`（第 274 行） | `public type F32Vec1` | `// === F32 family ===` |
| 当前第 291 行前 | `LowpF32Vec4`（第 290 行） | `public type F64Vec1` | `// === F64 family ===` |

## 类型定义

无变更。本任务不引入新类型、不修改已有类型。

## 错误处理

无变更。注释不影响编译。

## 行为契约

- 注释插入后文件行数从 306 变为 324（+18 行）
- 所有代码行位置下移（头部注释 2 行 + 分组注释 16 行）
- 无运行时或编译期行为变化

## 依赖关系

无变更。单文件纯注释修改。
