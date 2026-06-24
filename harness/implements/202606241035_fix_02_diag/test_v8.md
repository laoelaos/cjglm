# 测试报告（v8）

## 测试文件

`tests/glm/detail/test_type_mat_compare.cj`（追加在文件末尾 636-692 行）

## 测试清单

| 测试函数 | 类型 | 场景 | 断言 |
|---------|------|------|------|
| testHashMat4x4Int64SameValue | Mat4x4<Int64, Defaultp> | 相同值一致性 | `hashCode() ==` |
| testHashMat4x4Int64DiffValue | Mat4x4<Int64, Defaultp> | 不同值差异性 | `hashCode() !=` |
| testHashMat4x4Float32SameValue | Mat4x4<Float32, Defaultp> | 相同值一致性 | `hashCode() ==` |
| testHashMat4x4Float32DiffValue | Mat4x4<Float32, Defaultp> | 不同值差异性 | `hashCode() !=` |
| testHashMat2x3Int64SameValue | Mat2x3<Int64, Defaultp> | 相同值一致性 | `hashCode() ==` |
| testHashMat2x3Int64DiffValue | Mat2x3<Int64, Defaultp> | 不同值差异性 | `hashCode() !=` |
| testHashMat2x3Float32SameValue | Mat2x3<Float32, Defaultp> | 相同值一致性 | `hashCode() ==` |
| testHashMat2x3Float32DiffValue | Mat2x3<Float32, Defaultp> | 不同值差异性 | `hashCode() !=` |

## 覆盖维度

- 正常路径：8 个测试覆盖全部正向断言
- 边界条件：Mat4x4（4 列）和 Mat2x3（2 列）两种矩阵形态，覆盖列数差异
- 元素类型：Int64 和 Float32 两种元素类型
- 相同性一致性：4 个测试验证相同输入产生相同哈希
- 不同值差异性：4 个测试验证不同输入产生不同哈希

## 设计偏差

无偏差。
