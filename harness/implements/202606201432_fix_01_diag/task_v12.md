# 任务指令（v12）

## 动作
NEW

## 任务描述
在 `src/detail/shim_limits_test.cj` 末尾追加约 3 个测试函数，验证整数类型（Int64, Int32, Int16）的 `NumericLimits<T>.epsilon(hint)` 返回 `T(0)`。可选覆盖 Int8。

预期文件：
- `src/detail/shim_limits_test.cj` — 追加 ~3~4 个测试函数

## 选择理由
#29 是剩余任务中工作量最小的项（~3 测试函数），涉及单一文件，无外部依赖。已完成 #21/#22（test_lib 覆盖改进），剩余中等优先级任务中 #29 最适合作为下一项。

## 任务上下文
- 项目根目录：`C:\Develop\Software\cjglm_wp\cjglm`
- 文件路径：`src/detail/shim_limits_test.cj`（41 行，已有 8 个测试函数）
- 现有测试覆盖：Float32 epsilon、Float64 epsilon、isIec559Of(Float32/Float64/Int64)、epsilonOf(Float32/Float64)
- 缺失覆盖：整数类型的 epsilon 值（应为 0）

## 已有代码上下文
`shim_limits.cj:13` 中 `NumericLimits<T>.epsilon(hint)` 对整数类型执行 `hint - hint` → 返回 `T(0)`：
```cangjie
public static func epsilon(hint: T): T {
    if (hint is Float64) {
        return (2.220446049250313e-16 as T).getOrThrow()
    }
    if (hint is Float32) {
        return (Float32(1.1920929e-7) as T).getOrThrow()
    }
    return hint - hint
}
```
`epsilonOf<T>(hint)` 在 `shim_limits.cj:25-27` 委托给 `NumericLimits<T>.epsilon`，无需单独为整数添加测试。

## 测试函数设计

参照 `testNumericLimitsFloat32Epsilon` 模式：

| 函数名 | hint 类型 | 期望值 |
|--------|----------|--------|
| `testNumericLimitsInt64Epsilon` | `Int64(0)` | `Int64(0)` |
| `testNumericLimitsInt32Epsilon` | `Int32(0)` | `Int32(0)` |
| `testNumericLimitsInt16Epsilon` | `Int16(0)` | `Int16(0)` |

可选：`testNumericLimitsInt8Epsilon` 使用 `Int8(0)`，期望 `Int8(0)`。

## 验证
- `cjpm build` 编译通过
- `cjpm test` 新增测试全部 PASSED，无回归（基线 372）
