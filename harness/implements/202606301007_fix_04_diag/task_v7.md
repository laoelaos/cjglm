# 任务指令（v7）

## 动作
NEW

## 任务描述
修复 `gtc/round.cj` 中 `roundPowerOfTwo`、`ceilPowerOfTwo`、`floorPowerOfTwo` 三个函数的 ±0 输入丢失负零符号问题（G9）。

### 具体修改

**1. 修改 `cjglm/src/gtc/round.cj`**

三个函数的零值分支均使用 `(Float64(0) as T).getOrThrow()` 构造返回值，这始终返回 +0，丢失了输入负零的符号位。改为直接返回 `x` 以保留原始符号位：

| 函数 | 行号 | 当前代码 | 改为 |
|------|------|---------|------|
| `roundPowerOfTwo` | 9-11 | `return (Float64(0) as T).getOrThrow()` | `return x` |
| `ceilPowerOfTwo` | 30-32 | `return (Float64(0) as T).getOrThrow()` | `return x` |
| `floorPowerOfTwo` | 48-50 | `return (Float64(0) as T).getOrThrow()` | `return x` |

**2. 更新 `04_diag.md`**
在 G9 条目（第 483 行）追加 `✅ 已修复` 标记。

**3. 补充测试 - 位级符号验证**
在 `cjglm/tests/glm/gtc/round_test.cj` 中为每个受影响的函数添加 -0.0 输入测试，验证符号位保留。

⚠️ 注意：`@Expect` 底层使用 `==`，而 IEEE 754 规定 `-0.0 == 0.0` 为 true，因此不能直接用 `@Expect(func(-0.0), -0.0)` 验证。必须使用**位模式对比**——通过 `toBits()` 方法将浮点数转为位模式后再用 `==` 比较（±0 位模式不同：+0 = `0x0000000000000000`，-0 = `0x8000000000000000`）：

- `@ExpectTrue(roundPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())`
- `@ExpectTrue(ceilPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())`
- `@ExpectTrue(floorPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())`

（替代方案：取倒数符号检测 `Float64(1.0) / func(Float64(-0.0)) == -Float64.infinity()`，因 `1.0 / -0.0 = -Inf`，`1.0 / +0.0 = +Inf`）

**4. 更新 plan.md 路线表**
在 `plan.md` 的实施路线表格中新增 `v7` 列，在 P2-5 行的 `v7` 列打 ✅ 确认完成。

## 选择理由
P2-4（G8）已在 v6 完成并通过验证。P2-5（G9）是 P2 批次剩余的最后一个任务，同为"第二优先（API 完整性）"组别，且修改范围极小（仅 3 个函数体各改一行），风险低。完成后 P2 批次全部完成，可以进入 P3 和 P4 批次。

## 任务上下文
- **问题编号**：G9
- **严重等级**：一般
- **根因**：实现编码错误
- **OOD 设计覆盖**：OOD 文档 §3.3 gtc/round.cj 边界行为表明确要求 ±0 保留符号。编码实现未遵循设计规范。
- **证据**：GLM 1.0.3 中负零输入通过浮点运算自然传播符号；仓颉版本直接构造 `Float64(0)` 强制返回 +0

### 涉及文件
| 文件 | 操作 | 说明 |
|------|------|------|
| `cjglm/src/gtc/round.cj:9-11,30-32,48-50` | 修改 | 三个函数的零值分支改为返回 `x` 而非构造 +0 |
| `../../docs/diag/impl/04_diag.md:483` | 修改 | G9 条目追加 `✅ 已修复` |
| `cjglm/tests/glm/gtc/round_test.cj` | 修改 | 补充 -0.0 符号保留测试 |

### 验证方式
运行 `cjpm test` 确认：
1. 编译通过（无新增 errors/warnings）
2. 所有 435+ 测试通过，0 失败
3. -0.0 测试用例通过位模式对比验证符号位保留

---

## 修订说明（v7 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| [严重] 测试方案无法验证 ±0 符号位保留：`@Expect` 底层使用 `==`，而 IEEE 754 规定 `-0.0 == 0.0` 为 true | 将测试断言改为位模式对比（`toBits()`）：`@ExpectTrue(func(-0.0).toBits() == (-0.0).toBits())`。已在"补充测试"中详细说明选型理由并给出替代方案（取倒数符号检测） |
| [一般] plan.md 路线表未规划本条更新 | 新增步骤 4："更新 plan.md 路线表"，在实施路线表格中新增 `v7` 列，在 P2-5 行的 `v7` 列打 ✅ 确认 |
