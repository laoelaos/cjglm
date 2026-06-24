# 实现报告（v8）

## 概述
向 Vec2/3/4 三个类型各追加一个 `extend` 块，实现行向量×矩阵的 9 个 `operator *` 重载。同步创建测试文件覆盖所有重载。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | src/detail/type_vec2.cj | 末尾追加 Vec2 extend 块（Vec2/3/4 × Mat2x2/3x2/4x2） |
| 修改 | src/detail/type_vec3.cj | 末尾追加 Vec3 extend 块（Vec2/3/4 × Mat2x3/3x3/4x3） |
| 修改 | src/detail/type_vec4.cj | 末尾追加 Vec4 extend 块（Vec2/3/4 × Mat2x4/3x4/4x4） |
| 新建 | tests/glm/detail/test_vec_mat_mul.cj | 9 个重载各一个 Int64/Defaultp 测试用例 |

## 编译验证
`cjpm build` 成功，仅输出预存警告（stub 函数未用变量、lib.cj 中 shadowed import），无新增错误或警告。

## 设计偏差说明
无偏差。
