# 设计审查报告（v2 r4）

## 审查结果
REJECTED

## 发现

### **[严重] P1-2: `Int32.fromBits(UInt32)` API 在仓颉标准库中不存在**

**问题**：设计第 48/56/63/71 行提议使用 `Int32.fromBits(UInt32)` 和 `Int64.fromBits(UInt64)` 实现 UInt→Int 的位重解释。根据仓颉官方核心包文档（`core_package_intrinsics.md`），`fromBits` 静态方法**仅定义于浮点类型**（`Float16`/`Float32`/`Float64`），`Int32` 和 `Int64` 均无此方法。上述代码将无法编译。

**修正方向**：使用 `@OverflowWrapping` 注解配合 `(UInt32 as Int32)` 转型实现位重解释语义。在 wrapping 语义下，`(UInt32 as Int32)` 对 > Int32.Max 的值会回绕（wrap）为对应的负值，等价于位重解释。`@OverflowWrapping` 已在同一文件（`ulp.cj` 无此注解）乃至整个代码库（`quaternion_common.cj:15`、`scalar_quat_ops.cj`、`type_vec2.cj` 等）广泛用于需要 wrapping 语义的函数。修复后代码示意：

```cangjie
@OverflowWrapping
public func float_distance(x: Float32, y: Float32): Int32 {
    if (x.isNaN() || x.isInf() || y.isNaN() || y.isInf()) { return Int32.Max }
    let a = (x.toBits() as Int32)
    let b = (y.toBits() as Int32)
    abs(a - b)
}
```

需注意 `@OverflowWrapping` 会影响函数内所有整数运算（含 `a - b` 和 `abs` 内部的 `-a`），需验证 `abs` 在 wrapping 下对 Int32.Min 的行为是否符合预期。

### **[一般] P1-3: slerp 中 `cosOmega` 变量声明未指明可变性**

**问题**：设计第 93-108 行描述 cosTheta<0 分支中需要对 cosTheta 取反，但当前代码（`:46`）用 `let cosOmega = ...` 声明为不可变变量。设计未说明需要将 `let` 改为 `var`，也未说明 `clamp` 调用在 cosTheta<0 分支之前还是之后执行。

**修正方向**：明确将 `cosOmega` 声明为 `var`，并确定操作顺序为：(1) `var cosOmega = dot(x, y)`；(2) if cosOmega < 0: `z = -y; cosOmega = -cosOmega`；(3) `cosOmega = clamp(cosOmega, -one, one)`。clamp 应在符号翻转之后执行。

## 修改要求

1. **[严重] P1-2**：废除 `Int32.fromBits(UInt32)` 方案，改用 `@OverflowWrapping` + `(UInt32 as Int32)` 模式。同时更新"关键语义澄清"段落，修正对 `fromBits` API 存在性的错误声称。
2. **[一般] P1-3**：补充 `cosOmega` 从 `let` 改为 `var` 的说明，并明确 clamp 与 cosTheta 符号翻转的执行顺序。
