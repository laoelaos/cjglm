# 实现报告（v3）

## 概述

在 `src/detail/type_cast.cj` 中定义了 4 个 `public func cast` 重载，实现从 `Vec1`/`Vec2`/`Vec3`/`Vec4` 到 `Vec1` 的跨类型分量转换。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `src/detail/type_cast.cj` | 定义 4 个 `cast` 重载，包声明 `package glm.detail` |

## 编译验证

`cjpm build` —— **编译通过**（4 个 warning 均为已有 `lib.cj` 中的 `Vec1`-`Vec4` shadowing 警告，与本次变更无关）

## 设计偏差说明

无偏差，严格按 `detail_v3.md` 实现。
