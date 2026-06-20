# 计划审查报告（v2 r1）

## 审查结果
REJECTED

## 发现

### [严重] 文件路径与项目实际结构不一致

task_v2.md 将所有新文件路径指定为 `src/glm/detail/`，但项目实际目录结构中 `src-dir = "src"`，现有 R1 文件均直接位于 `src/detail/`（如 `src/detail/qualifier.cj`），而非 `src/glm/detail/`。分析如下：

- 项目 `cjpm.toml` 的 `src-dir = "src"`
- 现有文件 `src/detail/qualifier.cj` 声明 `package glm.detail`
- `src/lib.cj` 声明 `package glm`

这意味着包映射为：`src/` → 包根，`src/detail/*.cj` → 包 `glm.detail`。新文件（`compute_vector_relational.cj`、`vectorize.cj`、`compute_vector_decl.cj` 及其测试文件）应置于 `src/detail/` 而非 `src/glm/detail/`。按 task_v2.md 指定的路径将导致包名不匹配或目录不存在，无法通过编译。

### [严重] ComputeEqual.callConst 接口签名与 R1 shim_limits 不兼容

task_v2.md 的 `ComputeEqual.callConst` 以无参数方式调用 `isIec559Of<T>()` 和 `epsilonOf<T>()`：

```
public const static func callConst(a: T, b: T): Bool
    if (isIec559Of<T>()) {                    // 无 hint 参数
        abs(a - b) <= epsilonOf<T>()          // 无 hint 参数
    ...
```

但 R1 已交付的 `shim_limits.cj` 实际签名为：
```cangjie
public func isIec559Of<T>(hint: T): Bool { ... }
public func epsilonOf<T>(hint: T): T where T <: Number<T> { ... }
```

两者均需要 `hint: T` 入参，且均为非 `const` 函数。task_v2.md 未同步 R1 的偏差结论，直接沿用了 OOD 设计文档的原始签名（无参数 const 版本），而该版本的可行性已在 R1 中被证伪。

### [严重] const 函数体内调用非 const 函数导致编译不通过

`ComputeEqual.callConst` 声明为 `public const static func`，但其体内调用的 `isIec559Of<T>()` 和 `epsilonOf<T>()` 在 R1 实现中均为非 `const` 函数（使用运行时 `match`/`is` 类型分发）。仓颉 `const` 函数要求体内所有表达式为 const 表达式，非 const 函数调用不被允许。即使编译期 `if` 分支抑制生效，被选中的分支仍需满足 const 表达式约束，因此调用非 const `isIec559Of` 必然产生编译错误。此问题不能通过调整 `if` 分支逻辑绕过，必须重新设计 `callConst` 的签名与实现策略。

## 修改要求

1. **纠正文件路径**：将所有 `src/glm/detail/` 路径改为 `src/detail/`，与 R1 交付物保持一致。
2. **对齐 R1 接口**：`ComputeEqual.callConst` 的调用签名需适配 `isIec559Of(hint: T)` 和 `epsilonOf(hint: T)` 的 `hint` 参数约定，例如 `isIec559Of(a)`。
3. **解决 const 约束冲突**：至少有两个可选方向：
   - 将 `callConst` 改为非 `const` 函数（移除 `const` 修饰符），同时将 `==` 运算符的实现策略从 const 路径调整为运行时分支路径；
   - 或重新将 `isIec559Of`/`epsilonOf` 实现为 const 兼容形式（若编译器支持 `T(0) is Float64` 模式），但这需要与 R1 的已验证偏差结论协调。
   无论选择哪个方向，都需同步更新设计文档和 Vec 层的实现规划。
