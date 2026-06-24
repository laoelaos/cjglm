# 任务指令（v12）

## 动作
NEW

## 任务描述
在 9 个矩阵类型文件（`src/detail/type_mat2x2.cj` ~ `src/detail/type_mat4x4.cj`）中各追加两个 extend 块，实现矩阵比较运算符（==/!=/equalExact/equalEpsilon）。

同步创建测试文件 `tests/glm/detail/test_type_mat_compare.cj`。

### extend 块 1（Equatable<T> 约束）
```cangjie
extend<T, Q> Mat{C}x{R}<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Mat{C}x{R}<T, Q>): Bool {
        // 逐列所有分量比较，委托 ComputeEqual<T>.call()
        ComputeEqual<T>.call(this.c0.x, rhs.c0.x) && ...
    }
    public operator func !=(rhs: Mat{C}x{R}<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Mat{C}x{R}<T, Q>): Bool {
        // 与 == 行为语义等价
        ComputeEqual<T>.call(this.c0.x, other.c0.x) && ...
    }
}
```

### extend 块 2（Number<T> & Equatable<T> & Comparable<T> 约束）
```cangjie
extend<T, Q> Mat{C}x{R}<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Mat{C}x{R}<T, Q>): Bool {
        // 浮点容差比较，委托 ComputeEqualNumeric<T>.callConst()
        ComputeEqualNumeric<T>.callConst(this.c0.x, other.c0.x) && ...
    }
}
```

每个矩阵类型的分量序列（列主序遍历所有列的所有分量）：
- Mat2x2: c0.x, c0.y, c1.x, c1.y
- Mat2x3: c0.x, c0.y, c0.z, c1.x, c1.y, c1.z
- Mat2x4: c0.x, c0.y, c0.z, c0.w, c1.x, c1.y, c1.z, c1.w
- Mat3x2: c0.x, c0.y, c1.x, c1.y, c2.x, c2.y
- Mat3x3: c0.x, c0.y, c0.z, c1.x, c1.y, c1.z, c2.x, c2.y, c2.z
- Mat3x4: c0.x, c0.y, c0.z, c0.w, c1.x, c1.y, c1.z, c1.w, c2.x, c2.y, c2.z, c2.w
- Mat4x2: c0.x, c0.y, c1.x, c1.y, c2.x, c2.y, c3.x, c3.y
- Mat4x3: c0.x, c0.y, c0.z, c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, c3.x, c3.y, c3.z
- Mat4x4: c0.x, c0.y, c0.z, c0.w, c1.x, c1.y, c1.z, c1.w, c2.x, c2.y, c2.z, c2.w, c3.x, c3.y, c3.z, c3.w

### 测试文件（test_type_mat_compare.cj）
至少覆盖：
- 对每个矩阵类型至少一个 == true / false 和 != true / false 用例
- 对 Float32 类型的 equalExact true / false 用例（每类型至少 1 组）
- 对 Float32 类型的 equalEpsilon true / false 用例（每类型至少 1 组）
- Bool 矩阵的 ==/!= 用例（验证 Bool 矩阵也支持比较，但不支持 equalEpsilon）

## 选择理由
独立验证发现 §3.6 要求的比较运算符在全部 9 个矩阵类型中完全缺失，属于前序实现遗漏。Vec 类型已有相同模式的成功实现（type_vec2.cj:137-144 的 ComputeEqual/ComputeEqualNumeric 委托模式）可直接参考。比较运算符仅涉及包内已有类型（ComputeEqual/ComputeEqualNumeric 在 compute_vector_relational.cj 中定义，同包直接可见），无新增外部依赖。

## 任务上下文
参见设计文档 §3.6（比较运算符）、§5（NaN 行为、equalEpsilon 行为）。Vec2 参考模式见 type_vec2.cj:137-145。

==/!=/equalExact 约束：`where T <: Equatable<T>, Q <: Qualifier`
equalEpsilon 约束：`where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier`

## 已有代码上下文
- 所有 9 个矩阵类型文件均已包含 `import std.math.{ Number, Integer }`，无需修改 import 语句
- ComputeEqual<T>（需要 T <: Equatable<T>）和 ComputeEqualNumeric<T>（需要 T <: Number<T> & Equatable<T> & Comparable<T>）定义在 `compute_vector_relational.cj`，同包直接可见
- Vec2 参考实现位于 `type_vec2.cj:137-145`
- 当前所有矩阵文件均无任何比较运算符实现（grep 确认）
