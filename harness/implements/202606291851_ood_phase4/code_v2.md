# 实现报告（v2）

## 概述

实现了 `glm.detail` 包中两个核心函数库的完整实现：

1. **common.cj**（修改）：替换现有 12 个标量 stub 为完整实现，新增 13 个标量函数，并为全部函数补充 Vec1~Vec4 重载。总计 133 个函数（29 标量 + 104 Vec 重载）
2. **exponential.cj**（新建）：7 个指数函数（pow/exp/log/exp2/log2/sqrt/inversesqrt）的标量 + Vec1~Vec4 重载。总计 35 个函数

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | src/detail/common.cj | 替换 12 个 stub 为完整实现 + 新增全部 Vec 重载及新函数 |
| 新建 | src/detail/exponential.cj | 7 个指数函数的标量 + Vec1~Vec4 完整实现 |

## 编译验证

`cjpm build` 成功。编译输出仅有来自其他文件（gtc/matrix_transform.cj 未实现 stub、lib.cj 别名遮蔽）的预先存在的 warning，common.cj 和 exponential.cj 零错误、零 warning。

## 设计偏差说明

| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| `import std.math.{ ..., Comparable }` | `Comparable` 不在 `std.math` 中（自动导入），编译器报错 | 移除 `Comparable` 的显式导入，由 Cangjie 自动导入机制提供 |
| `T <: FloatingPoint<T>` 内使用 `==` 比较泛型值（roundEven 的 `diff == half`、frexp 的 `x == z`） | `FloatingPoint<T>` 不提供 `==` 运算符约束（需 `Equatable<T>`），编译器报错 | 改为先 `(x as Float64).getOrThrow()` 将 T 转为 Float64，再使用 Float64 的 `==` 比较 |
| `Float32.toBits()` 结果调用 `.toInt32()` | `UInt32` 类型无 `.toInt32()` 方法 | 使用 `(x.toBits() as Int32).getOrThrow()` 替代 |
| `Int32` 调用 `.toUInt32()` 传入 `Float32.fromBits` | `Int32` 类型无 `.toUInt32()` 方法 | 使用 `(bits as UInt32).getOrThrow()` 替代 |
| `Float64.toInt64()` 用于 roundEven 奇偶判断 | `Float64` 类型无 `.toInt64()` 方法 | 使用 `(rF64 as Int64).getOrThrow()` 替代 |
| `frexp` 的 `exp = Int64(floorT(log2T(absT(x)))) + 1` 中 `Int64(T)` | 无约束泛型 `Int64(T)` 不可编译 | 先 `(floorVal as Float64).getOrThrow()` 转 Float64，再 `(floorF64 as Int64).getOrThrow()` 转 Int64 |
