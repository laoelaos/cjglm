# 任务指令（v7）

## 动作
NEW

## 任务描述
重构 G2.3：将 `quaternion_geometric.cj:5-8`、`quaternion_trigonometric.cj:5-8`、`type_quat_cast.cj:122-125` 中 3 处 `sqrtT` 私有函数从 Float64 中转包装（`Float64(x).sqrt() as T`）改为直接调用 `std.math.sqrt(x)`，利用 T 自身的精度重载，使与 OOD §1 方案 A 一致。

## 选择理由
- G2.3 优先级 Medium——项目级一致性问题（实现策略偏离 OOD §1 方案 A），跨 3 个文件相同模式
- G2.1 已完成后为最高优先级剩余任务
- 纯机械重构，无功能变更，风险低

## 任务上下文
### 需修改文件
| 文件 | 修改内容 |
|------|---------|
| `cjglm/src/ext/quaternion_geometric.cj:5-8` | `sqrtT` 函数体：`Float64(x).sqrt() as T` → `std.math.sqrt(x)` |
| `cjglm/src/ext/quaternion_trigonometric.cj:5-8` | 同上 |
| `cjglm/src/detail/type_quat_cast.cj:122-125` | 同上 |

### 当前实现模式（3 文件相同）
```cangjie
private func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    Float64(x).sqrt() as T
}
```

### 目标实现模式
```cangjie
private func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    std.math.sqrt(x)
}
```

### 调用点（无需修改）
- `quaternion_geometric.cj:17`：`sqrtT(dot(q, q))`
- `quaternion_trigonometric.cj:18`：`one / sqrtT(tmp1)`
- `type_quat_cast.cj:83, 91, 99, 107`：`sqrtT(four?SquaredMinus1 + one)`

### 验证方式
- `cjpm build` 编译通过（0 errors）
- `cjpm test` 全部 PASSED / 0 FAILED（数值结果在浮点位模式层面可能产生约 1e-7 量级的微小差异，不影响功能正确性；若测试因精度差异失败，需调整断言容差）

### 参考
- 诊断报告 §G2.3（`docs/diag/impl/03_diag.md:357-368`）
- OOD §1 方案 A 要求直接调用 `std.math.sqrt` 利用类型重载
- 当前所有 T 实例化路径均强制走 Float64 中转（Float32/Float16 精度降级），违反 OOD §1
