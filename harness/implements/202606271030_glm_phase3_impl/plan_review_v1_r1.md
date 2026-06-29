# 计划审查报告（v1 r1）

## 审查结果
REJECTED

## 发现

### **[严重] 实施路线表格状态列全为空**
requirement.md § 特殊要求第 1 条明确要求 "在 `plan.md` 开头添加详细的实施路线表格，之后每次进展打勾确认"。当前 `plan.md:8-25` 的 16 轮表格中"状态"列全部为空。初始计划提交时应为每轮标注初始状态（如 "⬜"），以便后续追踪完成度。空状态列导致计划无法作为实施进度的可追溯基线。

### **[一般] 测试文件未纳入计划文件清单**
task_v1.md 第 39-42 行要求为 R1 创建 `tests/glm/detail/test_scalar_constants.cj`，但 `plan.md:10` 的"文件"列仅列出 `detail/scalar_constants.cj, ext/scalar_constants.cj`。后续 15 轮同样未提及对应的测试文件。Plan 应反映完整的文件产出清单，否则实施环节可能遗漏测试创建。

### **[一般] R1 零参数函数的 `match` 类型分派路径不明确，可能误导实施环节**
`plan.md:32` 声明 "函数需使用 `where T <: FloatingPoint<T>` 约束并内部使用 match 分派具体类型"，`task_v1.md:28-29` 进一步引用 `epsilonOf<T>(hint)` 的运行时分派模式。

问题在于：
- `epsilon<T>()` / `pi<T>()` / `cos_one_over_two<T>()` 均为 **零参数函数**，体内无可供 `match` 的值
- 引用的 `epsilonOf<T>(hint)` 恰因携带 `hint: T` 形参才能做运行时类型分派

OOD §3.12 line 809 已给出明确的委托方案 —— `epsilon<T>()` 内部应调用 `epsilonOf<T>(T(0))` 或 `epsilonOf<T>(T(1))`；`pi<T>()` 可使用已验证的 `FloatingPoint<T>.getPI()` 静态方法；`cos_one_over_two<T>()` 可通过 `getPI() + cos` 计算。Plan 和 task 均未引用 OOD 的这一权威指引，也未说明零参数场景的适配策略，可能导致实施者走弯路。

### **[轻微] R2 单轮 75 个 stub 签名工作量偏大**
`plan.md:11` R2 要求一次性产出 detail/trigonometric.cj 中 15 个函数 × 5 个签名 = 75 个 stub 签名（标量 + Vec1~Vec4）。虽均为机械性复制 OOD §3.11 签名模板，但批量编码的疲劳度和排错成本较高。建议明确标注该轮为纯机械签名复制，或考虑拆分为标量 + Vec1~Vec2 / Vec3~Vec4 两个子轮次。

## 修改要求

1. **[严重]** 填充实施路线表格（`plan.md:8-25`）的"状态"列 —— 初始状态全部标记为 "⬜"
2. **[一般]** 每轮"文件"列补充对应的测试文件路径（如 R1 追加 `tests/glm/detail/test_scalar_constants.cj`）
3. **[一般]** R1 段落（`plan.md:30-32`）补充零参数函数的实现策略指引 —— 明确使用 OOD §3.12 line 809 的委托模式（`epsilon<T>()` → `epsilonOf<T>(T(0))`，`pi<T>()` → `T.getPI()`，`cos_one_over_two<T>()` → `cos(pi<T>() / T(4))`），或说明通过 `T(Float64(0))` 构造临时值后 match（H1 已验证路径）
4. **[轻微]** R2 段落建议拆分或标注为纯机械拷贝，降低单轮编码风险
