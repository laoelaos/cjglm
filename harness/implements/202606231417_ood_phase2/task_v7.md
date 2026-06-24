# 任务指令（v7）

## 动作
NEW

## 任务描述
创建 `src/detail/scalar_mat_ops.cj`（package glm.detail），实现 36 个标量-矩阵四则运算全局函数——add/sub/mul/div 各 9 重载（覆盖 Mat2x2~Mat4x4 全部 9 个矩阵类型）。同步创建测试文件 `tests/glm/detail/test_scalar_mat_ops.cj`。

## 选择理由
T6（matrix.cj）已通过验证。scalar_mat_ops.cj 是 T8（Vec×Mat 行向量运算符）前的独立模块，仅依赖 9 个矩阵类型（均已完整实现）和 Number<T>/Qualifier，无其他包内文件依赖。模式与 scalar_vec_ops.cj 完全同构——全局具名函数通过第二参数类型消歧。4 个运算 × 9 矩阵 = 36 个函数，纯机械展开，适合当前轮次。

## 任务上下文

### 设计依据
参见设计文档 §3.5 标量-矩阵运算（scalar_mat_ops.cj 全局函数签名模板）、§3.8 编译顺序说明。

### 函数签名模板
全部 36 个函数遵循统一签名模式：
```cangjie
@OverflowWrapping
public func <op><T, Q>(s: T, m: Mat{C}x{R}<T, Q>): Mat{C}x{R}<T, Q>
    where T <: Number<T>, Q <: Qualifier
```

四个运算（add/sub/mul/div）各 9 重载，覆盖以下矩阵类型：
Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4

### 展开模式
每列逐分量应用标量运算（`result.c_j[i] = s op m.c_j[i]`），按属性访问展开：

| 矩阵 | 列数 | 列向量类型 | 展开模式（以 add 为例，sub/mul/div 同理） |
|------|------|-----------|------------------------------------------|
| Mat2x2 | 2 | Vec2 | `Mat2x2(Vec2(s+m.c0.x, s+m.c0.y), Vec2(s+m.c1.x, s+m.c1.y))` |
| Mat2x3 | 2 | Vec3 | `Mat2x3(Vec3(s+m.c0.x, s+m.c0.y, s+m.c0.z), Vec3(s+m.c1.x, s+m.c1.y, s+m.c1.z))` |
| Mat2x4 | 2 | Vec4 | `Mat2x4(Vec4(s+m.c0.x, s+m.c0.y, s+m.c0.z, s+m.c0.w), Vec4(s+m.c1.x, s+m.c1.y, s+m.c1.z, s+m.c1.w))` |
| Mat3x2 | 3 | Vec2 | `Mat3x2(Vec2(s+m.c0.x, s+m.c0.y), Vec2(s+m.c1.x, s+m.c1.y), Vec2(s+m.c2.x, s+m.c2.y))` |
| Mat3x3 | 3 | Vec3 | `Mat3x3(Vec3(s+m.c0.x, s+m.c0.y, s+m.c0.z), Vec3(s+m.c1.x, s+m.c1.y, s+m.c1.z), Vec3(s+m.c2.x, s+m.c2.y, s+m.c2.z))` |
| Mat3x4 | 3 | Vec4 | `Mat3x4(Vec4(s+m.c0.x, s+m.c0.y, s+m.c0.z, s+m.c0.w), Vec4(s+m.c1.x, s+m.c1.y, s+m.c1.z, s+m.c1.w), Vec4(s+m.c2.x, s+m.c2.y, s+m.c2.z, s+m.c2.w))` |
| Mat4x2 | 4 | Vec2 | `Mat4x2(Vec2(s+m.c0.x, s+m.c0.y), Vec2(s+m.c1.x, s+m.c1.y), Vec2(s+m.c2.x, s+m.c2.y), Vec2(s+m.c3.x, s+m.c3.y))` |
| Mat4x3 | 4 | Vec3 | `Mat4x3(Vec3(s+m.c0.x, s+m.c0.y, s+m.c0.z), Vec3(s+m.c1.x, s+m.c1.y, s+m.c1.z), Vec3(s+m.c2.x, s+m.c2.y, s+m.c2.z), Vec3(s+m.c3.x, s+m.c3.y, s+m.c3.z))` |
| Mat4x4 | 4 | Vec4 | `Mat4x4(Vec4(s+m.c0.x, s+m.c0.y, s+m.c0.z, s+m.c0.w), Vec4(s+m.c1.x, s+m.c1.y, s+m.c1.z, s+m.c1.w), Vec4(s+m.c2.x, s+m.c2.y, s+m.c2.z, s+m.c2.w), Vec4(s+m.c3.x, s+m.c3.y, s+m.c3.z, s+m.c3.w))` |

### 约束注意事项
- 不包含 mod 函数（矩阵取模无数学意义，GLM 未定义）
- 所有函数标注 `@OverflowWrapping`
- import: `std.math.{ Number }`
- 不依赖任何其他 detail 文件（仅依赖同包的矩阵类型结构体和 Vec 类型）

## 已有代码上下文

### 参考实现：scalar_vec_ops.cj
同包已有的标量-向量运算文件（`src/detail/scalar_vec_ops.cj`），模式完全相同——全局函数 `add/sub/mul/div/mod`，第一参数 `s: T`，第二参数为向量类型，`@OverflowWrapping`。scalar_mat_ops.cj 完全对标此模式。

### 依赖的矩阵类型（均已完整实现）
- `src/detail/type_mat2x2.cj` ~ `src/detail/type_mat4x4.cj`（9 个文件）
- 每个类型结构体包含 `c0: Vec{R}<T,Q>`, `c1: Vec{R}<T,Q>`, ... 等列向量成员

### 测试文件设计指导
创建 `tests/glm/detail/test_scalar_mat_ops.cj`（package glm.detail），建议覆盖：
- **add/sub/mul/div 各选 2~3 个代表性矩阵尺寸**（如 Mat2x2、Mat3x3、Mat4x4），使用 Int64 精确算术验证逐分量结果正确
- **div 浮点验证**：选取 Mat2x2，使用 Float32/Float64 验证逐元素除法
- **div 整数截断**：Int32 输入验证整数除法截断行为
- **与 scalar_vec_ops 一致性**：验证 `div(s, m)[0][0]` 与 `div(s, v)[0]` 在 `m[0][0] == v[0]` 时输出一致
- 测试元素类型统一使用 `Int64, Defaultp`（特殊标注除外）
- 参考 `scalar_vec_ops_test.cj` 的测试编写风格
