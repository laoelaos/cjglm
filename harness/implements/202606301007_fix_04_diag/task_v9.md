# 任务指令（v9）

## 动作
NEW

## 任务描述
补充 core 函数库测试覆盖，涉及 4 个测试文件、8 个问题（G13-G20）。全部为测试文件变更，不修改生产代码。

### 具体变更

**1. G13 — `tests/glm/detail/common_test.cj:382-387`**
testFractVec4 输入 `(1.3, 2.7, -0.5, 0.0)`，补充 `z` 和 `w` 断言：
```cangjie
@Expect(r.z, Float64(0.5))   // fract(-0.5) = 0.5
@Expect(r.w, Float64(0.0))   // fract(0.0) = 0.0
```

**2. G14 — `tests/glm/detail/exponential_test.cj`**
补充边界测试：
- `sqrt(Float64(-1.0))` → NaN 验证
- `log(Float64(0.0))` → -Inf 验证
- `log(Float64(-1.0))` → NaN 验证
- （`inversesqrt(0)` → +Inf 测试已存在：`testInversesqrtZero`）

**3. G15 — `tests/glm/detail/stdmath_shim_test.cj`**
为 25 个 stdmath_shim 函数中缺失 Float16 版本的全部 18 个函数补充 Float16 测试。当前仅有 7 个函数有 Float16 测试，需补充其余 18 个。

**4. G16 — `tests/glm/detail/stdmath_shim_test.cj`**
为 25 个 shim 函数的 Float32 测试补充多组输入值（当前多数仅测试单组值），使 Float32 测试深度与 Float64 版本对齐（2-3 组值含边界）。示例：对 `sinFloat32` 除 `0.0` 外补充 `pi/6`、`pi/4`、`pi/2`；对 `sqrtFloat32` 补充 `0.0`、`Inf`、正数抽样；对 `logFloat32` 补充 `0.0`（-Inf）、`-1.0`（NaN）、正数抽样。

**5. G17 — `tests/glm/detail/trigonometric_test.cj`**
补充三角恒等式验证（scalar + Vec1~Vec4）：
- `sin²(a) + cos²(a) = 1`（多角度抽样），使用容差比较：`|sin²(a) + cos²(a) - 1| < epsilon`（epsilon 取 `1e-12` 用于 Float64，`1e-6` 用于 Float32，`1e-3` 用于 Float16），避免 `@Expect` 精确相等因 IEEE 754 浮点舍入误差失败
- `tan(a) ≈ sin(a) / cos(a)`，使用交叉相乘验证：`|sin(a) - tan(a) * cos(a)| < epsilon`
- `1 + tan²(a) ≈ sec²(a)`，使用 `|sec²(a) - (1 + tan²(a))| < epsilon`

**6. G18 — `tests/glm/detail/trigonometric_test.cj`**
补充 Float16 版本的 `asin(±1)` 和 `acos(±1)` 边界测试（Float64 版本已有）。

**7. G19 — `tests/glm/detail/trigonometric_test.cj`**
补充 Float16 `atan2` 第二分支测试（当前仅测试 `atan2(0, 1)` 一个分支）。

**8. G20 — `tests/glm/detail/trigonometric_test.cj`**
补充 Vec3/Vec4 非零向量的 asinh/acosh/atanh 测试（当前仅测试全零向量）。

**9. 更新 `04_diag.md` 标记 G13-G20 为 ✅ 已修复**
修改 `04_diag.md` 第 246-300 行的 G13-G20 条目，在"诊断结论"末尾添加 `✅ 已修复` 标记。

**10. 更新 plan.md 路线表**
在 plan.md 路线表中标记 P4-1 v9 列为 ✅。

## 选择理由
P2-5（G9 round.cj ±0 + ulp.cj 编译修复）在 v8 验证 PASSED。P3-1（G3, G11 文档对齐）已在前面实施过程中同步完成。剩余工作量最大的批次为 P4（测试覆盖），按计划表 P4-1 为当前最高优先级——core 函数库测试基础且独立，完成后可继续 P4-2~P4-4。

## 任务上下文
- **P4-1 范围**：仅修改 tests/ 目录下的测试文件，不涉及 src/ 生产代码
- **deviations.md 检查**：本次变更均为测试文件修改，不改变生产代码行为，预计不会产生新偏差。实施完成后需确认偏差记录无需更新，确认结果在验证报告中说明
- **G13 代码位置**：`tests/glm/detail/common_test.cj:382-387`（testFractVec4）
- **G14 代码位置**：`tests/glm/detail/exponential_test.cj:37-52`（已有 testSqrt/testInversesqrtZero 可参考格式）
- **G15-G16 代码位置**：`tests/glm/detail/stdmath_shim_test.cj`（约 900 行，Float64/Float32 测试可作为 Float16 模板）
- **G17-G20 代码位置**：`tests/glm/detail/trigonometric_test.cj`（约 834 行，Float64 恒等式和 asin/acos ±1 边界测试可作为参考）
- 测试框架使用仓颉内置 `@Test` + `@Expect` 注解

## 验证标准
1. `cjpm test` 全量编译通过，435+ 测试全部通过，0 失败
2. G13：testFractVec4 的 z/w 断言与期望值匹配
3. G14：sqrt(-1) → NaN，log(0) → -Inf，log(-1) → NaN 断言正确
4. G15：所有 25 个 shim 函数均有 Float16 版本测试
5. G16：Float32 测试深度与 Float64 对齐（2-3 组值）
6. G17-G20：三角恒等式和边界测试均通过
7. 更新 plan.md 路线表 P4-1 v9 列标记 ✅
8. 04_diag.md 中 G13-G20 条目均已标记 ✅ 已修复

## 修订说明（v9 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| G17 三角恒等式测试缺少容差处理，`sin²+cos²` 因 IEEE 754 舍入不会精确等于 1.0 | G17 描述已改为容差比较：`\|sin²+cos² - 1\| < epsilon`，交叉相乘验证 `tan=s/c`，`epsilon` 按精度分层（Float64: 1e-12, Float32/Float16: 1e-6） |
| G16 Float32 增量描述不够明确 | G16 描述已补充示例（sin 补充 pi/6/pi/4/pi/2，sqrt 补充 0/Inf，log 补充 0/-1） |
| 计划未提及 deviations.md 更新检查 | 任务上下文已添加 deviations.md 检查说明：变更均为测试文件，预计无新偏差，实施后需确认并记录 |

## 修订说明（v9 r2）
| 审查意见 | 修改措施 |
|---------|---------|
| 计划未包含更新 plan.md 路线表的步骤 | "具体变更"已新增第 10 项：更新 plan.md 路线表 P4-1 v9 列标记 ✅ |

## 修订说明（v9 r3）
| 审查意见 | 修改措施 |
|---------|---------|
| G17 Float16 epsilon=1e-6 过紧（Float16 machine epsilon ~9.77e-4，累计误差约 1e-3） | G17 Float16 epsilon 从 1e-6 改为 1e-3；Float64=1e-12、Float32=1e-6 不变 |
