# R1: GLM Phase 4 — OOD 设计审查（common.cj / exponential.cj / trigonometric.cj）

审查时间：2026-06-30

### 审查范围

| 文件 | 当前状态 |
|------|---------|
| `cjglm/src/detail/common.cj` (365 行) | 替换 stub → 完整实现 |
| `cjglm/src/detail/exponential.cj` (61 行) | 新建完整实现 |
| `cjglm/src/detail/trigonometric.cj` (257 行) | 替换 stub → 完整实现 |
| `cjglm/src/detail/stdmath_shim.cj` (104 行) | 新建（支撑文件） |

### 发现

#### [一般] roundEven 奇偶判断分支反转

- **位置**：`cjglm/src/detail/common.cj:173~179`
- **描述**：`roundEven` 的偶数/奇数分支逻辑反转。当 `diffF64 == 0.5`（恰为 halfway）时，当前代码在 `rInt` 为偶数时返回 `r - one`、奇数时返回 `r`。正确行为应为：偶数时保持 `r`（已在最近偶数）、奇数时返回 `r - one`（退回到最近偶数）。
  - 示例：`roundEven(2.5)` → `roundT(2.5)=3`(odd) → 当前返回 `3`，应返回 `2`。
  - 示例：`roundEven(3.5)` → `roundT(3.5)=4`(even) → 当前返回 `3`，应返回 `4`。
  - 该 bug 影响全部浮点类型（Float16/Float32/Float64）的所有 halfway 输入。
- **建议**：交换第 176~179 行的分支：偶数分支应返回 `r`，奇数分支应返回 `r - one`。

#### [轻微] radians/degrees 使用 `pi<Float64>()` 而非 `pi<T>()`

- **位置**：`cjglm/src/detail/trigonometric.cj:208, 227`
- **描述**：`radians` 和 `degrees` 调用 `pi<Float64>()` 再转型为 `T`，而非直接调用 `pi<T>()`。设计文档（§3.1 trigonometric.cj）明确为 `x * pi<T>() / T(180)`。`pi<T>()` 已通过运行时 `match is` 返回正确的 `T` 类型值，额外经 `Float64` 中间值冗余且增加一次 `as T` 转型。
- **建议**：改为直接调用 `pi<T>()`，消除冗余转型。

#### [轻微] common.cj 的 abs 使用比较而非 delegate 到 absT

- **位置**：`cjglm/src/detail/common.cj:7~14`
- **描述**：`abs<T>` 使用比较分支（`if (a < z) { -a } else { a }`）而非委托 `absT`。设计文档未强制要求委托，数学上等价，但存在两个细微差异：(1) `a < z` 要求 `Comparable<T>` 约束，但 `abs` 已有该约束；(2) 对于 `-0.0`，比较路径中 `-0.0 < 0.0` 为 false（IEEE 754 -0.0 == 0.0 比较），因此 `.abs(-0.0)` 返回 `-0.0`，与 C++ GLM `std::abs(-0.0f)` 返回 `0.0f` 的行为一致，无影响。**无需修改**，仅作观察记录。

### 设计一致性检查总结

| 维度 | 结果 |
|------|------|
| **common.cj** 函数签名与 OOD §3.1 一致 | ✅ 完全一致（Group A/B/C/D/E/F 分组清晰，约束正确） |
| **exponential.cj** 函数签名与 OOD §3.1 一致 | ✅ 7 函数全部覆盖，标量+Vec1~Vec4 重载齐全 |
| **trigonometric.cj** 函数签名与 OOD §3.1 一致 | ✅ 16 函数全部覆盖（含 radians/degrees），asin/acos 越界保护正确 |
| **stdmath_shim.cj** 委托模式 | ✅ 25 个包装函数全部按统一模式实现 |
| **泛型约束策略** | ✅ Group A 用 `Number<T> & Comparable<T>`，Group B 用 `FloatingPoint<T>`，混用 `Integer<T>`、具体类型重载 |
| **Vec1~Vec4 逐分量重载** | ✅ 所有函数均提供 Vec1~Vec4 版本 |
| **边界处理** | ✅ acos/asin 越界保护返回 NaN；frexp NaN/Inf/Zero 前置检查；inversesqrt(0)=+Inf；modf 负数语义正确 |

### 已知偏差关联

- IMPL-02（Comparable 自动导入）：common.cj 未导入 Comparable — ✅ 正确
- IMPL-03（FloatingPoint 下无法使用 `==`）：roundEven 的 `diffF64 == halfF64` 和 frexp 的 `xF64 == 0.0` 均使用 Float64 比较 — ✅ 已规避
- IMPL-04（bits/Int32 转换方法）：floatBitsToInt/intBitsToFloat 使用 `(x as TargetType).getOrThrow()` 模式 — ✅ 一致
- IMPL-05（Float64.toInt64 缺失）：frexp 和 roundEven 使用 `(rF64 as Int64).getOrThrow()` — ✅ 一致
- IMPL-06（std.math 全限定名）：stdmath_shim.cj 使用 `import std.math as math` + `math.sqrt(...)` — ✅ 一致

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 1 |
| 轻微 | 1 |

注：roundEven 奇偶反转归为"一般"而非"严重"——仅影响 midway 输入的舍入方向（约占总输入的极小比例），但该问题是逻辑反转而非精度损失，需修复。

### 总评

三个源文件（common.cj 365 行、exponential.cj 61 行、trigonometric.cj 257 行）及支撑文件 stdmath_shim.cj（104 行）的整体实现质量高，与 OOD 设计文档 `docs/06_ood_phase4.md` 一致。泛型约束策略正确（`Number<T> & Comparable<T>` / `FloatingPoint<T>` / `Integer<T>` 三类约束覆盖）、stdmath_shim.cj 的 Float64 桥接模式一致、asin/acos 越界保护正确、frexp/ldexp/modf 元组返回与设计一致。

唯一需关注的缺陷是 **roundEven 奇偶判断反转**（common.cj:173~179），需交换分支逻辑。另有一处非功能性建议（trigonometric.cj:208/227 的 `pi<Float64>()` → `pi<T>()` 简化）。
