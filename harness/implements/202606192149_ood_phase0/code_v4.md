# 实现报告（v4）

## 概述
修改 `type_fromBoolVec.cj` 中全部 8 个 `fromBoolVec`/`fromBoolVecQ2` 函数签名，增加 `zero: T, one: T` 参数，函数体内 `T(1)`/`T(0)` 替换为参数引用。同步修改 `type_fromBoolVec_test.cj` 中 13 处调用传递 `Int64(0), Int64(1)`。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/type_fromBoolVec.cj` | 8 个函数增加 `zero: T, one: T` 参数；`T(1)`→`one`、`T(0)`→`zero` |
| 修改 | `src/detail/type_fromBoolVec_test.cj` | 13 处调用处传递 `Int64(0), Int64(1)` |

## 源文件修改细节

### `type_fromBoolVec.cj`
- 8 个函数签名中 `(v: VecN<..., ...>)` 后插入 `zero: T, one: T`
- 所有 `T(1)` 替换为 `one`，所有 `T(0)` 替换为 `zero`

### `type_fromBoolVec_test.cj`
- 7 处 `fromBoolVec` 调用：移除显式类型参数（由编译器通过 `zero`/`one` 和 `v` 参数推断），改为 `fromBoolVec(vb, Int64(0), Int64(1))`
- 6 处 `fromBoolVecQ2` 调用：保留显式类型参数 `<Int64, Defaultp, PackedHighp>`（Q 无法从参数推断），改为 `fromBoolVecQ2<...>(vb, Int64(0), Int64(1))`

## 设计偏差说明
无偏差。

## 编译验证
`cjpm build` 报告 96 个错误，全部来自 `type_vec1.cj`（`%`、`<<`、`>>` 运算符在无约束泛型 T 上的使用），属预存问题，不在本轮修改范围内。`type_fromBoolVec.cj` 无任何编译错误，原 `T(1)`/`T(0)` 导致的编译器错误已消除。
