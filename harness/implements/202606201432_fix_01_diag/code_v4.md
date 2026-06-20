# 实现报告（v4）

## 概述

在 `src/detail/type_cast.cj` 中将已有 4 个 `cast` 函数重命名为 `castVec1`，并追加 4 个 `castVec2` 重载（Vec1/Vec2/Vec3/Vec4 → Vec2）。同步更新 `type_cast_test.cj`。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 重命名 + 追加 | `src/detail/type_cast.cj` | `cast` → `castVec1`（4 处函数名），新增 `castVec2` 重载（4 个） |
| 重命名 + 追加 | `src/detail/type_cast_test.cj` | `cast(` → `castVec1(`（13 处调用），新增 10 个 `castVec2` 测试函数 |

## 编译验证

`cjpm build` —— **编译通过**（4 个 warning 均为已有 Vec1-Vec4 shadowing 警告，与本次变更无关）

## 测试验证

`cjpm test` —— **332/332 全部 PASSED**（R3 为 322/322，新增 10 个 Vec2-target 测试用例全部通过）

## 设计偏差说明

无偏差，严格按 `detail_v4.md` 实现。

### 函数名设计说明

因仓颉重载解析按参数类型而非返回类型判定（`function/README.md` §7.1），R3 的 `cast` 函数（返回 Vec1）与新增的 Vec2-target 重载参数签名完全相同，若保持同名将导致重定义错误。因此：
- R3 4 个 `cast` 函数重命名为 `castVec1`
- 新增 4 个 `castVec2` 函数（Vec1/Vec2/Vec3/Vec4 → Vec2）
- 此命名方案将目标 Vec 类型编码到函数名中，消除了重载歧义

此偏差属于**接口/行为有偏差**（类别二），需在后续以草案形式写入 `docs/deviations.md` §四。
