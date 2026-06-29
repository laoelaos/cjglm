# 设计审查报告（v2 r2）

## 审查结果
REJECTED

## 发现

### [严重] fromQuat/fromMat3/fromMat4 设计为实例方法，与现有项目惯例及语义要求不符

`fromQuat`、`fromMat3`、`fromMat4` 三个转换工厂函数设计为非 `static` 实例方法（签名中缺 `static` 关键字）。它们不依赖 `this`，本质是工厂/转换函数。已有代码库中所有同类模式均使用 `static` 方法（参见 `type_mat3x3.cj:134` `Mat3x3.fromParts`、`:143` `Mat3x3.fromMat`、`:152-192` `Mat3x3.fromMat` 系列；`type_mat4x4.cj:140` `Mat4x4.fromParts`、`:149` `Mat4x4.fromMat`、`:199-297` `Mat4x4.fromMat` 系列）。若保留实例方法形态，调用侧需构造哑元接收器：`dummyQuat.fromMat3(m)`，语义不合理且易误导使用者。

**修正方向**：三个方法一律增加 `static` 修饰为 `public static func fromQuat<U, P>(...)` / `public static func fromMat3(...)` / `public static func fromMat4(...)`，并相应调整测试方案中的调用方式。

### [一般] identity(one) 工厂方法的位置说明歧义

`identity(one)` 含有 `where T <: Number<T>` 约束，因此必须定义在 `extend<T, Q> Quat<T, Q> where T <: Number<T>, Q <: Qualifier` 块中（与 `Mat3x3.identity` 在 `type_mat3x3.cj:125-131` 的放置模式一致）。设计文档将 `identity` 列在"公开接口"主列表中，与 struct 体成员并列，未指明它实际位于扩展块。这可能导致实现者误放入 struct 体导致编译错误。

**修正方向**：将 `identity` 明确归入带 `Number<T>` 约束的 extend 块小节，与其他 `Number<T>` 约束的成员工厂函数并列。

### [一般] 跨 Qualifier 构造函数 init&lt;Q2&gt;(q: Quat&lt;T, Q2&gt;) 的项目内无先例验证

设计引入 `init<Q2>(q: Quat<T, Q2>) where Q2 <: Qualifier` 作为跨 Qualifier 转换构造。已有代码库中所有跨 Qualifier 转换均通过静态方法实现（如 `Mat3x3.fromMat<SrcQ>` 系列），无任何 `init` 带额外类型参数的先例。仓颉编译器对构造函数是否支持额外类型参数存在不确定性——类型参数 `Q2` 在 `init` 中既不是结构体类型参数也不是约束中的类型参数，其合法性未经本项目验证。

**修正方向**：建议将跨 Qualifier 转换统一为静态工厂方法（如 `Quat.fromQuat<Q2>(q: Quat<T, Q2>): Quat<T, Q> where Q2 <: Qualifier`），与 `fromQuat` 的跨类型转换工厂合并或并行，消除构造函数带类型参数的风险。

## 修改要求（仅 REJECTED 时）

1. **[严重]** `fromQuat`/`fromMat3`/`fromMat4` 改为 `public static func`，修正描述和测试方案中对应的调用方式。
2. **[一般]** 明确 `identity` 位于带 `Number<T>` 约束的 extend 块中，调整设计文档中"公开接口"的结构划分。
3. **[一般]** 将跨 Qualifier 转换从 `init<Q2>` 替换为静态工厂方法，消除仓颉编译器对构造函数类型参数的不确定性风险。
