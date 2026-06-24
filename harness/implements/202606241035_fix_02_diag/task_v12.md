# 任务指令（v12）

## 动作
NEW

## 任务描述
在 `test_integration_matrix.cj` 末尾追加 `testIntegrationFromMatRowShrink` 测试函数，覆盖纯 `rowSh`（仅行收缩）模式的 fromMat 集成测试。

推荐方向：`Mat4x4→Mat4x3`（OOD §3.3 9×9 转换矩阵表 `:393` 标注 `rowSh`）

测试数据与预期值：
- 源矩阵：`Mat4x4<Float32>(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0)`
- 列主序布局：c0=Vec4(1,2,3,4), c1=Vec4(5,6,7,8), c2=Vec4(9,10,11,12), c3=Vec4(13,14,15,16)
- RowShrink(R=4→3)：截断每列末行
- 预期结果：m.c0=Vec3(1,2,3), m.c1=Vec3(5,6,7), m.c2=Vec3(9,10,11), m.c3=Vec3(13,14,15)

## 选择理由
Route 表格顺序中的下一个待完成任务。T14 已验证 PASSED，T17 操作 `test_integration_matrix.cj`（追加到文件末尾），与已有完成的 T5 无行号冲突（T5 已修改 `:330-346`，T17 追加到文件末尾 `:565` 之后）。

## 任务上下文
- 诊断报告 §4 T17 精确定位：集成测试覆盖了 5 种 fromMat 模式（B/colExt+rowExt/colSh/colExt+rowSh/colSh+rowExt），未覆盖纯 `rowSh`（仅行收缩）
- OOD §3.3 9×9 转换矩阵表标注了 7 种不同模式，`rowSh` 是缺失的纯模式之一
- 已有集成测试：`testIntegrationFromMatBClass`、`testIntegrationFromMatColExtRowExt`、`testIntegrationFromMatColShrink`、`testIntegrationFromMatColExtRowShrink`、`testIntegrationFromMatColShrinkRowExt`

## 已有代码上下文
- 参考实现：`type_mat4x3.cj:197-200`——`Mat4x4→Mat4x3` fromMat 6a 实现：
  ```cangjie
  Mat4x3(Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z),
         Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z),
         Vec3<T, Q>(m.c2.x, m.c2.y, m.c2.z),
         Vec3<T, Q>(m.c3.x, m.c3.y, m.c3.z))
  ```
- 单元测试验证：`test_type_mat4x3.cj:562-577`——`testMat4x3FromMat6aMat4x4` 使用相同源数据并断言上述预期值
- 参考 `testIntegrationFromMatColShrink`（`:295-304`）的测试风格——使用 `Float32` 类型、`@Expect` 逐分量断言
- 文件末尾追加：`test_integration_matrix.cj` 当前共 565 行，末尾空行处追加
