# 设计审查报告（v3 r2）

## 审查结果
REJECTED

## 发现

### **[严重]** `std.math.sqrt` 仅接受 `Float64`，设计对 sqrt 的泛型能力假设错误

**问题位置**：`quaternion_geometric.cj` length 函数（第 69 行）、`quaternion_trigonometric.cj` axis 函数（第 253 行）

**描述**：设计多处声称"std.math.sqrt 仓颉标准库提供 Float16/Float32/Float64 重载"，但实际 Cangjie `std.math.sqrt` 仅有一个签名 `sqrt(x: Float64): Float64`（见 cangjie-std skill math 文档及现有代码 `type_quat_cast.cj:122-124` 的 `sqrtT` 辅助函数——该函数主动将泛型 T 转 Float64 再 sqrt 再转回）。这意味着：
- `quaternion_geometric.cj` 的 `length<T, Q>` 内 `std.math.sqrt(dot(q, q))` 当 `T` 为 `Float32` 或 `Float16` 时无法编译
- `quaternion_trigonometric.cj` 的 `axis<T, Q>` 内 `std.math.sqrt(tmp1)` 同样无法编译

**期望修正方向**：
- 方案 A：实现 `length()` 时使用 `sqrtT` 模式（先 `as Float64` 再 sqrt 再 `as T`），参考 `type_quat_cast.cj:122-124`，并在设计中说明此限制
- 方案 B：在 `quaternion_geometric.cj` 中声明一个私有的 `sqrtT` 辅助函数，供 length 和 normalize 调用
- 同理处理 `axis` 函数中的 sqrt 调用
- 删除设计中对"Float16/Float32/Float64 重载"的错误描述

### **[严重]** `quaternion_relational.cj` epsilon 比较的代码示例无法编译

**问题位置**：第 103 行

**描述**：
```cangjie
let d = x - y; (d >= T(0)) ? d : -d
```
`x - y` 计算结果类型为 `Quat<T, Q>`，但 `T(0)` 类型为 `T`。`Quat<T, Q> >= T` 运算符未定义，无法编译。

该节明确了返回类型为 `Vec4<Bool, Q>`，意图是逐分量比较，但代码示例未体现这一语义。

**期望修正方向**：修正为逐分量计算 abs 差值的 epsilon 比较：
```cangjie
let dw = x.w - y.w; let dx = x.x - y.x; let dy = x.y - y.y; let dz = x.z - y.z;
Vec4(
    ((dw >= T(0)) ? dw : -dw) < epsilon,
    ((dx >= T(0)) ? dx : -dx) < epsilon,
    ((dy >= T(0)) ? dy : -dy) < epsilon,
    ((dz >= T(0)) ? dz : -dz) < epsilon
)
```
（notEqual 同理使用 `>= epsilon`）

### **[轻微]** ULP 函数计数内部不一致

**问题位置**：第 150 行标题与第 161 行正文描述

**描述**：标题"ULP 版本函数签名模式（8 个重载，stub）"声称 8 个，但正文描述为 Vec1~Vec4 各 4 个重载（equal/notEqual × scalar ULPs/vector ULPs），合计 16 个。正文数量与 epsilon 版本的模式一致是正确的，但标题数字有误。

**期望修正方向**：将标题"8 个重载"修正为"16 个重载"
