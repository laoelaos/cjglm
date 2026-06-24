# 测试报告（v5）

## 概述

经检查，`test_type_mat3x3.cj` 和 `test_type_mat4x4.cj` 测试文件已包含详细设计 v5 所需的全部测试用例，无需新增修改。

## 测试文件状态

| 文件路径 | 用例数 | 状态 |
|---------|--------|------|
| tests/glm/detail/test_type_mat3x3.cj | ~52 个 @Test 函数 | 已存在，完整覆盖设计 |
| tests/glm/detail/test_type_mat4x4.cj | ~56 个 @Test 函数 | 已存在，完整覆盖设计 |

## 覆盖维度检查

### test_type_mat3x3.cj

| 类别 | 覆盖状态 |
|------|---------|
| 构造（标量填充/逐分量/列向量） | ✅ 已存在 |
| length() | ✅ 已存在 |
| 下标（取值/赋值/越界/负索引） | ✅ 已存在 |
| col() 取值 | ✅ 已存在 |
| 一元负号 `-m` | ✅ 已存在 |
| 矩阵-标量 + - * / | ✅ 已存在 |
| 矩阵-矩阵 ± | ✅ 已存在 |
| Mat3x3×Mat2x3/Mat3x3/Mat4x3 | ✅ 已存在（3 个重载） |
| 矩阵除法 stub（throw Exception） | ✅ 已存在 |
| Mat3x3×Vec3 | ✅ 已存在 |
| diagonal | ✅ 已存在 |
| identity | ✅ 已存在 |
| fromParts（跨类型 9 参数 conv） | ✅ 已存在 |
| fromColumns（跨类型 3 列 conv） | ✅ 已存在 |
| fromMat 7（跨类型同尺寸） | ✅ 已存在 |
| fromMat 6a（8 方向） | ✅ 已存在 |
| fromMat 6b（8 方向 + conv） | ✅ 已存在 |

### test_type_mat4x4.cj

| 类别 | 覆盖状态 |
|------|---------|
| 构造/下标/col/算术（同 mat3x3 模式，Vec4 维度） | ✅ 已存在 |
| Mat4x4×Mat2x4/Mat3x4/Mat4x4 | ✅ 已存在（3 个重载） |
| 矩阵除法 stub | ✅ 已存在 |
| Mat4x4×Vec4 | ✅ 已存在 |
| diagonal/identity（4×4） | ✅ 已存在 |
| fromParts/fromColumns/fromMat 7 | ✅ 已存在 |
| fromMat 6a（8 方向） | ✅ 已存在 |
| fromMat 6a Mat4x2 偏差方向（GLM 特殊处理） | ✅ 已存在 |
| fromMat 6b（8 方向 + conv） | ✅ 已存在 |
| fromMat 6b Mat4x2 偏差方向（conv 版本） | ✅ 已存在 |

## 偏差说明

无偏差。所有测试用例严格遵循详细设计 v5 的行为契约编写。
