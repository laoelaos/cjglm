# 任务指令（v8）

## 动作
NEW

## 任务描述
在 type_vec2.cj、type_vec3.cj、type_vec4.cj 每个文件末尾各追加一个 extend 块，实现行向量×矩阵乘法成员运算符。同步创建测试文件 `tests/glm/detail/test_vec_mat_mul.cj`。

### 预期产出

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | src/detail/type_vec2.cj | 文件末尾追加 1 个 extend 块（3 个重载） |
| 修改 | src/detail/type_vec3.cj | 文件末尾追加 1 个 extend 块（3 个重载） |
| 修改 | src/detail/type_vec4.cj | 文件末尾追加 1 个 extend 块（3 个重载） |
| 新建 | tests/glm/detail/test_vec_mat_mul.cj | 9 个重载各至少 1 个测试用例 |

### Vec2 extend 块（3 个重载）

```cangjie
extend<T, Q> Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(m: Mat2x2<T, Q>): Vec2<T, Q> { ... }
    @OverflowWrapping
    public operator func *(m: Mat3x2<T, Q>): Vec3<T, Q> { ... }
    @OverflowWrapping
    public operator func *(m: Mat4x2<T, Q>): Vec4<T, Q> { ... }
}
```

- Vec2 × Mat2x2: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y`（j=0,1）
- Vec2 × Mat3x2: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y`（j=0,1,2）
- Vec2 × Mat4x2: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y`（j=0,1,2,3）

### Vec3 extend 块（3 个重载）

```cangjie
extend<T, Q> Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(m: Mat2x3<T, Q>): Vec2<T, Q> { ... }
    @OverflowWrapping
    public operator func *(m: Mat3x3<T, Q>): Vec3<T, Q> { ... }
    @OverflowWrapping
    public operator func *(m: Mat4x3<T, Q>): Vec4<T, Q> { ... }
}
```

- Vec3 × Mat2x3: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y + this.z * m.c_j.z`（j=0,1）
- Vec3 × Mat3x3: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y + this.z * m.c_j.z`（j=0,1,2）
- Vec3 × Mat4x3: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y + this.z * m.c_j.z`（j=0,1,2,3）

### Vec4 extend 块（3 个重载）

```cangjie
extend<T, Q> Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(m: Mat2x4<T, Q>): Vec2<T, Q> { ... }
    @OverflowWrapping
    public operator func *(m: Mat3x4<T, Q>): Vec3<T, Q> { ... }
    @OverflowWrapping
    public operator func *(m: Mat4x4<T, Q>): Vec4<T, Q> { ... }
}
```

- Vec4 × Mat2x4: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y + this.z * m.c_j.z + this.w * m.c_j.w`（j=0,1）
- Vec4 × Mat3x4: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y + this.z * m.c_j.z + this.w * m.c_j.w`（j=0,1,2）
- Vec4 × Mat4x4: `result[j] = this.x * m.c_j.x + this.y * m.c_j.y + this.z * m.c_j.z + this.w * m.c_j.w`（j=0,1,2,3）

### 扩展文件名约定

`type_mat{C}x{R}.cj` 中的列向量名为 `c0`~`c{C-1}`，各列向量成员名为 `.x`/`.y`/`.z`/`.w`（由 VecN 类型决定）。

## 测试要求

新建 `tests/glm/detail/test_vec_mat_mul.cj`（package glm.detail），覆盖：
- 每个重载至少 1 个用例（Int64、Defaultp），构造已知向量和矩阵，手动计算结果并验证
- 覆盖所有 9 个方向：Vec2×Mat2x2, Vec2×Mat3x2, Vec2×Mat4x2, Vec3×Mat2x3, Vec3×Mat3x3, Vec3×Mat4x3, Vec4×Mat2x4, Vec4×Mat3x4, Vec4×Mat4x4

## 选择理由
T7（scalar_mat_ops.cj）已验证通过。T8 是 Vec×Mat 行向量乘法，仅依赖 9 个矩阵类型（均已完整实现）和 Vec2~4/Number<T>/Qualifier，无其他包内文件依赖。Vec1 无有效目标（本阶段无行数=1 矩阵），不修改。

## 任务上下文
参见设计文档 §3.5 行向量-矩阵乘法定义。每行向量 extend 块在 Number<T> 约束下实现，标注 @OverflowWrapping，使用 `.x`/`.y`/`.z`/`.w` 属性访问避免下标开销。

## 已有代码上下文
- type_vec2.cj: 150 行，已有 3 个 extend 块（Number<T> / Integer<T> / Equatable<T> / Number&Equatable&Comparable<T> / Bool）
- type_vec3.cj: 159 行，已有 5 个 extend 块（同上）
- type_vec4.cj: 168 行，已有 5 个 extend 块（同上）
- 9 个 type_mat{N}x{M}.cj 已完整实现，所有矩阵类型同包可见
- 所有 extend 块使用 `extend<T, Q> VecN<T, Q> where T <: Number<T>, Q <: Qualifier { ... }` 模式
