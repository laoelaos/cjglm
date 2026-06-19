根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 问题 1（中等）：`const if` 为文档简写而非语法关键字，`if` 在 `const` 函数中的分支抑制行为未经验证

**问题描述**：文档全文在 `ComputeEqual.callConst`（§3.5）、`isIec559Of<T>()`（§3.6）、`mod` 双路径（§4.3）、`const if` 抑制验证（§10）等关键位置将 `const if` 当作已知的仓颉关键字使用。经查阅仓颉 const 特性文档，`const if` 并非独立关键字，而是文档作者对"`const` 函数中的 `if` 表达式"的简写。核心设计不依赖不存在的语法，而是依赖 `if` 在 `const` 函数体内的分支抑制行为——此行为虽未在 const 文档中明确说明，但具有语义合理性。

**所在位置**：§3.5 ComputeEqual.callConst（`const if (isIec559Of<T>())`）、§3.6 isIec559Of 实现（`const if (T(0) is Float64 || T(0) is Float32)`）、§4.3 mod 双路径（`const if (isIec559Of<T>())`）、§10 const if 抑制验证（全文）

**改进建议**：
- 全文将 `const if (...)` 改写为 `if (...)`，避免误导实施者编写不存在的关键字
- 在 §7 新增设计决策记录此依赖的验证状态
- 此问题影响面覆盖 §3.5 容差比较路径、§3.6 编译期类型检测、§4.3 mod 浮点路径等核心设计要素的可行性

### 问题 2（中等）：`public import glm.detail.{ add, sub, mul, div, mod }` 存在潜在的命名冲突

**问题描述**：§2 lib.cj 使用 `public import glm.detail.{ add, sub, mul, div, mod }` 从 `glm.detail` 包导入算术函数。这些函数当前定义在 `scalar_vec_ops.cj` 中。但 `glm.detail` 包由 12+ 个文件组成，若未来其他文件也在 `glm.detail` 包中定义了同名函数，`public import` 将因 `glm.detail` 范围内的重名导致导入歧义。

**所在位置**：§2 lib.cj、§4.3 具名函数定义位置

**改进建议**：
- 在 §2 lib.cj 的 `public import` 注解中补充命名空间占用声明：约定 `glm.detail` 包中只有 `scalar_vec_ops.cj` 文件定义 `add`/`sub`/`mul`/`div`/`mod` 包级函数
- 或在 §7 新增设计决策，明确约定 `scalar_vec_ops.cj` 对上述名称的独占权

### 问题 3（中等）：§11 迁移成本评估缺少 `equalExact` 迁移模式的系统性覆盖

**问题描述**：§11 评估了 8 类迁移成本（`&&/||`、`++/--`、跨类型赋值、`bitwiseNot`、`Inf==Inf`、`@OverflowWrapping`、别名命名、跨 Q 赋值），但未包含 `equalExact` 的迁移模式。C++ GLM 中没有 `equalExact`——用户直接使用 `==` 进行 IEEE 754 精确比较。迁移到仓颉后，如果 `==` 默认使用容差比较（§4.5），则原 C++ 代码中依赖精确 `==` 语义的场景需要被识别并替换为 `equalExact()`。

**所在位置**：§11（全文）

**改进建议**：
- 在 §11 中新增子节"§11.9 `equalExact` 迁移模式"，覆盖 C++ GLM 原生 `==` 的 IEEE 754 精确语义 vs 仓颉容差 `==` 的行为差异、需要替换的场景清单、搜索替换规则、迁移工作量评估

### 问题 4（一般）：对 `references/glm-1.0.3/` 的引用基于假设其存在，但未验证关键路径的实现准确性

**问题描述**：§7 D6 对 `GLM_CONFIG_CLIP_CONTROL` 默认值的修正依赖于对参考实现 `setup.hpp` 的解读。整个文档对参考实现的使用策略（§8.4）依赖于"参考实现存在且结构正确"的假设，而设计文档未对参考实现进行完整性检查。

**所在位置**：§7 D6、§8.4

**改进建议**：
- 在 §1 或 §8.4 中补充前置验证步骤：在编码启动前，确认参考实现中条件编译逻辑与 §7 D6 描述的决策分支一致
- 对 §8.4 策略 4 增加"若参考实现中的条件分支逻辑与当前描述不符，以参考实现为准并更新 D6"的兜底条款

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及的问题）

以下问题已在 v3~v9 迭代中被逐一修复，当前诊断不再提及：
- `bitwiseNot()` 对 `VecN<Bool, Q>` 的排除策略不可行（v3 P1）
- 别名命名约定 PascalCase 的迁移成本评估（v3 P2）
- 跨 Q 赋值迁移模式（v3 P3）
- `epsilonOf<T>()` Option B 不可行（v3 P4）
- `operator[]` const 取值形式（v3 P5）
- `mod` 浮点实现的外部依赖验证（v3 P6）
- `mod` const if 函数声明（v4 P1）
- `length()` const 声明（v4 P2, v5 P1）
- D32 设计决策缺失（v5 P2）
- D13 范围声明自相矛盾（v5 P3）
- D29+D30 组合回退分析缺失（v5 P4）
- increment/decrement/bitwiseNot const 声明（v5 P5）
- 大写驼峰长期认知负担（v5 P6）
- 文档版本标识混乱（v6 P1）
- 缺少 cjpm.toml 和项目脚手架（v6 P2）
- D32 const 验证缺口（v6 P3）
- mod const if 编译抑制验证（v6 P4）
- extend 块中 const 函数声明（v7 P1）
- const if 中 T2 is Bool 验证（v7 P2）
- 测试文件未覆盖（v7 P3）
- << 溢出策略描述（v7 P4）
- 构造函数 Q 约束充分性（v7 P5）
- const if 编译期分支抑制验证计划（v7 P6）
- @OverflowWrapping 扩展成员函数标注（v8 P1）
- Vec1 构造函数不对称性说明（v8 P2）
- countof 范围跟踪（v8 P3, v9 P6）
- 跨类型构造函数 T2 约束矩阵（v8 P4）
- lib.cj public import 路径 v9 P1）
- 目录树形图结构（v9 P5）
- 测试包可见性假设验证（v9 P4）

### 持续存在的问题（在多轮反馈中反复出现的问题，需重点解决）

1. **equalExact 覆盖不完整**（v9 P3 → 本轮 P3）：
   - v9 P3 指出 equalExact 在验证计划中缺少 NaN 测试项和行为差异说明。
   - 本轮 P3 进一步发现 §11 迁移成本评估中 equalExact 迁移模式完全缺失。
   - **综合修复方向**：equalExact 需要在测试计划（§12.1/§9.3）、验证计划（§10）、迁移成本评估（§11）三个章节中都被完整覆盖。

2. **参考实现验证策略不足**（v7 P7 → v9 P2 → 本轮 P4）：
   - v7 P7 要求补充参考实现使用策略（已修复，在 §8.4）。
   - v9 P2 发现 D6 中 `GLM_CLIP_CONTROL_DISABLE` 宏在参考实现中不存在（已修复）。
   - 本轮 P4 进一步指出整个文档缺少前置验证步骤确认参考实现与设计假设的一致性。
   - **综合修复方向**：在 §1 或 §8.4 中补充前置验证步骤和兜底条款，确保设计与参考实现之间的偏差能被系统性捕获。

### 新发现的问题（本轮新识别的问题）

1. **`const if` 为文档简写而非语法关键字**（本轮 P1）：
   - 此前多轮聚焦于 `const if` 的编译抑制行为验证，但本轮首次指出 `const if` 本身不是仓颉有效关键字——文档作者以简写形式编写了不存在的语法结构。
   - 修复范围覆盖 §3.5/§3.6/§4.3/§10，需要将 `const if (...)` 全部改写为 `if (...)`。

2. **`public import` 的 `glm.detail` 包内命名冲突风险**（本轮 P2）：
   - 此前（v9 P1）纠正了 `public import` 的包路径错误，但未评估命名空间污染风险。
   - 本轮首次提出 `glm.detail` 多文件包中函数名独占权的约定需求。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606190029_glm-migration-ood\a_v10_copy_from_v9.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606190029_glm-migration-ood\requirement.md
