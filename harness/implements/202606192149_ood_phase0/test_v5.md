# 测试编写报告（v5）

## 概述
为公共 API 面与别名层（R4）编写单元测试，验证 `src/lib.cj` 的 `public import` 导出和 `src/fwd.cj` 的类型别名可正常使用。

## 测试文件

### tests/glm/test_lib.cj — 公共 API 导出验证
- **testLibVec2Construct**: 构造 `Vec2<Float32, PackedHighp>`，验证通过 `glm.*` 导入后的类型可用
- **testLibAddScalarVec**: 调用 `add(s, v)` 包级函数，验证标量-向量加法可访问
- **testLibFromBoolVec**: 调用 `fromBoolVec` 函数，验证布尔向量转换可访问
- **testLibQualifierType**: 引用 `Qualifier`、`Defaultp`、`PackedHighp` 类型，验证类型可访问

### tests/glm/test_fwd.cj — 类型别名验证
- **testFwdBVec2**: 实例化 `BVec2` 别名（`Vec2<Bool, PackedHighp>`），验证向量别名可用
- **testFwdVec4**: 实例化 `Vec4` 别名（`Vec4<Float32, PackedHighp>`），验证默认精度向量别名可用
- **testFwdLowpIVec3**: 实例化 `LowpIVec3` 别名（`Vec3<Int32, PackedLowp>`），验证低精度向量别名可用
- **testFwdScalarAlias**: 使用 `int32` 标量别名，验证标量类型别名可用

## 测试覆盖
| 行为契约 | 正向用例 | 覆盖文件 |
|---------|---------|---------|
| `lib.cj` 的 `public import` 精确匹配 `glm.detail` 公开符号名 | 4 | test_lib.cj |
| `fwd.cj` 别名可正常实例化 | 4 | test_fwd.cj |

## 设计偏差
无。测试实现严格遵循详细设计 v5 的用例描述。
