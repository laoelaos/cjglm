# 任务指令（v8）

## 动作
RETRY

## 任务描述
修复 `gtc/ulp.cj:55-57,63-65` 中 `float_distance` 函数的 `as` 转型结果未展开 `Option` 导致的编译错误，全量构建验证通过后确认 P2-5（G9 round.cj ±0 符号保留）完成。

### 具体代码变更

**`cjglm/src/gtc/ulp.cj`**（2 处修改）：

1. **Line 55-57** (Float32 版本):
```cangjie
// 修改前：
let a = (x.toBits() as Int32)
let b = (y.toBits() as Int32)
abs(a - b)

// 修改后：
let a = (x.toBits() as Int32).getOrThrow()
let b = (y.toBits() as Int32).getOrThrow()
abs(a - b)
```

2. **Line 63-65** (Float64 版本):
```cangjie
// 修改前：
let a = (x.toBits() as Int64)
let b = (y.toBits() as Int64)
abs(a - b)

// 修改后：
let a = (x.toBits() as Int64).getOrThrow()
let b = (y.toBits() as Int64).getOrThrow()
abs(a - b)
```

### 无需修改的内容
- `src/gtc/round.cj` — G9 fix 已在 v7 正确完成（三处 `return x`）
- `tests/glm/gtc/round_test.cj` — 三个 -0.0 位模式对比测试已到位
- `docs/diag/impl/04_diag.md:483` — G9 ✅ 已修复 已标记

## 选择理由
R7 的 round.cj G9 修复代码正确性已通过全部 review（design/code/test/plan r2 均 APPROVED），验证失败的唯一原因是 `cjpm test` 全量构建暴露了 `gtc/ulp.cj` 中预存的编译错误：`(x.toBits() as Int32)` 返回 `Option<Int32>` 而非 `Int32`，`-` 运算符无法在 `Option` 类型上执行。此错误非 v7 引入，但之前被增量编译掩盖。修复 ulp.cj 后全量构建即可通过并确认 P2-5 完成。

## 任务上下文
- G9 条目（04_diag.md:483）：round.cj zero 分支 `return (Float64(0) as T).getOrThrow()` → `return x`，保留 -0.0 符号
- round.cj L9-10, L29-31, L47-49：三处 `return x` 已验证
- round_test.cj L88-101：`testRoundPowerOfTwoNegZero`、`testCeilPowerOfTwoNegZero`、`testFloorPowerOfTwoNegZero`
- ulp.cj L53-57：Float32 float_distance — `(x.toBits() as Int32)` 需 `.getOrThrow()`
- ulp.cj L61-65：Float64 float_distance — `(x.toBits() as Int64)` 需 `.getOrThrow()`
- ulp.cj L2：import `glm.detail.abs` — 已存在，无需新增
- ulp.cj 顶部 `@OverflowWrapping` 属性保持不变

## 验证标准
1. `cjpm test` 编译通过（仅预存 warnings，无 errors）
2. G9 的三个 -0.0 测试用例（`testRoundPowerOfTwoNegZero`、`testCeilPowerOfTwoNegZero`、`testFloorPowerOfTwoNegZero`）通过
3. ulp.cj 中 `float_distance` 函数（Float32/Float64 版本）编译通过且测试通过
4. 原有 435+ 测试中的 ulp 相关测试不受影响
5. plan.md 路线表 v8 列 P2-5 标记 ✅
