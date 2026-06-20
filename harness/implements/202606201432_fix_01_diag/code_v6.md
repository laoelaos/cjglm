# 实现报告（v6）

## 概述
追加 4 个 `castVec4` 重载（Vec1/Vec2/Vec3/Vec4 → Vec4）及对应测试。

## 文件变更清单
| 操作 | 文件 | 说明 |
|------|------|------|
| 追加 | `src/detail/type_cast.cj` | 4 个 `castVec4` 重载 |
| 追加 | `src/detail/type_cast_test.cj` | 10 个 Vec4-target 测试 |

## 编译验证
`cjpm build` —— 通过（仅已有 4 个 shadowing warning）

## 测试验证
`cjpm test` —— **352/352 全部 PASSED**

## 设计偏差说明
无偏差。
