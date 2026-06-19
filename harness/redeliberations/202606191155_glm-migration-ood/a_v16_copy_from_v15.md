# GLM 1.0.3 仓颉迁移首轮 OOD 设计方案（v16）

> **产出内部版本号**：v16
> **外部再审议迭代轮次**：第 16 次（第 16 轮设计迭代）
> **此轮审查来源**：a_v16_iteration_requirement.md
> **上一版本**：a_v15_copy_from_v14.md（v15）
> **修订日期**：2026-06-19
> **版本谱系说明**：本文件源自 v15（a_v15_copy_from_v14.md），在其基础上经过 v15 修订后进一步迭代为本版本 v16。版本追溯路径从 v4 起始（v1-v3 已被 v4 重构合并，不再追溯）：v4 → v5 → v6 → v7 → v8 → v9 → v10 → v11 → v12 → v13 → v14 → v15 → v16

---

## 1. 概述

### 编码实施快速参考

> **📋 编码实施快速参考**（面向编码实施者，按查阅频率排序）：
> 
> | 查阅目的 | 定位章节 |
> |---------|---------|
> | 项目初始化与 `cjpm.toml` 配置 | §2 项目初始化与构建基础设施 |
> | 目录结构模板 | §2 初始目录结构 |
> | 编码前必须验证的编译器假设清单 | §2.1 编码前验证检查清单（25 项，含验证方法/通过标准/回退方案） |
> | Vec 结构体定义模板（成员/构造函数/运算符） | §3.2 Vec 结构体系 + §4.1 构造函数签名清单 + §4.3 算术运算符语法模板 |
> | `extend` 块中位运算符模板 | §4.4 extend 块完整语法示例 |
> | `@OverflowWrapping` 标注策略（何处标注、何处不标注） | §4.6 `@OverflowWrapping` 标注策略（总结段） |
> | Qualifier 接口定义与 Aligned 可见性策略 | §3.1 Qualifier 体系 |
> | 类型别名映射表（256 个向量别名 + 44 个标量别名） | §3.7 标量别名表 + §3.8 256 个别名格式示例表 + 脚本模板 |
> | 别名生成脚本模板 | §3.8 最小生成脚本示例（~40 行 Python） |
> | 迁移顺序（增量编译验证步骤） | §8.3 迁移顺序与依赖说明 |
> | 参考实现使用策略（前置验证项） | §8.4 参考实现使用策略 |
> | 首轮排除清单（哪些不迁移及其理由） | §8.5 首轮内容排除清单 |
> | 跨类型构造函数 T2 类型转换边界 | §4.1 T2 跨类型约束矩阵 + §9.4 类型转换边界表 |
> | 异常场景与边界行为 | §9 异常场景和边界条件补充 |
> | Bool Vec 专用 API 行为（哪些可用、哪些编译错误） | §3.2 VecN<Bool,Q> 完整行为约定 |
> | const 上下文中不可用的 API 清单 | §3.2 const 上下文 API 可用性速查表 |
> | 迁移模式（C++ → 仓颉代码映射） | §11 迁移成本评估各子节 |
> | 编译器验证依赖 → 设计路径选择 | §12.3 决策映射表 |
> | 验收标准 | §12.2 验收标准 |
>
> 编码阶段建议：先在 §2.1 完成全部 25 项编码前验证，再按 §8.3 迁移顺序分阶段编码。每完成一个阶段后运行 `cjpm build` 增量验证。

### 范围可追溯性承诺

**范围可追溯性**：本方案全量映射 roadmap §3E/3G 定义的首轮迁移范围。§8 提供范围可追溯性对照表，逐项定位 roadmap 子范围编号对应的设计章节与迁移文件。用户需求中的"首轮"对应 roadmap §3E + §3G 范围确认结论中的基础设施层（子范围 1）、类型系统（子范围 2a/4~8）及 shim 层（子范围 S1~S3）。**全量覆盖声明**：本方案已对 docs/01_roadmap.md §3E/3G 定义的首轮全部子范围逐项落实，无遗漏或未约定的范围缺口。所有偏离 roadmap 草案的设计决策已在 §8.2 对照表"偏离说明"列显式记录。

### 历史参考与已知问题追踪

**历史迭代参考**：本设计方案参考了此前两轮再审议的历史记录，以下列出关键循环问题及其当前状态：

| 历史记录 | 时间 | 与本方案的关系 |
|---------|------|--------------|
| 再审议 202606170050 | 2026-06-17 | 首轮架构审议，确立了 OOD 框架和核心抽象（Qualifier 接口 + Vec 结构体系），本轮继承其架构级决策 |
| 再审议 202606190029 | 2026-06-19 | 首轮审议循环，识别出参考实现行号标注、编译器假设分散、排除清单缺失等 6 个问题，本轮针对性地逐一解决 |

**循环问题状态追踪**（截至本版本 v10）：

| 问题编号 | 问题描述 | 首次发现轮次 | 状态 | 解决版本 |
|---------|---------|------------|------|---------|
| P1 | §8.4/§7 D6 参考实现行号错误 | 第 1 轮 | ✅ 已解决（v2）— 移除全部行号标注，仅保留文件名引用 |
| P2 | 编译器行为假设分散无集中全景图 | 第 1 轮 | ✅ 已解决（v2）— 新增 §7 集中表格 |
| P3 | 缺少"首轮内容排除清单"结构化表格 | 第 1 轮 | ✅ 已解决（v2）— 新增 §8.5 |
| P4 | 跨 Q 等价假设影响范围表缺失 | 第 1 轮 | ✅ 已解决（v2）— 新增 §3.1 分节 |
| P5 | 版本标识不一致（标题仍标注 v30） | 第 1 轮 | ✅ 已解决（v2）— 更新为 v2 |
| P6 | 未显式参考前两次再审议历史记录 | 第 1 轮 | ✅ 已解决（v2）— 新增本子节 |
| P7 | §7 D6 CLIP_CONTROL 默认值跨文件一致性 | 第 2 轮 | ✅ 已解决（v11）— roadmap 已同步，默认值一致为 `0x0A`。经参考实现条件编译逻辑验证（`setup.hpp:563-584`），文档值与 roadmap 值均已统一为 `0x0A`，跨文件冲突已不存在 |
| P8 | 标量与向量别名精度前缀命名风格不一致未说明 | 第 2 轮 | ✅ 已解决（v3）— §3.8 新增风格差异说明段落 |
| P9 | equalEpsilon 对 Bool Vec 编译错误未覆盖在迁移成本中 | 第 2 轮 | ✅ 已解决（v3）— §4.5 新增迁移指南，§11 新增 §11.15 |
| P10 | Vec4 构造函数重载解析验证覆盖不足 | 第 2 轮 | ✅ 已解决（v3）— 升级为参数数量全扫描，新增系统性扫描策略 |
| P11 | §2 模块依赖图箭头方向与概念依赖相反 | 第 2 轮 | ✅ 已解决（v3）— 新增 scalar_vec_ops → type_vecN 箭头 |
| P12 | fromBoolVecQ2 命名中 Q2 含义不直观 | 第 2 轮 | ✅ 已解决（v3）— §4.8 新增 Q2 命名说明 |
| P13 | cjc-version 缺乏版本最低要求说明 | 第 2 轮 | ✅ 已解决（v3）— §2 新增版本要求说明，§2.1 新增验证项⑮ |
| P14 | const init 与跨类型 init<T2,Q2> 共存性分析缺失 | 第 2 轮 | ✅ 已解决（v4）— §3.2 新增构造函数分类与共存安全性分析，§2.1 新增验证项⑯ |
| P15 | % 运算符编译器行为假设未经验证 | 第 2 轮 | ✅ 已解决（v4）— §2.1 新增验证项⑰，§4.3/D13 补充条件性移动策略 |
| P16 | public import 重导出策略依赖编译器行为未验证 | 第 2 轮 | ✅ 已解决（v4）— §2.1 新增验证项⑱ |
| P17 | 路径 A epsilonOf<T>() 对整数类型不可用 | 第 2 轮 | ✅ 已解决（v4）— §3.5 补充可用性分析并重新评估路径排序，§2.1 新增验证项⑲ |
| P18 | Gen 脚本 uint 别名硬编码方式不利扩展 | 第 2 轮 | ✅ 已解决（v4）— §3.8 脚本模板将 uint 纳入 SCALAR_MAP 循环生成 |
| P19 | scalar: T vs init(v: Vec1<T,Q>) 重载歧义未分析 | 第 2 轮 | ✅ 已解决（v4）— §2.1 新增验证项⑳ |
| P20 | Inf==Inf 验收标准未反映两种合法路径 | 第 2 轮 | ✅ 已解决（v4）— §12.2 新增条件依赖验收项 |
| P21 | @Derive[Hashable] 约束检查策略可能不一致 | 第 2 轮 | ✅ 已解决（v4）— §2.1 新增验证项㉑，§7 D37-A13 更新为待验证 |
| P22 | 目录结构树缩进错误 | 第 2 轮 | ✅ 已解决（v4）— §2 修正缩进 |
| P23 | 版本号标识维度混淆 | 第 2 轮 | ✅ 已解决（v4）— 文件头部分别标注"产出内部版本号"和"外部再审议迭代轮次" |
| P24 | Vec1 广播运算模式完全遗漏 | 第 3 轮 | ✅ 已解决（v5）— §4.3 新增 Vec1 广播运算模式设计专节，§4.4 位运算符同步补充，§4.6 标注策略补充广播运算符方案，§8.5 新增排除条目，§11 新增迁移成本评估 |
| P25 | `abs()` 调用形式在代码示例中与仓颉标准库 API 不匹配 | 第 3 轮 | ✅ 已解决（v5）— §7 D29 A03 修正为 `std.math.abs` 包级函数，代码示例补充 import 依赖标注，§2.1 新增验证项 |
| P26 | 跨类型复合赋值可用性损失未评估 | 第 3 轮 | ✅ 已解决（v5）— §4.3 复合赋值说明段新增显式声明，§8.5 新增排除条目，§11 新增迁移模式评估 |
| P27 | Vec 别名自引用风险未闭环 | 第 1 轮 | ✅ 已解决（v5）— §2.1 新增验证项，§3.8 新增同名别名风险脚注与验证依赖说明 |
| P28 | Vec1 运算符设计完整性未做独立分析 | 第 3 轮 | ✅ 已解决（v5）— §4.3 新增 Vec1 运算符设计专节，分析语义重叠/调用方指引/矩阵角色 |
| P29 | Bool→Numeric 降级未在排除清单/迁移成本中覆盖 | 第 3 轮 | ✅ 已解决（v5）— §8.5 新增条目，§11 新增迁移模式评估 |
| P30 | 历史严重问题 P14/P15 修复状态需抽查确认 | 第 3 轮 | ✅ 已解决（v5）— 修订说明中记录抽查过程与结论 |
| P31 | Vec1 跨类型标量复合赋值特殊性未被覆盖 | 第 3 轮 | ✅ 已解决（v5）— 作为 §11 迁移模式子场景一并评估 |
| P32 | C++ GLM `compute_equal` 行为一致性的系统性误述 | 第 4 轮 | ✅ 已解决（v6）— §3.5/§4.5/§9.3/§11.5/§11.9 五处同步修正 |
| P33 | §4.6 `<<` 广播位运算符计数错误（遗漏 Vec1-op-VecN 方向） | 第 4 轮 | ✅ 已解决（v6）— 修正为 6 个并同步更新合计值 |
| P34 | §4.3 Vec1 广播复合赋值限定条件不精确 | 第 4 轮 | ✅ 已解决（v6）— 精确化为"仅支持同类型 T 右操作数" |
| P35 | §8.3 迁移顺序表阶段 3 并行标注不精确 | 第 4 轮 | ✅ 已解决（v6）— 补充计算依赖说明 |
| P36 | 机器 epsilon 容差值域局限性未声明 | 第 4 轮 | ✅ 已解决（v6）— §3.5 新增局限性说明段，§9.3 新增交叉引用 |
| P37 | C++ GLM  API 映射完整性与 type_vecN.inl 逐文件交叉验证 | 第 5 轮 | ✅ 已解决（v16）— 将扫描责任明确归属到设计审议方（提供依赖项核查清单），编码实施者按清单逐项确认后进入编码。§1 P37 下方新增完整核查清单表格（每文件 3~5 个核查要点），§8.3 阶段 0 同步更新执行人描述 |

#### 7 文件快速扫描依赖项核查清单

**责任归属**：设计审议方负责提供本核查清单及首次扫描确认；编码实施者负责在编码启动前逐项确认并在扫描结论上签字。

**执行时机**：阶段 0（§8.3），必须早于任何编码工作。

**退出标准**：7 项全部确认通过；若任一文件发现遗漏依赖，须更新对应设计章节并记录于范围变更日志后方可进入编码。

| 文件 | 风险等级 | 核查要点 | 确认标记 |
|------|---------|---------|---------|
| **1. setup.hpp** | 中 | ① GLM_CONFIG_CLIP_CONTROL 默认值 `0x0A` 与 `setup.hpp:563-584` 条件编译逐行一致；② 18 个 GLM_CONFIG_* 对应 §7 D6 全部覆盖；③ 检测宏（GLM_ARCH/GLM_COMPILER/GLM_PLATFORM）无间接引用到首轮文件；④ `GLM_SWIZZLE_DISABLED=2` 确保 swizzle 路径在首轮不可达 | ☐ |
| **2. qualifier.hpp** | 中 | ① `storage<L,T,Q>` 非 SIMD 路径仅使用 `T data[L]`（与 D23 一致）；② `genTypeTrait`/`init_gentype`/`find_best_type` 已排除至后续轮次且首轮无消费代码；③ `enum qualifier` → `interface Qualifier` + 空结构体映射无误；④ 前向声明 `vec`/`mat`/`qua` 注释性保留 | ☐ |
| **3. compute_vector_relational.hpp** | 低 | ① 简化 `ComputeEqual<T>` 移除 `IsFloat` 参数后功能等价性确认；② 非首轮的 `lessThan`/`greaterThan` 等具名函数无意外引用 | ☐ |
| **4. compute_vector_decl.hpp** | 低 | ① `compute_vec_*` 10 个策略结构体定义完整；② 首轮仅定义不消费，无运行时调用测试需求 | ☐ |
| **5. _vectorize.hpp** | 低 | ① Functor 按分量数拆分为 16 个独立定义无误；② 模板模板参数替换为仓颉函数类型参数后约束正确 | ☐ |
| **6. fwd.hpp** | 低 | ① 标量别名 44 个全量映射（含 `uint`）；② 向量别名 256 个全量映射；③ 脚本 `gen_fwd_aliases.py` 映射表与 `fwd.hpp` 对应关系一致；④ 无 `GLM_DEPRECATED`/`GLM_ALIGNED_TYPE` 等宏间接依赖 | ☐ |
| **7. shim 文件**（`<cassert>`/`<cstddef>`/`<limits>`） | 低 | ① `shim_assert.cj` 的 `if+throw` 模式覆盖 C++ `GLM_ASSERT_LENGTH` 所有使用点；② `shim_limits.cj` 的 `isIec559Of<T>()` 无约束函数调用链完整；③ `shim_cstddef.cj` 的 `SizeT`/`LengthT` 别名定义后无未处理的有符号/无符号冲突 | ☐ |

**超时升级路径**：扫描中发现未覆盖依赖项且 24 小时内无法确认处理方案，上报主 Agent + 设计审议评估范围变更。

**闭环原则**：发现≠解决——扫描结果仅标识差异，编码阶段须以实际编译验证为最终闭环依据。本扫描的评估结论为"按核查清单逐文件确认"，不做"无遗漏"的绝对声称。其余 7 个文件的逐 API 级对照规划在第 2 轮编码阶段以本附录为模板补充完成。

### 设计目标

将 GLM 1.0.3 首轮迁移范围内的 C++ 实现（基础设施层 + 向量类型系统 + 类型别名体系）以仓颉语言重新实现，提供一个在仓颉泛型系统和值类型语义下可独立编译运行的向量数学基础库。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| `Qualifier` | 定义精度/对齐策略的多态契约 | 接口 |
| `PackedHighp` / `PackedMediump` / `PackedLowp` / `AlignedHighp` / 等 | 具体精度/对齐策略标记 | 空结构体（实现 `Qualifier`） |
| `Vec1<T,Q>` / `Vec2<T,Q>` / `Vec3<T,Q>` / `Vec4<T,Q>` | 表示数学向量的值对象 | 泛型结构体 |
| `Functor1` / `Functor2` / `Functor2VecSca` / `Functor2VecInt` | 逐分量标量函数映射工具（按分量数分别定义，为后续轮次预留） | 结构体（各分量数分别定义） |
| `ComputeVecAdd` / `ComputeVecSub` / 等 | 向量逐分量运算策略（为后续 SIMD 轮次预留） | 结构体 |
| `ComputeEqual<T>` | 分量相等比较策略 | 结构体 |
| 标量类型别名 | 仓颉原生整数/浮点类型的 GLM 兼容命名 | `type` 别名 |
| 向量类型别名 | 具现化 Vec 类型的便捷命名 | `type` 别名 |

### 设计确定性声明

> **设计确定性声明**：当前设计方案的可行性取决于以下三类编译器行为假设的验证结果：
> 
> | 类别 | 假设项数 | 验证通过时的编码路径 | 部分回退时的编码路径 | 停工重评估条件 |
> |------|---------|--------------------|--------------------|-------------|
> | **X — 可直接编码** | 25 项验证项全部通过 | ✓ 按 §8.3 迁移顺序直接编码，无需设计修订 | — | — |
> | **Y — 可基于回退方案编码** | 1~3 项回退触发（较大概率） | — | ✓ 按各回退方案（§2.1 回退方案列 + §11.13 叠加效应分析）局部修订后编码，无需停工 | 回退方案间无不可调和冲突（§11.13 已分析全部已知组合） |
> | **Z — 需停工重评估** | 3 项以上核心假设同时回退 | — | — | ①③④⑫ 四项高影响项中任意两项同时失败，或任意三项核心假设同时失败 → 触发停工评估流程（主 Agent + 设计审议 + 项目负责人），预计 1-2 周重新评估路径。**阈值选择理由**：Z 类别阈值与 §2.1 影响范围分类保持一致——高影响项（①③④⑫）覆盖核心语义章节，其中任意两项同时失败即可确认设计确定性严重不足；原阈值中包含的⑮（低影响项）从停工条件中移除，因其失败仅影响 0-1 个章节且有独立回退方案 |
> 
> **当前评估**：本设计在 25 项验证全部通过时可直接编码；1~3 项部分回退时可基于 §2.1 回退方案和 §11.13 叠加效应分析指导编码；仅当 3 项以上核心假设同时失败或高影响项（①③④⑫）中 2+ 项同时失败时才需停工重评估。编码阶段建议优先执行第①③④⑫项（高影响项）以尽早暴露最高风险项。

#### 快速预筛步骤（编码启动前置信度锚点）

为进一步降低编译器假设验证的乐观路径风险，在 §2.1 编码前验证清单的正式逐项验证之前，新增以下**快速预筛步骤**，优先执行 4 项最高诊断价值的验证以快速建立置信度锚点：

| 预筛项 | 验证焦点 | 预期耗时 | 置信度回报 |
|--------|---------|---------|-----------|
| **① 编译器版本确认（§2.1 项⑮）** | 确认 `cjc --version ≥ 1.0.5`，为所有依赖假设提供编译器基础 | ~5 分钟 | 排除版本因素导致的假阴性/假阳性 |
| **② 首次编码前原型验证（§2.1 项①）** | `const` 表达式链、`T(0)` const 构造、`is` 在 const 泛型中的可用性、`@OverflowWrapping` 继承性——覆盖 4 项高影响项 | ~1 小时 | 暴露最高风险项（影响 5-8 章节），若失败可及早切换回退路径 |
| **③ 编译期 `if` 分支抑制验证（§2.1 项④）** | 统一原型测试 `testConstIfSuppression<T>()` 以 `Float32`/`Int32`/`Bool` 分别实例化 | ~30 分钟 | 验证 5 个依赖点（A~E）的编译器行为是否满足设计假设 |
| **④ 统一集成验证（§2.1 项⑫）** | 综合验证编译期 `if` 分支抑制、`@OverflowWrapping` 继承性、语法共存性 | ~1 小时 | 核心假设的最终置信度确认 |

**预筛通过标准**：4 项预筛均通过 → 置信度充足，进入 §2.1 正式逐项验证。预筛项①~③中任一项失败 → 置信度不足，启动对应回退路径后重新预筛。预筛结果记录于编码日志，作为 §11.12 成本合计表"置信度评估"列的输入依据。

**关于验证项⑥（浮点 mod 边界值验证）未纳入快速预筛步骤的说明**：项⑥的验证焦点为浮点 `mod` 恒等式 `x - y * trunc(x / y)` 的数值正确性及负操作数/Inf/NaN 边界行为，其失败回退方案（拆分为 `modInt`/`modFloat` 具名函数）影响面有限（仅影响 §4.3 `mod` 函数和 §11.13 回退成本），不属于最高诊断价值的验证项。项⑥正式安排在 §2.1 验证时序建议的第(2)步中，快速预筛步骤聚焦 4 项最高风险项（⑮①④⑫）以尽快建立置信度锚点。

### 整体架构思路

采用"双层包结构 + 独立具象化别名"的架构：`glm.detail` 包封装全部核心泛型类型定义和运算逻辑，`glm` 包通过类型别名暴露已具现化的常用向量类型。类型系统以 `Qualifier` 接口为精度/对齐策略的多态入口，四个 Vec 结构体作为独立泛型类型（而非分量数参数化的单一模板）承载向量数据与运算。

---

## 2. 模块划分

### 包组织

```
package glm.detail        — 核心实现层
  ├── setup.cj            — 配置常量
  ├── qualifier.cj        — Qualifier 接口及实现类型、前向声明
  ├── shim_assert.cj      — 断言替代
  ├── shim_limits.cj      — numeric_limits 等效
  ├── shim_cstddef.cj     — SizeT/LengthT 类型别名（VArray size 属性提供编译期长度查询）
  ├── compute_vector_relational.cj  — compute_equal
  ├── compute_vector_decl.cj        — compute_vec_add/sub/mul/div 等运算策略结构体（为后续轮次预留）
  ├── scalar_vec_ops.cj             — scalar-op-vec 方向辅助函数（add(s,v)/sub(s,v)/mul(s,v)/div(s,v)/mod(s,v)，首轮即被消费）
  ├── vectorize.cj                  — functor1/functor2/functor2_vec_sca/functor2_vec_int（为后续轮次预留）
  ├── type_vec1.cj                  — Vec1<T,Q> 结构体定义（含二元运算符 + 扩展块）
  ├── type_vec2.cj                  — Vec2<T,Q> 结构体定义（含二元运算符 + 扩展块）
  ├── type_vec3.cj                  — Vec3<T,Q> 结构体定义（含二元运算符 + 扩展块）
  ├── type_vec4.cj                  — Vec4<T,Q> 结构体定义（含二元运算符 + 扩展块）
  └── type_fromBoolVec.cj          — fromBoolVec/fromBoolVecQ2 包级独立工厂函数

package glm               — 公共 API 面 + 别名层
  ├── lib.cj              — 公共 API 重导出（使用 public import 暴露 Vec/Qualifier 核心类型）
  └── fwd.cj              — 标量类型别名 + 向量类型别名
```

### 公共 API 面设计

`lib.cj`（`package glm`）通过 `public import` 将 `glm.detail` 中的核心类型重新导出；`fwd.cj` 与 `lib.cj` 同属 `package glm`，其 `public type` 别名已自动对外可见。下游消费者只需 `import glm.*` 即可使用所有公共 API 和类型别名，无需直接依赖 `glm.detail` 内部包或单独导入 `fwd.cj`。具体导出内容：

```
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
// 后续轮次新增的矩阵/四元数类型在对应轮次追加至此文件
// 注：fwd.cj 中 256 个 public type 别名与 lib.cj 同属 package glm，已自动对外可见
```

此设计确保：
- `package glm.detail` 中的内部实现类型（如 shim 文件、functor、compute_vector_decl 等）对下游不可见
- 下游消费者仅通过 `import glm.Vec2` 等获得类型，包路径中不含 `detail`
- `fwd.cj` 与 `lib.cj` 同属 `package glm`，其中 256 个 `public type` 别名已自动属于 `package glm`，下游 `import glm.*` 即可直接访问 `BVec2` 等全部别名，无需额外导入。注：`scalar_vec_ops.cj` 声明了 `package glm.detail`，因此其中的函数通过 `glm.detail.{ add, sub, mul, div, mod }` 导入，路径中不包含文件名 `scalar_vec_ops`
- **命名空间占用声明**：`glm.detail` 包中约定**仅 `scalar_vec_ops.cj`** 定义名为 `add`、`sub`、`mul`、`div`、`mod` 的包级函数。`glm.detail` 包中的其他文件（如 `compute_vector_decl.cj`、`type_vecN.cj` 等）不得定义同名包级函数，以避免 `public import glm.detail.{ add, sub, mul, div, mod }` 产生导入歧义。此约定在 §7 D35 中正式记录为设计决策。
- 后续轮次扩展公共 API 面时只需在 `lib.cj` 追加对应的 `public import` 行

### 模块间依赖

```
glm.detail（内部无包引用，同包直接可见）
  setup 无依赖
  qualifier → setup
  shim_* 无依赖（仅使用仓颉原生类型）
  compute_vector_relational → shim_limits
  vectorize → qualifier（使用 LengthT / Qualifier 接口约束）
  compute_vector_decl → vectorize + qualifier
  scalar_vec_ops → qualifier + std.math（仅 mod 浮点路径依赖 std.math.trunc，详见 §10 浮点 mod 验证依赖②；整数路径和无浮点 mod 场景不依赖 std.math）
  scalar_vec_ops → type_vecN（scalar_vec_ops 中的函数使用 VecN<T, Q> 类型作为参数，概念上依赖 type_vecN 定义的类型；同包内无需显式 import，编译顺序不受影响）
  type_vecN → qualifier + compute_vector_relational + scalar_vec_ops（按需）

glm
  lib.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型,scalar_vec_ops}
  fwd.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型}
```

`glm` 包单向依赖 `glm.detail`，反向无依赖。

### 项目初始化与构建基础设施

**前提准备**（编码启动前必须完成）：

1. **项目初始化**：使用 `cjpm init --type=static` 创建仓颉静态库项目，生成 `cjpm.toml` 骨架。
2. **完整 cjpm.toml 配置**（可直接拷贝使用，含测试目录设置）：
   ```toml
   [package]
     cjc-version = "1.0.5"
     name = "glm"
     version = "0.1.0"
     output-type = "static"
     src-dir = "src"
   [test]
     src-dir = "tests"
   ```
    此完整配置确保 `cjpm test` 可正确发现位于 `tests/glm/detail/` 和 `tests/glm/` 目录下的 `@Test` 标注测试用例。`[test] src-dir = "tests"` 指定测试源文件根目录，`cjpm test` 自动递归扫描所有 `.cj` 文件中的 `@Test` 标注函数并执行。**版本要求说明**：`cjc-version = "1.0.5"` 为本设计所依赖的编译器版本号。低于此版本时，以下关键功能可能不可用：① `const` 函数体内的编译期 `if` 分支抑制（§7 D29/D34，依赖 `const` 特性在 1.0.5 中的完整支持）；② `@OverflowWrapping` 标注与自动复合赋值继承性（§7 D30）；③ `@Derive[Hashable]` 自动派生（§3.2）；④ `extend` 块的完整泛型语法支持（§4.3/§4.4）。编码前验证检查清单（§2.1）中的各项原型测试默认在 `cjc 1.0.5` 下执行。若目标编译器版本低于 1.0.5，需逐项重新评估清单中各验证项的通过性。
3. **初始目录结构**：
   ```
    glm-cangjie/
    ├── cjpm.toml
    ├── scripts/
    │   └── gen_fwd_aliases.py   # 别名生成脚本（参见 §3.8 最小生成脚本示例）
    ├── src/
    │   └── glm/
    │       ├── lib.cj
    │       ├── fwd.cj
    │       └── detail/
    │           ├── setup.cj
    │           ├── qualifier.cj
    │           ├── shim_assert.cj
    │           ├── shim_limits.cj
    │           ├── shim_cstddef.cj
    │           ├── compute_vector_relational.cj
    │           ├── compute_vector_decl.cj
    │           ├── scalar_vec_ops.cj
    │           ├── vectorize.cj
    │           ├── type_vec1.cj
    │           ├── type_vec2.cj
    │           ├── type_vec3.cj
    │           ├── type_vec4.cj
    │           └── type_fromBoolVec.cj
    ├── tests/
    │   └── glm/
    │       ├── test_lib.cj
    │       ├── test_fwd.cj
    │       └── detail/
    │           └── (测试文件，与 src 结构对应)
    └── target/               # 自动生成
    ```
4. **创建辅助脚本目录**：在项目根目录创建 `scripts/` 目录，用于存放别名生成脚本 `gen_fwd_aliases.py` 等辅助工具。此目录已在上述目录结构树中预占位，但初始化步骤未包含其创建指令。

5. **初始编译验证**：在项目根目录执行 `cjpm build` 确认基础编译链路正常。
6. **测试运行器配置**：执行 `cjpm test` 运行 `@Test` 标注的单元测试。测试文件可置于 `src/` 目录下（以 `_test.cj` 后缀命名）或独立的 `tests/` 目录中，`cjpm test` 自动发现并执行。
7. **首次编码前原型验证**：在开始正式编码前，按 §10 的设计阶段验证要求编写原型测试，确认编译器对 `const` 表达式链、`T(0)` const 构造、`is` 运算符在 const 泛型中的可用性、`@OverflowWrapping` 标注继承性等关键假设的支持程度。

### 依赖拓扑澄清

`setup.cj` 不包含 `LengthT`/`SizeT` 类型别名定义，这些归入 `shim_cstddef.cj`。`setup.cj` 仅包含 `const` 配置常量。`shim_cstddef.cj` 无任何依赖，所有 shim 文件与 `setup.cj` 之间不存在相互依赖。

首轮中 `compute_vector_decl.cj` 和 `vectorize.cj` 中的 `compute_vec_*` 策略结构体（如 `compute_vec_add`、`compute_vec_sub` 等）定义类型但不被 Vec 运算符实现消费，为后续轮次预留。`scalar-op-vec` 方向辅助函数（如 `add(s, v)`、`sub(s, v)` 等）已从 `compute_vector_decl.cj` 中独立为 `scalar_vec_ops.cj` 文件——它们属于首轮即被消费的例外，Vec 使用者需在 `scalar + vec` 等场景中调用它们。

**标准库依赖声明**：`scalar_vec_ops.cj` 的浮点取模路径（`mod(s, v)` 中 `T` 为浮点类型时）依赖 `std.math.trunc`（`Float64` 版本），通过 `Float32` 提升至 `Float64` 后调用 `trunc` 实现。编码阶段须在 `scalar_vec_ops.cj` 文件头部添加 `import std.math.{ trunc }`。此标准库依赖已在 §10 浮点 `mod` 验证依赖②中覆盖，§8.1 文件清单的"说明"列同步标注。

### §2.1 编码前验证检查清单

> **§2.1 维护原则**：本清单是验证任务的**唯一权威出处**（当前共 25 项）。§10 仅保留设计特有行为描述和回退方案依赖关系（如编译期 `if` 分支抑制各依赖点的回退方案、`equalEpsilon` 双路径触发条件等），所有原型测试方法和验证过程描述均以 §2.1 为准。§12.3 仅保留验证→设计路径选择映射关系。凡在此三章节间发现内容重叠，**以 §2.1 为裁决依据**，其余两处应同步消重。维护者在后续轮次中新增验证项时，应优先追加至本清单。

以下清单集中列出所有必须在编码前完成的设计阶段验证任务，确保编译器对关键语言特性的支持符合设计假设。每项验证通过后方可进入正式编码。

> **验证时序建议**：建议按以下顺序执行验证：（1）**第⑮项（编译器版本确认）**——确认 cjc 版本 ≥ 1.0.5，为后续所有验证提供编译器基础；（2）**先执行独立原型验证（①③④⑤⑧）**——每项聚焦单个编译器假设边界，暴露最基础的编译器行为问题。第①③④⑤⑧项通过后，各核心编译器假设的独立回退方案已明确；（3）**再执行第⑫项（统一集成验证）**——在独立验证全部通过后执行，覆盖编译期 `if` 分支抑制、`@OverflowWrapping` 继承性和 `const`+`@OverflowWrapping` 语法共存性三项的集成验证，确认多项编译器行为在组合场景下的一致性。第⑫项通过后，再按编号顺序（②→⑥→⑦→⑨→⑩→⑪→⑬→⑭→⑯→⑰→⑱→⑲→⑳→㉑→㉒→㉓→㉔→㉕）依次验证其余各项。

> **层级说明**：本清单中第①③④⑤⑧项为 **独立原型验证**——每项聚焦单个编译器假设边界，通过/失败对应独立回退方案，不依赖其他验证项的结果。第⑫项为 **统一集成验证**——在独立验证全部通过后执行，覆盖编译期 `if` 分支抑制、`@OverflowWrapping` 继承性和 `const`+`@OverflowWrapping` 语法共存性三项的集成验证，确认多项编译器行为在组合场景下的一致性。第⑫项**取代**①③④⑤⑧项的独立验证结果——若独立验证已通过但集成验证失败，以集成验证为准取代独立结论。

| 验证任务 | 章节位置 | 验证方法 | 通过标准 | 失败回退 | 影响范围 | 类型 |
|---------|---------|---------|---------|---------|---------|------|
| ① 首次编码前原型验证 | §2 步骤 7 | 编写原型测试验证 `const` 表达式链、`T(0)` const 构造、`is` 在 const 泛型中的可用性、`@OverflowWrapping` 继承性 | 所有原型测试编译通过 | 根据失败项调整设计（详见对应章节的回退方案） | **高** — 影响 §3.5/§4.5/§4.6/§7 D29/D30 | 独立原型验证 |
| ② 参考实现前置验证 | §8.4 策略 0 | 确认参考实现目录结构完整，验证 `GLM_CONFIG_CLIP_CONTROL` 条件编译逻辑、`storage` 非 SIMD 路径、`type_vecN.inl` 构造函数宏展开 | 三项验证项均与设计描述一致 | 以参考实现为准更新设计文档 | **中** — 影响 §7 D6/D23/§4.1/§8.4 | 独立原型验证 |
| ③ `isIec559Of` 核心依赖验证 | §10 依赖①②③ | 编写 `const` 泛型函数测试 `T(0)` const 构造 + `is` 运算符 + `abs()`/`epsilon()` const 兼容性 | 对 `Int32`/`Float32`/`Bool` 均编译通过 | 依赖①②失败 → 整体回退精确比较；依赖③单独失败 → 移除容差路径 | 独立原型验证 |
| ④ 编译期 `if` 分支抑制验证 | §10 依赖点 A~E | 编写 `testConstIfSuppression<T>()` 统一原型测试，以 `Float32`/`Int32`/`Bool` 分别实例化 | 三项均编译通过 | 各依赖点按独立回退方案处理（详见 §10 回退表） | 独立原型验证 |
| ⑤ `@OverflowWrapping` 继承性验证 | §7 D30 | 编写原型测试验证二元运算符标注 `@OverflowWrapping` 后，编译器自动生成的复合赋值版本是否继承 wrapping 语义 | 复合赋值在溢出时执行 wrapping | 切换到备选方案：在已有 20 个扩展成员函数上补充标注 | 独立原型验证 |
| ⑥ 浮点 `mod` 边界值验证 | §10 mod 验证 | 编写原型测试覆盖 `Float32.Max % 1.0`、负操作数、`Inf`/`NaN` 等边界值 | 所有边界值行为与 C++ `std::fmod` 一致 | 拆分为 `modInt`/`modFloat` 非 `const` 具名函数 | 独立原型验证 |
| ⑦ Vec1 跨类型 fill-from-Vec1 重载冲突验证 | §4.1/D31 | 原型测试验证 `Vec2( Vec1<Int32,PackedHighp> )` 编译无歧义 | 编译通过 | 移除跨类型 fill-from-Vec1 构造 | 独立原型验证 |
| ⑧ Bool→Numeric 转换路径 B `as` 方案可行性验证 | §9.4/§10 | 按 §10 `Bool→Numeric` 转换验证子节的方法，编写 3 项原型测试验证 `as` 运算符、`if-let` 模式匹配、`T(1)`/`T(0)` 构造器的可用性 | 三项均编译通过 | 路径 B 标记为"不可行"，回退至路径 A（`fromBoolVec`/`fromBoolVecQ2` 包级独立工厂函数） | 独立原型验证 |
| ⑨ `internal` 类型测试访问策略验证 | §12.4 | 在 `tests/glm/detail/` 目录下创建测试文件（声明 `package glm.detail`），尝试实例化 `AlignedHighp` 类型 | 编译通过（同包 `internal` 可访问） | 按 §12.4 回退方案层级逐级尝试：① 同包测试直接访问（首选）→ ② `protected` 可见性（需验证测试包与生产包同模块）→ ③ `public` 可见性 → ④ 测试 helper 文件 | 独立原型验证 |
| ⑩ 别名对外可见性验证 | §3.8/§12.2 | 从独立测试包中通过 `import glm.BVec2` 访问别名并实例化，验证编译通过 | 编译通过 | 检查 `fwd.cj` 中所有 `type` 别名是否添加 `public` 修饰符；确认 `fwd.cj` 声明 `package glm` 且其 `public type` 别名通过 `import glm.*` 直接可达 | 独立原型验证 |
| ⑪ 生成脚本映射表正确性验证 | §3.8 | 抽查 4 个家族的别名命名是否符合 §3.8 命名约定（如 B/BVec、I/IVec、U/UVec、Vec 各抽查一个精度变体）；**重点验证 `Vec`/`DVec`/`FVec` 三家族不产生 `VecVec`/`DVecVec`/`FVecVec` 等错误名称**；确认脚本生成结果与人工审查一致 | 抽查项全部匹配，`Vec`/`DVec`/`FVec` 三家族命名正确 | 修正脚本映射表中的错误映射后重新生成并验证；若 `Vec`/`DVec`/`FVec` 命名错误，检查脚本条件格式 `'' if fam.endswith('Vec') else 'Vec'` 是否正确实现 | 独立原型验证 |
| ⑫ 编译器依赖统一集成验证 | §10 依赖点 A~E、§7 D29/D30 | 编写统一原型程序 `testConstIfSuppression<T>()`，以 `Float32`/`Int32`/`Bool` 分别实例化，验证编译期 `if` 非选择分支抑制机制对所有 5 个依赖点成立；同时编写 `@OverflowWrapping` 继承性原型测试 `testOverflowWrappingInheritance()` 验证自动生成复合赋值是否继承标注语义；编写 `@OverflowWrapping`+`const` 语法共存性原型测试；编写 Vec4 构造函数重载解析原型测试 | 所有原型测试编译通过，运行时溢出行为符合 wrapping 预期；Vec4 构造函数无歧义 | 各依赖点按独立回退方案处理（详见 §10 回退表及 §11.13 回退成本评估）；若编译器行为假设不成立，对应设计章节按回退方案修改 | 统一集成验证 |
| ⑬ Vec4 构造函数重载解析验证 | §10 Vec4 重载解析验证 | 编写原型测试验证 Vec4 的 `Vec3+T` vs `Vec3+Vec1` 等重载对编译器无歧义报错；验证"具体类型优先于泛型类型"规则 | 所有对偶重载分支编译无歧义 | 移除 4-6 个歧义分支，改为具名工厂函数（详见 §4.1 回退方案） | 独立原型验证 |
| ⑭ 测试运行器配置验证 | §2 项目初始化 | 在项目中创建含 `@Test` 标注的单元测试文件（如 `tests/glm/test_runner.cj` 声明 `package glm`），执行 `cjpm test` 确认可正确发现并执行该测试用例 | `cjpm test` 输出显示测试用例被正确发现，无"未找到测试"相关告警 | 检查 `cjpm.toml` 的 `[test] src-dir` 配置路径是否正确；确认测试文件后缀和 `@Test` 标注语法正确；确认测试文件声明的包名与 `src-dir` 目录结构一致 | 构建工具验证 |
| ⑮ 编译器版本确认 | §2 项目初始化 | 执行 `cjc --version` 确认编译器版本 ≥ `1.0.5` | 版本号 ≥ 1.0.5 | 升级编译器至 1.0.5 或更高版本；若无法升级，按 §2 cjpm.toml 版本要求说明逐项评估关键功能可用性 | 构建工具验证 |
| ⑯ const init 与非 const init 共存验证 | §3.2/§4.1 | 编写原型测试：定义含 `const init(x: T)` 和 `public init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier` 的泛型 struct，验证二者参数列表差异足以区分（前者为逐分量同类型初始化，后者跨类型转换），编译无重载冲突 | 编译通过，无重复定义错误 | 若编译器报告重载冲突，分析冲突条件并调整构造函数分类（如将跨类型 `init<T2,Q2>` 改为具名工厂函数） | 独立原型验证 |
| ⑰ `%` 运算符编译器定义处/实例化处报错验证 | §4.3/§7 D13 | 编写原型测试：定义包含 `%` 运算符的泛型 struct（`operator func %(rhs: VecN<T, Q>)`），验证编译器是否在泛型定义处报错（类似 Rust well-formedness 检查），还是仅在实例化处（如 `Float32`）报错。**若定义处报错，进一步验证步骤**：将 `%` 运算符移至 `extend<T, Q> VecN<T, Q> where Q <: Qualifier` 块中重新编译，验证 extend 块中定义 `%` 运算符是否也在定义处报错——若 extend 块中定义处不报错（仅实例化处报错）→ 走路径②；若 extend 块中也在定义处报错 → 走路径③ | 编译器在实例化处报错（延迟检查语义），定义处编译通过 | 若编译器在定义处报错：路径②——`%` 运算符移至 `extend` 块中定义（若 extend 块定义处不报错）；路径③——从 struct 体和 extend 块中完全移除 `%` 运算符，改为仅 `mod` 具名函数（若 extend 块也在定义处报错） | 独立原型验证 |
| ⑱ `public import` 重导出验证（含扩展成员函数可见性子步骤） | §2 公共 API 面 | (a) 基础重导出验证：在 `package a` 中定义 `public struct S`，在 `package b` 中通过 `public import a.S` 重导出，验证从 `package c` 通过 `import b.S` 可正常访问 `S` 类型，名义路径为 `b.S`。<br/>(b) 扩展成员函数可见性验证：在 `package a` 中定义 `public extend<T> S { public func foo(): T { ... } }`，通过 `public import` 重导出后，验证从 `package c` 通过 `import b.S` 后 `S<Int32>(0).foo()` 可正常调用。此子步骤验证 `extend` 块中定义的扩展成员函数随 `public import` 重导出后的可见性是否与 struct 本身一致 | 基础重导出和扩展成员函数在重导出后均从 `package c` 可正常访问 | 若基础重导出行为与预期不符，调整 `lib.cj` 策略——改为在 `package glm` 中直接定义 `public type Vec2 = glm.detail.Vec2` 类型别名替代 `public import` 重导出；若扩展成员函数可见性在重导出后丢失，回退方案与基础重导出一致（改为类型别名方案），或参考 D37-A20 的独立回退方案 | 独立原型验证 |
| ⑲ `T(1e-6)` 对整数类型可用性验证 | §3.5 路径 A | 编写原型测试：定义泛型函数 `func epsilonOf<T>(): T { T(1e-6) }`，分别以 `Int32`、`Float32`、`Bool` 实例化，验证编译行为 | 对 `Float32`/`Float64` 编译通过；对 `Int32`/`Bool` 明确编译错误 | 若 `Int32(1e-6)` 编译错误，路径 A 需编译期分支或完全切换至路径 B（内联固定容差 `T(1e-6)` 仅限浮点分支），重新评估路径排序。**联动修改注意事项**：此验证项的结果与 epsilonOf 兼容性策略（§3.5 路径 A vs 路径 B）直接关联——路径 A 触发时联动修改 1 处（`shim_limits.cj` 中移除 `Number<T>` 约束）；路径 B 触发时合计联动修改 6 处（`shim_limits.cj` 移除 `epsilonOf<T>()` + Vec1~Vec4 `equalEpsilon` 替换 + `ComputeEqual.callConst` 替换） | 独立原型验证 |
| ⑳ `scalar: T` vs `init(v: Vec1<T, Q>)` 重载歧义验证 | §4.1 | 编写原型测试：定义同时包含 `init(scalar: T)` 和 `init(v: Vec1<T, Q>)` 的 struct，传入 `Vec1<T, Q>` 实例，验证编译器正确选择 `init(v: Vec1<T, Q>)` 而非将 `Vec1` 误匹配到标量填充版本 | 传入 `Vec1<T, Q>` 选择 fill-from-Vec1 版本，传入 `T` 字面量选择标量填充版本 | 若编译器报歧义错误，为 fill-from-Vec1 构造函数增加区分性命名参数（如 `init(from v: Vec1<T, Q>)`） | 独立原型验证 |
| ㉑ `@Derive[Hashable]` 泛型 struct 约束检查策略验证 | §3.2/§7 A13 | 编写原型测试：定义 `@Derive[Hashable] struct GenericVec<T> { var x: T }`（无 `where T <: Hashable` 约束），先以 `Int32` 实例化确认编译通过，再定义 `struct NonHashable {}` 并以 `NonHashable` 实例化确认编译错误——验证编译器是在定义处要求 `T <: Hashable` 还是在实例化处报错 | 编译器在实例化处报错（延迟检查），定义处编译通过 | 若编译器在定义处要求 `T <: Hashable` 约束，需在 `VecN<T, Q>` 定义中添加 `where T <: Hashable`，与 D5 宽松约束策略直接矛盾——需重新评估 D5 策略或移除 `@Derive[Hashable]` 改为手动实现 | 独立原型验证 |
| ㉒ `std.math.abs` 包级函数在 const 函数体内可调用验证 | §3.5/§7 D29 A03 | 编写原型测试：在 `const` 函数内调用 `std.math.abs(a - b)`（`import std.math.{ abs }`），以 `Float32`/`Float64` 实例化，验证编译通过 | 编译通过 | 若 `std.math.abs` 非 const 函数，回退至内联 `x >= T(0) ? x : -x` 或 D29 整体回退精确比较 | 独立原型验证 |
| ㉓ Vec 别名同名自引用风险验证 | §3.8 | 编写原型测试：定义 `public type Vec2 = Vec2<Float32, PackedHighp>`（左侧别名 `Vec2` 与右侧泛型结构体 `Vec2` 同名），验证仓颉编译器是否允许此别名定义且不产生歧义 | 编译通过，别名正确解析为右侧完整泛型类型 | 若编译器报歧义错误，修正脚本中 Vec 家族的别名策略：为泛型结构体添加包路径前缀（如 `glm.detail.Vec2`）或重命名别名（如 `Vec2F`） | 独立原型验证 |
| ㉔ `<<` 运算符默认溢出策略验证 | §4.4/§7 D37 A19 | 编写原型测试：分别对 `UInt8`、`Int32`、`UInt64` 执行超出位宽的左移（如 `UInt8(1) << 8`），观察编译器默认行为：若抛 `ArithmeticException` → 默认 `@OverflowThrowing`，需标注 `@OverflowWrapping` 对齐 C++ 高位丢弃语义；若自动 wrapping → 默认 `@OverflowWrapping`，无需额外标注 | 确认默认策略后 `@OverflowWrapping` 标注策略与编译器实际行为一致 | 若默认 `@OverflowWrapping`，移除 `<<` 运算符上的 `@OverflowWrapping` 标注；若默认 `@OverflowThrowing`，保留现有标注 | **低** — 影响 §4.4/§4.6 | 独立原型验证 |
| ㉕ `fromBoolVecQ2` 编译器从返回值类型推断 struct 泛型实参验证 | §4.8 `[^compiler-dep]` | 编写原型测试：定义泛型函数 `func makeVec<T, Q>(): Vec2<T, Q> where Q <: Qualifier { Vec2(T(0), T(0)) }`，验证编译器是否允许从函数返回值类型 `Vec2<T, Q>` 推断 `Vec2` 构造函数的泛型实参 `<T, Q>`；再用 `fromBoolVecQ2` 的实际调用模式——`func test<T, Q, Q2>(v: Vec2<Bool, Q2>): Vec2<T, Q> where Q <: Qualifier, Q2 <: Qualifier { fromBoolVecQ2(v) }` 验证编译器是否支持从返回值类型推断 | 两项原型测试均编译通过，编译器正确从返回值类型推断 struct 构造函数的泛型实参 | 若编译器不支持此推断，所有 `fromBoolVecQ2`（Vec1~Vec4）的 `VecN(...)` 调用处须显式标注类型参数，如 `Vec2<T, Q>(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })` | **中** — 影响 §4.8 `fromBoolVecQ2` 所有 4 个跨 Q 版本（Vec1~Vec4）的函数体实现 | 独立原型验证 |

#### 验证项影响范围分类

以上 25 项验证项按其失败时影响的设计章节数量分为三类：

| 影响范围 | 数量 | 验证项编号 | 失败时影响的设计章节数 |
|---------|------|-----------|-------------------|
| **高** — 影响 5+ 个章节，含核心语义 | 4 项 | ①③④⑫ | 5-8 章（§3.5/§4.3/§4.5/§4.6/§7 D29-D30/§10/§11.6/§11.12 等） |
| **中** — 影响 2-4 个章节，含局部修订 | 10 项 | ②⑤⑥⑧⑯⑰⑲⑳㉑㉕ | 2-4 章（局部回退方案） |
| **低** — 影响 ≤1 个章节，独立局部 | 11 项 | ⑦⑨⑩⑪⑬⑭⑮⑱㉒㉓㉔ | 0-1 章（或无影响，仅验证确认） |

> **量化说明**：25 项验证全部通过时可直接编码；1-4 项部分回退时（以中/低影响项目为主）可基于 §2.1 回退方案局部修订后继续编码，无需停工；仅当高影响项（①③④⑫）中 2+ 项同时失败时才需触发停工重评估流程。当前设计确定性声明见 §1 "设计确定性声明"框。

---

## 3. 核心抽象

### 3.1 Qualifier 体系

**角色**：为向量类型的精度（ULP）和对齐策略提供编译期类型级区分能力。

C++ GLM 中 `qualifier` 是枚举值，可直接作为模板非类型参数传递。仓颉泛型系统仅接受类型作为泛型实参，因此将枚举映射为"接口 + 实现结构体"模式：

- **`interface Qualifier`** — 标记接口，无成员。所有精度/对齐策略类型实现此接口。
- **`struct PackedHighp <: Qualifier {}`** — 默认精度/对齐策略。代表数据紧凑存储、高精度运算。
- **`struct PackedMediump <: Qualifier {}`** / **`struct PackedLowp <: Qualifier {}`** — 紧缩中/低精度。
- **`struct AlignedHighp <: Qualifier {}`** / **`struct AlignedMediump <: Qualifier {}`** / **`struct AlignedLowp <: Qualifier {}`** — 对齐策略（首轮 `GLM_CONFIG_ALIGNED_GENTYPES = false`，对齐类型可定义但内部不使用）。
- **`public type Defaultp = PackedHighp`** — 默认精度别名。

**Aligned 系列的可见性策略**：
- **首轮可见性**：AlignedHighp/AlignedMediump/AlignedLowp 在 `qualifier.cj` 中声明为 **`internal`**（包级可见）。理由：首轮 `GLM_CONFIG_ALIGNED_GENTYPES = false`，对齐类型在 Vec 内部不被使用，无需对外暴露。下游消费者通过 `Packed` 系列和 `Defaultp` 即可满足所有使用场景。
- **后续轮次切换配置时的可见性变更**：当未来将 `GLM_CONFIG_ALIGNED_GENTYPES` 切换为 `true` 时：
  1. 将 AlignedHighp/AlignedMediump/AlignedLowp 的可见性从 `internal` 改为 `public`。
  2. 在 `lib.cj` 的 `public import` 列表新增对应的 Aligned 类型导出行。
  3. 评估是否需要为 Aligned 类型补充独立的行为约定文档（当前 Aligned 与 Packed 行为等价，切换配置后可能引入对齐差异）。
- **`lib.cj` 导出策略**：`lib.cj` 的当前 `public import` 列表仅导出 `PackedHighp`/`PackedMediump`/`PackedLowp` 和 `Defaultp`。Aligned 系列的导出交由后续轮次完成。

Vec 泛型结构体通过 `where Q <: Qualifier` 约束 Q 参数，确保精度标记的类型安全性。预定义的 `lowp_`/`mediump_`/`highp_` 别名等价于分别绑定不同的 Qualifier 实现类型。

**C++ `storage<L,T,Q>` 模板结构体说明**：GLM 的 `qualifier.hpp` 中定义了 `storage` 模板（`namespace detail`），用于根据 `L`（分量数）、`T`（分量类型）和 `is_aligned` 标志选择底层数据存储类型——在非 SIMD 路径下为 `T data[L]`，在 SIMD 路径下为 SIMD 内部类型（如 `glm_f32vec4`）。仓颉 Vec 结构体直接声明具名数据成员（`var x: T` 等），不依赖 C 数组或 SIMD 内部类型，因此 `storage` 抽象在首轮中**无需也不可映射**。Vec 的数据布局由编译器根据 struct 成员定义自动确定，与 `storage` 在 C++ 中角色等效。`storage` 的 SIMD 特化（SSE2/AVX/NEON 路径）待后续 SIMD 轮次重新设计。

**选择理由**：采用接口而非 sealed 枚举+匹配（enum），是因为泛型参数需要类型级区分以支持不同 Vec 实例的编译期类型区分，而非运行时分支分发。空结构体的零开销值与接口的泛型约束能力结合，是仓颉泛型系统下最直接的映射方案。

**Qualifier 运行时行为约定**：
- **跨 Q 赋值/转换规则（首轮）**：不同 Qualifier 之间**可相互赋值和转换**。由于首轮所有 Qualifier 实现类型（PackedHighp、PackedMediump、PackedLowp、AlignedHighp 等）均为空结构体，无运行时数据差异，跨 Q 赋值在数据语义上等价于同 Q 赋值。因此 Vec 的跨类型转换构造函数（`init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）已在类型层面允许 Q2→Q 的转换——Q 参数仅影响编译期类型签名，不影响数据表示。首轮编码阶段无需对跨 Q 转换添加额外的静态断言或运行时检查。
- **跨 Q 赋值/转换规则（后续轮次）**：当后续轮次为不同 Qualifier 引入差异化行为（如 aligned 类型使用不同内存对齐策略、SIMD 变体使用不同内部数据布局）时，跨 Q 赋值的语义需要重新评估。届时可按需引入编译期静态检查（如通过仓颉宏或自定义注解）限制特定 Q 组合间的转换。此评估留待对应轮次的设计审议中处理。

**跨 Q 等价假设影响范围**：由于首轮所有 Q 实现类型行为等价（均为空结构体），以下场景中 Q 的变化不改变运行时语义，仅影响编译期类型签名：

| 受影响场景 | 涉及构造/操作 | Q 变化方式 | 等价说明 |
|----------|-------------|-----------|---------|
| **跨 Q Vec 构造** | `init<T2, Q2>(v: VecN<T2, Q2>)` | Q2（输入）→ Q（输出） | 数据无差异，仅类型签名改变 |
| **跨 Q fromBoolVec** | `fromBoolVecQ2<T, Q, Q2>()` | 输入 Q2、输出 Q 可不同 | Bool→数值转换结果相同 |
| **跨 Q 变量赋值** | `var a: Vec2<F32, PHp> = b` 其中 b 为 `Vec2<F32, PLp>` | 源 Q → 目标 Q（通过构造） | 数据完全一致 |
| **跨 Q 函数参数传递** | `func foo(v: Vec2<F32, PHp>)` 传入 `Vec2<F32, PLp>` | 调用方 Q → 参数 Q（通过构造） | 构造后数据等价 |
| **跨 Q 容器元素** | `ArrayList<Vec2<F32, PHp>>` 接收 `Vec2<F32, PLp>` 值 | 同赋值规则 | 存储后 Q 统一 |
| **Vec4 跨 Q 多元构造** | `init<T2, Q2>(a: Vec3<T2, Q2>, b: Vec1<T2, Q2>)` | 多元参数 Q2 统一 → Q | 多元参数间 Q 是否一致不影响构造后数据 |
- **Qualifier 差异引入路径的预期说明**：当前首轮设计将 Qualifier 定义为实现统一空接口的独立空结构体，它们在类型层面是不同的泛型参数但行为完全等价。后续轮次可通过以下路径逐步引入差异化：
  1. **对齐策略差异化**（第 2 轮）：`AlignedHighp` 等对齐类型可关联自定义对齐元数据（如通过仓颉 `@Align` 注解或包装结构体），在 `GLM_CONFIG_ALIGNED_GENTYPES = true` 时生效。
  2. **SIMD 路径差异化**（第 5+ 轮）：`PackedHighp` 可关联 SIMD 内部数据布局（如通过条件编译选择 `Vector128<T>` 等 SIMD 类型），在 `GLM_CONFIG_SIMD = true` 时生效。
  3. **精度语义差异化**（后续轮次）：`PackedLowp`/`PackedMediump` 可在函数库层面（如三角函数、标准化运算）通过 `if (isLowp<Q>())` 分支选择精度折衷算法路径。
  上述差异化路径均在当前接口+空结构体框架下兼容，无需改变类型形态。

### 3.2 Vec 结构体系

**角色**：表示 N 维数学向量，是 GLM 中最核心的领域实体。每个 Vec 是值类型（struct），支持构造、分量访问、算术运算、比较运算和位运算。

四个 Vec 类型（`Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>`）各自独立定义，而非使用分量数参数化的单一泛型模板。每个 Vec 有自己的：

- **数据成员**：声明为 `var`（可变，无初始值），命名约定如下：
  - `Vec1<T,Q>`：`var x: T`
  - `Vec2<T,Q>`：`var x: T, var y: T`
  - `Vec3<T,Q>`：`var x: T, var y: T, var z: T`
  - `Vec4<T,Q>`：`var x: T, var y: T, var z: T, var w: T`

  数据成员使用 `var` 而非 `let`。成员无初始值——仓颉 struct 允许 `var x: T` 形式。因此编译器不会为 Vec 结构体自动生成无参默认构造函数。所有 Vec 实例必须通过显式构造函数创建。（具体构造方式见 §4.1。）

- **`const public static func length(): Int64`** — 返回编译期常量：Vec1 返回 1，Vec2 返回 2，Vec3 返回 3，Vec4 返回 4。此函数是计算分量数的静态接口，替代 C++ `length_t` 参数在泛型运算中的角色。

- **`const init` 构造函数**：每个 Vec 定义一个 `const init(x: T, y: T, ...)` 构造函数，允许 `const` 实例成员函数（定义在 struct 体内部）的定义，同时其本身在非 const 上下文中也可用于运行时构造（const README §3.2 规则 5），因此不再需要同参数列表的普通 `init`。`const init` 的存在使得 `==` 等比较运算符可以声明为 `const` 函数，从而在函数体内使用编译期 `if` 分支实现编译期分支选择。「注意」仓颉 `extend` 块中不允许 `const` 修饰符，因此扩展成员函数（位运算符、具名函数 `increment`/`decrement`/`bitwiseNot`/`equalExact`/`logicalAnd`/`logicalOr` 等）须以非 `const` 形式定义。编译期 `if` 分支在非 `const` 函数中不可用，相关备选方案见 §7 修订。

**`const init` 与非 `const init` 共存性分析**：Vec 的构造函数体系包含两类 `init`：(A) **`const init`**——逐分量初始化，参数列表为 `const init(x: T, y: T, ...)`（同类型 T 参数），无需类型转换表达式，函数体内仅使用 `=` 赋值初始化 `var` 成员，在 `const` 上下文中合法；(B) **非 `const init`**——跨类型转换，参数列表为 `init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`，函数体内包含 `T(v.x)` 类型构造表达式（源类型 T2 到目标类型 T 的显式类型转换）。两类构造函数的参数列表**类型结构显著不同**：(A) 接收与分量数相同数量的同类型 `T` 参数，(B) 接收单个 Vec 类型参数 `VecN<T2, Q2>`。因此仓颉函数重载规则中二者不构成歧义——参数个数与参数类型均不同，编译器可正确区分。**关键区分点**：`const init(x: T, y: T)` 永远不会被误匹配为 `init<T2, Q2>(v: VecN<T2, Q2>)`，因为前者接收多个 `T` 类型的独立标量参数，后者接收单个 `VecN<T2, Q2>` 类型的聚合参数；反之亦然。**关于 `T(v.x)` 在 `const init` 上下文中的合法性**：(B) 类构造函数不声明为 `const`，因此 `T(v.x)` 类型转换表达式不受 `const` 函数体内对表达式必须是 const 表达式的限制（const README §3.2 规则 3 仅要求 `const` 函数体内表达式为 const 表达式，`const init` 例外——规则 3 注明"`const init` 函数除外"）。若将 (B) 类构造函数误标注为 `const init`，则 `T(v.x)` 类型转换表达式需满足 const 表达式要求，对多数 T2→T 组合（如 `Int32(Float32(1.5))`）不可用。因此 (B) 类构造函数**必须**声明为非 `const init`，与 (A) 类 `const init` 的参数列表差异确保二者安全共存。编码前验证项⑯须编写原型确认此共存安全性。此分析结论已在 §4.1 构造函数清单中以 `// const 构造函数` 和 `// 跨类型转换（非 const）` 注释分类标注。

- **类型参数显式指定**：仓颉泛型系统不支持类型参数默认值，Q 参数必须显式指定。`Vec2<Float32, PackedHighp>` 为完整合法写法。对于需要省略 Q 参数的场景，在 `fwd.cj` 中通过 `public type` 别名提供常用具现化（如 `public type Vec2f = Vec2<Float32, PackedHighp>`）。如需在泛型代码中编写 `Vec2<T>` 形式，可将不同精度包装为不同别名。

- **构造函数体系**（见 §4.1 完整清单）。
- **下标运算符 `[]`** 用于分量访问。有取值和赋值两种形式（见 §4.2）。
- **二元算术运算符**在 Vec 结构体内部定义（或通过 extend 块扩展），标注 `@OverflowWrapping`，直接实现逐分量运算。复合赋值运算符由编译器自动生成（仓颉在重载二元算术运算符且返回类型与左操作数类型匹配时自动生成对应的复合赋值版本）。
- **位运算符** — 二元位运算符（`&`、`|`、`^`、`<<`、`>>`）在 extend 块中定义。`~`（按位取反）不在仓颉可重载运算符列表中，改为提供具名函数 `bitwiseNot()`。
- **比较运算符** — `==` 通过 `ComputeEqual` 策略比较，声明为 `const` 函数以支持编译期 `if` 分支。`!=` 定义为 `!(a == b)`。`<`/`<=`/`>`/`>=` 运算符的覆盖见 §4.5。
- **布尔逻辑运算**：`&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符。改为提供具名函数 `logicalAnd()` 和 `logicalOr()`。各 VecN 类型分别定义对应版本，接收 `VecN<Bool, Q>` 并返回 `VecN<Bool, Q>`。
- **`%` 运算符**：在 Vec 结构体内部或 extend 块中定义，直接实现逐分量取模。当 `T` 为整数类型时编译通过；当 `T` 为浮点类型时，因仓颉原生浮点类型不支持 `%`，在实例化时产生编译错误。此行为与 D5（宽松泛型约束，延迟检查）一致。**编译器行为依赖与条件性移动策略**：当前设计假设编译器在**实例化处**报错（延迟检查语义），而非在**泛型定义处**报错（类似于 Rust well-formedness 检查）。若编译器在泛型 struct 定义处即因 `T % T` 对未知的 `T` 可能不合法而报错，则 `%` 运算符**不能定义在 Vec 结构体内部**——需移动到 `extend` 块中（`extend` 块泛型扩展可针对特定类型约束定义），或从运算符层面完全移除（仅保留具名函数 `mod`）。编码前验证项⑰须确认编译器行为：若定义处报错，`%` 运算符从 Vec 结构体内部移除，改为在 `extend` 块中定义（仅整数 `T` 可用）或完全移除（浮点取模由 `mod` 具名函数覆盖，整数取模也改为 `%` 不作为运算符而作为 `mod` 整数路径实现）。此条件性移动策略使 D13 的决策空间扩展为三种可能状态：① 延迟检查成立→`%` 保留在 struct 体内（当前设计）；② 定义处报错→`%` 移至 extend 块；③ 定义处报错且 extend 块中 `%` 也受限→`%` 完全移除，`mod` 函数覆盖所有取模场景。
- **`++`/`--` 运算符**：仓颉可重载运算符列表中不包含 `++`/`--`，因此无法为 Vec 类型重载。改为提供具名函数 `increment()`（返回逐分量加 1 的新向量）和 `decrement()`（返回逐分量减 1 的新向量）。这些函数标注 `@OverflowWrapping`，语义与 C++ GLM 的 `operator++`/`operator--` 返回新副本的行为一致（C++ 前缀形式返回引用，后缀返回副本；仓颉值类型统一返回副本）。注：`increment`/`decrement` 定义在 `extend` 块中，受仓颉扩展语法限制（仓颉扩展 §4.2），声明为非 `const` 函数。C++ 的后缀 `v++` 在迁移时需替换为 `v = v.increment()`，前缀 `++v` 替换为 `v = v.increment()` 后重新赋值。

**`VecN<Bool, Q>` 完整行为约定**（集中说明）：
- Bool 分量 Vec 支持构造、下标访问、`==`/`!=` 比较（返回 `bool`）、`!` 一元运算符（逐分量逻辑非）、`logicalAnd`/`logicalOr` 具名函数。
- 算术运算符（`+`/`-`/`*`/`/`/`%`）在 `VecN<Bool, Q>` 上实例化时报编译错误（`Bool` 不支持算术运算），与 D5 延迟检查语义一致。
- 模运算（`%` / `mod`）：所有形式均不可用。`%` 运算符与算术运算符一致在实例化时报编译错误；`mod` 具名函数（扩展成员函数方向 `v.mod(s)` 及包级独立函数方向 `mod(s, v)`）均在实例化时报编译错误。
- 位运算符（`&`/`|`/`^`）在 `VecN<Bool, Q>` 上可编译通过——仓颉 `Bool` 支持 `&`/`|`/`^`，语义为逐分量逻辑运算，与 C++ GLM 的 `bvec` 位运算行为等价。
- `<<`/`>>` 在 `VecN<Bool, Q>` 上实例化时报编译错误（`Bool` 不支持移位）。
- `increment()`/`decrement()` 在 `VecN<Bool, Q>` 上实例化时报编译错误。
- `bitwiseNot()` 在 `VecN<Bool, Q>` 上可编译通过——`!` 对 `Bool` 执行逻辑非。**不可消除的已知行为差异**：C++ GLM 的 `~bvec` 因整数提升机制（`bool` → `int` 按位取反 → `bool` 转换，非零即 `true`）对任一分量始终返回 `true`；而仓颉 `!Bool` 执行逻辑否定（`!true = false`），两种行为完全相反。此差异无法通过类型系统消除——仓颉不支持偏特化或负向约束条件性地为 `VecN<Bool, Q>` 排除 `bitwiseNot()`。迁移 `~bvec` 时需要人工审查并按上下文选择替换方式（详见 §11.4）。

**Hashable 实现策略**：
- 所有 Vec 类型统一通过 `@Derive[Hashable]` 自动派生 `hashCode(): Int64`。仓颉 `@Derive` 宏为所有字段类型已实现 `Hashable` 的实例化生成 `hashCode()`——此条件对所有数值类型（`Int32`、`Float32`、`Float64` 等）和 `Bool` 均满足。
- **泛型类型参数 T 的 `Hashable` 约束传递性**：`@Derive[Hashable]` 在泛型 struct `VecN<T, Q>` 上使用时，编译器对 `T` 的 `Hashable` 约束检查策略**尚未确认**——可能为以下两种模式之一：**(a) 延迟检查（实例化处报错）**：编译器在 `VecN<T, Q>` 定义处不要求 `T <: Hashable`，仅在实例化时（如 `VecN<NonHashable, PackedHighp>`）产生编译错误。此模式与 D5 宽松约束策略兼容，对当前设计无影响——首轮目标类型均已实现 `Hashable`，且 `Bool` 实现 `Hashable`，无实例化冲突风险。**(b) 定义处检查**：编译器在 `VecN<T, Q>` 定义处即要求 `T <: Hashable`（需在 `where` 子句中添加 `where T <: Hashable`），否则拒绝编译。此模式与 D5 直接矛盾——D5 明确声明 `T` 不做紧约束以允许 `Bool` 等非 `Number` 类型，若添加 `where T <: Hashable`，Vec 的泛型签名需修改，公共 API 受影响。编码前验证项㉑须明确编译器行为。若为模式 (b)，回退方案：① 移除 `@Derive[Hashable]`，改为在 Vec 结构体中手动定义 `hashCode()` 函数——此方案对 D5 无影响但增加编码工作量；② 在 Vec 定义中添加 `where T <: Hashable` 并评估对 D5 的影响——由于 `Hashable` 约束比 `Number<T>` 更宽松（`Bool`、所有数值类型均已实现 `Hashable`），添加此约束对首轮目标类型无实际影响，但改变了 D5 的声明立场。首选方案取决于编码前验证结果。
- `hashCode()` 覆盖 Vec 的所有数据分量（Vec1 覆盖 x，Vec2 覆盖 x/y，Vec3 覆盖 x/y/z，Vec4 覆盖 x/y/z/w）。
- **浮点 Vec 的已知限制**：`Hashable` 契约要求 `hashCode()` 与 `==` 一致（`a == b ⇒ hashCode(a) == hashCode(b)`）。浮点 Vec 的 `==` 使用容差比较，而 `@Derive` 生成的 `hashCode()` 使用按位精确哈希——两个在容差范围内相等但按位不同的浮点向量可能产生不同的哈希值。此不一致是已知限制，需在文档中标注。在哈希集合/映射中使用浮点 Vec 时，若键值必须保证一致性，调用方应确保键值精确匹配或自行包装为自定义类型。

**字符串表示策略**：
- Vec 类型不实现自定义 `toString()` 或 `Format`/`Display`。首轮依赖仓颉编译器为 struct 生成的默认字符串表示——格式和内容由编译器确定，调用方不应依赖特定格式。
- **选择理由**：① Vec 是值类型结构体，编译器默认字符串表示已提供最基本的分量值输出能力，足以满足调试场景；② 自定义 `Display`/`Format` 需要为 Vec1~Vec4 各定义一个格式化实现，增加约 40 行代码，但首轮无实际消费方（下游需要格式化时使用独立具名函数）；③ `Display`/`Format` 接口的实现策略（统一格式 vs 可配置格式）待后续函数库轮次统一设计，首轮制定为时尚早。若编码阶段发现编译器默认表示严重不足于调试，可将 `Display` 实现提前至首轮。
- 若下游需要格式化输出，可通过独立具名函数（如 `to_string(v: VecN<T, Q>): String`）在后续函数库轮次中提供。

**类型形态选择理由**：
- 使用 **struct** 而非 class：向量是纯值语义类型，按值传递/赋值应复制而非共享引用。Struct 的值语义与 C++ vec 的行为一致。
- 四个**独立结构体**而非单模板特化：仓颉不支持 C++ 偏特化，无法通过 `Vec<N, T, Q>` 单模板的分量数偏特化实现各分量数版本的差异化行为。四个独立类型虽然代码重复但实现模式简单直接。
- 数据成员声明为 `var` 且无初始值：`var` 使 `mut` 函数（在 `var` 绑定的变量上）可修改成员；无初始值意味着编译器不生成默认构造函数，调用方须显式构造。
- **二元算术运算符在 Vec 结构体内部定义为 `operator func`（非 `mut`），标注 `@OverflowWrapping`；复合赋值由编译器自动生成**。此策略替代了 v3 中"copy + op="委托模式——因复合赋值运算符（`+=` 等）不在仓颉可重载运算符列表中，无法显式定义。编译器在检测到返回类型匹配的二元运算符后自动生成复合赋值版本，`@OverflowWrapping` 标注在二元运算符上，复合赋值继承其 wrapping 语义。
- `scalar + vec`（标量在左、向量在右）不可作为运算符重载实现，因为左操作数 `scalar` 类型（如 `Float32`）的 `+` 运算符无法被本包扩展。替代方案是提供具名函数。`scalar / vec` 同理。
- `const init` 的引入：为支持 `const` 实例成员函数（如 `const` 版本的 `==` 运算符），需定义一个 `const init` 构造函数。仓颉要求：对于 struct，只有定义了 `const init` 才能定义 `const` 实例成员函数。`const init` 内可使用 `=` 赋值初始化 `var` 成员。数据成员声明为 `var` 与 `const init` 不冲突——`const init` 初始化成员，`const` 实例函数（如 `==`）非 `mut`，可正常访问 `var` 成员。`const init` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），因此同参数列表的普通 `init` 不再需要——移除后仅保留 `const init` 可避免仓颉函数重载规则中因 `const` 修饰符不构成区分依据而导致的重复定义编译错误。
- **Q 参数显式指定**：仓颉泛型系统不支持类型参数默认值，Q 必须显式指定。使用 `public type` 别名（如 `public type Vec2f = Vec2<Float32, PackedHighp>`）提供常用具现化的简写形式，在 `glm` 包中通过别名隐藏 Q 参数细节。

#### const 上下文中的 API 可用性速查表

由于仓颉 `extend` 块不支持 `const` 修饰符（仓颉扩展 §4.2），以下 API 在 const 上下文中不可用，列表集中声明以便于迁移开发者快速评估影响：

| 不可用的 const API | 所属运算类别 | const 替代方案 |
|-------------------|-------------|--------------|
| `v.add(s)` | 算术：vec-op-scalar 方向扩展成员函数 | 改用包级独立函数 `add(s, v)`（声明为 `const`，但需交换操作数顺序）或直接使用二元运算符 `v + s` |
| `v.sub(s)` | 算术：vec-op-scalar 方向扩展成员函数 | 改用 `sub(s, v)` 或 `v - s` |
| `v.mul(s)` | 算术：vec-op-scalar 方向扩展成员函数 | 改用 `mul(s, v)` 或 `v * s` |
| `v.div(s)` | 算术：vec-op-scalar 方向扩展成员函数 | 改用 `div(s, v)` 或 `v / s` |
| `v.mod(s)` | 算术：vec-op-scalar 方向扩展成员函数 | 改用包级独立函数 `mod(s, v)`（声明为 `const`）或直接使用 `v % s` |
| `v.equalExact(other)` | 比较：精确相等比较 | 在 struct 体内自行定义 const 版本的 `equalExact`（D33 备选方案）或手动编写精确内联比较表达式 |
| `v.logicalAnd(other)` | 布尔逻辑：逻辑与 | 改用一元 `!` 或组合表达式（如 `!(v.logicalOr(w))` 根据德摩根律转换） |
| `v.logicalOr(other)` | 布尔逻辑：逻辑或 | 同上 |
| `v.increment()` | 算术：`++` 替代 | 改用 `add(T(1), v)`（包级独立函数，声明为 `const`） |
| `v.decrement()` | 算术：`--` 替代 | 改用 `sub(T(1), v)`（包级独立函数，声明为 `const`） |
| `v.bitwiseNot()` | 位运算：`~` 替代 | 改用 `!v`（`!` 为可重载运算符，对整数分量执行按位取反） |
| Vec1 广播运算符（`v + vec1`、`v & vec1` 等） | 算术/位运算：Vec1 广播 | extend 块中定义，非 const。改用包级独立广播函数（若需 const）或在 const 上下文中先提取 Vec1.x 再用 `v + s` |

以上 12 个 API 均因定义于 `extend` 块而无法获得 `const` 修饰符。此限制影响 const 表达式中的编译期调用能力，但不影响运行时功能正确性。迁移审查时需要评估受影响的 const 上下文场景中各 API 的替代方案切换成本。**调用方注意**：包级独立函数 `add(s, v)`/`sub(s, v)`/`mul(s, v)`/`div(s, v)`/`mod(s, v)`（定义于 `scalar_vec_ops.cj`）无此限制，声明为 `const` 函数，可在 const 表达式中调用。`equalExact` 的 const 替代方案见 §4.5 的 `const` 声明说明段落。

### 3.3 Functor 体系

**角色**：封装"对标量函数逐分量映射到向量"的调用模式，是后续轮次 SIMD 优化或 swizzle 操作的基础设施。首轮 Functor 定义其类型但不被 Vec 运算符实现调用，为后续轮次预留。

C++ `_vectorize.hpp` 中的四个 functor 模板（`functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int`）使用了模板模板参数。由于仓颉中 Vec1~Vec4 是四个独立结构体而非同一模板的特化，模板模板参数模式无法复用。

首轮按分量数拆分 functor——为 Vec1~Vec4 各定义四组独立的 functor 结构体：

- **`Functor1Vec1<R, T, Q>`** ~ **`Functor1Vec4<R, T, Q>`** — 一元映射（`Func(T) -> R`）
- **`Functor2Vec1<T, Q>`** ~ **`Functor2Vec4<T, Q>`** — 二元映射（`Func(T, T) -> T`）
- **`Functor2VecScaVec1<T, Q>`** ~ **`Functor2VecScaVec4<T, Q>`** — 向量-标量二元映射
- **`Functor2VecIntVec1<T, Q>`** ~ **`Functor2VecIntVec4<T, Q>`** — 向量-整数向量二元映射

每个 functor 提供一个静态 `call` 方法，接收一个仿函数/函数引用和向量操作数，返回向量结果。首轮这些类型仅定义为结构体，不产生消费代码。后续轮次可对 Vec 运算符实现进行优化，通过宏生成这些重复定义。

### 3.4 ComputeVec* 运算策略体系

**角色**：封装向量逐分量运算的具体实现，为后续轮次 SIMD 路径或特化提供扩展点。首轮 ComputeVec* 定义其类型但不被 Vec 运算符实现调用。

`compute_vector_decl.hpp` 中定义的 `compute_vec_add`、`compute_vec_sub`、`compute_vec_mul`、`compute_vec_div`、`compute_vec_mod`、`compute_vec_and`、`compute_vec_or`、`compute_vec_xor`、`compute_vec_shift_left`、`compute_vec_shift_right`、`compute_vec_equal`、`compute_vec_nequal`、`compute_vec_bitwise_not` 等结构体，在 C++ 中通过偏特化的参数进行 SIMD/非 SIMD 和整数/非整数的分支。

首轮设计简化策略：

- **所有 `UseSimd` 参数取 `false`**：`GLM_CONFIG_SIMD = false`，无 SIMD 路径。
- **整数/浮点运算直接在 Vec 运算符中通过泛型 `+`/`-`/`*`/`/` 等原生运算处理**，无需通过 ComputeVec* 委托。
- **相等比较通过 `ComputeEqual<T>` 策略处理**：简化后的 `ComputeEqual` 不再携带 `IsFloat` 参数，使用编译期 `if` 分支（详见 §3.5）。

首轮 ComputeVec* 结构体定义为无状态结构体（仅提供静态 `call` 方法），按分量数分别定义 Vec1~Vec4 版本。首轮这些类型仅定义但不被 Vec 运算符实现调用，为后续 SIMD 轮次预留。

### 3.5 ComputeEqual

**角色**：提供分量级别的相等比较策略，向量的 `==` 运算符委托此类型做逐分量比较。简化后的 `ComputeEqual<T>` 不再携带 `IsFloat` 参数。

> **C++ GLM 行为偏离声明**：C++ GLM 1.0.3 的 `compute_equal`（定义于 `compute_vector_relational.hpp`）对所有分量类型使用精确比较 `a == b`——其 `compute_equal<float>` 特化原包含浮点 `epsilon` 容差比较实现，但在 GLM 1.0.3 中该特化分支被注释掉，实际生效的仅泛型默认 `a == b`。因此 C++ GLM 的 `==` 运算符对所有 Vec 类型（含浮点 Vec）均使用 IEEE 754 精确相等语义。仓颉迁移引入的浮点容差比较（`abs(a - b) <= epsilonOf<T>()`）是仓颉泛型路径下新增的全量行为偏离，**非 C++ GLM 语义的等价迁移**。此偏离影响所有浮点 Vec 的 `==` 比较场景，不限于 Inf/NaN 边界。整数/Bool Vec 的 `==` 行为保持不变（精确比较）。

`ComputeEqual<T>` 的 `isIec559` 判定依赖编译期 `if` 配合 `is` 运算符完成。`isIec559Of<T>()` 对所有 `T`（含 `Bool`）可用，非数值类型默认返回 `false`。

```
struct ComputeEqual<T> {
    static func call(a: T, b: T): Bool { a == b }
    // const 版本：通过编译期 if 实现编译期分支
    // 注意：abs() 调用依赖 import std.math.{ abs }（§8.1 已标注依赖），
    //       此处 abs 为 std.math 包级函数（非 Float32.abs()/Float64.abs() 静态方法）
    const static func callConst(a: T, b: T): Bool {
        if (isIec559Of<T>()) {
            // 浮点路径：使用 Epsilon 容差比较
            abs(a - b) <= epsilonOf<T>()  // abs → std.math.abs 包级函数
        } else {
            // 整数/Bool 路径：精确比较
            a == b
        }
    }
}
```

**`epsilonOf<T>()` 定义**：`ComputeEqual.callConst` 中引用的 `epsilonOf<T>()` 是定义于 `shim_limits.cj` 的 `const` 泛型函数。其签名为 `const func epsilonOf<T>(): T where T <: Number<T>`，内部实现委托给 `NumericLimits<T>.epsilon()` ——`Number<T>` 约束在此处合法，因为 `if (isIec559Of<T>())` 分支仅在浮点 `T` 上进入，而浮点类型（`Float32`/`Float64`）满足 `Number<T>` 约束。定义形式如下：

```
const func epsilonOf<T>(): T where T <: Number<T> {
    NumericLimits<T>.epsilon()
}
```

**`where T <: Number<T>` 约束兼容性验证**：`epsilonOf<T>()` 的 `Number<T>` 约束在非执行路径（`编译期 if` 的 `else` 分支）上的编译器行为需要验证——虽然编译期 `if` 分支确保仅浮点 `T` 进入容差比较路径，但编译器可能仍会对 `else` 分支（整数/Bool `T`）进行语法检查，检查 `epsilonOf<T>()` 的实例化是否满足 `Number<T>` 约束。若编译器在非执行路径上仍对泛型约束进行全面检查（而非延迟到实际调用点），则 `epsilonOf<Bool>()` 等实例化可能产生编译错误（`Bool` 不实现 `Number<T>`）。**兼容性策略**：若编码阶段验证发现非执行路径的编译器行为导致约束冲突，根据 `epsilonOf<T>()` 的生命周期选择以下策略之一：

**路径 A（原推荐——保留 `epsilonOf<T>()`）**：移除 `epsilonOf<T>()` 的 `where T <: Number<T>` 约束，将其实现修改为 `const func epsilonOf<T>(): T { T(1e-6) }`（对所有 `T` 可用，不再需要 `Number<T>` 约束）。此路径下 `equalEpsilon` 函数体继续引用 `epsilonOf<T>()`，无需联动修改；`ComputeEqual.callConst` 的浮点分支仍使用 `abs(a - b) <= epsilonOf<T>()`，`epsilonOf<T>()` 内部返回固定容差值 `T(1e-6)` 替代 `NumericLimits<T>.epsilon()`。

**⚠ 路径 A 整数可用性分析**：`T(1e-6)` 对整数类型 `T`（如 `Int32`、`UInt8`）不可用——仓颉整数类型的构造函数不接受浮点字面量（`Int32(1e-6)` 编译错误，`Int32(0.000001)` 同样编译错误），仅接受整数字面量（如 `Int32(0)`、`Int32(1)`）。因此路径 A 的 `epsilonOf<T>(): T { T(1e-6) }` 实现对整数类型 `T` 不可用，整数 `T` 实例化 `epsilonOf<T>()` 将产生编译错误。然而，`epsilonOf<T>()` 仅在编译期 `if` 的浮点分支中被调用（`if (isIec559Of<T>()) { abs(a - b) <= epsilonOf<T>() }`），整数 `T` 永远不会进入此分支。若编译器在实例化处对非选择分支中的 `epsilonOf<T>()` 仍进行语法/语义检查（包括泛型约束检查），则整数 `T` 对 `epsilonOf<T>()` 的实例化可能产生编译错误。此风险与编译期 `if` 分支抑制验证（§2.1 项④/⑫）直接关联——若编译器正确抑制非选择分支，路径 A 安全；若编译器对非选择分支仍执行全面检查，路径 A 需补充编译期分支保护（如将 `epsilonOf<T>()` 调用包裹在 `if (isIec559Of<T>())` 内）。**路径排序修正**：鉴于路径 A 对整数类型的可用性依赖编译期 `if` 分支抑制行为，其实际修改范围并非"最小"——需在分支抑制验证通过后方可确认安全。因此**路径 A 与路径 B 的优劣排序需重新评估**：路径 A 的优势在于 `equalEpsilon` 和 `ComputeEqual.callConst` 无需联动修改（仅修改 `epsilonOf<T>()` 一处）；路径 B 的优势在于完全消除 `epsilonOf<T>()` 依赖，将容差值内联到调用点，无需依赖编译期 `if` 分支抑制行为对泛型约束的豁免——但需联动修改 `equalEpsilon` 定义（Vec1~Vec4 共 4 处）。**推荐策略**：编码前验证项⑲确认 `T(1e-6)` 对整数类型的编译行为，并根据结果选择：(1) 若 `Int32(1e-6)` 编译错误且编译期 `if` 分支抑制对非选择分支中的泛型约束检查有效→路径 A 安全，优先采用；(2) 若编译期 `if` 分支抑制对非选择分支中的泛型约束检查无效→优先采用路径 B。

**路径 B（备选升级——完全移除 `epsilonOf<T>()`）**：移除 `epsilonOf<T>()` 函数，将 epsilon 逻辑直接内联到所有调用点：
- 在 `ComputeEqual.callConst` 的浮点分支中内联：`if (isIec559Of<T>()) { abs(a - b) <= T(1e-6) } else { a == b }`。
- 在 `equalEpsilon` 的函数体中同步内联（将 `epsilonOf<T>()` 引用替换为 `T(1e-6)`），涉及 Vec1~Vec4 共 4 处定义。
此路径需要联动修改 §4.5 的 `equalEpsilon` 定义。**路径 B 对整数类型的可用性**：`T(1e-6)` 同样对整数类型不可用，但路径 B 中该表达式仅出现在 `if (isIec559Of<T>())` 的选择分支内，且 `equalEpsilon` 为非 `const` 函数——编译期 `if` 分支抑制在非 `const` 函数中不可用，因此 `equalEpsilon` 体内的 `T(1e-6)` 对整数 `T` 实例化时会直接编译错误。此行为与当前设计一致（`equalEpsilon` 在 `Bool` Vec 上编译错误，§4.5 已标注）。整数 `T` 上的 `equalEpsilon` 因 `-` 运算符可用（整数支持减法）而能编译通过，但内联的 `T(1e-6)` 将导致编译失败——解决方案：路径 B 中 `equalEpsilon` 的 `T(1e-6)` 也需编译期分支保护，或接受整数 Vec 的 `equalEpsilon` 在路径 B 下编译失败（整数 Vec 本应使用 `==` 精确比较，`equalEpsilon` 对整数语义上无意义）。**选择依据**：路径 A 与路径 B 的选择取决于编码前验证项⑲的结果和编译期 `if` 分支抑制的验证状态。若验证确认分支抑制有效，路径 A 修改范围最小（仅修改 `epsilonOf<T>()` 一处），推荐采用。若验证确认分支抑制对泛型约束检查无效，路径 B 更安全（彻底消除 `epsilonOf<T>()` 依赖）但需联动修改 4+1 处（Vec1~Vec4 的 `equalEpsilon` + `ComputeEqual.callConst`）。

`IsFloat` 参数不再需要——`if (isIec559Of<T>())` 在编译期直接查询 `T` 是否为 IEEE 754 浮点类型，零运行时开销地选择比较路径。`ComputeEqual` 的类型参数简化为单一 `T`。

**编译期判定路径**：
1. Vec 结构体定义 `const init` 构造函数。
2. Vec 的 `==` 运算符声明为 `const` 函数。
3. `const` 函数体内通过 `if (isIec559Of<T>())` 在编译期选择比较路径——浮点类型使用容差比较，整数/Bool 类型使用 `==` 直接比较。
4. `isIec559Of<T>()` 由 `shim_limits.cj` 提供。实现策略：在 `const` 函数体内使用 `is` 运算符对类型实例进行编译期类型检测——创建 `T` 类型的临时值并通过 `is` 判断其是否为 `Float32` 或 `Float64`。该模式在仓颉 `const` 函数上下文中可行，因为 `is` 属于可参与 `const` 表达式的运算符，且 `T(0)` 作为数值/布尔类型的 const 构造是合法的（数值类型构造函数、`Bool(0)` 均在 const 表达式中可用）。

**实现方案**：
```cangjie
const func isIec559Of<T>(): Bool {
    if (T(0) is Float64 || T(0) is Float32) { true } else { false }
}
```
此方案不依赖函数重载或模板特化——通过 `is` 运算符在编译期直接检测类型身份，完全符合仓颉泛型函数的重载规则（单一泛型函数，无非泛型部分的差异）。`T(0) is Float64` 中，`T(0)` 是合法的 const 表达式（数值/布尔类型的构造函数在 const 上下文中可用），`is` 是合法的 const 表达式运算符。

**备选路径**（若 `const` 函数体内的 `if` 分支在特定上下文不可用）：所有类型使用精确比较（`a == b`）。此路径不损失正确性——浮点数直接比较在大多数使用场景下足够。浮点容差比较通过独立的非 `const` 具名函数 `equalEpsilon`（定义见 §4.5）提供给需要容差比较的场景。**回退路径一致性**：此备选路径与 §7 D29 定义的二值决策中的"回退路径"一致——若 `const` 表达式链验证失败，`==` 整体回退到精确比较路径，浮点容差比较由非 `const` 具名函数 `equalEpsilon` 提供。

**`const operator ==` 表达式链兼容性**：`abs(a - b) <= epsilonOf<T>()` 表达式链中各环节（减法、`abs()`、`epsilonOf<T>()`、`<=` 比较）的 const 兼容性要求及验证状态详见 §7 D29。编码阶段需逐一验证后方可确认完整 const 路径的可行性。

**机器 epsilon 容差比较的值域局限性**：`ComputeEqual.callConst` 的浮点路径使用 `NumericLimits<T>.epsilon()`（机器 epsilon）作为绝对容差阈值。此方案存在值域局限性：机器 epsilon 是相对于 1.0 量级浮点值的 ULP（units in the last place），对于远大于 1.0 的值（如 `1e10`），`epsilon()` 过于宽松（两个 `1e10 + epsilon` 级别差值的比较可能错误判定为相等）；对于远小于 1.0 的值（如 `1e-10`），`epsilon()` 过于严格（微小的相对误差即被判为不等）。**适用范围约定**：容差比较路径适用于值域接近 1.0 量级的浮点比较场景。对于大值或极小值的比较，调用方应自行选择合适的绝对或相对容差，或使用 `equalExact` 精确比较。**此值域局限性为仓颉迁移新增行为**——C++ GLM 的 `compute_equal` 对所有类型使用精确 `==`，不引入容差比较，因此不存在此局限性。

### 3.6 Shim 层

**角色**：替代 GLM 所依赖的 C++ 标准库设施（`<cassert>`、`<cstddef>`、`<limits>`），是首轮范围的编译前提。

- **`shim_assert.cj`**：提供 `assert(condition: Bool, message?: String)` 函数，行为等价于 `if (!condition) { throw ... }`。这替代了 `setup.hpp` 中的 `assert()` 宏及其变体 `GLM_ASSERT_LENGTH`。首轮 Debug 模式下 `assert` 触发异常，Release 模式不做断言消除（两种模式均保留断言）。后续轮次可通过 `const` 配置 + 编译期 `if` 在 Release 模式下跳过断言检查。

- **`shim_limits.cj`**：提供数值极限查询功能。为避免 `NumericLimits<T>` 上的 `where T <: Number<T>` 约束与 D5（宽松泛型约束，允许 `Bool` 作为 `T`）冲突，将 `NumericLimits` 拆分为两个独立部分：
  - **`NumericLimits<T>` 结构体**（保留 `where T <: Number<T>` 约束）：提供 `static max(): T`、`static min(): T`、`static epsilon(): T` 等需要数值运算的支持接口。此结构体仅在需要数值极限的场景中使用（如 `ComputeEqual` 的浮点容差 `epsilon` 路径）。
  - **`isIec559Of<T>()` 函数**（无约束，`const` 函数）：提供编译期 `Bool` 常量，判断 `T` 是否为 IEEE 754 浮点类型。对任意 `T`（含 `Bool`）可用，非浮点类型默认返回 `false`。此函数由 `ComputeEqual.callConst` 中的 `编译期 if` 分支使用，无 `Number<T>` 约束要求。

  `isIec559Of<T>()` 的实现策略：在 `shim_limits.cj` 中定义一个 `const` 泛型函数，函数体内使用编译期 `if` 配合 `is` 运算符检测类型：
  ```cangjie
  const func isIec559Of<T>(): Bool {
      if (T(0) is Float64 || T(0) is Float32) { true } else { false }
  }
  ```
  `T(0) is Float64` 在编译期求值——当 `T` 被实例化为具体类型后，`T(0)` 的值类型在编译期已完全确定，`is` 运算符可静态判定。此方案不依赖函数重载或模板特化，符合仓颉泛型系统的约束规则（类型变量约束不参与重载解析，但此处不涉及重载）。

- **`shim_cstddef.cj`**：定义 `type SizeT = UInt64`（无符号语义场景）和 `type LengthT = Int64`（索引/长度场景）两个类型别名，明确区分有符号/无符号使用场景，替代 C++ `size_t`/`ptrdiff_t`。VArray 的 `size` 属性提供编译期长度查询，等效于 C++ 中基于 `sizeof` 的数组元素计数宏。不单独定义 `countof` 函数——`VArray<T, $N>` 的 `$N` 必须是固定数值字面量，不可声明为值泛型参数。
- **`LengthT` 的使用边界**：`LengthT` 是通用长度/索引类型别名，**供下游消费者使用**——即需要以 `Int64` 类型表示向量维度或索引的通用代码场景。Vec 类型内部保持直接使用 `Int64` 作为 `length()` 返回类型和 `operator[]` 索引类型。理由：① Vec Vec1~Vec4 的 `length()` 返回值为编译期常量（1/2/3/4），`Int64` 字面量直接编码更清晰；② `operator[]` 的索引范围固定为 0~3，使用 `Int64` 无需类型别名间接引用；③ `LengthT` 的使用价值体现在下游泛型代码中——如编写一个接收任意 Vec 类型并输出其长度的函数时，可使用 `LengthT` 统一表示返回值类型。

### 3.7 标量类型别名

**角色**：在 `package glm` 中为仓颉原生数值类型提供与 GLM 兼容的命名体系。

映射规则：仓颉的 `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`/`UInt16`/`UInt32`/`UInt64`/`Float32`/`Float64` 分别映射为 GLM 的 `int8`~`uint64`/`float`/`double`。此外为各类型提供 `lowp_`/`mediump_`/`highp_` 精度变体别名。

补充 `uint` 别名：`public type uint = UInt32`，对应 C++ GLM 中的 `typedef unsigned int uint;`。

完整的标量别名 `public type` 语法清单（覆盖 10 个原生类型 + `uint` + 4 精度变体 = 44 个别名）：

| GLM 原生名 | highp（无前缀） | highp_ | mediump_ | lowp_ |
|-----------|---------------|--------|---------|-------|
| `int8` | `public type int8 = Int8` | `public type highp_int8 = Int8` | `public type mediump_int8 = Int8` | `public type lowp_int8 = Int8` |
| `int16` | `public type int16 = Int16` | `public type highp_int16 = Int16` | `public type mediump_int16 = Int16` | `public type lowp_int16 = Int16` |
| `int32` | `public type int32 = Int32` | `public type highp_int32 = Int32` | `public type mediump_int32 = Int32` | `public type lowp_int32 = Int32` |
| `int64` | `public type int64 = Int64` | `public type highp_int64 = Int64` | `public type mediump_int64 = Int64` | `public type lowp_int64 = Int64` |
| `uint8` | `public type uint8 = UInt8` | `public type highp_uint8 = UInt8` | `public type mediump_uint8 = UInt8` | `public type lowp_uint8 = UInt8` |
| `uint16` | `public type uint16 = UInt16` | `public type highp_uint16 = UInt16` | `public type mediump_uint16 = UInt16` | `public type lowp_uint16 = UInt16` |
| `uint32` | `public type uint32 = UInt32` | `public type highp_uint32 = UInt32` | `public type mediump_uint32 = UInt32` | `public type lowp_uint32 = UInt32` |
| `uint64` | `public type uint64 = UInt64` | `public type highp_uint64 = UInt64` | `public type mediump_uint64 = UInt64` | `public type lowp_uint64 = UInt64` |
| `float` | `public type float = Float32` | `public type highp_float = Float32` | `public type mediump_float = Float32` | `public type lowp_float = Float32` |
| `double` | `public type double = Float64` | `public type highp_double = Float64` | `public type mediump_double = Float64` | `public type lowp_double = Float64` |
| `uint` | `public type uint = UInt32` | — | — | — |

**编码说明**：标量别名的定义在 `fwd.cj` 文件顶部，位于向量别名之前。推荐将标量生成逻辑合并到 §3.8 的 Python 脚本中，以在 `gen_fwd_aliases.py` 内一次调用完整生成整个 `fwd.cj` 文件（标量别名 + 向量别名）。参见 §3.8 脚本增强说明。

由于仓颉原生数值类型名称已足够简洁（如 `Int32` 比 `i32` 更清晰且是语言关键字），标量别名在 `package glm` 中定义以供需要 GLM 命名风格的代码使用，但 `package glm.detail` 内部直接使用仓颉原生类型名。

### 3.8 向量类型别名

**标量与向量命名风格差异说明**：标量类型别名（§3.7）使用小写下划线精度前缀（如 `highp_int8`），而向量类型别名使用 PascalCase 精度前缀（如 `HighpBVec2`）。两风格在同一包中共存，原因如下：① 标量别名遵循 C++ GLM 的原始命名约定（`highp_int8`、`mediump_float` 等），以最大化与 C++ GLM 源码的命名兼容性——C++ GLM 中标量别名即为小写下划线风格；② 向量别名采用 PascalCase 是因为仓颉类型别名惯用大写驼峰命名，且向量别名用于类型声明位置（如 `var v: HighpBVec2`），PascalCase 符合仓颉类型命名惯例。此不一致是有意保持 GLM 源兼容性（标量侧）与仓颉生态惯例（向量侧）的折衷结果。迁移时需注意：C++ GLM 中的标量精度前缀（`highp_`/`mediump_`/`lowp_`）在仓颉中保持原样，而向量精度前缀（`Highp`/`Mediump`/`Lowp`）按 PascalCase 风格转换。§11.7 迁移映射表中已标注此差异。

**角色**：在 `package glm` 中为 Vec1~Vec4 的常用具现化提供简洁命名。

**别名数量**：16 个别名家族（bvec/ivec/uvec/vec/dvec/i8vec/i16vec/i32vec/i64vec/u8vec/u16vec/u32vec/u64vec/fvec/f32vec/f64vec）× 4 分量数（1/2/3/4）× 4 精度变体（`lowp_`/`mediump_`/`highp_`/无前缀） = **256 个别名**。此数量与 roadmap §3C/§3G 中明确的"256 个类型别名定义数"一致，是首轮强制交付标准，不存在其他替代数量。

**命名约定**（强制规则）：

1. **大小写风格**：统一采用 **大写驼峰（PascalCase）** 风格。GLM 原生小写名称（如 `bvec`、`i8vec`）在转换为别名时首字母大写（`BVec`、`I8Vec`）。所有别名首字母均大写。
2. **精度前缀**：无精度前缀的别名默认为 `highp_` 变体（等价于 `PackedHighp`）。精度前缀统一使用 **驼峰拼接**（无下划线分隔）：`Highp`、`Mediump`、`Lowp` 作为前缀直接拼接在家族名前。例如 `LowpBVec2`（非 `lowp_bvec2` 或 `Lowp_BVec2`）。
3. **格式模板**：`[Precision]FamilyName[Dimension]`，其中 `Precision` 为 `Highp`/`Mediump`/`Lowp` 之一（默认精度省略），`FamilyName` 为家族名的大写驼峰形式，`Dimension` 为 1/2/3/4。
4. **家族名到大写驼峰的映射规则**：
   - 单字母家族：`b`→`B`、`i`→`I`、`u`→`U`
   - 定长家族：`vec`→`Vec`、`dvec`→`DVec`、`fvec`→`FVec`
   - 数字前缀家族：`i8`→`I8`、`i16`→`I16`、`i32`→`I32`、`i64`→`I64`、`u8`→`U8`、`u16`→`U16`、`u32`→`U32`、`u64`→`U64`、`f32`→`F32`、`f64`→`F64`

**256 个别名格式示例表**（覆盖 4 个精度变体的完整模式）：

| GLM 原生名 | highp（无前缀） | highp | mediump | lowp |
|-----------|----------------|-------|---------|------|
| `bvec2` | `BVec2` | `HighpBVec2` | `MediumpBVec2` | `LowpBVec2` |
| `ivec3` | `IVec3` | `HighpIVec3` | `MediumpIVec3` | `LowpIVec3` |
| `vec4` | `Vec4` | `HighpVec4` | `MediumpVec4` | `LowpVec4` |
| `dvec2` | `DVec2` | `HighpDVec2` | `MediumpDVec2` | `LowpDVec2` |
| `i8vec3` | `I8Vec3` | `HighpI8Vec3` | `MediumpI8Vec3` | `LowpI8Vec3` |
| `u16vec4` | `U16Vec4` | `HighpU16Vec4` | `MediumpU16Vec4` | `LowpU16Vec4` |
| `f32vec2` | `F32Vec2` | `HighpF32Vec2` | `MediumpF32Vec2` | `LowpF32Vec2` |

每个别名的 `type` 定义形式如：

```
public type BVec2 = Vec2<Bool, PackedHighp>
public type LowpBVec2 = Vec2<Bool, PackedLowp>
public type IVec3 = Vec3<Int32, PackedHighp>
public type HighpDVec2 = Vec2<Float64, PackedHighp>
public type LowpI8Vec2 = Vec2<Int8, PackedLowp>
```

**别名实用性分级（仅用于编码顺序规划，非交付标准）**：256 个别名可按使用频率分为三级，用于指导编码阶段的实现顺序而非定义交付边界：

| 级别 | 数量 | 涵盖范围 | 说明 |
|------|------|---------|------|
| **必备** | 64 | 4 标量家族（b/ i/ u/ vec）× 4 分量数 × 4 精度变体 | 最常用的布尔/整数/无符号/浮点向量全体精度 |
| **常用** | 48 | 3 标量家族（d/ i8/ u8）× 4 分量数 × 4 精度变体 | 双精度和 8 位整数向量全体精度 |
| **可选** | 144 | 其余 9 家族 × 4 分量数 × 4 精度变体 | 16/32/64 位整数及 fvec/f32/f64 向量全体精度 |
| **合计** | 256 | 16 家族 × 4 分量数 × 4 精度变体 | — |

**消费者快速选择指引**：以下规则帮助下游开发者快速确定应使用的别名家族，无需逐一查阅映射表：
| 使用场景 | 推荐别名家族 | 说明 |
|---------|------------|------|
| 通用浮点向量（单精度） | `Vec` 家族（`Vec2`/`Vec3`/`Vec4`） | 最常用的浮点向量，对应 C++ GLM `vec2`/`vec3`/`vec4` |
| 双精度浮点向量 | `DVec` 家族 | 对应 C++ GLM `dvec2`/`dvec3`/`dvec4` |
| 32 位有符号整数向量 | `I` 家族 | 对应 C++ GLM `ivec2`/`ivec3`/`ivec4` |
| 32 位无符号整数向量 | `U` 家族 | 对应 C++ GLM `uvec2`/`uvec3`/`uvec4` |
| 布尔向量 | `B` 家族 | 对应 C++ GLM `bvec2`/`bvec3`/`bvec4` |
| 特定位宽整数向量 | 数字前缀家族（`I8`/`I16`/`I64`/`U8`/`U16`/`U64`/`F32`/`F64`） | 按位宽选择，如 `I8Vec2` 为 `Vec2<Int8, PackedHighp>` |
| 不关心精度（使用默认 `PackedHighp`） | 无前缀别名（如 `BVec2`） | 自动绑定 `PackedHighp`，最简洁形式 |
| 需显式指定低精度/中精度 | 带精度前缀别名（`LowpBVec2`/`MediumpBVec2`） | 精度前缀使用 PascalCase 风格 |

**首轮实现策略**：
- **强制交付标准**：`fwd.cj` 中**全量定义 256 个别名**，此为首轮验收强制标准。
- **降级策略（可选，需触发范围变更评审）**：若首轮孵化阶段因进度或资源限制需要缩小范围，可将别名覆盖范围从 256 缩减至**无精度前缀别名 + `highp_` 精度变体**（16 家族 × 4 分量数 × 1 默认精度 = 64 个）。此缩编必须经过**范围变更评审**并由主 Agent 确认。降级后剩余的 192 个别名纳入第 2 轮范围，在首轮验收通过后立即实施。roadmap 中描述的"最简可行范围 48 个"（16 家族 × 3 分量数 × 1 精度变体，排除 Vec1 别名）可作为进一步缩编的边界参考，但同样需触发范围变更评审。
  - **缩编触发条件**：① 首轮编码完成全部 256 个别名后，经编译验证发现 256 个别名导致总编译时间超过项目可接受阈值（如 > 30 分钟）或生成产物大小超过预期（如静态库体积 > 5MB）；② 项目进度评估由主 Agent 认定首轮交付窗口期不足，需人工下调别名覆盖范围。**审批路径**：由实施者提出缩编申请 → 主 Agent 确认 → 记录于范围变更日志。**剩余别名补全期限**：缩编后剩余的 192 个别名须在首轮验收通过后的下一轮次（第 2 轮）内补全，不晚于首轮验收后 4 周。
- **外部脚本生成策略**：256 个别名的定义具有高度规律性（16 家族 × 4 分量数 × 4 精度变体 = 256 组合），推荐使用**外部脚本**自动生成 `fwd.cj` 的别名定义代码。脚本策略：① 使用 Python 或 Node.js 脚本枚举所有组合（家族名→分量类型映射、分量数→VecN 映射、精度→Qualifier 映射）；② 按命名约定模板 `[Precision]FamilyName[Dimension]` 生成 `type` 定义行；③ 按家族分组、分量数排序组织输出；④ 输出直接写入 `fwd.cj` 的别名区域。此策略减少手动编码错误、降低重复劳动，且后续轮次新增别名家族时只需更新脚本的映射表。
  - **脚本产出规范**：
    - 输出路径：`src/glm/fwd.cj`（覆盖该文件的别名定义区域，保留文件头注释和文件尾空行）
    - 格式约定：按 16 家族分组（每组以 `// === {FamilyName} family ===` 注释头分隔），组内按分量数递增排列（Vec1→Vec2→Vec3→Vec4），每组内按精度变体排列（无前缀→Highp→Mediump→Lowp）
    - 版本控制策略：生成的 `fwd.cj` 文件纳入版本控制，生成脚本（如 `scripts/gen_fwd_aliases.py`）同步纳入版本控制仓库
    - 产物审查要求：生成的 `fwd.cj` 必须通过人工审查——抽查至少 4 个家族（`B`/`I`/`U`/`Vec`）各一个精度变体的别名映射正确性；审查后执行 `cjpm build` 验证全量编译通过
  - **fwd.cj 预期文件结构**：
    ```
    // fwd.cj — GLM 兼容类型别名
    // 注意：此文件由脚本自动生成，手动修改请谨慎
    
    package glm
    import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
    import glm.detail.{ PackedHighp, PackedMediump, PackedLowp, Qualifier }
    
    // === Bool family ===
    public type BVec1 = Vec1<Bool, PackedHighp>
    public type HighpBVec1 = Vec1<Bool, PackedHighp>
    public type MediumpBVec1 = Vec1<Bool, PackedMediump>
    public type LowpBVec1 = Vec1<Bool, PackedLowp>
    public type BVec2 = Vec2<Bool, PackedHighp>
    // ...（以下按模式重复）
    
    // === Int family ===
    public type IVec1 = Vec1<Int32, PackedHighp>
    // ...
    ```
    256 个别名集中在单文件中不拆分多文件——`fwd.cj` 预期约 300-350 行（含分组注释和空行），在单文件范围内可管理。
- **编码顺序**：在 `fwd.cj` 中按标量家族分组组织，每组内按分量数递增排列。首轮编码时按"必备→常用→可选"顺序依次实现，每完成一组即编译验证。

选择将别名集中在 `fwd.cj`（`package glm`）中，而非分散在各 Vec 定义文件，以保持良好的关注点分离——Vec 结构体关心类型定义，别名层关心命名约定。

**命名差异的长期影响**：大写驼峰别名（`BVec2`、`IVec3`）与 C++ GLM 小写名（`bvec2`、`ivec3`）的差异引入持续的认知映射成本。下游使用者需在以下两种命名空间之间建立 mental mapping：① C++ GLM 文档和遗留代码中的小写原生名；② 仓颉代码中的 PascalCase 别名。此映射成本在前 1-3 个月的过渡期最为显著（开发者频繁查阅 GLM 官方文档时需进行大小写转换），之后随着代码库的使用趋于自动化。**缓解措施**：① 在项目 `CONTRIBUTING.md` 或编码规范文档中提供完整映射表（已包含在 §11.7 中）；② 编码阶段将 `fwd.cj` 的首行注释标注为"GLM 兼容类型别名，命名风格为大写驼峰（PascalCase）"，作为新开发者的即时提示；③ 对于高频使用的标量类型（`vec`/`ivec`/`uvec`/`bvec`），可考虑在团队内部编码规范中建立"GLM 名 → 仓颉别名"的快速参考卡片。**长期可维护性评估**：一旦代码库定型，PascalCase 别名的使用将成为仓颉项目的编码惯例，新代码开发时直接使用 PascalCase 名称不会产生额外的跨语言切换成本。此差异在首轮可接受，无需在后续轮次修正。

**⚠ 同名别名自引用风险说明**：§3.8 脚本模板中 Vec 家族的别名生成遵循 `public type Vec2 = Vec2<Float32, PackedHighp>` 模式——左侧别名 `Vec2` 与右侧泛型结构体 `Vec2` 同名（仅别名省略了泛型参数 `<Float32, PackedHighp>`）。仓颉的 `type` 别名语义要求右侧引用指向完整类型路径——当 `fwd.cj` 位于 `package glm` 且 `import glm.detail.{ Vec2 }` 后，右侧 `Vec2` 应解析为 `glm.detail.Vec2<Float32, PackedHighp>`，而左侧别名 `Vec2` 属于 `package glm` 命名空间。**编译器行为不确定性**：编译器在处理 `public type Vec2 = Vec2<Float32, PackedHighp>` 时，是否将右侧的 `Vec2` 解析为 `glm.detail.Vec2`（导入来源）而非正在定义的别名自身（自引用），取决于仓颉编译器对别名定义中右侧表达式的解析时序——通常编译器在别名定义完成前应优先解析右侧为已有类型的引用。但此行为**未在仓颉语言文档中明确声明**，属于编译器实现细节。**验证依赖**：编码前验证项㉓须确认此同名别名的编译器行为——若编译器报歧义错误，修正策略为：(1) 在 `fwd.cj` 中为泛型结构体添加完整包路径前缀（`public type Vec2 = glm.detail.Vec2<Float32, PackedHighp>`），或 (2) 重命名别名为不含同名冲突的形式（如 `Vec2F`）。策略 (1) 更优（保持 GLM 兼容命名），仅需在脚本模板中调整 import 和引用格式。

#### 最小生成脚本示例

为使实施者无需从零编写生成脚本，以下提供一份最小 Python 脚本模板（约 40 行），覆盖 256 个别名的全量生成逻辑。实施者可基于此模板定制（如调整输出格式、增加分组注释、适配本地路径等）。

```python
#!/usr/bin/env python3
"""gen_fwd_aliases.py — Generate fwd.cj (scalar + vector type aliases for GLM)"""

SCALAR_MAP = {
    'int8': 'Int8', 'int16': 'Int16', 'int32': 'Int32', 'int64': 'Int64',
    'uint8': 'UInt8', 'uint16': 'UInt16', 'uint32': 'UInt32', 'uint64': 'UInt64',
    'float': 'Float32', 'double': 'Float64',
    'uint': 'UInt32',
}
SCALAR_PRECISIONS = [('', ''), ('highp_', ''), ('mediump_', ''), ('lowp_', '')]

VEC_FAMILIES = {
    'B': 'Bool', 'I': 'Int32', 'U': 'UInt32', 'Vec': 'Float32',
    'DVec': 'Float64', 'I8': 'Int8', 'I16': 'Int16', 'I32': 'Int32',
    'I64': 'Int64', 'U8': 'UInt8', 'U16': 'UInt16', 'U32': 'UInt32',
    'U64': 'UInt64', 'FVec': 'Float32', 'F32': 'Float32', 'F64': 'Float64',
}
VEC_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                  ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
DIMS = [1, 2, 3, 4]
VEC_TYPES = {1: 'Vec1', 2: 'Vec2', 3: 'Vec3', 4: 'Vec4'}

def gen_fwd():
    lines = ['// fwd.cj — GLM 兼容类型别名（自动生成）',
             '// 注意：此文件由脚本自动生成，手动修改请谨慎', '',
             'package glm',
             'import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }',
             'import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }', '']

    # === 标量别名 ===
    lines.append('// === Scalar aliases ===')
    for glm_name, cj_type in SCALAR_MAP.items():
        for prec_prefix, _ in SCALAR_PRECISIONS:
            alias = f'{prec_prefix}{glm_name}'
            lines.append(f'public type {alias} = {cj_type}')
    lines.append('')

    # === 向量别名（256 个） ===
    for fam, typ in VEC_FAMILIES.items():
        lines.append(f'// === {fam} family ===')
        for dim in DIMS:
            for prec, qual in VEC_PRECISIONS:
                suffix = '' if fam.endswith('Vec') else 'Vec'
                name = f'{prec}{fam}{suffix}{dim}'
                lines.append(f'public type {name} = {VEC_TYPES[dim]}<{typ}, {qual}>')
        lines.append('')
    return '\n'.join(lines) + '\n'

if __name__ == '__main__':
    with open('src/glm/fwd.cj', 'w') as f:
        f.write(gen_fwd())
    print('Generated src/glm/fwd.cj with scalar aliases + 256 vector aliases')
```

**脚本定制指南**：
- **标量别名部分**：`SCALAR_MAP` 字典控制标量别名的 GLM 名 → 仓颉类型映射。`SCALAR_PRECISIONS` 控制精度前缀变体。`uint` 别名已在脚本中固定输出。
- **向量别名部分**：`VEC_FAMILIES` 字典控制 16 个家族的映射。若需要按"必备→常用→可选"分级输出，可调整字典键的顺序。命名约定已在 `VEC_PRECISIONS` 中依据 PascalCase 风格配置。
- 输出路径 `src/glm/fwd.cj` 与 §2 初始目录结构一致。生成脚本本身应存放于 `scripts/gen_fwd_aliases.py` 并纳入版本控制。

**与 §2 目录结构的对应**：在 §2 初始目录结构中新增 `scripts/` 目录作为脚本占位：
```
glm-cangjie/
├── scripts/
│   └── gen_fwd_aliases.py   # 别名生成脚本
├── src/
│   └── glm/
│       ├── ...
```
此目录在 §2 中已同步更新（见 §2 初始目录结构）。

**仓颉 `type` 别名可见性提醒**：仓颉中 `type` 别名的默认可见性为 `internal`（包及子包可见）。若要对外暴露给下游消费者，必须在 `type` 前添加 `public` 修饰符。以上所有 `fwd.cj` 中的别名定义均使用 `public type` 形式。由于 `fwd.cj` 与 `lib.cj` 同属 `package glm`，这些 `public` 别名自动属于 `package glm`，下游消费者通过 `import glm.*` 即可正常访问。

**生成脚本生命周期警告**：生成的 `fwd.cj` 纳入版本控制后，若实施者手动修改了该文件中的别名定义，必须同步更新 `scripts/gen_fwd_aliases.py` 中的映射表（`FAMILIES`/`PRECISIONS`/`DIMS`），否则下次脚本重新生成时将覆盖手动修改。建议的变更流程：① 修改映射表 → ② 重新生成 `fwd.cj` → ③ 编译验证 → ④ 提交两者变更。

### 编译时间考量

256 个别名对编译时间的影响需区分两个阶段评估：

1. **别名定义阶段**（`fwd.cj` 编译期）：256 个 `public type` 别名定义本身对编译时间影响可忽略——`type` 别名是类型层面的引用绑定，不产生代码生成或模板实例化。此阶段编译时间增加主要来自文件 I/O（约 300-350 行文本解析），预计 < 1% 的总编译时间增长。

2. **别名使用阶段**（下游代码编译期）：当消费者代码引用这些别名时（如 `let v: BVec2 = ...`），编译器需要将别名解析为对应的具现化泛型类型（如 `Vec2<Bool, PackedHighp>`）。对于仅在变量声明中使用别名的场景，编译器完成类型解析即可，不触发完整的泛型实例化代码生成。当消费者代码触发泛型函数实例化（如 `v + v` 触发 Vec2 的 `operator +` 具现化），编译器为每种 Vec 类型生成对应机器码。**关键影响点**：256 个别名本身不直接导致 256 次具现化——具现化次数取决于下游代码中实际使用的别名组合数量。若下游代码仅使用 10 种 Vec 类型，编译器仅实例化 10 种 Vec 的代码。因此别名定义数量对编译时间的影响是间接的——别名数量影响类型解析时间（别名→具体类型映射），而非代码生成时间。

3. **缓解措施**：若编译时间确实成为瓶颈（如全量编译超过 30 分钟），可按 §3.8 定义的缩编流程降级别名覆盖范围（先缩减至 64 个最常用别名）。但缩编仅影响类型解析阶段，对实际泛型实例化次数无影响——实例化次数由消费者使用模式决定，与别名数量无关。

### 3.9 C++ 辅助设施省略说明

**`genTypeTrait` 和 `find_best_type` 等辅助设施**：
- C++ `qualifier.hpp` 的 `detail` 命名空间中定义了 `genTypeEnum` 枚举（`GENTYPE_VEC`/`GENTYPE_MAT`/`GENTYPE_QUAT`）、`genTypeTrait<genType>` 模板偏特化（查询类型是 VEC/MAT/QUAT）、`init_gentype<genType, type>` 模板（提供 `identity()` 静态方法），以及 `find_best_type` 等类型选择工具。
- 这些辅助设施在首轮中**不需要且不迁移**。理由：它们的功能服务于矩阵/四元数层的泛型代码（如 `init_gentype` 为矩阵和四元数提供单位值生成），当前首轮范围不包含矩阵和四元数类型。这些设施将在第 2-3 轮（矩阵/四元数迁移）时随对应实现一并引入。首轮保留 `qualifier.cj` 中的 `vec`/`mat`/`qua` 前向声明注释即可。

---

## 4. 关键行为契约

### 4.1 向量构造

- **默认构造**：**不可用**。数据成员无初始值，编译器不自动生成无参构造函数。需要默认值的场景应使用标量填充构造（传入 `T(0)`）。
- **标量填充构造**：接收单一标量，赋值给所有分量。对 Vec1~Vec4 均有效。也是事实上的"默认构造"替代。
- **逐分量构造**：接收与分量数相同数量的标量参数。Vec2 接收 `(x, y)`，Vec3 接收 `(x, y, z)`，Vec4 接收 `(x, y, z, w)`。
- **跨 Vec 转换构造**：从同分量数但不同 `T`/`Q` 的 Vec 构造，分量值通过 `T(v)` 显式类型构造函数转换。不使用 `where T2 <: T` 类型的泛型约束——仓颉原始数值类型间不存在子类型关系（`Int8` 不是 `Int32` 的子类型），因此 `where T2 <: T` 约束对于数值类型转换无效。改用无约束泛型参数配合分量级 `T(v2.components)` 显式转换实现。
- **跨分量数构造**：Vec4 可从 Vec2+Vec2、Vec3+标量、Vec1+Vec2+Vec1 等组合构造；Vec3 类似；Vec2 从 Vec1+标量等。遵循 GLSL 5.4.1 规范。
- **从 Vec1 显式构造**：所有 Vec 支持从 `Vec1<T, Q>` 显式构造，所有分量取 Vec1 的单一分量值。

**完整构造函数签名清单**（仓颉语法）：

**Vec1<T, Q> where Q <: Qualifier**：
```
// === const 构造函数（逐分量同类型初始化，可用于 const 上下文）===
public const init(x: T)  // 兼任标量填充构造
// === 非 const 构造函数（跨类型转换，不可用于 const 上下文）===
public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier
```
**Vec1 构造函数接口不对称性说明**：Vec1 仅提供 `const init(x: T)` 而无 `public init(scalar: T)`，与其他 VecN（Vec2~Vec4）同时提供 `public init(scalar: T)` 和 `const init(...)` 的构造模式不同。原因：Vec1 的 `const init(x: T)` 仅接收一个 `T` 参数，若同时定义 `public init(scalar: T)`，两者参数列表均为单 `T` 参数。仓颉函数重载规则中 `const` 修饰符不构成重载区分依据（const README §3.2 规则 7），因此 `const init(x: T)` 与 `public init(scalar: T)` 视为重复定义，编译将报错。此限制仅影响 Vec1（单分量 Vec 的 `const init` 天然具有与标量填充构造相同的参数签名），Vec2~Vec4 的 `const init(x, y, ...)` 参数数量与 `public init(scalar: T)` 不同，不受此影响。Vec1 的 `const init(x: T)` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），等效于标量填充构造的功能。**此不对称性对 `fromBoolVec` 工厂函数无影响**：`fromBoolVec` 现已改为包级独立函数（详见 §4.8），不再依赖 Vec 类型作为 receiver，因此 Vec1 的构造函数不对称性对其定义无任何制约——包级函数签名的参数列表与 Vec1 构造函数无任何重载冲突。Vec1 的 `fromBoolVec` 实现与其他 VecN 一致，仅需处理单分量 `if (v.x) { T(1) } else { T(0) }`。

**Vec2<T, Q> where Q <: Qualifier**：
```
// === 非 const 构造函数（标量填充，无需类型转换也可在运行时构造）===
public init(scalar: T)
// === const 构造函数（逐分量同类型初始化，可用于 const 上下文）===
public const init(x: T, y: T)
// === 非 const 构造函数（跨类型转换）===
public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
// 跨分量数截断构造
public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec3, take x,y
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec4, take x,y
```

**Vec3<T, Q> where Q <: Qualifier**：
```
// === 非 const 构造函数 ===
public init(scalar: T)
// === const 构造函数（逐分量同类型初始化，可用于 const 上下文）===
public const init(x: T, y: T, z: T)
// === 非 const 构造函数（跨类型转换）===
public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier
// Vec2 + 标量组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 2 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 + 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 + Vec1 组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec2 + Vec1 组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
// 跨分量数截断构造
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec4, take x,y,z
```

**Vec4<T, Q> where Q <: Qualifier**：
```
// === 非 const 构造函数 ===
public init(scalar: T)
// === const 构造函数（逐分量同类型初始化，可用于 const 上下文）===
public const init(x: T, y: T, z: T, w: T)
// === 非 const 构造函数（跨类型转换）===
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier
// Vec3 + 标量组合
public init<T2, Q2>(a: Vec3<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec3<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec3<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec3<T2, Q2>) where Q2 <: Qualifier
// Vec2 + Vec2 组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec2 + 2 标量组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 3 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
```

以上清单覆盖 GLSL 5.4.1 规范定义的构造语义。编码阶段按此清单实现每个 Vec 的构造函数，无需额外参考 C++ 源码中的宏展开。

**跨类型构造函数 T2 有效性范围**：所有跨类型构造函数（`public init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）的 T2 参数在签名层面无约束——T2 可为任意类型，包括非数值类型（如 `Bool`）。T2 的类型有效性由构造函数体内的 `T(v.x)` 转换表达式在实例化时决定：若 `T2` 到 `T` 的类型转换合法（即仓颉原生类型构造函数 `T(T2_value)` 可编译），则实例化通过；反之产生编译错误。此行为与 D5（宽松泛型约束，延迟检查）一致。T2 到 T 各组合转换的详细边界约定见 §9.4 类型转换边界表——跨类型构造的具体转换行为（整数宽度提升/截断、无符号↔有符号、浮点↔整数、Bool↔数值等）以该表为准。编码阶段实现跨类型构造函数时须同步查阅 §9.4 确认各 T2-T 组合的预期行为。

**跨 Q 构造函数重载解析风险与约束验证**：
- 所有跨类型构造函数（`public init<T2, Q2>(...) where Q2 <: Qualifier`）在 Q 参数上使用相同的约束（`Q2 <: Qualifier`），当 Q2 被实例化为不同 Qualifier 类型时，重载解析按实际参数类型匹配。仓颉泛型函数重载解析规则：泛型参数不构成区分依据，实际参数类型匹配决定选择。
- **已知安全场景**：① 不同 VecN 分量数的构造函数不会冲突（参数类型不同：`Vec2<T2, Q2>` vs `Vec3<T2, Q2>`），重载解析按分量数区分；② 同分量数的跨类型构造函数（`init<T2, Q2>(v: VecN<T2, Q2>)`）与同类型 fill-from-Vec1 构造函数（`init(v: Vec1<T, Q>)`）的冲突已在 D31 中覆盖——fill-from-Vec1 仅保留同类型版；③ 标量参数类型（`T`）与 Vec 参数类型的构造函数不会冲突（参数个数和类型均不同）。
- **风险领域**：当调用方传递一个已部分具现化的 Vec 类型（如 `Vec2<Float32, PackedHighp>`）时，仓颉编译器可能同时匹配多个泛型构造函数模板。需编码阶段原型验证：对 `Vec4` 的 `init<T2, Q2>(v: Vec3<T2, Q2>, b: T)` 和 `init<T2, Q2>(v: Vec3<T2, Q2>, b: Vec1<T2, Q2>)`，当第二个参数为 `Vec1<T, Q>` 类型的变量时，两个构造函数的第一个参数匹配相同（`Vec3`），第二个参数 `T` vs `Vec1<T, Q>` 是否因类型结构不同而充分区分。
- **重载解析风险严重程度评估**：Vec4 构造函数清单包含约 30 个重载版本，跨类型构造签名（`init<T2, Q2>(...) where Q2 <: Qualifier`）中泛型参数 Q2 在实例化前不参与重载解析区分。主要风险集中在 Vec4 的 `Vec3 + 标量` vs `Vec3 + Vec1` 等参数数量相同但第 2 个参数类型不同的对偶分支（共约 6 组重载对）。**此外**，多元 Vec1 参数组合内部（如 Vec4 的 4 个参数全为 Vec1 的组合中，4 个 `Vec1<T, Q>` vs 4 个 `T` 的重载），当部分参数为 `Vec1`、部分为 `T` 时可能产生额外歧义。两类风险均需系统性扫描覆盖。风险等级：**中等**——重构成本较高（需从约 30 个签名中识别并移除 4-6 个歧义分支改为具名工厂函数），但影响面有限（仅影响 Vec4 的少数特定重载对，Vec1~Vec3 不涉及此类歧义）。
- **回退方案**：若编码阶段原型验证发现重载歧义，按以下优先级处理：
  1. **移除歧义分支**：移除参数结构难以区分的重载对中较不常用的一侧（如 `Vec3 + Vec1` 组合而非 `Vec3 + 标量`组合），改为提供具名工厂函数（如 `fromVec3AndVec1(a: Vec3<T2,Q2>, b: Vec1<T2,Q2>): Vec4<T,Q>`）。
  2. **预计移除数量**：4-6 个构造函数分支，改为 4-6 个具名工厂函数。修改范围仅限于 `type_vec4.cj`，不影响 Vec1~Vec3 或公共 API 面。
  3. **验证项**：在 §2.1 编码前检查清单和 §10 设计阶段验证中新增 Vec4 重载解析验证项，确认回退方案的有效性。
- **重载解析期望注解**：当调用方提供的参数类型存在多重匹配时，仓颉编译器的预期重载解析规则为"具体类型优先于泛型类型"——即同分量数的非泛型构造函数（如 `public init(v: Vec1<T, Q>)`）优先于泛型跨类型构造函数（如 `public init<T2, Q2>(v: Vec1<T2, Q2>)`）。此期望需编码阶段原型验证确认，若编译器行为与预期不符则需调整相关构造函数设计（如将模糊分支改为具名函数形式）。

**T2 跨类型约束矩阵**：以下矩阵覆盖跨类型转换构造函数 `public init<T2, Q2>(v: VecN<T2, Q2>)` 中 T2 到 T 各组合的编译/行为状态。行标题为目标类型 `T`，列标题为源类型 `T2`。单元格填写编译与运行时行为描述。

| T \ T2 | Int8~Int64 | UInt8~UInt64 | Float32 | Float64 | Bool |
|--------|-----------|-------------|---------|---------|------|
| **Int8~Int64** | 编译通过，整数宽度提升/截断按仓颉类型构造函数规则 | 编译通过，无符号↔有符号按 wrapping 截断语义 | 编译通过，浮点→整数在溢出时抛 `ArithmeticException` | 编译通过，同左 | 编译错误（`IntN(Bool)` 不被 Cangjie 支持），改用 `fromBoolVec` 工厂函数 |
| **UInt8~UInt64** | 编译通过，有符号↔无符号转换 | 编译通过，整数宽度提升/截断 | 编译通过，浮点→无符号整数溢出抛异常 | 编译通过，同左 | 编译错误，改用 `fromBoolVec` 工厂函数 |
| **Float32** | 编译通过，整数→浮点精度损失（大整数场景） | 编译通过，同左 | 编译通过，同类型转换（恒等） | 编译通过，Float64→Float32 精度截断 | 编译错误，改用 `fromBoolVec` 工厂函数 |
| **Float64** | 编译通过，整数→浮点无损 | 编译通过，同左 | 编译通过，Float32→Float64 精度提升（无损） | 编译通过，同类型转换（恒等） | 编译错误，改用 `fromBoolVec` 工厂函数 |
| **Bool** | 编译通过（`Bool(IntN)` 合法：`0→false`，非零→`true`） | 编译通过（同左） | 编译通过（`Bool(Float32)` 合法：`0.0→false`，非零→`true`） | 编译通过（同左） | 编译通过，同类型转换（恒等） |

**矩阵解读**：
- Bool→Numeric 所有路径均为编译错误，需通过 §4.8 的 `fromBoolVec`/`fromBoolVecQ2` 工厂函数替代。
- Numeric→Bool 路径均编译通过（仓颉 `Bool(T)` 构造函数对非零值返回 `true`，对零值返回 `false`）。
- 浮点↔整数路径编译通过，但运行时溢出行为不同：浮点→整数溢出抛异常，整数→浮点精度损失不抛异常。
- 该矩阵与 §9.4 类型转换边界表语义一致，此处集中呈现以提升实施者查阅效率。

### 4.2 分量访问

- 通过 `operator []` 按索引访问（0 ~ N-1），带边界断言（`GLM_ASSERT_LENGTH` 等效）。仓颉 `[]` 运算符有两种形式：
  - **取值形式**：`public operator func [](i: Int64): T` — 返回第 i 分量。越界时触发断言。
  - **赋值形式**：`public mut operator func [](i: Int64, value!: T): Unit` — 将第 i 分量设为 value。`value` 为命名参数。必须声明为 `mut` 函数，因为 struct 的非 `mut` 实例成员函数不能修改实例成员。越界时触发断言。
- **const 上下文中的分量访问**：仓颉的 `const` 修饰符不构成函数重载的区分依据（const README §3.2 规则 7），因此无法同时定义 `const` 和非 `const` 两个版本的 `operator[]` 取值形式。对于需要在 `const` 实例成员函数中通过索引访问分量的场景，提供具名 const 函数：
  ```cangjie
  public const func componentAt(i: Int64): T
  ```
  该函数与 `operator[]` 取值形式的行为完全一致（含边界断言），但标注为 `const`，可在 `const` 实例成员函数体内使用。`componentAt` 在非 const 上下文中同样可用。
- 通过具名成员（`x`/`y`/`z`/`w`、`r`/`g`/`b`/`a`、`s`/`t`/`p`/`q`）直接访问。

断言行为统一见 §5.1 下标越界策略。

**`operator[]` 索引类型选择理由**：采用 `Int64` 作为索引类型。原因：① `shim_cstddef.cj` 中的 `LengthT` 别名定义为 `Int64`，`length()` 静态函数返回 `Int64`，索引类型与之保持一致可避免编译器在有符号/无符号比较时的告警；② `Int64` 是仓颉默认整数类型，在索引场景中覆盖所有可能的向量长度（当前 Vec1~Vec4 的最大索引为 3）；③ 与 GLM 默认 `length_t = int`（有符号）的行为一致。

### 4.3 算术运算

- **二元算术运算符**（`+`、`-`、`*`、`/`、`%`）：在 Vec 结构体内部定义为 `operator func`（非 `mut`），标注 `@OverflowWrapping`，内部实现为逐分量直接运算。支持 `VecN op VecN` 和 `VecN op T`（右操作数为标量）两种右操作数类型。
- **Vec1 广播运算模式**：C++ GLM 的 `type_vecN.inl` 中为 Vec2~Vec4 均提供了 `vecN op vec1` 和 `vec1 op vecN` 两种广播运算符重载（覆盖 `+`、`-`、`*`、`/`、`%` 共 5 种运算符），以及 `vecN op= vec1` 形式的广播复合赋值。仓颉中此广播模式通过 `extend` 块定义——在 `extend<T, Q> VecN<T, Q> where Q <: Qualifier` 块中新增 `operator func +(rhs: Vec1<T, Q>): VecN<T, Q>` 等广播运算符，逐分量将 `rhs.x` 广播到左操作数的每个分量进行运算。Vec1 左操作数的广播（`vec1 op vecN`）因运算符重载定义在左操作数类型作用域内的规则，可在 Vec1 的 `extend` 块中定义——`operator func +(rhs: Vec2<T, Q>): Vec2<T, Q>` 等，将 Vec1 的单一分量广播到右操作数的每个分量。**定义位置**：广播运算符在对应 `type_vecN.cj` 的 `extend` 块中与位运算符一同定义；Vec1 左操作数方向的广播运算符在 `type_vec1.cj` 的 `extend` 块中定义。**复合赋值**：Vec1 广播二元运算符的返回类型与左操作数类型匹配（如 `Vec2 + Vec1` 返回 `Vec2`），仓颉编译器自动生成对应的广播复合赋值版本（如 `Vec2 += Vec1`）。**精度说明**：Vec1 广播复合赋值仅支持同类型 `T` 右操作数（`VecN<T,Q> += Vec1<T,Q>`），编译器自动生成；跨类型版本不可用，详见 §8.5 排除清单。Vec1 左操作数方向的广播运算符返回类型为右操作数类型（如 `Vec1 + Vec2` 返回 `Vec2`），但复合赋值要求左操作数与返回类型匹配——`Vec1 += Vec2` 中左操作数为 Vec1、返回类型为 Vec2，不匹配，因此编译器**不自动生成**此方向的复合赋值。调用方需使用 `v1 = v1 + v2` 两步模式替代。
- **`@OverflowWrapping` 标注**：Vec1 广播运算符与已有二元算术运算符保持一致——定义在 `extend` 块中的广播运算符**直接标注 `@OverflowWrapping`**（与 `<<` 等位运算符的标注策略一致），自动生成的广播复合赋值继承标注语义。
- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`、`%=`）：由仓颉编译器从对应的二元运算符自动生成。不需要也不允许在源码中显式定义。`@OverflowWrapping` 标注在二元运算符上，复合赋值继承 wrapping 语义。**跨类型复合赋值不可用**：仓颉编译器自动生成的复合赋值仅接受与左操作数完全相同类型的右操作数。C++ GLM 中 `operator+=(vec<1, U, Q> const& v)` 和 `operator+=(vec<N, U, Q> const& v)` 允许跨类型复合赋值（右操作数的分量类型 `U` 可与左操作数的 `T` 不同）。仓颉中此能力不可用，具体分为两个子场景：(a) **同维度跨类型复合赋值**——`VecN<T, Q> op= VecN<T2, Q>`（如 `Vec2<Int32> += Vec2<Int16>`），与 §7 D15 跨类型运算不支持的设计决策一致，需先构造后赋值两步模式（`v = v + Vec2<Int32>(w)`）；(b) **Vec1 广播复合赋值**——`VecN<T, Q> += Vec1<T, Q>` 通过广播运算符自动生成可用，但 `VecN<T, Q> += Vec1<T2, Q>`（跨类型 Vec1 广播复合赋值）不可用——广播运算符仅接受同类型 Vec1 右操作数，需先转换再复合赋值两步模式（`v = v + Vec1<T, Q>(w)`）。
- **一元运算符**（`+`、`-`）：`+v` 返回自身；`-v` 返回逐分量取反的新向量。
- **标量在左的运算替代方案**：`scalar + vec`、`scalar - vec`、`scalar / vec` 等左标量右向量的运算符重载不可实现。提供具名函数替代，包括双向重载覆盖两种操作数顺序：
  - `add(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `add(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `sub(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `sub(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `mul(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `mul(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `div(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `div(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `mod(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `mod(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
- **`const` 修饰符差异依据**：扩展成员函数（`vec-op-scalar` 方向）因定义在 `extend` 块中，仓颉扩展语法不允许 `const` 修饰符（仓颉扩展 §4.2）。包级独立函数（`scalar-op-vec` 方向）无此限制，声明为 `const` 以支持编译期调用。此差异对公共 API 的影响：`v.add(s)` 语法丢失编译期调用能力，而 `add(s, v)` 语法保留。编码阶段若需在 `const` 上下文中使用 `vec-op-scalar` 方向，可调用包级独立函数并交换操作数顺序（`add(s, v)`）。
- **具名函数的定义位置与形态**：
  - **`vec-op-scalar` 方向**（如 `add(v, s)`）：定义为 Vec 的 **扩展成员函数**（通过 `extend VecN<T,Q>` 块），定义在对应 `type_vecN.cj` 文件中。调用方通过 `v.add(s)` 语法调用，随 Vec 类型导入自动可见。
  - **`scalar-op-vec` 方向**（如 `add(s, v)`）：定义为 **包级独立函数**，集中定义在独立的 `scalar_vec_ops.cj` 文件中（与 ComputeVec* 运算策略 `compute_vector_decl.cj` 职责分离）。调用方通过 `import glm.detail.{ add, sub, mul, div, mod }` 或通过 `glm` 包统一引入。该方向无法定义为扩展成员函数（孤儿规则——标量类型如 `Int32`/`Float32` 不在本包中定义）。
  - **Vec1~Vec4 各自定义**：每个 `add`/`sub`/`mul`/`div`/`mod` 函数为 Vec1~Vec4 各定义四个版本（共 5 运算 × 4 Vec × 2 方向 = 40 个函数），通过函数重载按 Vec 类型参数区分。
  - **`@OverflowWrapping` 标注策略**：20 个 vec-op-scalar 方向扩展成员函数（`add(v,s)` 等，5 运算 × 4 Vec）的内部实现**委托给对应 Vec 的二元算术运算符**（`+`/`-`/`*`/`/`/`%`）。二元运算符已在 Vec 结构体内部直接标注 `@OverflowWrapping`（§4.6），因此扩展成员函数通过委托**隐式获得 wrapping 语义**，无需额外标注。委托实现模式示例：`func add(self: Vec2<T,Q>, s: T): Vec2<T,Q> { self + s }`（调用已标注 `@OverflowWrapping` 的 `+`）。此策略避免 20 处重复标注，且确保扩展成员函数与二元运算符的溢出行为完全一致（同一代码路径，仅调用入口不同）。**scalar-op-vec 方向包级独立函数**（`add(s, v)` 等，共 20 个，定义于 `scalar_vec_ops.cj`）因不通过 Vec 二元运算符委托（直接使用 `T` 类型原生算术运算符），须在函数定义上**直接标注 `@OverflowWrapping`**，以确保 `add(s, v)` 与 `v.add(s)` 的溢出行为一致。详见 §4.6。
  - 后续轮次可通过**宏生成**自动产生上述具名函数的重复定义，减少手动编码量。
  - **命名空间污染风险评估**：`scalar-op-vec` 方向具名函数（`add(s, v)`、`sub(s, v)` 等）定义为 `package glm.detail` 中的包级独立函数，通过 `lib.cj` 的 `public import` 暴露到 `package glm` 命名空间。这些函数的名称（`add`、`sub`、`mul`、`div`、`mod`）是常见英文单词，在不同上下文中可能与其他库或用户代码中的同名函数发生冲突。**风险等级**：低-中。在单一项目中此类冲突概率较低；但在大型项目中，`add`/`sub` 等名称可能被多个模块定义。**调用方最佳实践**：① 优先使用 `vec-op-scalar` 方向的扩展成员函数（`v.add(s)`）以避免导入包级函数；② 若需使用 `scalar-op-vec` 方向函数，通过限定导入（`import glm.detail.{ add, sub, mul, div, mod }`）明确来源——注意 `scalar_vec_ops.cj` 声明了 `package glm.detail`，导入路径使用包名而非文件名；③ 若发生命名冲突，使用 `import glm` 的别名导入或通过局部函数包装消除歧义。
- **二元运算符与具名函数的关系及选择指南**：`vec-op-scalar` 方向具名函数（如 `add(v, s)`）与二元运算符 `v + s` 在功能上重叠——两者均执行逐分量加法运算。关系如下：① 二元运算符（`+`、`-`、`*`、`/`、`%`）是首选语法糖，适用于表达式链中需要运算符简洁性的场景（如 `a + b * c`）；② `vec-op-scalar` 方向扩展成员函数（`v.add(s)`）在功能上与 `v + s` 等价，适用于需要显式方法调用风格或未来需要替换为优化版本（如 SIMD 路径）的场景；③ `scalar-op-vec` 方向独立函数（`add(s, v)`）覆盖二元运算符无法表达的操作数顺序（标量在左），是运算符的**补充而非重复**。编码阶段建议：优先使用二元运算符，仅在需要 `scalar-op-vec` 方向或需要函数作为一等公民传递时使用具名函数。
> **💡 编码实现效率建议**：Vec1~Vec4 的运算符定义模式高度重复（Vec2~Vec4 各约 70 个运算符函数，Vec1 约 40 个，四个 Vec 类型合计约 280-320 个函数/运算符定义，约 2000+ 行手动编写）。建议以下降本策略：
> - **多光标编辑或代码片段模板**：以 Vec2 模板为基准，使用多光标编辑（VS Code Ctrl+Shift+L 等）批量扩展分量数；或为 Vec3/Vec4 各保存一份代码片段模板，插入后仅需调整分量名和数量
> - **脚本生成**（推荐）：编写简短 Python/Node.js 脚本，以 Vec2 模板为输入，生成 Vec1/Vec3/Vec4 的变体——替换分量名（`x,y` → `x,y,z,w`）、调整构造函数参数和运算符体内的分量运算行。与 §3.8 别名生成脚本共用同一脚本基础设施
> - **增量验证**：每完成一个 Vec 类型的运算符定义后立即编译验证（`cjpm build`），避免积压大量重复代码后一次性调试

**`Vec2<T,Q>` 算术运算符完整语法模板**（可作为其他 VecN 运算符实现的编码参考模板。注：`%` 仅对整数 `T` 可用，浮点 `T` 在实例化时产生编译错误（D5 延迟检查语义））：
```cangjie
// Vec2 结构体内部：二元算术运算符（直接标注 @OverflowWrapping，直接实现逐分量运算）
@OverflowWrapping
public operator func +(rhs: Vec2<T, Q>): Vec2<T, Q> {
    Vec2(this.x + rhs.x, this.y + rhs.y)
}
@OverflowWrapping
public operator func -(rhs: Vec2<T, Q>): Vec2<T, Q> {
    Vec2(this.x - rhs.x, this.y - rhs.y)
}
@OverflowWrapping
public operator func *(rhs: Vec2<T, Q>): Vec2<T, Q> {
    Vec2(this.x * rhs.x, this.y * rhs.y)
}
@OverflowWrapping
public operator func /(rhs: Vec2<T, Q>): Vec2<T, Q> {
    Vec2(this.x / rhs.x, this.y / rhs.y)
}
@OverflowWrapping
public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> {
    Vec2(this.x % rhs.x, this.y % rhs.y)
}
@OverflowWrapping
public operator func +(rhs: T): Vec2<T, Q> {
    Vec2(this.x + rhs, this.y + rhs)
}
@OverflowWrapping
public operator func -(rhs: T): Vec2<T, Q> {
    Vec2(this.x - rhs, this.y - rhs)
}
@OverflowWrapping
public operator func *(rhs: T): Vec2<T, Q> {
    Vec2(this.x * rhs, this.y * rhs)
}
@OverflowWrapping
public operator func /(rhs: T): Vec2<T, Q> {
    Vec2(this.x / rhs, this.y / rhs)
}
@OverflowWrapping
public operator func %(rhs: T): Vec2<T, Q> {
    Vec2(this.x % rhs, this.y % rhs)
}
// 一元运算符（不涉及溢出，不标注 @OverflowWrapping）
public operator func +(): Vec2<T, Q> { this }
public operator func -(): Vec2<T, Q> { Vec2(-this.x, -this.y) }
```
Vec3/Vec4 的运算符定义与 Vec2 模式完全一致，仅分量数不同（Vec3 增加 z 分量，Vec4 增加 z/w 分量）。Vec1 仅 x 分量，模式较 Vec2 更简单。

- **`%` 运算的整数约束**：`%` 运算符在 Vec 上定义为逐分量取模。当 `T` 为整数类型时正常编译；当 `T` 为浮点类型时，因仓颉原生 `Float32`/`Float64` 不支持 `%`，在实例化时产生编译错误。此行为与 D5（宽松泛型约束）一致——错误触发于使用处而非定义处。对于需要浮点数取模的场景，使用具名函数 `mod`（属于首轮范围）。`mod` 对浮点类型 Vec 的实现策略：整数 T 场景直接使用 `%` 运算符（与 Vec 二元 `%` 运算符行为一致）；浮点 T 场景因仓颉原生 `Float32`/`Float64` 不支持 `%`，改用算术恒等式 `x - y * trunc(x / y)` 实现浮点取模——其中 `trunc` 取自 `std.math`。对于 `Float32` 分量，通过先提升至 `Float64` 计算截断再转换回 `Float32` 的方式实现（`std.math.trunc` 仅提供 `Float64` 版本，预期精度提升无损取模语义的正确性（需验证，详见 §10 浮点 `mod` 实现正确性验证依赖项②））。此双路径在函数体内通过 `if (isIec559Of<T>())` 实现编译期分支选择。仓颉中编译期分支 `if` 要求所在函数必须为 `const` 函数，因此 `mod` 的**包级独立函数**方向（`mod(s: T, v: VecN<T,Q>)`）声明为 `const`。**扩展成员函数**方向（`mod(v: VecN<T,Q>, s: T)`）因定义在 `extend` 块中，不支持 `const` 修饰符（仓颉扩展 §4.2），无法使用编译期 `if`。此方向的整数/浮点双路径方案不可行——回退方案：`mod` 扩展成员函数仅提供整数路径（使用 `%`），浮点路径由包级独立函数覆盖。`add`/`sub`/`mul`/`div` 的包级独立函数声明为 `const`，扩展成员函数声明为非 `const`。
> **API 影响标注**：`v.mod(s)`（扩展成员函数）因仅提供整数路径，当 `T` 为浮点类型（`Float32`/`Float64`）时在实例化处产生编译错误。浮点 Vec 的取模运算须改用包级独立函数 `mod(s, v)`（定义于 `scalar_vec_ops.cj`，声明为 `const`，支持编译期 `if` 双路径）。此 API 不对称性由 `extend` 块不支持 `const` 修饰符的语言限制导致——`add`/`sub`/`mul`/`div` 的扩展成员函数不受此限，它们不依赖编译期 `if` 对整数和浮点类型均可用。
- **`++`/`--` 替代方案**：`++`/`--` 不在仓颉可重载运算符列表中，不可实现为运算符重载。改为提供具名函数 `increment(): VecN<T,Q>` 和 `decrement(): VecN<T,Q>`（标注 `@OverflowWrapping`，因定义在 `extend` 块中声明为非 `const` 函数），返回逐分量加/减 1 的新向量。C++ 的 `v++`（后缀）迁移为 `v = v.increment()`，`++v`（前缀）迁移为 `v = v.increment()`。对于 `VecN<Bool, Q>`，`increment()`/`decrement()` 在实例化时因 `Bool` 不支持 `+`/`-` 产生编译错误，与 `%` 的整数约束行为一致。
- **跨类型操作**：二元运算符仅支持同类型操作数（`VecN<T, Q> op VecN<T, Q>` 及 `VecN<T, Q> op T`）。不支持跨类型操作数（如 `Vec2<Int32> + Vec2<Int16>`）。需要跨类型运算时，调用方应显式转换操作数类型（使用跨 Vec 转换构造函数）。此限制源自仓颉运算符重载不能为泛型的语言规则——运算符函数定义中无法声明额外的类型形参 `U`（运算符不能使用 `operator func +<U>(rhs: U)` 的形式引入新类型参数）。

#### Vec1 运算符设计专节

Vec1 作为单分量向量，其运算符与标量 `T` 的运算存在语义重叠，需独立分析。

**语义重叠关系**：`Vec1<T, Q>(5) + Vec1<T, Q>(3)` 与 `5 + 3` 数学等价（均产生 8）。调用方可能对两者之间的选择产生混淆。差异点如下：
- **类型不同**：`Vec1<T, Q> + Vec1<T, Q>` 返回 `Vec1<T, Q>`（向量类型），`T + T` 返回 `T`（标量类型）。
- **语义意图不同**：Vec1 运算保留向量身份语义（结果仍为向量），便于后续与 Vec2~Vec4 广播组合（`vec2 + vec1`、`vec1 * vec2` 等）；标量运算丢失向量身份。
- **Qualifier 传播**：Vec1 运算携带 `Q` 类型参数，参与泛型代码中的 Qualifier 约束传播；标量运算无此维度。

**调用方选择指引**：

| 场景 | 推荐使用 | 理由 |
|------|---------|------|
| 纯标量计算（无需向量语义） | 标量运算 `T + T` | 避免不必要的 Vec1 包装开销，类型更直接 |
| Vec1 到 VecN 广播组合前序运算 | `Vec1 + Vec1` | 保持向量身份，支持与 Vec2~Vec4 的广播运算（`vecN + vec1`） |
| 泛型函数中 `VecN<T, Q>` 统一处理 | `Vec1 + Vec1` | 泛型代码中 Vec1 与 Vec2~Vec4 统一为 `VecN<T, Q>` 类型，保持代码一致性 |
| 矩阵运算中的标量广播角色 | `Vec1 + Vec1` | 矩阵乘法中 Vec1 作为"1×N 行向量/标量广播"角色，与矩阵元素的广播组合需要 Vec1 保持向量身份 |

**Vec1 在矩阵运算中的角色**：C++ GLM 中 Vec1 广播是矩阵运算的核心模式之一——矩阵×向量运算中，Vec1 的单一分量广播到矩阵行/列的全部元素。仓颉首轮虽不包含矩阵类型，但 Vec1 的广播运算符设计（本节上方"Vec1 广播运算模式"段）已为矩阵迁移轮次预留了运算基础——Vec1→VecN 广播运算符（`vecN + vec1`、`vec1 * vecN` 等）将在矩阵运算中直接消费。**矩阵迁移连锁影响评估**：若首轮不提供 Vec1 广播运算符，矩阵迁移轮次将无法直接实现 `mat * vec1` 广播模式，需在矩阵轮次补充定义——这将增加矩阵轮次的设计复杂度和迁移成本。因此 Vec1 广播运算符**属于首轮必须提供的运算模式**，对矩阵迁移具有直接连锁影响。

### 4.4 位运算

仅整数分量 Vec 有意义。包括 `&`、`|`、`^`、`<<`、`>>`。逐分量运算。二元位运算符通过 `extend` 块定义为扩展成员函数。

**Vec1 广播位运算模式**：与算术运算符对称，位运算符同样提供 Vec1 广播版本——`VecN & Vec1`、`VecN | Vec1`、`VecN ^ Vec1`、`VecN << Vec1`（移位量取 Vec1.x）、`VecN >> Vec1` 以及 Vec1 左操作数方向的 `Vec1 & VecN`、`Vec1 | VecN`、`Vec1 ^ VecN`。广播位运算符在 `extend` 块中与已有位运算符一同定义，`<<` 广播版本标注 `@OverflowWrapping`（与已有 `<<` 标注策略一致）。复合赋值规则与算术广播一致——`VecN &= Vec1` 自动生成可用，`Vec1 &= VecN` 不自动生成。

`extend` 块的完整语法示例如下：

```cangjie
// 以 Vec2<T, Q> 为例，在 type_vec2.cj 中定义位运算符
extend<T, Q> Vec2<T, Q> where Q <: Qualifier {
    @OverflowWrapping
    public operator func <<(shift: T): Vec2<T, Q> {
        Vec2(this.x << shift, this.y << shift)
    }
    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q> {
        Vec2(this.x & rhs.x, this.y & rhs.y)
    }
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q> {
        Vec2(this.x | rhs.x, this.y | rhs.y)
    }
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q> {
        Vec2(this.x ^ rhs.x, this.y ^ rhs.y)
    }
    public operator func >>(shift: T): Vec2<T, Q> {
        Vec2(this.x >> shift, this.y >> shift)
    }
    public func bitwiseNot(): Vec2<T, Q> {
        Vec2(!this.x, !this.y)
    }
}
```
`extend` 块的类型参数声明语法与 struct 定义一致——`extend<T, Q> Vec2<T, Q> where Q <: Qualifier`。扩展成员函数默认可见性与被扩展类型一致（`internal`），可通过 `public` 提升为对外可见。`this` 关键字在扩展成员函数中指向被扩展的 Vec 实例。注：`extend` 块中的成员函数不支持 `const` 修饰符（仓颉扩展 §4.2），因此 `bitwiseNot` 在此声明为非 `const` 函数。

**溢出策略**：`&`、`|`、`^` 运算不会产生溢出（按位运算结果在位宽内）。`<<`（左移）可能溢出——仓颉中 `<<` 的默认溢出策略**属于编译器实现定义行为**，`ThrowingOp<T>` 标准库辅助接口不包含 `throwingShl`，因此无法依赖标准库接口保证其默认策略。编码阶段须通过原型测试确认目标编译器的实际行为：若默认抛异常则标注 `@OverflowWrapping` 匹配 C++ GLM 的高位丢弃语义；若默认已 wrapping 则无需额外标注。C++ GLM 中 `vec << scalar` 是定义良好的（高位丢弃），因此 `<<` 运算符在 Vec 的 extend 块中定义时优先标注 `@OverflowWrapping`，编码阶段验证后确认是否需要保留。`>>` 右移不会产生溢出异常（高位补符号位或 0），保持默认策略。

`~`（单目按位取反）不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数 `bitwiseNot(): VecN<T,Q>`，通过 `extend` 块定义为非 `const` 扩展成员函数（仓颉扩展语法不允许 `const` 修饰符，详见 §3.2）。实现方式：`!` 是仓颉可重载的一元运算符，且对整数类型执行按位取反、对 `Bool` 执行逻辑非。因此 `bitwiseNot()` 的内部实现统一对每个分量调用 `!` 即可——对于整数分量，`!` 执行按位取反（与 C++ GLM 的 `~` 语义一致）；对于 `Bool` 分量（`VecN<Bool, Q>` 场景），`!` 执行逻辑否定（`!true = false`），这与 C++ GLM 的 `~bvec` 因整数提升始终返回 `true` 的行为完全相反。详见 §3.2 `VecN<Bool, Q>` 行为约定的已知行为差异说明。

**浮点类型约束**：`bitwiseNot()` 在 `VecN<Float32, Q>` 或 `VecN<Float64, Q>` 实例上会产生编译错误。原因是仓颉浮点类型（`Float32`/`Float64`）不原生支持 `!` 一元运算符（`!` 仅定义于整数类型和 `Bool`）。当 `T = Float32` 时，`bitwiseNot()` 函数体内的 `!component` 表达式无法通过编译。此行为与 D5（宽松泛型约束，延迟检查到实例化处）一致——错误发生在 Vec 使用者实例化 `VecN<Float32, Q>.bitwiseNot()` 的调用处，而非 Vec 结构体定义处。

**`<<` 和 `>>` 的移位量参数**：仓颉运算符重载不能为泛型——即不能定义 `operator func <<<U>(rhs: U)` 引入新类型参数。因此移位量的类型必须是具体类型（不可为模板参数 `U`）。可选方案：
- **方案 A（采用）：移位量取 `T`** ——右操作数类型与分量类型相同。对于 `Vec2<UInt8> << UInt8(3)`，移位量为 `UInt8`。方案 A 与 C++ GLM 的 `operator<<(vec, T scalar)` 行为一致，且适用于所有整数 `T`。注意：当 `T = UInt8` 时，移位量范围受限（0~7），但 `UInt8(3)` 在语义上与 `Int64(3)` 等效。
- **方案 B（备选）：移位量取 `Int64`** ——右操作数为固定 `Int64` 类型，与分量类型无关。此方案使移位量类型与 `LengthT` 一致（均为 `Int64`），移位移位较大向量时无需类型转换。但无法用 VecN 作为右操作数（`vec << vec` 形式在 GLM 中存在但极少使用），且需为每个 VecN 单独定义接受 `Int64` 的 `<<` 运算符（无法复用分量类型 `T` 的运算符）。
- **决策**：首轮采用方案 A（移位量取 `T`），在 Vec 的 extend 块中定义为 `operator func <<(shift: T): VecN<T, Q>`。此方案与 D5（宽松泛型约束）一致——移位操作在整数 `T` 上正确编译，在非整数 `T` 上于实例化处报错。方案 B（`Int64` 移位量）作为备选，若后续编码阶段发现 `T` 类型移位量在位宽较窄时（如 `UInt8`）产生过多截断转换，可改为方案 B。

### 4.5 比较运算

**相等比较**：
- **`==`**：逐分量调用 `ComputeEqual<T>.callConst` 比较，全分量相等返回 `true`。声明为 `const` 函数，利用 Vec 的 `const init` 构造函数支持，在函数体内通过 `if (isIec559Of<T>())` 在编译期选择比较路径——浮点类型使用 Epsilon 容差比较，整数/Bool 类型使用 `==` 直接比较。
- **`!=`**：定义为对 `==` 结果取反——`!(a == b)`。任一分量不等返回 `true`。仓颉中无 `!==` 运算符概念，因此采用取反形式。
- **浮点精确相等比较**（`equalExact`）：为浮点分量 Vec 提供 `equalExact(other: VecN<T,Q>): Bool` 扩展成员函数（定义在 `extend` 块中，声明为非 `const`）。该函数跳过容差比较路径，直接使用仓颉原生 `==` 对每个分量做精确比较。适用于需要 IEEE 754 精确相等语义的场景（如 `Infinity == Infinity` 返回 `true`、`NaN == NaN` 返回 `false`）。`equalExact` 在各 `type_vecN.cj` 的 extend 块中定义，对整数/Bool 分量 Vec 其行为与 `==` 等价（整数/Bool 精确比较）。浮点类型在调用 `equalExact` 时不受 `==` 的 Epsilon 容差分支影响。`equalExact` 的 `@OverflowWrapping`/溢出策略：不涉及算术运算，无需标注。

  > **全量行为偏离声明**：仓颉浮点 Vec 的 `==` 使用容差比较（`abs(a-b) <= epsilonOf<T>()`），而 C++ GLM 1.0.3 对浮点和整数 Vec 统一使用精确 `==`（其 `compute_equal<float>` 的浮点特化分支已被注释掉）。因此仓颉 `==` 的浮点容差行为是迁移引入的全量偏离，影响所有浮点 Vec 的 `==` 比较场景，不仅限于 Inf/NaN 边界。`equalExact` 提供了与 C++ GLM 行为一致的精确比较路径。
- **`equalExact` 的 `const` 声明说明**：仓颉 `extend` 块不支持 `const` 修饰符（仓颉扩展 §4.2），因此 `equalExact` 在 `extend` 块中声明为非 `const` 函数。此限制不影响功能正确性——浮点 `==` 在非 `const` 上下文中同样可用，仅失去在 `const` 表达式中编译期调用的能力。`equalExact` 的 const 声明策略与 D32/D33 统一约定一致——所有定义在 `extend` 块中的扩展成员函数统一声明为非 `const`，若编码阶段需要在 `const` 上下文中调用 `equalExact`，按 D33 备选方案统一处理（将定义移至 struct 体内声明为 `const` 实例成员函数），而非独立于 D33 约定单独处理。
- **`==` 回退路径标注**：若 `ComputeEqual.callConst` 的 `const` 表达式链验证失败（§7 D29），`==` 整体回退到精确比较路径（所有类型使用 `a == b`）。在此回退路径下，`equalExact` 的行为与 `==` 完全等价（均使用精确比较），`equalExact` 作为独立具名函数保留以提供语义明确性和与 `==` 潜在未来差异化的扩展点。

> **集中参考框 — `equalEpsilon` 跨章节依赖关系**：
> - **实现定义**：§4.5（本段），定义于各 `type_vecN.cj` 的 `extend` 块中
> - **双路径依赖**：§3.5 兼容性策略（路径 A/B）控制 `epsilonOf<T>()` 的生命周期，影响 `equalEpsilon` 函数体内的引用
> - **const 真空**：本段 ⚠ 警示，描述 D29 回退后 const 上下文中容差比较不可用及三条缓解路径
> - **成本评估**：§11.14 评估 const 化备选方案的成本（路径①~③）
> - **设计阶段验证**：§10 `equalEpsilon` 设计阶段验证子节（依赖项①~④）
> - **验收标准**：§12.2 `equalEpsilon` 正确性验收项 + `equalEpsilon-epsilonOf` 回退联动验收项
> - **迁移影响**：§11.9 `equalExact` 迁移模式（`equalEpsilon` 作为回退路径下的容差比较 API）

- **浮点容差比较回退函数（`equalEpsilon`）**：为 `==` 回退路径提供浮点容差比较能力的独立非 `const` 具名函数。仅在 `==` 因 §7 D29 回退到精确比较时使用。各 VecN 类型分别在对应 `type_vecN.cj` 的 `extend` 块中定义：
  ```cangjie
  // 以 Vec2<T, Q> 为例
  // 注意：abs() 调用依赖 import std.math.{ abs }（§8.1 已标注依赖），
  //       此处 abs 为 std.math 包级函数（非 Float32.abs()/Float64.abs() 静态方法）
  extend<T, Q> Vec2<T, Q> where Q <: Qualifier {
      public func equalEpsilon(other: Vec2<T, Q>): Bool {
          // 非 const 精确容差路径：内联容差比较
          // 注意：仅当 T 为浮点类型时有意义；整数 T（Int32 等）上 `-` 和 `abs` 合法，行为等价于 exact；
          // Bool T 上因 `-` 运算符不可用而在实例化时产生编译错误（与 §4.3 increment/decrement 在 Bool Vec 上的延迟检查行为一致）
          // 双路径依赖：epsilonOf<T>() 的兼容性策略参见 §3.5 路径 A（保留 epsilonOf<T>）或路径 B（完全移除，内联固定容差 T(1e-6)）
          // 若选择路径 B，须将 epsilonOf<T>() 替换为内联固定容差 T(1e-6)，详见 §3.5 双路径策略
          abs(this.x - other.x) <= epsilonOf<T>() && abs(this.y - other.y) <= epsilonOf<T>()
      }
  }
  ```
  > **双路径交叉引用**：上述 `equalEpsilon` 实现引用 `epsilonOf<T>()`，对应 §3.5 兼容性策略的**路径 A**（保留 `epsilonOf<T>()`）。若编码阶段选择 **路径 B**（完全移除 `epsilonOf<T>()`），须将 `epsilonOf<T>()` 替换为内联固定容差 `T(1e-6)`——详见 §3.5 双路径策略描述及 §12.2 `equalEpsilon-epsilonOf` 回退联动验收项。两条路径的联动修改要求在 §10 `equalEpsilon` 设计阶段验证依赖④和 §12.2 中已显式归档。

  **重要限制**：`equalEpsilon` 定义在 `extend` 块中，受仓颉扩展语法限制（仓颉扩展 §4.2）声明为非 `const` 函数。因此 `equalEpsilon` 体内的 `abs()`/`epsilonOf<T>()` 在非 `const` 上下文中调用，不依赖 `const` 表达式链的通过性。若 `const` 表达式链验证通过（D29 未触发），`==` 已内置容差比较，`equalEpsilon` 虽可定义但与 `==` 行为高度重叠——此时 `equalEpsilon` 作为显式容差比较 API 保留，供调用方在需要明确表达"使用容差比较"语义时使用。若 D29 回退触发，`equalEpsilon` 成为浮点 Vec 上唯一可用的运算符级容差比较路径（非 `==`，但语义与之等价）。

  > **Bool Vec 迁移指南**：`equalEpsilon` 在 `VecN<Bool, Q>` 上实例化时因 `Bool` 不支持 `-` 运算符而产生编译错误（与 §4.3 `increment`/`decrement` 在 Bool Vec 上的延迟检查行为一致）。迁移 `VecN<Bool, Q>` 的相等比较时：① 应使用 `==` 运算符（精确比较，对 Bool Vec 正常编译通过）；② 应使用 `equalExact`（语义与 `==` 等价）；③ **不可**使用 `equalEpsilon`。若需要 Bool Vec 的逐分量逻辑比较，应使用 `==`（返回 Bool 聚合结果）或 `logicalAnd`/`logicalOr`（返回 `VecN<Bool, Q>` 逐分量结果）。详见 §11.15 Bool Vec 相关 API 迁移模式。

  **⚠ const 真空警示**：当 D29 回退触发且 `==` 降级为精确比较后，`equalEpsilon` 作为唯一容差比较路径仅可在**非 const 上下文**中使用——它定义在 `extend` 块中，已被声明为非 `const` 函数。因此在 const 表达式（如 const 泛型函数、编译期常量初始化等场景）中，浮点 Vec 的容差比较能力完全不可用。若下游代码需要在 const 上下文中执行浮点容差比较，可选择以下路径：

  - **路径②（实际可行——推荐）**：在 const 上下文中使用精确比较 `==`（已降级为精确比较），放弃容差比较。若业务逻辑要求有限值容差容忍，在调用方将比较逻辑移至非 const 代码段，或在 const 上下文中接受精确比较语义。此路径无需任何源码修改，零实施成本。
  - **路径①（已废弃——仅作理论记录，不可实施）**：将 `equalEpsilon` 的定义从 `extend` 块移至 Vec 结构体体内声明为 `const` 实例成员函数。**废弃理由**：D29 回退的根本原因在绝大多数场景中由 `T(0)` const 构造或 `is` 运算符在 const 泛型中的不可用性导致——若此底层表达式链不可用，`equalEpsilon` 移至 struct 体内后函数体 `abs(a-b) <= epsilonOf<T>()` 仍包含被否定的表达式，必然同样失败。路径①仅在 D29 回退由**非 `const` 函数体内 `extend` 块语法限制**单独导致（而非底层表达式链不可用）的极端罕见场景中才理论上可行——此前提条件在实际中几乎不可能独立出现。**可行性评级：已废弃**。编码阶段**严禁**为此路径预留任何工作量或实施计划。§11.14 中与此路径相关的成本评估已同步移除，不计入任何成本合计。
  - **路径③（理论路径）**：调用方自行编写 const 内联比较表达式（如 `abs(v1.x - v2.x) <= T(1e-6) && ...`），将整个容差比较逻辑内联到 const 上下文的调用点。成本较高（分散修改）但无编译器行为依赖。

  此 const 真空是 D29 回退路径的一个已知副作用，需在触发 D29 回退后在 §12.2 验收中新增对应的 const 上下文验证项。

  **浮点 `Inf`/`NaN` 边界行为**：`equalEpsilon` 与 `const operator ==` 的容差路径共享同一实现模式（`abs(a - b) <= epsilonOf<T>()`），因此 `Inf == Inf` 返回 `false`（`Inf - Inf = NaN` 导致比较失败）、`NaN` 参与比较始终返回 `false`——与 §9.3 所述 `==` 容差路径的行为一致。若需 IEEE 754 精确相等语义，使用 `equalExact`（§4.5）。
  **定义位置**：`equalEpsilon` 在各 `type_vecN.cj` 的 `extend` 块中与 `equalExact` 一同定义（共享同一 extend 块），对 Vec1~Vec4 各定义一个版本。`equalEpsilon` 的可用性不受 D29 验证状态影响——无论 `const` 路径是否通过，该函数始终可编译通过（其实现不依赖 `const`）。**编码阶段建议**：无论 D29 验证结果如何，`equalEpsilon` 均纳入首轮定义。若 D29 通过，`equalEpsilon` 作为显式容差比较 API 提供；若 D29 回退，`equalEpsilon` 成为浮点 Vec 上唯一可用的容差比较路径。

**`<`/`<=`/`>`/`>=` 运算符**：
- **决策**：首轮**不定义** `<`/`<=`/`>`/`>=` 运算符。
- **理由**：C++ GLM 的 Vec 类型上未定义这四个运算符——`type_vecN.hpp` 中仅声明了 `==`、`!=`、`&&`、`||`。在 GLSL 语义中，向量的逐分量比较通过具名函数（`lessThan`、`greaterThan`、`lessThanEqual`、`greaterThanEqual`）完成，而非运算符。在仓颉中若定义这些运算符，需要明确语义选择——聚合比较（返回 `bool`，类似 `==`）与 C++ GLM 行为不一致，逐分量比较（返回 `VecN<Bool, Q>`）则无法在 `if` 中直接使用。因此首轮不提供，避免语义混淆。逐分量比较函数纳入后续函数库迁移轮次（从 `vector_relational.hpp` 迁移）。
- **替代方案**：需要逐分量比较时，使用 `ext/vector_relational.hpp` 中的具名函数（将来迁移）。

**布尔逻辑运算**：
- `&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数。各 VecN 类型分别定义对应版本：
  - `logicalAnd(a: VecN<Bool, Q>, b: VecN<Bool, Q>): VecN<Bool, Q>` — 定义为 **扩展成员函数**（通过 `extend VecN<Bool, Q>` 块），逐分量逻辑与（各 VecN 分别定义）。调用方使用 `v1.logicalAnd(v2)` 语法。注：`extend` 块不支持 `const` 修饰符，`logicalAnd` 声明为非 `const` 函数
  - `logicalOr(a: VecN<Bool, Q>, b: VecN<Bool, Q>): VecN<Bool, Q>` — 定义为 **扩展成员函数**（通过 `extend VecN<Bool, Q>` 块），逐分量逻辑或（各 VecN 分别定义）。调用方使用 `v1.logicalOr(v2)` 语法。注：与 `logicalAnd` 同理，声明为非 `const` 函数
  - 一元 `!` 可为 `VecN<Bool, Q>` 重载（`!` 在可重载运算符列表中）。

### 4.6 `@OverflowWrapping` 标注策略

> **⚠ 与 roadmap §0.5.1 的已知偏离声明**
> Roadmap §0.5.1 推荐的策略是在复合赋值运算符上标注 `@OverflowWrapping`、二元运算符委托给复合赋值。本设计采用完全相反的策略（二元运算符上直接标注、复合赋值由编译器自动生成）。此偏离由仓颉语言限制驱动——仓颉可重载运算符列表不包含复合赋值运算符，无法在复合赋值上显式标注。偏离的技术理由在下方正式说明。此偏离已在 §8.2 范围可追溯性对照表中正式记录在案。

本设计采用以下唯一确定的策略管理溢出标注：

**策略与 roadmap §0.5.1 的差异说明**：
- Roadmap §0.5.1 推荐的策略是：在**复合赋值运算符**（`+=`、`-=` 等）上标注 `@OverflowWrapping`，二元算术运算符委托给复合赋值实现，因此二元运算符无需标注。
- **本设计采用相反策略**：在**二元算术运算符**（`+`、`-`、`*`、`/`、`%`）上直接标注 `@OverflowWrapping`，复合赋值由编译器自动生成并继承标注语义。
- **理由**：仓颉的可重载运算符列表**不包含**复合赋值运算符（`+=`、`-=` 等），因此无法在源码中显式定义复合赋值函数，也就无法在其上直接标注 `@OverflowWrapping`。编译器在检测到返回类型与左操作数类型匹配的二元运算符后会自动生成对应的复合赋值版本，且自动生成时继承二元运算符上的 `@OverflowWrapping` 标注。因此将标注置于二元运算符上是唯一可行路径，且与 roadmap 在运行时语义上等价——wrapping 行为覆盖所有算术运算路径（包括复合赋值）。

具体标注分布：

- **二元算术运算符**（`+`、`-`、`*`、`/`、`%`）：在 Vec 结构体内部或 extend 块中定义为 `operator func`（非 `mut`），**直接标注 `@OverflowWrapping`**。`%` 虽整数取模不产生溢出，但标注 `@OverflowWrapping` 保持与所有算术运算符的一致性策略。共 5 个运算符 × 4 个 Vec 类型 = 20 处标注。运算符内部实现逐分量直接运算——不再使用"copy + op="委托模式（因复合赋值不可显式定义）。
- **`<<` 运算符**：在 extend 块中定义为位运算符，**标注 `@OverflowWrapping`**。`<<` 的默认溢出策略属于编译器实现定义行为，当前设计按 `@OverflowThrowing` 假设标注（C++ GLM 的 `vec << scalar` 高位丢弃为 wrapping 语义），编码前通过验证项㉔确认实际编译器行为后决定保留或移除标注。共 1 个运算符 × 4 个 Vec 类型 = 4 处标注。
- **`>>` 运算符**：右移不会产生溢出异常，不需要标注。
- **`&`、`|`、`^` 运算符**：按位运算不会产生溢出，不需要标注。
- **`increment()`/`decrement()` 具名函数**：作为 `++`/`--` 的替代，标注 `@OverflowWrapping`。共 2 个函数 × 4 个 Vec 类型 = 8 处标注。
- **vec-op-scalar 方向扩展成员函数**（`add(v,s)`/`sub(v,s)`/`mul(v,s)`/`div(v,s)`/`mod(v,s)`，共 5 运算 × 4 Vec = 20 个函数）：**无需直接标注**。这些函数的内部实现**委托给对应的二元算术运算符**（后者已标注 `@OverflowWrapping`），因此通过委托**隐式继承 wrapping 语义**。委托实现模式：`func add(self, s) { self + s }`（调用已标注的 `+`）。此策略避免重复标注，且确保扩展成员函数与二元运算符的溢出行为完全一致。
- **Vec1 广播运算符**（VecN op Vec1 方向 × 5 运算 × 3 Vec（Vec2/Vec3/Vec4）= 15 个 + Vec1 op VecN 方向 × 5 运算 × 3 Vec = 15 个，共 30 个运算符；位运算广播 × 5 运算 × 3 Vec × 2 方向 = 30 个运算符）：定义在 `extend` 块中，**直接标注 `@OverflowWrapping`**（与 `<<` 等位运算符的标注策略一致）。广播复合赋值由编译器自动生成并继承标注语义。
- **scalar-op-vec 方向包级独立函数**（`add(s,v)`/`sub(s,v)`/`mul(s,v)`/`div(s,v)`/`mod(s,v)`，共 5 运算 × 4 Vec = 20 个函数）：**需直接标注 `@OverflowWrapping`**。这些函数定义于 `scalar_vec_ops.cj`，内部直接使用 `T` 类型的原生算术运算符（如 `s + x`）而非通过 Vec 二元运算符委托。仓颉原生算术运算符默认采用 `@OverflowThrowing` 策略，若不标注 `@OverflowWrapping`，`add(s, v)` 与 `v.add(s)` 的溢出行为不一致（前者抛异常，后者 wrapping）。因此在全部 20 个函数定义上直接标注 `@OverflowWrapping`，确保 `scalar-op-vec` 与 `vec-op-scalar` 方向的溢出行为一致。标注格式示例：`@OverflowWrapping public func add<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where Q <: Qualifier { ... }`。
- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`、`%=`、`<<=`）：由仓颉编译器**自动生成**，不需要也不允许在源码中显式定义。编译器在检测到返回类型与左操作数类型匹配的二元运算符后自动生成对应的复合赋值版本。`@OverflowWrapping` 标注在二元运算符上，自动生成的复合赋值继承 wrapping 语义。
- **浮点类型无需标注**：浮点类型（`Float32`、`Float64`）在仓颉中不会触发溢出异常（浮点溢出产生 `±Infinity` 而非异常），因此 `@OverflowWrapping` 在浮点类型的 Vec 上语义无影响（标注与否行为一致）。首轮采用统一标注的简化策略——在所有 Vec 二元算术运算符上标注，无论 `T` 为何类型。</br></br>**⚠ 浮点 `@OverflowWrapping` 的编译期行为影响**：`@OverflowWrapping` 标注在浮点运算符上虽不影响运行时溢出语义，但可能影响编译器的代码生成选择——标注的存在可能抑制编译器对浮点 NaN/Infinity 检测的优化路径（如部分编译器在标注 `@OverflowWrapping` 的函数中跳过 IEEE 754 特殊值检测以提升性能）。若编码阶段在浮点 Vec 的算术运算中发现非预期的编译优化行为（如 NaN/Infinity 传播路径被编译器优化为未定义结果），可采取以下可选的编译期优化路径：</br>  1. **移除浮点 Vec 二元运算符上的 `@OverflowWrapping` 标注**（仅保留整数类型 Vec 的标注），消除对编译器浮点优化路径的潜在抑制。此路径需要修改 Vec1~Vec4 结构体中共 20 个算术运算符的标注策略——将标注从所有二元算数运算符改为条件性标注（仅整数 T 标注），需在编译期 `if` 分支内使用 `if const` 模式或通过拆分运算符定义实现。建议先在单一 Vec 类型上原型验证编译器行为差异后再决定。</br>  2. **保持统一标注**（当前设计）——若原型验证确认 `@OverflowWrapping` 对浮点代码生成无负面影响，则维持当前策略以保持标注一致性。</br>  编码阶段建议在完成 §2.1 项⑤⑫（`@OverflowWrapping` 继承性验证）时同步验证浮点标注对编译器代码生成的影响，以决定是否采用路径 1 的条件性标注策略。
- **`%` 运算符的溢出行为**：`%` 的溢出行为与 C++ GLM 一致——整数取模不产生溢出（除零仍抛异常）。`@OverflowWrapping` 标注在 `%` 上主要是为了一致性，实际不影响取模运算的语义。

**总结**：`@OverflowWrapping` 在二元算术运算符（5 个：`+`、`-`、`*`、`/`、`%`）、`<<`（1 个）、`increment()`/`decrement()`（2 个）、**20 个 scalar-op-vec 方向包级独立函数**和**30 个 Vec1 广播算术运算符 + 30 个 Vec1 广播位运算符**（其中所有 30 个算术广播运算符均在 extend 块中**直接标注 `@OverflowWrapping`**，与 §4.3 声明一致；`<<` 相关广播标注 `@OverflowWrapping`，`&`/`|`/`^`/`>>` 无溢出风险无需标注，实际需标注 30 个算术广播 + 6 个 `<<` 广播（VecN`<<`Vec1 方向 3 个 + Vec1`<<`VecN 方向 3 个）= 36 个）上直接标注；20 个 vec-op-scalar 方向扩展成员函数通过委托间接继承 wrapping 语义，无需直接标注；复合赋值通过编译器自动生成继承标注语义。`@OverflowThrowing` 默认策略对 `>>`、`&`、`|`、`^` 保持原样（这些运算不产生溢出）。无内部矛盾的唯一决策。

**`@OverflowWrapping` 标注继承性验证要求**：当前策略断言编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注（见 §7 D30 验证计划）。**此行为依赖编译器的未文档化行为**——仓颉注解文档（§1.1）声明溢出注解"只能标记于函数声明上"，但未明确说明自动生成的复合赋值函数是否继承被委托二元运算符的注解。此继承性在仓颉语言层面既未确认也未否认，属于对编译器实现行为的推测。编码阶段需优先编写原型测试代码进行验证。若验证失败，切换到备选方案——**在已定义的 20 个 vec-op-scalar 方向扩展成员函数（§4.3 已纳入首轮范围）上直接标注 `@OverflowWrapping`**，二元运算符委托给这些已标注的函数。注意：由于 add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数已属于首轮范围（§4.3），D30 回退**无需新增函数定义**，仅需补充标注和修改委托目标。备选方案的额外工作量和成本已纳入 §11.6 迁移成本评估。

### 4.7 哈希契约

- Vec 类型通过 `@Derive[Hashable]` 统一实现 `Hashable` 接口。编译器自动为所有分量类型已实现 `Hashable` 的实例化生成 `hashCode(): Int64`，包括整数/Bool/浮点分量 Vec。
- `hashCode()` 覆盖 Vec 的所有数据分量（Vec1 覆盖 x，Vec2 覆盖 x/y，Vec3 覆盖 x/y/z，Vec4 覆盖 x/y/z/w）。
- **浮点 Vec 的 `Hashable` 限制**：`@Derive` 生成的按位 `hashCode()` 与浮点容差 `==` 不完全一致——两个在容差范围内相等但按位不同的浮点向量可能产生不同的哈希值。此限制在 §3.2 中详细说明。需要哈希容器键值一致性的场景，调用方应确保键值精确匹配或自行包装。

### 4.8 Bool→Numeric 转换工厂函数 `fromBoolVec`

**角色**：提供 `VecN<Bool, Q>` 到 `VecN<T, Q>`（T 为数值类型）的显式转换路径，作为跨 Vec 转换构造函数无法直接处理 Bool→Numeric 的补充方案（详见 §9.4 路径 A）。

**设计决策**：采用**包级独立函数**模式，而非扩展成员函数。理由：
- 避免调用方需要持有同类型 Vec 实例作为 dummy receiver 的非自然调用路径。
- 包级独立函数与构造工厂函数的语义一致——调用方直接通过 `fromBoolVec(targetTypeInstance, sourceBoolVec)` 形式调用，无需预创建目标类型实例。
- 包级独立函数可在单个标量类型参数下统一为 Vec1~Vec4 各定义一个版本（通过函数重载按 Vec 类型参数区分），与 `scalar-op-vec` 方向辅助函数（`add(s,v)` 等）的模式一致。

**签名清单**（包级独立函数，建议定义在 `type_fromBoolVec.cj` 中以保持关注点分离，定义域为 `package glm.detail`）：

```
// Vec1 — 同 Q 版本
public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>): Vec1<T, Q> where Q <: Qualifier {
    Vec1(if (v.x) { T(1) } else { T(0) })
}

// Vec1 — 跨 Q 版本（输入 Vec 的 Qualifier 为 Q2，输出 Vec 的 Qualifier 为 Q）
public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>): Vec1<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    Vec1(if (v.x) { T(1) } else { T(0) })  // [^compiler-dep] Vec1(...) 调用未显式标注类型参数 <T, Q>，依赖编译器从返回值类型推断 struct 泛型实参
}

// Vec2 — 同 Q 版本
public func fromBoolVec<T, Q>(v: Vec2<Bool, Q>): Vec2<T, Q> where Q <: Qualifier {
    Vec2(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })
}

// Vec2 — 跨 Q 版本
public func fromBoolVecQ2<T, Q, Q2>(v: Vec2<Bool, Q2>): Vec2<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    Vec2(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })
}

// Vec3 — 同 Q 版本
public func fromBoolVec<T, Q>(v: Vec3<Bool, Q>): Vec3<T, Q> where Q <: Qualifier {
    Vec3(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) }, if (v.z) { T(1) } else { T(0) })
}

// Vec3 — 跨 Q 版本
public func fromBoolVecQ2<T, Q, Q2>(v: Vec3<Bool, Q2>): Vec3<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    Vec3(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) }, if (v.z) { T(1) } else { T(0) })
}

// Vec4 — 同 Q 版本
public func fromBoolVec<T, Q>(v: Vec4<Bool, Q>): Vec4<T, Q> where Q <: Qualifier {
    Vec4(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) }, if (v.z) { T(1) } else { T(0) }, if (v.w) { T(1) } else { T(0) })
}

// Vec4 — 跨 Q 版本
public func fromBoolVecQ2<T, Q, Q2>(v: Vec4<Bool, Q2>): Vec4<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    Vec4(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) }, if (v.z) { T(1) } else { T(0) }, if (v.w) { T(1) } else { T(0) })
}
```

**`T` 参数类型范围**：`T` 可为任意数值类型（`Int8`~`Int64`、`UInt8`~`UInt64`、`Float32`/`Float64`）及 `Bool` 自身。当 `T = Bool` 时，`fromBoolVec` 生成 `VecN<Bool, Q>`，语义为"Bool 值保持不变"（`true→T(1)=Bool(1)=true`，`false→T(0)=Bool(0)=false`），即此函数的值语义等价于恒等映射（分量值保持不变，但 Qualifier 类型可能变化）。注意：`T(1)`/`T(0)` 构造器对所有数值类型和 `Bool` 均合法，因此该函数对所有目标 `T` 均编译通过，不受 §4.1 跨类型构造函数中 Bool→Numeric 编译错误的限制。

**行为约定**：
- 对每个布尔分量，若为 `true` 则生成 `T(1)`，若为 `false` 则生成 `T(0)`。
- 包级独立函数默认可见性为 `internal`（包级），需添加 `public` 修饰符以在 `lib.cj` 中通过 `public import` 对外暴露。建议在 `lib.cj` 中新增：`public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }`。
- Vec1 的构造函数不对称性（§4.1）不影响 `fromBoolVec`/`fromBoolVecQ2` 的定义——包级独立函数不依赖 Vec 类型作为 receiver，参数列表与任何构造函数无重载冲突。
- 跨 Q 版本 `fromBoolVecQ2` 允许输入 Bool Vec 的 Qualifier（Q2）与输出数值 Vec 的 Qualifier（Q）不同。同 Q 版本 `fromBoolVec` 要求输入与输出的 Qualifier 相同。
- **`Q2` 命名说明**：`fromBoolVecQ2` 函数名中的 `Q2` 指代源 Bool Vec 的 Qualifier 类型参数（即 `fromBoolVecWithInputQualifier` 的缩写形式）。命名理由：C++ GLM 中跨 Q 转换由模板参数隐式处理，仓颉中 Q2 作为独立泛型参数需显式标注在函数名中以区分同 Q / 跨 Q 两个版本。替代命名 `fromBoolVecWithInputQualifier` 更具自解释性但长度较长，编码阶段可选择保留 `fromBoolVecQ2` 并在函数文档注释中增加自解释性说明（`// Q2 = source Bool Vec's Qualifier`），或替换为更描述性的命名。
- 函数体不依赖 `const` 修饰符，所有版本均声明为非 `const` 包级独立函数（浮点类型 `T` 上的 `T(1)`/`T(0)` 构造在非 const 上下文中无兼容性问题）。
- 调用方使用 `fromBoolVec<Int32, PackedHighp>(boolVec)` 或 `fromBoolVecQ2<Int32, PackedLowp, PackedHighp>(boolVec)` 语法。
- **类型参数显式指定说明**：`fromBoolVec<T, Q>` 和 `fromBoolVecQ2<T, Q, Q2>` 的泛型参数（`T`/`Q`/`Q2`）在满足以下条件时可省略：① 返回值的上下文可明确推断目标类型 `T` 和输出 `Q`（如将返回值赋值给类型标注的变量 `var v: Vec2<Float32, PackedHighp>`）；② 输入参数的 `Q2` 可自动推导。当返回值上下文不明确（如作为实参传递给重载函数、或赋给 `var` 未指定类型的变量），调用方须**显式指定全部泛型参数**以避免推导歧义。建议在公共代码中始终显式指定至少 `T` 和 `Q` 以消除调用方歧义。若编码阶段发现类型参数推导在某些调用模式（如链式调用、复合表达式）中频繁歧义，可考虑为 Vec1~Vec4 各增加一个辅助函数（如 `func fromBoolVecOf<T, Q>(v: VecN<Bool, Q>): VecN<T, Q>`）将返回值赋值给 `let` 绑定变量，通过变量类型标注辅助推导。
> **`[^compiler-dep]` 编译器推断依赖**：`fromBoolVecQ2` 函数体中的 `Vec1(...)` 调用未显式标注类型参数 `<T, Q>`，依赖仓颉编译器从函数返回值类型 `Vec1<T, Q>` 推断 `Vec1` 构造函数的泛型实参。此推断行为在当前设计阶段**未被验证覆盖**——编码前须编写原型验证确认编译器是否支持从返回值类型推断 struct 构造函数的泛型参数。若验证失败（编译器不支持此推断），须在所有 `fromBoolVecQ2`（Vec1~Vec4）的 `VecN(...)` 调用处显式标注类型参数，修改后的完整函数体示例如下：
> ```
> // Vec2 — 跨 Q 版本（显式标注类型参数 <T, Q> 后的完整函数体）
> public func fromBoolVecQ2<T, Q, Q2>(v: Vec2<Bool, Q2>): Vec2<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
>     Vec2<T, Q>(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })
> }
> 
> // Vec4 — 跨 Q 版本（显式标注类型参数 <T, Q> 后的完整函数体）
> public func fromBoolVecQ2<T, Q, Q2>(v: Vec4<Bool, Q2>): Vec4<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
>     Vec4<T, Q>(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) }, if (v.z) { T(1) } else { T(0) }, if (v.w) { T(1) } else { T(0) })
> }
> ```
> Vec1/Vec3 的修改模式与 Vec2/Vec4 一致——在 `Vec1(...)`/`Vec3(...)` 调用处分别标注 `<T, Q>`。此修改需覆盖 `fromBoolVecQ2` 的所有 4 个重载版本（Vec1~Vec4），同 Q 版本 `fromBoolVec` 不受影响（无类型推断需求）。

---

## 5. 错误处理策略

### 5.1 标准错误场景

| 场景 | 策略 |
|------|------|
| 下标越界（`operator[]`） | 在运行时检测索引范围，越界时调用 `assert()` 等效的 `if + throw` 模式。与 C++ `GLM_ASSERT_LENGTH` 行为一致。**注意语义差异**：C++ `GLM_ASSERT_LENGTH` 在 Release 模式下被宏定义移除（编译为空），而仓颉的 `if + throw` 无法通过编译消除（除非使用 `const` 配置常量 + 编译期 `if` 在 Release 模式下跳过断言检查）。首轮统一策略：Debug 和 Release 模式下均保留断言检查，Release 模式消除标记为后续轮次任务。 |
| 整数溢出 | 通过在二元算术运算符和 `<<` 运算符上标注 `@OverflowWrapping` 将溢出行为从"抛异常"改为"wrapping"，与 C++ UB 行为在数值结果上等价。`<<` 的默认行为是 `@OverflowThrowing`（超出位宽抛 `ArithmeticException`），标注 `@OverflowWrapping` 后与 C++ GLM 的高位丢弃行为一致。<br><br>**⚠ 有符号整数 `@OverflowWrapping` 与 C++ UB 迁移注意事项**：C++ 标准规定有符号整数溢出为未定义行为（UB），GLM 在此类场景中的实际行为依赖于编译器实现（通常为 wrapping）。仓颉的 `@OverflowWrapping` 将溢出语义**确定性地**定义为 wrapping（高位丢弃），这与 C++ UB 的实际常见行为一致，但改变了 UB 的法律状态——从"不可预测"变为"确定性的 wrapping"。迁移时需注意：① 若原 C++ 代码**依赖**有符号整数溢出后的特定 wrapping 行为（如模拟低级位运算），`@OverflowWrapping` 提供了相同的行为确定性，迁移安全；② 若原 C++ 代码**依赖** UB 不会发生（即代码自身确保不产生溢出），`@OverflowWrapping` 不会改变正确性（额外开销：当溢出实际发生时，wrapping 替代了可能的崩溃或数据损坏，产生静默错误）；③ 若原 C++ 代码**依赖**调试期间的 UB 检测（如 `-fsanitize=undefined` 编译时捕获有符号溢出），`@OverflowWrapping` 将使此类检测失效——溢出被静默处理，无法通过运行时检测发现。建议在迁移审查中对涉及有符号整数 Vec 运算的代码增加溢出标记审查，识别原本不应发生溢出的路径（标注 `@AssertNotOverflow` 等注释标记），便于后续轮次启用增强检查。<br><br>**跨类型构造中的溢出**：跨类型构造函数（`public init<T2, Q2>(v: VecN<T2, Q2>)`）内部使用 `T(v.x)` 类型构造函数执行分量转换，其溢出行为**不**受 `@OverflowWrapping` 影响——类型构造函数自身的溢出策略由仓颉语言定义（整数截断按 wrapping 语义，浮点→整数溢出错抛 `ArithmeticException`）。因此跨类型构造中的溢出行为与二元算术运算符的溢出行为可能不一致（前者使用语言默认策略，后者使用 `@OverflowWrapping`）。此差异是已知且合理的——构造和运算是两类不同操作，应遵循各自的溢出策略。<br><br>**迁移审查建议**：建议编写辅助搜索脚本，识别使用有符号整数 Vec 的运算表达式（特别是 `+`、`-`、`*`、`++` 模式），并在迁移时逐处审查原 C++ 代码中该表达式的溢出上下文，判断 `@OverflowWrapping` 的适用性。对于敏感数据路径（如安全关键计算），考虑在 wraps 后增加饱和度检查（通过后续轮次引入的 `clamp` 函数）。
| 除零 | 依赖底层仓颉运行时行为（整数除零抛 `ArithmeticException`，浮点除零返回 `±Inf`）。首轮不添加额外保护层。 |
| 位运算溢出 | `<<` 按 `@OverflowWrapping` 处理；`>>`、`&`、`|`、`^` 无溢出风险，保持默认策略。`increment()`/`decrement()` 按 `@OverflowWrapping` 处理。 |

### 5.2 异常场景和边界条件

首轮需明确约定以下边界行为：

| 场景 | 行为约定 |
|------|---------|
| 零向量标准化（`normalize(0,0,0)`） | 首轮不实现 `normalize` 函数，此约定适用于后续轮次。在算子层面，零向量的算术运算始终返回有效值（零向量加零向量得零向量，等）。 |
| 零向量除零保护 | 标量除零：`vec / 0` 对整数分量抛 `ArithmeticException`，对浮点分量返回包含 `±Inf`/`NaN` 的向量。与仓颉运行时行为一致，不做预防性检查。 |
| 浮点 NaN/Infinity 在各运算中的传播策略 | 所有算术运算直接委托给仓颉原生浮点运算，因此 NaN/Infinity 的传播行为与 IEEE 754 标准一致（NaN 参与的任何运算产生 NaN，Infinity 参与算术运算按 IEEE 754 规则传播）。首轮不引入 NaN 检测或特殊处理。 |
| 跨 Vec 转换中的精度损失 | 从较宽类型向较窄类型转换（如 `Float64` → `Int32`）时使用仓颉的类型构造函数转换语义。若为隐式转换不支持的场景（如 `Float64` → `Int32`），构造函数应要求调用方显式执行转换后传入。不默认截断或 saturate。 |

无 `Option`/`Result` 使用场景——向量算术运算始终返回有效值（在 wrapping 语义下），类型构造始终有效，不涉及可能失败的 I/O 或资源获取。

---

## 6. 并发设计

首轮范围无共享状态：Vec 结构体是值类型，所有运算不可变（产生新向量）或就地修改（复合赋值）。值类型的复制语义天然线程安全——不存在同一内存位置的并发写冲突。Vec 类型不做内部加锁，调用者负责在多线程场景下的值隔离（通过局部变量或消息传递）。

### 多线程场景覆盖

| 场景 | 行为约定 |
|------|---------|
| **Vec 在线程间传递** | Vec 为值类型，跨线程传递时通过复制实现——每个线程拥有独立的副本，无共享写冲突。通过 `spawn` 传递 Vec 变量时，捕获的 Vec 值被复制到新线程的栈上。 |
| **Vec 在并发容器中的行为** | Vec 可作为 `HashSet`/`HashMap` 键值使用（参见 §4.7 哈希契约）。在并发容器（如 `ConcurrentHashMap`）中使用时，Vec 作为不可变键值按值语义参与线程安全的容器操作。注意：`ConcurrentHashMap` 等容器内部已做同步，Vec 自身不做额外加锁。 |
| **复合赋值非原子性** | `v += other`（编译器自动生成的复合赋值）在并发场景下非原子——读取 v、逐分量运算、写回 v 三步骤不构成原子操作。若多个线程对同一 `var` 绑定的 Vec 变量执行复合赋值，可能产生竞争条件（丢失更新）。**约定**：对共享的 `var` Vec 变量执行复合赋值时，调用方需自行加锁（如使用 `Mutex`）或使用线程局部变量。此限制在 §9 异常场景中不重复声明，作为通用并发约束适用于所有 Vec 类型。 |
| **`@OverflowWrapping` 与并发** | 溢出标注不影响并发行为——`@OverflowWrapping` 仅控制算术运算的溢出语义（wrapping vs throwing），不影响数据竞争条件。在多线程复合赋值的竞争场景中，wrapping 行为仅保证每个分量的运算结果不抛异常，不保证分量的读写原子性。 |
| **const 函数与并发** | `const` 修饰符保证函数的只读语义（不修改实例成员），但不提供线程安全保证。在无共享可变状态的值类型场景中，const 函数的并发调用始终安全——多个线程对同一 Vec 副本调用 const 函数不会产生数据竞争。 |

---

## 7. 设计决策

### D1. 独立 Vec 结构体 vs 单模板 + 宏生成

**决策**：四个独立泛型结构体（Vec1~Vec4），不使用宏生成。

**理由**：仓颉不支持 C++ 偏特化，无法实现 `Vec<N,T,Q>` 单模板的分量数差异。宏生成虽然可减少重复代码，但首轮四个 Vec 结构体的定义模式高度一致且数量可控（4 个），独立编写可提供更好的 IDE 支持、调试可见性和代码导航体验。后续可在第二轮通过宏重构减少重复。

### D2. Qualifier 接口 vs 枚举 vs sealed class

**决策**：`interface Qualifier` + 空结构体实现。

**理由**：
- 枚举（enum）：仓颉 enum 值不能作为泛型类型实参传递，enum 构造器在泛型参数位置不被接受。
- Sealed class：引入继承和引用语义（class 为引用类型），而 precision tag 是零成本类型标记，不应有堆分配开销。
- 接口 + 空结构体：零运行时开销（空结构体的大小为零或极小），类型参数 `Q <: Qualifier` 编译期约束保证了类型安全性。通过 `type` 别名在 `glm` 包中提供常用具现化的简写形式。

### D3. 二元运算符 `@OverflowWrapping` 直接标注 vs 委托模式

**决策**：二元算术运算符直接标注 `@OverflowWrapping`、直接实现逐分量运算；复合赋值由编译器自动生成。

**理由**：v3 中采用"copy + op="委托模式，但仓颉可重载运算符列表中不包含复合赋值运算符（`+=` 等），因此 `mut operator func +=` 无法显式定义。v4 将标注和实现重心从复合赋值移到二元运算符——二元运算符在定义时标注 `@OverflowWrapping`，编译器自动生成复合赋值版本。此方案消除了 v3 中的可行性错误，同时保持 wrapping 语义的精确可控。

关于 roadmap §0.5.1 的差异：roadmap 推荐在复合赋值上标注、二元运算符委托的模式在仓颉中不可行（复合赋值不可显式定义）。本设计采用的"二元运算符直接标注"方案与 roadmap 在运行时语义等价——标注继承机制确保复合赋值自动获得 wrapping 语义，与 roadmap 的最终效果一致。

### D4. 仓颉原生类型名 vs GLM 兼容别名

**决策**：`package glm.detail` 内部直接使用 `Int32`/`Float32` 等仓颉原生类型名；`package glm` 中通过 `type` 别名提供 `int32`/`f32` 等 GLM 兼容命名。

**理由**：`package glm.detail` 是内部实现，应遵循仓颉语言惯例和最佳实践。`package glm` 是公共 API，需保持与现有 GLM 用户代码的兼容性。适当分离内部实现命名和外部接口命名。

### D5. 泛型约束粒度

**决策**：Vec 的 `T` 参数不做紧约束（不要求 `T <: Number<T>`），仅约束 `Q <: Qualifier`。

**理由**：GLM 的 vec 类型在 C++ 中对分量类型几乎不做约束（通过 SFINAE 校验有效性）。在仓颉中若对 `T` 加 `Number<T>` 约束，排除了 `Bool` 类型向量。宽松约束允许编译器在运算符函数体中因类型不支持运算报错，而非在类型定义处报错，与 C++ 模板的延迟检查行为一致。`ComputeEqual` 的浮点判定（`isIec559Of<T>()`）与 `NumericLimits` 的 `Number<T>` 约束解耦后，不再与 D5 冲突——对任意 `T`（含 `Bool`）均可编译通过（详见 D18）。

### D6. GLM_CONFIG_* 配置常量采用 const 声明

**决策**：将 C++ `#define` 宏映射为仓颉 `const` 常量（编译期常量），在 `setup.cj` 中集中声明。首轮所有配置取最保守值。

**理由**：`const` 常量是仓颉编译时求值的基本机制，可被 `if` 分支用于消除死代码（const 求值优化）。**作用域限制**：`const` 常量可用于全局、局部或静态成员（不可在扩展中声明）。`const + if` 的分支消除仅适用于函数体内的内联条件代码——在函数体外部（如顶层类型选择或成员定义）无法使用此模式。因此编译期类型选择（如 `ComputeEqual` 的浮点判定）必须在函数体内通过编译期 `if` 分支实现，而非在泛型参数约束或类型定义层面。

**18 个 GLM_CONFIG_* 常量完整清单**（与 v3 一致，子常量均已替换为字面量）：

| GLM 宏名 | 仓颉等效常量名 | 首轮推荐值 | 用途说明 |
|---------|--------------|-----------|---------|
| `GLM_CONFIG_SWIZZLE` | `const GLM_CONFIG_SWIZZLE: Int64` | `2` | 控制 swizzle 操作：0=operator, 1=function, 2=disabled。首轮必须设为 disabled。对应 C++ `GLM_SWIZZLE_DISABLED`=2 |
| `GLM_CONFIG_SIMD` | `const GLM_CONFIG_SIMD: Bool` | `false` | 控制 SIMD 指令集启用。首轮必须设为 false 以避免 `type_vec_simd.inl` 依赖。对应 C++ `GLM_DISABLE` |
| `GLM_CONFIG_ALIGNED_GENTYPES` | `const GLM_CONFIG_ALIGNED_GENTYPES: Bool` | `false` | 控制对齐类型（aligned/packed）。首轮使用非对齐默认布局 |
| `GLM_CONFIG_ANONYMOUS_STRUCT` | `const GLM_CONFIG_ANONYMOUS_STRUCT: Bool` | `false` | 控制匿名 struct 特性。仓颉不支持，首轮禁用 |
| `GLM_CONFIG_UNRESTRICTED_GENTYPE` | `const GLM_CONFIG_UNRESTRICTED_GENTYPE: Bool` | `false` | 控制泛型类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_UNRESTRICTED_FLOAT` | `const GLM_CONFIG_UNRESTRICTED_FLOAT: Bool` | `false` | 控制浮点类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_CLIP_CONTROL` | `const GLM_CONFIG_CLIP_CONTROL: Int64` | `0x0A`（十进制 10） | 裁剪空间约定（LH/RH, NO/ZO 位组合）。对应 C++ `RH_BIT \| NO_BIT` = 0x0A，首轮使用默认 RH_NO。**默认值来源已验证（参考实现确认）**：GLM 1.0.3 `setup.hpp` 中的 `GLM_CONFIG_CLIP_CONTROL` 默认值由两层条件编译决定——首先判断 `GLM_FORCE_DEPTH_ZERO_TO_ONE` 设置 `ZO_BIT`/`NO_BIT`，再判断 `GLM_FORCE_LEFT_HANDED` 设置 `LH_BIT`/`RH_BIT`。在无额外定义时，两层条件编译均走 `#else` 分支，最终等效于 `RH_NO = 0x0A`。**位定义值说明**：参考实现中 `RH_BIT = 1 << 3 = 8`（第 3 位，位值为 8），`NO_BIT = 1 << 1 = 2`（第 1 位，位值为 2），两者按位或得 `8 \| 2 = 0x0A`。**已验证结论**：通过读取 `setup.hpp:563-584` 的原始条件编译块，逐行确认分支走向与 `0x0A` 推导一致，三层次条件编译最终值完全吻合。**一致性确认**：经与 roadmap §3A.1 核实，默认值已统一为 `0x0A`，跨文件一致，无需协调 |
| `GLM_CONFIG_CONSTEXP` | `const GLM_CONFIG_CONSTEXP: Bool` | `false` | 控制 constexpr 标识函数。仓颉中 `const` 函数编译期求值可替代 |
| `GLM_CONFIG_XYZW_ONLY` | `const GLM_CONFIG_XYZW_ONLY: Bool` | `false` | 控制仅 xyzw 分量命名模式。首轮使用完整 rgba/stpq 命名 |
| `GLM_CONFIG_CTOR_INIT` | `const GLM_CONFIG_CTOR_INIT: Int64` | `0` | 控制构造函数初始化策略。首轮不依赖特定初始化。对应 C++ `GLM_CTOR_INIT_DISABLE`=0 |
| `GLM_CONFIG_DEFAULTED_FUNCTIONS` | `const GLM_CONFIG_DEFAULTED_FUNCTIONS: Bool` | `false` | 控制 C++11 defaulted 函数 |
| `GLM_CONFIG_DEFAULTED_DEFAULT_CTOR` | `const GLM_CONFIG_DEFAULTED_DEFAULT_CTOR: Bool` | `false` | 控制 defaulted 默认构造函数 |
| `GLM_CONFIG_LENGTH_TYPE` | `const GLM_CONFIG_LENGTH_TYPE: Int64` | `1` | 控制 `length_t` 类型选择：1=int（有符号），2=size_t（无符号）。对应 C++ `GLM_LENGTH_INT`=1，首轮使用有符号 Int64 |
| `GLM_CONFIG_PRECISION_BOOL` | `const GLM_CONFIG_PRECISION_BOOL: Int64` | `3` | 控制 bool 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_INT` | `const GLM_CONFIG_PRECISION_INT: Int64` | `3` | 控制 int 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_UINT` | `const GLM_CONFIG_PRECISION_UINT: Int64` | `3` | 控制 uint 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_FLOAT` | `const GLM_CONFIG_PRECISION_FLOAT: Int64` | `3` | 控制 float 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_DOUBLE` | `const GLM_CONFIG_PRECISION_DOUBLE: Int64` | `3` | 控制 double 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |

18 个常量集中在 `setup.cj` 中声明。首轮所有 `GLM_CONFIG_*` 取最保守值（如 `SIMD=false`、`SWIZZLE=2`），确保最小依赖闭合。`setup.cj` 不包含类型别名或 `assert` 函数（分别归入 `shim_cstddef.cj` 和 `shim_assert.cj`）。

**子常量编码策略**：上表中所有 C++ 宏常量（`GLM_SWIZZLE_DISABLED`、`GLM_DISABLE`、`GLM_HIGHP`、`GLM_LENGTH_INT`、`GLM_CTOR_INIT_DISABLE`、`RH_BIT(8)`、`NO_BIT(2)` 等）在首轮 `setup.cj` 中**统一采用字面量替换**，不定义对应的独立命名常量。理由：① 这些 C++ 宏在 GLM 中为 `#define` 整数值，在其余首轮源代码中不被直接引用（`GLM_CONFIG_*` 值仅在 `setup.cj` 中定义，首轮 Vec 运算符不依赖 C++ `GLM_ARCH`/`GLM_HAS_CONSTEXPR` 等检测宏的值）；② 后续轮次引入平台检测或 SIMD 路径时，如需引用这些子常量对应值，可在对应轮次的 `setup.cj` 更新中补充命名常量定义；③ 字面量直接写在配置表中，编码阶段无需查找外部宏定义即可获得完整常量值。

**`GLM_CONFIG_CLIP_CONTROL` 类型选择**：采用 `Int64` 而非自定义 enum。该配置值为位掩码（由 `LH_BIT`/`RH_BIT`/`ZO_BIT`/`NO_BIT` 按位或组合），`Int64` 类型直接匹配位运算语义。C++ GLM 中该宏定义为整数 `#define` 常量值的组合，映射到 `Int64` 是最直接的一对一对应。

### D7. Functor 不直接映射 C++ `<functional>` 中的 `std::plus<T>` 等

**决策**：functor 的 `call` 方法直接接受 lambda 或函数引用作为参数，不引入 `std::plus` 等函数对象的直接等效。

**理由**：仓颉无 `std::plus`，但函数类型 `(T, T) -> T` 和 lambda 表达式可直接作为参数传递。泛型 functor 接收 `F: (T, T) -> T` 类型的函数参数即可。对比 C++ 需要 `std::plus<T>`（一个标准函数对象类型），仓颉更简洁——直接在调用点使用 `{ a, b => a + b }` 或运算符引用。

### D8. var 数据成员对 let 绑定变量的影响

**决策**：Vec 结构体的数据成员全部声明为 `var`（无初始值）。

**理由**：编译器自动生成的复合赋值运算符需要能够修改 Vec 实例的成员。若使用 `let` 声明成员，则即使通过 `var` 绑定的结构体变量也无法执行复合赋值（`var` 绑定允许调用 `mut` 函数，但 `mut` 函数不能修改 `let` 成员）。将数据成员声明为 `var`，使得 `var v = Vec2(...)` 可以正常执行 `v += 1` 等自动生成的复合赋值。对于 `let v = Vec2(...)` 的变量，复合赋值触发编译错误，这与 C++ 中 `const` 向量不能执行 `op=` 的行为一致。

数据成员无初始值的决定：避免为默认构造函数引入不合理的约束。调用方需显式构造，使用标量填充构造 `Vec2(T(0))` 作为默认值替代。

### D9. `!=` 运算符的实现形态

**决策**：`!=` 定义为 `!(a == b)`。

**理由**：仓颉语言中不存在 `!==` 运算符。将 `!=` 重载为对 `==` 结果取反的语义是最直接且正确的实现。这一实现与 C++ GLM 中 `operator!=` 的语义等价。

### D10. 标量在左的运算无法重载

**决策**：不支持 `scalar + vec`、`scalar / vec` 等左标量右向量的运算符重载形式，以具名函数替代。

**理由**：仓颉的运算符重载要求运算符函数定义在左操作数类型的作用域内。标量类型（如 `Float32`）的 `+` 运算符无法由本包通过 `extend` 扩展（标量类型本身不在此包中定义，且扩展运算符重载也不被允许创建新的重载覆盖原生类型已有运算符）。因此 `scalar + vec` 模式不可实现。提供 `add(scalar, vec)` 和 `add(vec, scalar)` 双向具名函数覆盖两种操作数顺序。同样，`div`、`sub`、`mul`、`mod` 等也需提供双向重载。

### D11. 引入 `const init` 支持编译期分支

**决策**：为每个 Vec 结构体定义 `const init` 构造函数，移除与 `const init` 参数列表相同的普通 `init`。所有 `const init` 构造函数均显式声明为 `public`。

**理由**：仓颉语言要求仅当 struct 定义了 `const init` 时，才能定义 `const` 实例成员函数。`const` 实例成员函数（如 `==`）可以在函数体内使用编译期 `if` 实现编译期分支，零运行时开销地选择浮点容差比较路径或精确比较路径。`const init` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），因此同参数列表的普通 `init` 不再需要。仓颉函数重载规则中 `const` 修饰符不构成区分依据（const README §3.2 规则 7），若同时保留二者将导致重复定义编译错误。移除冗余额外的普通 `init`，仅保留 `const init` 即可覆盖所有构造场景。

### D12. `&&`/`||`/`~` 以具名函数替代运算符重载

**决策**：`&&`、`||`、`~` 不可作为运算符重载，以具名函数 `logicalAnd`、`logicalOr`、`bitwiseNot` 替代。

**理由**：仓颉可重载运算符列表为：`()`、`[]`、`!`、`-`（一元）、`**`、`*`、`/`、`%`、`+`、`-`（二元）、`<<`、`>>`、`<`、`<=`、`>`、`>=`、`==`、`!=`、`&`、`^`、`|`。该列表不包含 `&&`、`||`、`~`，因此无法为 Vec 类型重载这些运算符。具名函数在语义上等价，且可通过函数重载支持多参数形式。

### D13. `%` 运算符的可用性约束

**决策**：`%` 在 Vec 结构体上定义为逐分量取模运算符。对于整数 `T` 实例正常编译；对于浮点 `T` 实例在实例化时产生编译错误（因仓颉原生浮点类型不支持 `%`）。

**理由**：采用 D5 的宽松约束策略——`T` 在 Vec 结构体上不做紧约束，`%` 运算符体中使用 `T % T` 表达式。编译器在定义处通过语法检查，在实例化处验证语义。此行为与 C++ 模板的延迟检查一致（`std::vector<float> v; v % v;` 在 C++ 中同样在实例化处报错）。对于需要浮点取模的场景，使用具名函数 `mod`（属于首轮范围）。

**编译器行为条件性移动策略**：若编码前验证项⑰确认编译器在泛型 struct 定义处即对 `T % T` 表达式报错（非延迟检查），则 `%` 运算符需从 Vec 结构体内部移出。三种迁移路径按优先级排序：(1) **移至 extend 块**——将 `%` 运算符定义在 `extend<T, Q> VecN<T, Q> where Q <: Qualifier` 块中，编译器可能仅在具现化时对浮点 `T` 报错（extend 块的延迟检查语义可能不同于 struct 内部，需验证）；(2) **完全移除 `%` 运算符**——若 extend 块中 `%` 也在定义处报错，则从运算符层面完全移除，所有取模场景（含整数）统一通过 `mod` 函数实现；(3) **条件性 extend**——在 extend 块中添加额外约束 `where T <: Integral<T>`（若仓颉提供此类接口）限制 `%` 仅对整数 `T` 可见。此条件性策略的验证依赖编码前验证项⑰的结果。**路径②与路径③的区分条件**：路径②（移至 extend 块）适用条件为——编译器在 extend 块中对 `T % T` 不报定义处错误（具有实例化处延迟检查语义）；路径③（完全移除）适用条件为——编译器在 extend 块中对 `T % T` 同样报定义处错误（与 struct 体内行为一致）。此区分条件已纳入 §2.1 项⑰ 的扩展验证步骤。

### D14. 跨 Vec 类型转换不使用子类型约束

**决策**：跨 Vec 转换构造不使用 `where T2 <: T` 约束，改用无约束泛型 + `T(v)` 显式转换。

**理由**：仓颉原始数值类型间不存在子类型关系。`Int8` 不是 `Int32` 的子类型，因此 `where T2 <: T` 约束无法用于数值类型的跨类型 Vec 构造。改为无约束泛型参数，在构造函数体内对各分量调用 `T(v2.x)` 等显式类型构造函数，由仓颉的类型构造函数转换规则处理数值类型间的转换。这种方式的语义与 C++ `static_cast` 更为一致。

### D15. 跨类型运算不支持

**决策**：二元运算符不支持跨类型操作数（如 `Vec2<Int32> + Vec2<Int16>`）。

**理由**：仓颉运算符重载不能为泛型（不能引入新类型参数）。Vec 的 `operator +` 只能接受 `VecN<T, Q>` 类型的右操作数（`T` 和 `Q` 与左操作数相同）。对于跨类型运算，调用方必须使用跨 Vec 转换构造函数先将操作数转为同一类型。此限制在迁移时需通过搜索替换规则处理（详见 §11 迁移成本评估）。

### D16. Functor/ComputeVec 首轮仅定义不消费；scalar-op-vec 辅助函数独立于 scalar_vec_ops.cj 首轮消费

**决策**：`vectorize.cj` 和 `compute_vector_decl.cj` 中的类型在首轮的行为分为两类：

1. **`compute_vec_*` 策略结构体**（如 `compute_vec_add`、`compute_vec_sub` 等）和 **Functor 类型**：首轮仅定义结构体，不被 Vec 运算符实现调用，为后续 SIMD 轮次预留。定义在 `compute_vector_decl.cj` 和 `vectorize.cj` 中。
2. **`scalar-op-vec` 方向辅助函数**（如 `add(s, v)`、`sub(s, v)` 等）：独立为 `scalar_vec_ops.cj` 文件，首轮即被消费——Vec 使用者在 `scalar + vec` 等场景中需调用它们。该文件与 `compute_vector_decl.cj` 职责清晰分离：前者专注方向辅助函数，后者专注策略结构体。

**理由**：首轮 Vec 运算符实现直接使用泛型算术运算符逐分量运算，无需通过 ComputeVec* 或 Functor 委托。方向辅助函数（`add(s, v)` 等）是 `scalar + vec` 运算符重载不可实现的替代方案，属于首轮公共 API 的必要部分。Functor 和 ComputeVec 为后续 SIMD 轮次、swizzle 操作轮次或性能优化轮次预留。将方向辅助函数独立为 `scalar_vec_ops.cj` 消除了 `compute_vector_decl.cj` 的双重角色架构层次模糊问题（§2 模块划分中独立文件的依赖关系更清晰）。首轮定义它们可以尽早验证其在仓颉类型系统中的可行性，但运算符代码不引用它们。后续轮次引入 SIMD 路径时，可将 Vec 运算符实现重构为通过 ComputeVec* 委托，利用 Functor 实现函数映射。

### D17. 跨类型赋值语义

**决策**：不提供跨类型 `=` 赋值（`VecN<Int32, Q> = VecN<Float32, Q>`）。跨类型赋值要求调用方显式使用跨 Vec 转换构造函数转换后赋值。

**理由**：仓颉 struct 的 `=` 赋值运算符由编译器自动生成，且仅接受完全相同类型的右操作数。无法为 Vec 泛型结构体重载自定义 `=` 以支持跨类型赋值。三种候选方案中：① 显式转换后赋值（采用）——调用方编写 `v = Vec2<Int32, Q>(w)` 将 `Vec2<Float32, Q>` 转换为 `Vec2<Int32, Q>` 后再赋值，转换语义清晰无歧义；② 定义泛型 `=` ——仓颉运算符不能为泛型，不可行；③ 记录为已知差异——在迁移成本评估中标注此差异。选用方案①，因为语义最明确且与 D14（跨 Vec 转换构造）和 D15（跨类型运算不支持）的设计一致。

### D18. `NumericLimits` 与宽松泛型约束的兼容性

**决策**：将 `NumericLimits<T>` 拆分为两个独立部分——保留 `NumericLimits<T> where T <: Number<T>` 用于数值极限查询，新增无约束的 `isIec559Of<T>()` 函数用于浮点类型判定。

**理由**：`ComputeEqual<T>` 的 `if (isIec559Of<T>())` 需要在不约束 `T` 的前提下判断 `T` 是否为浮点类型。若使用 `where T <: Number<T>` 约束，`Bool` 作为 `T` 时将编译失败（`Bool` 不实现 `Number<T>`）。将 `isIec559` 分离为独立的无约束函数，与 `NumericLimits` 的 `max()`/`min()`/`epsilon()` 等需要数值运算支持的功能解耦。此拆分后，`NumericLimits<T>` 仅在需要数值极限的浮点路径中被引用（由编译期 `if` 在编译期已排除非浮点分支），因此 `Number<T>` 约束在浮点 `T` 上自然满足，不会产生编译错误。

### D19. `isIec559Of<T>()` 的实现方案选择

**决策**：采用编译期 `if` 配合 `is` 运算符的值级类型检测方案。

**理由**：仓颉泛型函数的重载规则禁止按类型参数约束进行重载（类型变量约束不参与重载解析判断），因此 v5 描述的"为每类数值类型提供重载函数"的路径不可行。三种可行方案的分析：

| 方案 | 描述 | 评估 |
|------|------|------|
| ① 编译期 `if` + `is` 运算符值级检测（采用） | `if (T(0) is Float64 \|\| T(0) is Float32)` | 无重载依赖，完全在仓颉 const 表达式约束内——`is` 属于可参与 const 表达式的运算符，`T(0)` 为合法的 const 构造表达式（数值/布尔类型的构造函数在 const 上下文中可用）。编码阶段需验证所有目标类型是否支持 `T(0)` const 构造。 |
| ② 放弃编译期分支 | 所有类型统一使用 `==` 精确比较 | 功能正确但丢失浮点容差比较优势。可作为备选回退路径。 |
| ③ 反射或注解方式 | 运行时通过 `TypeInfo` 或自定义注解实现 | 引入运行时开销，背离编译期零开销的设计目标。 |

采用方案①，理由：保持编译期零开销类型分发，不依赖语言尚未确认的特性，实现模式与编译期 `if` 的现有语义一致。

### D20. `VecN<Bool, Q>` 的完整行为约定集中化

**决策**：在 §3.2 中集中描述 `VecN<Bool, Q>`（指 Vec1~Vec4 分别以 Bool 为 T 参数的实例）的完整行为约定，各运算符章节仅引用之。

**理由**：Bool 分量 Vec 在不同运算符类别中表现出不同的行为模式（部分可编译、部分不可编译），分散描述易导致遗漏或矛盾。统一在 Vec 结构体系的总体描述中给出完整表格，各运算符章节以"详见 §3.2 VecN<Bool, Q> 行为约定"方式引用，确保一处定义、各处同步。

### D21. `operator[]` 索引类型选择

**决策**：索引类型统一采用 `Int64`。

**理由**：① `LengthT` 别名为 `Int64`，`length()` 返回值也是 `Int64`，保持一致避免有符号/无符号比较告警；② `Int64` 为仓颉默认整数类型，在所有目标平台上覆盖所有有效索引范围（Vec1~Vec4 的索引 0~3）；③ 与 GLM 默认 `length_t = int`（有符号整数）行为一致。

### D22. `<`/`<=`/`>`/`>=` 运算符首轮不提供

**决策**：首轮不定义 `<`/`<=`/`>`/`>=` 运算符。

**理由**：C++ GLM 的 Vec 类型上未定义这些运算符。若在仓颉中定义则需要决定语义是聚合比较还是逐分量比较——前者与 GLM 行为不一致，后者在仓颉中（返回 `VecN<Bool, Q>`）无法直接用于 `if` 条件。首轮保留 `==` 和 `!=`（返回 `bool` 的聚合比较），逐分量比较功能随后续函数库轮次（`vector_relational.hpp` 的 `lessThan`/`greaterThan` 等具名函数）一并迁移。

### D23. C++ `storage<L,T,Q>` 模板省略理由

**决策**：首轮不映射 `storage<L,T,Q>` 模板结构体。

**理由**：`storage` 是 C++ 中用于在不同条件下（非对齐/对齐/SIMD）选择底层数据类型的辅助类型。仓颉 Vec 结构体的数据成员直接声明为 `var x: T` 等形式，编译器自动负责内存布局和对齐，无需手动选择存储类型。`storage` 的 SIMD 特化路径待后续 SIMD 支持轮次时重新设计。

### D24. `genTypeTrait`/`find_best_type` 等辅助设施省略理由

**决策**：首轮不迁移 `genTypeTrait`、`init_gentype`、`find_best_type` 等类型查询设施。

**理由**：这些设施服务于矩阵和四元数类型的泛型代码（如 `init_gentype` 为矩阵和四元数提供 `identity()` 方法），首轮范围不包含这些类型。这些辅助设施将在第 2-3 轮（矩阵/四元数迁移）时随对应类型定义一并引入。首轮 `qualifier.cj` 中保留 `vec`/`mat`/`qua` 的注释性前向声明即可。

### D25. `VecN<Bool,Q>.bitwiseNot()` 的行为差异认定

**决策**：`bitwiseNot()` 对 `VecN<Bool, Q>` 可编译通过，但声明为**不可消除的已知行为差异**而非语义等价。

**理由**：C++ GLM 中 `~bvec` 因整数提升机制（`bool` → `int` → 按位取反 → 转换回 `bool`，非零即 `true`）对任一分量始终返回 `true`。仓颉中 `!Bool` 执行逻辑否定（`!true = false`，`!false = true`），两种行为完全相反。此差异无法通过类型系统消除——仓颉不支持偏特化或负向约束（`where` 子句无法表达"当 T != Bool 时定义"），因此无法在类型层面条件性地为 `VecN<Bool, Q>` 排除 `bitwiseNot()`。将 `bitwiseNot()` 对 `Bool` 的行为认定为不可消除的已知差异而非等价迁移，迁移 `~bvec` 时需要人工审查并按上下文选择替换方式（详见 §11.4）。

### D26. 跨类型构造函数标量参数使用目标类型

**决策**：跨类型构造函数中的所有标量参数使用目标分量类型 `T`，而非源分量类型 `T2`。

**理由**：C++ GLM 的跨类型构造中，标量参数虽然声明为 `T2` 类型，但因 C++ 隐式类型转换规则自动转换到目标类型 `T`。仓颉无隐式数值类型转换，若标量参数保持 `T2` 类型，调用方必须将标量值显式构造为 `T2` 类型再传入，与 GLM 的"标量可自然使用目标类型字面量"的调用体验不一致。将标量参数改为 `T` 类型后，调用方可直接使用目标类型的字面量或变量，构造函数体内通过 `T(scalar)` 完成转换（若需跨类型转换）。Vec 类型参数（如 `Vec2<T2, Q2>`）保持 `T2` 不变，因构造函数体内需对 Vec 分量逐一调用 `T(v.x)` 进行类型转换。

### D27. Qualifier 跨 Q 赋值/转换行为约定

**决策**：首轮中不同 Qualifier 之间的赋值和转换默认允许，无运行时或编译期限制。后续轮次引入 Qualifier 差异化时重新评估此约定。

**理由**：首轮所有 Qualifier 实现类型（PackedHighp、PackedMediump、PackedLowp、AlignedHighp 等）均为空结构体，无运行时数据差异。跨 Q 赋值（如 `Vec2<Float32, PackedHighp>` 赋给 `Vec2<Float32, PackedLowp>` 类型变量）在数据语义上等价于同 Q 赋值——仅类型签名改变。Vec 的跨类型转换构造函数（`init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）在类型层面已允许 Q2→Q 的转换。若在首轮禁止跨 Q 转换（如通过 `static assert` 限制特定 Q 组合），将增加不必要的复杂性且无实际收益。后续轮次引入差异化行为时，可按需通过编译期约束（如 `where` 条件、宏或自定义注解）重新限制跨 Q 转换路径。

### D28. `operator[]` const 取值形式与赋值形式

**决策**：`operator[]` 的取值形式不标注 `const`，另提供具名 const 函数 `componentAt(i: Int64): T` 满足 const 上下文中的分量访问；赋值形式声明为 `mut operator func`。

**理由**：
- **const 取值形式不可通过重载实现**：仓颉的函数重载规则中，`const` 修饰符不构成重载区分依据（const README §3.2 规则 7），因此无法同时定义 `const operator func [](i: Int64): T` 和 `operator func [](i: Int64): T` 两个版本的 `[]` 运算符。
- **`componentAt` 替代方案**：提供 `public const func componentAt(i: Int64): T` 具名函数，满足 const 实例成员函数中通过索引访问分量的需求。该函数支持编译期 `if` 编译期分支，与非 const 的 `operator[]` 取值形式共享同一实现体（含边界断言）。
- **赋值形式须为 `mut`**：仓颉 struct 的普通（非 `mut`）实例成员函数不能修改实例成员。`operator[]` 赋值形式需要修改第 i 分量的值，因此必须标注 `mut` 修饰符。否则 `v[i] = val` 将无法编译通过（struct 的 `let` 绑定变量上调用 `mut` 函数报错，`var` 绑定变量上调用非 `mut` 函数无法修改成员）。此规则同样适用于 extend 块中定义的 `[]` 赋值形式——extend 块中的 `operator func []` 赋值形式同样需要 `mut` 修饰符方可修改实例成员。

### D29. `const operator ==` 的表达式链 const 兼容性要求（含回退触发条件）

**决策**：`ComputeEqual<T>.callConst` 中 `const operator ==` 的完整表达式链需系统性标注每项的 const 兼容性。回退方案采用**二值决策**——验证通过则维持当前设计，否则整体回退到精确比较路径。

**理由**：`const operator ==` 体内表达式链 `abs(a - b) <= epsilonOf<T>()` 的每个环节必须支持在 `const` 函数上下文中编译通过。各环节的 const 兼容性要求及验证状态如下：

| 表达式环节 | const 兼容性要求 | 验证状态 | 回退方案 |
|-----------|----------------|---------|---------|
| `T(0) is Float64`（编译期类型检测） | 数值类型的 `T(0)` const 构造 + `is` 运算符 | 待验证（需原型测试，见 §10 设计阶段验证要求） | 任一环节不可用 → 整体回退到所有类型精确比较 `a == b` |
| `a - b`（浮点减法） | 仓颉 `Float32`/`Float64` 的二元 `-` 可在 const 函数体内调用 | 待验证（需原型测试） | 同上 |
| `abs(x)`（绝对值） | `std.math.abs` 包级函数须为 `const` 函数 | 待验证（需原型测试） | 同上。若仅 `abs()` 非 const，可内联 `x >= T(0) ? x : -x` 尝试局部修复 |
| `epsilonOf<T>()`（获取 epsilon） | `NumericLimits<T>.epsilon()` 须为 `const` 函数。且 `NumericLimits<T> where T <: Number<T>` 的约束在此路径中自动满足（编译期 `if` 确保仅浮点类型进入此分支） | 待验证（需原型测试） | 同上。若仅 `epsilon()` 非 const，可尝试固定容差值 `T(1e-6)` 局部修复 |
| `result <= epsilon`（比较） | `Float32`/`Float64` 的 `<=` 可在 const 函数体内调用 | 可确认（仓颉 `<=` 为原生比较运算符，在 const 上下文中可用） | 无 |

**验证决策**：编码阶段编写单一原型测试函数，在 `const` 上下文中一次性验证完整表达式链 `abs(a - b) <= epsilonOf<T>()` 的编译通过性。若编译通过 → 维持当前设计。若编译失败 →**整体回退到备选路径**（所有类型使用精确比较 `a == b`），浮点容差比较通过独立的非 `const` 具名函数 `equalEpsilon`（定义见 §4.5）提供。不再细分逐级修复方案——`abs()` 内联或 `epsilon()` 固定值替代作为编码阶段的局部优化尝试，不属于设计层面的回退路径。

### D30. `@OverflowWrapping` 标注继承性验证计划

**决策**：在 §4.6 中补充备选方案——若 `@OverflowWrapping` 标注继承性经验证不成立，则在已有 20 个 vec-op-scalar 方向扩展成员函数（§4.3 首轮范围）上直接标注 `@OverflowWrapping`，二元运算符委托给这些函数。

**理由**：当前设计断言编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注。此行为**依赖编译器的未文档化行为**——仓颉注解文档声明溢出注解"只能标记于函数声明上"，但未说明自动生成的复合赋值函数是否继承源运算符的注解。此继承性在仓颉语言层面既未确认也未否认。因此需要：
1. **编码前验证**：编写原型测试代码，验证二元算术运算符上的 `@OverflowWrapping` 标注是否能被编译器自动生成的复合赋值版本继承。测试核心：对自定义 struct 定义标注 `@OverflowWrapping` 的 `+` 运算符，验证 `+=` 在溢出时执行 wrapping 而非 throwing。
2. **备选方案（若继承性不成立）**：在已有 20 个 vec-op-scalar 方向扩展成员函数（`add(v,s)`/`sub(v,s)`/`mul(v,s)`/`div(v,s)`/`mod(v,s)`，§4.3 已纳入首轮范围）上直接标注 `@OverflowWrapping`，二元运算符委托给这些已标注的函数。此方案无需新增函数定义——add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数已存在，仅需补充 `@OverflowWrapping` 标注并将运算符委托目标从"直接逐分量运算"改为"调用已标注的扩展成员函数"。此方案虽失去运算符语法糖，但确保溢出语义精确可控。备选方案的额外工作量已纳入 §11.6 迁移成本评估（由于函数已定义，实际工作量低于原评估的"新增 20 个函数"）。

**决策路径**：原型验证优先。若标注继承性成立，维持当前设计（二元运算符直接标注，复合赋值自动继承）。若不成立，切换到备选方案（具名函数 + 运算符委托）。

#### D30 与 D29 组合回退场景分析

D29（const 表达式链验证）和 D30（@OverflowWrapping 继承性验证）各自定义了独立回退方案。两者可能同时失败，需评估组合回退的交互影响。

**组合回退的三种可能状态**：

| D29 状态 | D30 状态 | 组合结果 | 影响评估 |
|---------|---------|---------|---------|
| ✅ 通过 | ✅ 通过 | 维持当前设计 | 无影响 |
| ❌ 回退 | ✅ 通过 | `==` 退至精确比较；算术运算符及复合赋值保持当前 `@OverflowWrapping` 标注策略 | 两项回退独立——D29 影响比较路径选择，D30 影响算术溢出策略，互不干扰 |
| 任意 | ❌ 回退 | 算术运算通过已有扩展成员函数实现（补充 `@OverflowWrapping` 标注）；`==` 依 D29 状态选择路径 | 扩展成员函数中的算术运算不受 D29 影响（比较与算术独立）；注意：add/sub/mul/div/mod 扩展成员函数已在 §4.3 中定义为首轮范围，回退仅需补充标注而非新增函数 |

**交互分析**：两项回退独立正交，无冲突。D29 控制比较语义（容差 vs 精确），D30 控制算术溢出策略（运算符标注 vs 扩展成员函数标注），影响的运算类别不重叠。当两者同时触发时，`==` 使用精确比较（非容差路径），算术运算通过已标注 `@OverflowWrapping` 的扩展成员函数实现。此组合在运行时语义上等价于"所有类型使用精确比较 + 算术运算通过扩展成员函数 wrapping"——虽损失容差比较优势和运算符语法糖，但功能正确性不受损。**复杂度成本**：编码阶段需同时实现 D29 的 `equalEpsilon` 独立函数和 D30 的补充标注（20 个已有函数补充 `@OverflowWrapping` + 修改 5 个运算符的委托目标），合计约 1-2 人天额外工作量（已在 §11.6 评估中覆盖）。注意：由于 add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数已在 §4.3 中定义为首轮范围，D30 回退**无需新增函数定义**。此前的"新增 20 个具名函数"评估已在 v9 中修正。**建议**：编码阶段按 D29 → D30 顺序逐项验证，一项失败后再进入下一项的组合验证，降低并行失败的信息熵。

#### 「const 在 extend 块中不可用」与 D30 交互说明

D30 备选方案（通过 extend 块中的具名函数实现 Vec 算术运算）中，算术具名函数因定义在 `extend` 块中已声明为非 `const` 函数（§4.3 明确区分了扩展成员函数为非 `const`、包级独立函数为 `const`）。此约束已由 §7 D32/D33 统一处理，D30 备选方案不依赖这些函数的 `const` 声明——`@OverflowWrapping` 标注与非 `const` 函数兼容（溢出注解语法独立于 `const` 修饰符），算术语义不受影响。因此 `const` 在 extend 块中不可用与 D30 回退路径无交互冲突。**组合回退场景的三种可能状态**扩展如下：

| D29 状态 | D30 状态 | const-in-extend 状态 | 组合结果 | 影响评估 |
|---------|---------|---------------------|---------|---------|
| ✅ 通过 | ✅ 通过 | 不可用（已确认） | 维持当前设计 | const-in-extend 限制已通过 D32/D33 统一处理，不影响设计与算术运算符 |
| ❌ 回退 | ✅ 通过 | 不可用（已确认） | `==` 退至精确比较；算术运算符及复合赋值保持当前 `@OverflowWrapping` 标注策略 | 两项独立，互不干扰 |
| 任意 | ❌ 回退 | 不可用（已确认） | 算术运算通过已有扩展成员函数实现（补充 `@OverflowWrapping` 标注）；`==` 依 D29 状态选择路径 | const-in-extend 不影响扩展成员函数的功能正确性——`@OverflowWrapping` 和非 `const` 函数兼容；注：add/sub/mul/div/mod 扩展成员函数已在 §4.3 中定义为首轮范围，回退无需新增 |

结论：`const` 在 extend 块中不可用的约束已由本设计的全局策略（所有扩展成员函数声明为非 `const`）统一处理，D30 回退路径中的算术扩展成员函数属于此策略覆盖范围，无需额外回退。

### D31. 跨类型 fill-from-Vec1 构造器的重载冲突约束

**决策**：Vec2~Vec4 的 fill-from-Vec1 构造器仅提供同类型版本 `public init(v: Vec1<T, Q>)`，不提供跨类型版本 `public init<T2, Q2>(v: Vec1<T2, Q2>)`。

**理由**：仓颉函数重载规则中，当泛型参数被实例化为具体类型时，重载解析按实际类型匹配。若同时存在 `public init(v: Vec1<T, Q>)` 和 `public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier`，在 `T2 = T` 且 `Q2 = Q` 的场景下两个构造函数具有相同的参数列表（`Vec1<T, Q>`），导致重载冲突编译错误。受仓颉泛型实例化的重载解析规则限制，此冲突无法通过添加额外泛型约束（如 `where T2 != T`）解决——仓颉的 `where` 子句不支持否定约束或不等约束。

因此当前设计仅保留同类型版本，跨类型 fill-from-Vec1 场景可通过其他构造函数形式覆盖（如 Vec4 可通过 `Vec4(v1_x, v1_y, v1_z, v1_w)` 组合构造或通过 `init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, ...)` 等形式间接实现）。若编码阶段需要跨类型 fill-from-Vec1 构造，可通过将 Vec 类型变量显式转换为目标类型后调用同类型版本实现（`let v = Vec2<T, Q>(Vec2<T2, Q2>(src).x)` 等模式）。

Vec1 的跨类型 fill-from-Vec1（`init<T2, Q2>(v: Vec1<T2, Q2>)`）不受此限制——Vec1 仅单个分量，跨类型版本实质是分量级类型转换而非广播填充，与 `const init(x: T)` 的参数列表类型结构（`T` vs `Vec1<T2, Q2>`）不同，不构成重载冲突。

### D32. 具名函数（add/sub/mul/div/mod）的 const 声明策略

**决策**：`add`、`sub`、`mul`、`div`、`mod` 的 `scalar-op-vec` 方向（包级独立函数）声明为 `const`；`vec-op-scalar` 方向（扩展成员函数）声明为非 `const`。

**理由**：仓颉 `extend` 块不支持 `const` 修饰符（仓颉扩展 §4.2），因此 `vec-op-scalar` 方向扩展成员函数无法声明为 `const`。`scalar-op-vec` 方向包级独立函数无此限制。`mod` 的包级独立函数方向使用 `if (isIec559Of<T>())` 实现整数/浮点双路径编译期分支选择，仓颉要求编译期 `if` 所在函数必须标注 `const` 修饰符，因此仅包级独立函数方向可以承载编译期 `if` 分支。扩展成员函数方向 `mod(v, s)` 仅提供整数路径（使用 `%`），浮点路径由包级独立函数 `mod(s, v)` 覆盖。

**`add`/`sub`/`mul`/`div` 包级独立函数的 const 声明**：虽不直接使用编译期 `if`，但声明为 `const` 有以下益处：① 与 `mod` 的 API 签名一致；② 允许在 const 表达式中调用 `add(s, v)` 等；③ 为后续轮次引入 const 路径优化预留扩展点。扩展成员函数方向（`v.add(s)` 等）因 `extend` 块限制声明为非 `const`，功能等价。

**const 兼容性验证要求**：20 个包级独立函数的 `const` 声明依赖目标类型 `T` 的算术运算符在 const 函数体内的可用性。20 个扩展成员函数因非 `const` 无此约束。验证计划如下：

| 验证项 | 验证方法 | 回退方案 |
|--------|---------|---------|
| `add`/`sub`/`mul`/`div` 包级独立函数对 `Float32`/`Float64`/`Int32` 等核心类型的 `const` 兼容性 | 编写原型测试实例化 `add`/`sub`/`mul`/`div` 各一种，确认 const 编译通过 | 若核心类型失败 → 包级独立函数降级为非 `const` |
| `mod` 包级独立函数对核心类型的 `const` + 编译期 `if` 兼容性 | 编写原型测试分别以 `Int32` 和 `Float32` 实例化 `mod`，确认编译期 if 分支选择正确 | 若失败 → 拆分为独立包级函数 `modInt`（非 `const`，使用 `%`）和 `modFloat`（非 `const`，使用 `trunc` 恒等式） |
| 扩展成员函数（非 `const`）的功能正确性 | 编写原型测试验证 `v.add(s)` 等扩展成员函数在运行时正确性 | 若扩展成员函数因语法错误不通过 → 改为包级独立函数，调用方通过 `add(v, s)` 语法使用 |

### D33. increment()/decrement()/bitwiseNot() 的 const 声明策略

**决策**：`increment()`、`decrement()`、`bitwiseNot()` 因定义在 `extend` 块中，受仓颉扩展语法限制（仓颉扩展 §4.2——`extend` 块不允许 `const` 修饰符），声明为**非 `const`** 函数。

**理由**：此三函数与 D32 中的算术具名函数同为纯函数——仅读取 Vec 分量值并返回新 Vec，不修改实例成员。但因定义位置在 `extend` 块中，`const` 修饰符不可用。此限制的影响：① 失去在 `const` 表达式中编译期调用的能力，运行时行为不受影响；② `increment()`/`decrement()` 标注 `@OverflowWrapping` 与是否 `const` 无关——`@OverflowWrapping` 为非 `const` 函数同样可用；③ `bitwiseNot()` 不涉及算术运算，无溢出注解需求。**备选方案**：若编码阶段需要在 `const` 上下文中调用这些函数，可将其定义移至 struct 体内（各 Vec 结构体自身定义该函数），利用 `const init` 声明为 `const` 实例成员函数。此备选方案适用于 `bitwiseNot()`（不依赖分量数差异），对 `increment()`/`decrement()` 同样可行。评估应在编码阶段按需决定是否实施。

**`equalExact` 的 const 备选方案纳入**：`equalExact`（§4.5）同样定义在 `extend` 块中且声明为非 `const`，其 const 化备选方案与此处 `increment()`/`decrement()`/`bitwiseNot()` 的备选方案一致——若编码阶段需要在 const 上下文中调用 `equalExact`，按上述方案将定义移至 struct 体内声明为 `const` 实例成员函数。此备选方案不影响公共 API 签名，与 D32 的算术具名函数 const 声明策略一致（`scalar-op-vec` 方向包级独立函数已声明为 `const`，无需备选方案）。**协同基准**：`equalExact` 的 const 化备选方案统一遵循 D33 约定（与 `increment`/`decrement`/`bitwiseNot` 共用同一备选路径），不再在 §4.5 中独立声明。

### D34. 编译期 `if` 分支文档简写约定

**决策**：设计文档中所有出现的"编译期 `if`"统一用于指代 `const` 函数体内的编译期分支抑制行为，不再使用"const if"作为独立术语。文档中涉及编译期分支抑制行为描述时，使用"`const` 函数体内的 `if` 表达式"或"编译期 `if` 分支"等表述。

**理由**：仓颉语言中不存在 `const if` 独立关键字。`if` 表达式在 `const` 函数体内天然具有编译期分支抑制行为——编译器仅在实例化后选择被满足的分支进行代码生成，非选择分支的代码不参与实际编译（仅做语法检查）。此行为已在仓颉 const 特性文档中确认：`const` 函数中的 `if` 条件若可在编译期确定，则仅编译被执行分支。文档此前使用"编译期 `if`"作为简写形式，可能误导实施者编写不存在的 `const if` 关键字。本决策统一采用"编译期 `if`"表述，消除实施歧义。

**验证状态**：编译期 `if` 分支抑制行为是 `const` 函数的固有语义，不依赖独立的关键字支持。§10 中列出的所有依赖点（A~E）的验证计划保持不变——验证对象为"`const` 函数中 `if` 表达式的编译期分支抑制行为"，与编译期 `if` 的命名无关。验证方法（统一原型测试 `testConstIfSuppression<T>()`）和回退方案均不受本次命名修正影响。

### D35. `scalar_vec_ops.cj` 的包级函数名独占权约定

**决策**：约定 `glm.detail` 包中仅 `scalar_vec_ops.cj` 文件有权定义名为 `add`、`sub`、`mul`、`div`、`mod` 的包级函数。`glm.detail` 包中的其他文件不得定义同名包级函数。

**理由**：`lib.cj` 通过 `public import glm.detail.{ add, sub, mul, div, mod }` 将这些函数暴露到 `package glm` 公共命名空间。`glm.detail` 包由 12+ 个文件组成，若未来其他文件也在同一包中定义同名函数，`public import` 将因 `glm.detail` 范围内的重名导致导入歧义。此约定以设计决策形式记录命名空间占用规则，确保编码阶段实施者和后续轮次维护者明确知晓 `add`/`sub`/`mul`/`div`/`mod` 五个名称的独占归属。此约定已在 §2 公共 API 面设计的命名空间占用声明中同步记录。

**违规检测**：编码阶段可通过在 `glm.detail` 包的其他文件中尝试定义名为 `add` 的函数来验证规则——若与 `scalar_vec_ops.cj` 中已有函数冲突，编译器将报重复定义错误。此检测由编译器自动完成，无需额外测试步骤。

### D36. 通用范围变更管理流程

**决策**：新增通用范围变更日志条目模板，覆盖所有可能的范围变更场景（不仅限于别名缩编）。变更日志作为 §7 末尾的附属文档维护。

**理由**：当前 §3.8 仅定义了别名缩编的特定变更流程（缩编触发条件 + 审批路径 + 补全期限），缺少对其他类型范围变更（如新增功能、推迟交付、依赖范围调整等）的统一管理流程。通用变更日志条目模板确保各类变更均被记录、审批和追溯。

**变更日志条目模板**（记录于本文件 §7 末尾或独立变更日志文件）：

```markdown
## 范围变更日志

### {变更编号} — {变更日期}

**类型**：缩编 / 新增 / 推迟 / 替换 / 其他
**触发条件**：{描述触发本次变更的具体条件或原因}
**变更内容**：{描述变更的具体内容，包括受影响的范围、文件、设计决策等}
**审批路径**：{申请人} → {审批人} — {审批日期}
**影响评估**：
- 范围影响：{受影响的范围项及数量}
- 进度影响：{预计工期变化}
- 质量影响：{对功能正确性、测试覆盖、性能等的影响}
- 依赖影响：{对其他模块或后续轮次的影响}
**实施期限**：{变更实施的最晚完成日期}
**实施状态**：待实施 / 实施中 / 已完成 / 已回滚
```

**与 §3.8 别名缩编流程的关系**：别名缩编作为范围变更的一种特殊类型，其触发条件和审批路径已在 §3.8 中明确定义。通用变更日志条目模板适用于别名缩编之外的所有范围变更场景。别名缩编触发时，除按 §3.8 流程执行外，也应填写通用变更日志条目作为正式记录。

#### 首轮范围新增文件变更日志

以下条目记录首轮范围内新增的 3 个 roadmap 范围外文件，按 D36 通用范围变更管理流程正式归档。

**变更编号：SCO-001 — 2026-06-19**
**类型**：新增
**触发条件**：scalar-op-vec 方向辅助函数（add(s,v)/sub(s,v)/mul(s,v)/div(s,v)/mod(s,v)）需要独立文件承载，避免与 compute_vector_decl.cj 角色混淆
**变更内容**：新增文件 scalar_vec_ops.cj（package glm.detail），定义 20 个 scalar-op-vec 方向包级独立函数
**审批路径**：设计审议确认 → 主 Agent 批准（2026-06-19）
**影响评估**：
- 范围影响：新增 1 个文件（package glm.detail），5 个具名函数 × 4 Vec 类型 = 20 个函数定义
- 进度影响：约 +0.5 人天（编码）+ 0.2 人天（测试）
- 质量影响：无负面，scalar-op-vec 方向是首轮必需 API
- 依赖影响：新增文件依赖 qualifier.cj（Q 参数约束），被 lib.cj public import 消费
**实施期限**：首轮编码阶段
**实施状态**：已完成（首轮交付范围永久扩展）

**变更编号：SCO-002 — 2026-06-19**
**类型**：新增
**触发条件**：Bool->Numeric 转换通过跨 Vec 转换构造函数不可直接实现（仓颉中 Int32(Bool) 不支持），需独立工厂函数
**变更内容**：新增文件 type_fromBoolVec.cj（package glm.detail），定义 fromBoolVec/fromBoolVecQ2 包级独立工厂函数（Vec1~Vec4 各 2 版本 = 8 个函数）
**审批路径**：设计审议确认 → 主 Agent 批准（2026-06-19）
**影响评估**：
- 范围影响：新增 1 个文件（package glm.detail），8 个工厂函数
- 进度影响：约 +0.3 人天（编码）+ 0.2 人天（测试）
- 质量影响：无负面，为 Bool->Numeric 提供显式安全转换路径
- 依赖影响：新增文件依赖 qualifier.cj 和 type_vec1.cj~type_vec4.cj
**实施期限**：首轮编码阶段
**实施状态**：已完成（首轮交付范围永久扩展）

**变更编号：SCO-003 — 2026-06-19**
**类型**：新增
**触发条件**：需统一公共 API 面，通过 public import 重导出核心类型和 scalar-op-vec 方向辅助函数，避免下游直接依赖 glm.detail 内部包
**变更内容**：新增文件 lib.cj（package glm），集中 public import Vec1~Vec4、Qualifier 实现类型、scalar_vec_ops 方向辅助函数
**审批路径**：设计审议确认 → 主 Agent 批准（2026-06-19）
**影响评估**：
- 范围影响：新增 1 个文件（package glm），约 10 行 public import 声明
- 进度影响：约 +0.1 人天（编码）+ 0.1 人天（测试）
- 质量影响：正向——封装公共 API 面，降低下游耦合
- 依赖影响：单向依赖 glm.detail 包，无新类型定义
**实施期限**：首轮编码阶段
**实施状态**：已完成（首轮交付范围永久扩展）

### D37. 编译器行为假设集中一览

本设计多处依赖编译器对特定语言特性的实现行为。以下表格集中列出所有编译器行为假设，作为 §10 设计阶段验证的全景索引。每项假设标注所在章节、依赖的编译器行为、验证状态和回退方案。

| 编号 | 假设描述 | 所在章节 | 编译器依赖行为 | 验证状态 | 回退方案 |
|------|---------|---------|-------------|---------|---------|
| A01 | `T(0)` const 构造对所有数值类型和 Bool 合法 | §3.5 `isIec559Of`、§10 依赖① | const 泛型函数中 `T(0)` 表达式编译通过 | 待验证（§2.1 项①③） | 整体回退精确比较路径 |
| A02 | `is` 运算符在 const 泛型函数中对泛型参数实例化值可用 | §3.5 `isIec559Of`、§10 依赖② | `T(0) is Float64` 在 const 泛型中求值 | 待验证（§2.1 项③） | 同上 |
| A03 | `std.math.abs` 包级函数在 const 函数体内可调用 | §10 依赖③ | `std.math.abs`（包级函数，非 `Float32.abs()`/`Float64.abs()` 静态方法）在 const 函数体内编译通过 | 待验证（§2.1 项③㉒） | 内联 `x >= T(0) ? x : -x` 或回退精确比较 |
| A04 | `NumericLimits<T>.epsilon()` 在 const 函数体内可调用 | §10 依赖③ | `epsilon()` 为 const 函数 | 待验证（§2.1 项③） | 固定容差值 `T(1e-6)` 替代 |
| A05 | 编译期 `if` 在 const 函数中对非选择分支的编译抑制 | §10 依赖点 A~E | `const` 函数中 `if (const-expr)` 仅编译被选择分支 | 待验证（§2.1 项④⑫） | 各依赖点按独立回退方案处理 |
| A06 | `@OverflowWrapping` 标注被自动生成的复合赋值运算符继承 | §4.6、§7 D30 | 编译器为标注 `@OverflowWrapping` 的二元运算符自动生成的 `op=` 继承标注语义 | 待验证（§2.1 项⑤⑫） | 在已有 20 个扩展成员函数上补充标注 |
| A07 | `@OverflowWrapping` 与 `const` 在统一函数声明中共存 | §10 | `@OverflowWrapping const func` 语法合法且语义兼容 | 待验证（§2.1 项⑫） | 包级独立函数降级为非 const，保持标注 |
| A08 | `const init` 在非 const 上下文中可作为运行时构造函数使用 | §3.2 | const README §3.2 规则 5 | 可确认（语言文档已声明） | 不可用→补充同参数列表非 const init |
| A09 | `const` 修饰符不构成函数重载区分依据 | §3.2 Vec1 不对称性 | const README §3.2 规则 7 | 可确认（语言文档已声明） | 调整构造器设计 |
| A10 | `extend` 块不支持 `const` 修饰符 | §3.2、§4.3 | 仓颉扩展 §4.2 | 可确认（语言文档已声明） | 将函数定义移至 struct 体内 |
| A11 | `std.math.trunc` 对 `Float64` 可用 | §10 浮点 mod 验证依赖① | 标准库函数签名正确 | 可确认（标准库文档） | 恒等式改为 `x - y * (x / y).trunc()` 等模式 |
| A12 | `Float32`→`Float64` 提升→`trunc`→`Float32` 降级无语义损失 | §10 浮点 mod 验证依赖② | 精度提升后截断再降级的数值正确性 | 待验证（§2.1 项⑥） | 拆分为 modInt/modFloat 具名函数 |
| A13 | `@Derive[Hashable]` 在泛型 struct 上的约束检查策略——编译器在定义处还是实例化处检查 `T: Hashable` | §3.2、§10 | 编译器对泛型参数 T 的 Hashable 约束传递性检查位置（定义处 vs 实例化处） | **待验证**（§2.1 项㉑） | 若编译器在定义处要求 `T <: Hashable`，需在 Vec 定义中添加约束或移除 `@Derive[Hashable]` 改手动实现——此项与 D5 宽松约束策略可能直接矛盾 |
| A14 | `as` 运算符对泛型类型参数的表达式合法 | §9.4 路径 B、§10 | `v.x as Bool` 在泛型函数体中编译通过 | 待验证（§2.1 项⑧） | 路径 B 不可行→回退至路径 A 工厂函数 |
| A15 | if-let 模式匹配在非 const init 中可用 | §9.4 路径 B、§10 | `if (let Some(b) <- expr)` 在 init 中编译通过 | 待验证（§2.1 项⑧） | 同上 |
| A16 | `T(1)`/`T(0)` 常量构造器对所有数值类型和 Bool 合法 | §9.4 路径 B、§10 | 泛型函数中 `T(0)`/`T(1)` 表达式编译通过 | 待验证（§2.1 项⑧） | 同上 |
| A17 | Vec4 多重重载构造函数中"具体类型优先于泛型类型"规则 | §4.1、§10 Vec4 重载解析验证 | 非泛型 `init(v: Vec1<T,Q>)` 优先于泛型 `init<T2,Q2>(v: Vec1<T2,Q2>)` | 待验证（§2.1 项⑬） | 移除歧义分支改为具名工厂函数 |
| A18 | `internal` 类型在同包测试文件中可访问 | §12.4 | `cjpm test` 将测试文件与被测包视为同模块处理 | 待验证（§2.1 项⑨） | 按 §12.4 回退方案层级逐级尝试 |
| A19 | `<<` 运算符默认溢出策略为 `@OverflowThrowing` | §4.4 | 仓颉 `<<` 在超出位宽时抛 `ArithmeticException` | 待验证（§4.4 溢出策略说明） | 标注 `@OverflowWrapping` 对齐 C++ 高位丢弃 |
| A20 | 扩展成员函数在 `public import` 重导出后保持对外可见 | §2 公共 API 面、§4.3 | `public import` 将扩展成员函数（定义于 `extend` 块中）随 struct 类型一同重导出到目标包 | 待验证（§2.1 项⑱ 子步骤 b） | 若扩展成员函数可见性在重导出后丢失，与基础重导出同步回退——改为 `public type` 类型别名方案，扩展成员函数改为包级独立函数形式 |

**验证状态说明**："可确认"表示该行为已被仓颉语言文档明确声明，无需独立验证；"待验证"表示需在设计阶段通过原型测试确认。

### D38. `GLM_CONFIG_CLIP_CONTROL` 默认值正式设计决策

**决策**：`GLM_CONFIG_CLIP_CONTROL` 默认值为 `0x0A`（十进制 10），对应 C++ GLM 1.0.3 `setup.hpp` 条件编译无额外定义时的 `RH_NO` 组合（`RH_BIT = 1 << 3 = 8`，`NO_BIT = 1 << 1 = 2`，按位或得 `0x0A`）。

**依据**：经参考实现 `setup.hpp:563-584` 三层条件编译逐行确认——第一层 `GLM_FORCE_DEPTH_ZERO_TO_ONE` 条件编译走 `#else` 分支（`NO_BIT`），第二层 `GLM_FORCE_LEFT_HANDED` 条件编译走 `#else` 分支（`RH_BIT`），第三层无额外定义走默认路径，最终值为 `0x0A`。

**与 roadmap 的一致性确认**：roadmap §3A.1 已同步更新该配置默认值为 `0x0A`，与本文档一致。跨文件冲突已不存在，无需协调。

---

## 8. 迁移文件清单与依赖拓扑

### 8.1 文件清单与 roadmap 子范围映射

| 序号 | 文件（package glm.detail） | 依赖 | 说明 | Roadmap 子范围 | Roadmap §3E 序号 |
|------|---------------------------|------|------|---------------|-----------------|
| 1 | `setup.cj` | 无 | 18 个 `GLM_CONFIG_*` 编译期常量 | S | 1（前身为 C++ `setup.hpp` 映射，shim 配置层） |
| 2 | `qualifier.cj` | `setup.cj` | `Qualifier` 接口及实现类型、V 前向声明注释 | 1 | 2 |
| 3 | `shim_assert.cj` | 无 | `assert()` 函数 | S | S1 |
| 4 | `shim_limits.cj` | 无 | `NumericLimits<T>`（含 `isIec559Of<T>()` 无约束 const 函数，`max/min/epsilon` 受 `Number<T>` 约束） | S | S2 |
| 5 | `shim_cstddef.cj` | 无 | `SizeT`/`LengthT` 别名（`VArray` 的 `size` 属性提供编译期长度查询） | S | S3 |
| 6 | `compute_vector_relational.cj` | `shim_limits.cj`、**`std.math`（`abs` 包级函数）** | `ComputeEqual<T>`（简化版，无 `IsFloat` 参数）。注：`ComputeEqual.callConst` 中 `abs(a - b)` 调用 `std.math.abs` 包级函数，编码阶段须在文件头部添加 `import std.math.{ abs }` | 2a | 3 |
| 7 | `vectorize.cj` | `qualifier.cj` | Functor1~4 的 Vec1~Vec4 版本（为后续轮次预留） | 2a | 5 |
| 8 | `compute_vector_decl.cj` | `vectorize.cj` | ComputeVecAdd/Sub/Mul/Div/...（为后续轮次预留） | 2a | 4 |
| 8a | `scalar_vec_ops.cj`（新增） | `qualifier.cj`、**`std.math`（仅 mod 浮点路径）** | scalar-op-vec 方向辅助函数（add(s,v)/sub(s,v)/mul(s,v)/div(s,v)/mod(s,v)，首轮即被消费）。注：仅浮点 `mod` 路径依赖 `std.math.trunc`；整数路径和无浮点 mod 场景不依赖 std.math | 2a（随 Vec 运算） | 新增 |
| 9~12 | `type_vec1.cj`~`type_vec4.cj` | `qualifier.cj` + `compute_vector_relational.cj` + `scalar_vec_ops.cj` + **`std.math`（`abs` 包级函数，用于 `equalEpsilon`）** | Vec 结构体定义（含 `const init`、`@OverflowWrapping` 二元算术运算符、`@OverflowWrapping` 对 `<<`）、extend 块（位运算符 + Vec1 广播运算符 + 具名函数 `increment`/`decrement`/`bitwiseNot`/`logicalAnd`/`logicalOr`/`equalEpsilon`/`equalExact`）。注：`type_vec1.cj` extend 块包含 Vec1 左操作数方向广播运算符（Vec1 op Vec2/3/4），`type_vec2~4.cj` extend 块包含 VecN 右操作数方向广播运算符（VecN op Vec1）；编码阶段须在 `type_vecN.cj` 文件头部添加 `import std.math.{ abs }` | 4~7 | 6~9 |
| 12b | `type_fromBoolVec.cj`（新增） | `qualifier.cj` + `type_vec1.cj`~`type_vec4.cj` | `fromBoolVec`/`fromBoolVecQ2` 包级独立工厂函数（Vec1~Vec4 各定义同 Q 和跨 Q 两个版本，共 8 个函数） | 4~7（随 Vec 类型提供转换能力） | 新增 |

| 序号 | 文件（package glm） | 依赖 | 说明 | Roadmap 子范围 | Roadmap §3E 序号 |
|------|--------------------|------|------|---------------|-----------------|
| 13 | `lib.cj`（新增） | `glm.detail.*` | 公共 API 重导出——通过 `public import` 暴露 Vec 类型、Qualifier 类型、`scalar_vec_ops` 方向辅助函数；`fwd.cj` 与 `lib.cj` 同属 `package glm`，其 `public type` 别名已自动对外可见 | 8（随向量别名） | 新增 |
| 14 | `fwd.cj` | `glm.detail.*` | 标量别名（含 `uint`）+ 256 个向量别名 | 2b（标量部分）+ 8（向量部分） | 10（标量部分）+ 11（向量部分） |

**对应测试文件清单**（与前序各序号一一对应）：

| 序号 | 测试文件（package glm.detail） | 被测文件 | 说明 |
|------|-------------------------------|---------|------|
| T1 | `test_setup.cj` | `setup.cj` | 验证 18 个 `GLM_CONFIG_*` 常量值正确性 |
| T2 | `test_qualifier.cj` | `qualifier.cj` | 验证 `Qualifier` 接口实现类型构造与约束检查 |
| T3~T5 | `test_shims.cj`（合并） | `shim_assert.cj` + `shim_limits.cj` + `shim_cstddef.cj` | 验证 assert 行为、`NumericLimits` 边界值、`isIec559Of` 类型判定 |
| T6 | `test_compute_vector_relational.cj` | `compute_vector_relational.cj` | 验证 `ComputeEqual` 对 `Int32`/`Float32`/`Bool` 的比较结果 |
| T7 | `test_vectorize.cj` | `vectorize.cj` | 验证 Functor 静态 `call` 方法编译通过（首轮仅定义不消费，编译通过即足） |
| T8 | `test_compute_vector_decl.cj` | `compute_vector_decl.cj` | 验证 compute_vec_* 结构体编译通过 |
| T8a | `test_scalar_vec_ops.cj` | `scalar_vec_ops.cj` | 验证 scalar-op-vec 方向辅助函数双向调用正确性 |
| T9~T12 | `test_type_vec1.cj`~`test_type_vec4.cj` | `type_vec1.cj`~`type_vec4.cj` | 验证各 Vec 类型的构造/算术/比较/位运算/边界行为 |
| T12b | `test_type_fromBoolVec.cj` | `type_fromBoolVec.cj` | 验证 `fromBoolVec`/`fromBoolVecQ2` 对 Vec1~Vec4 各分量数的 Bool→Numeric 转换正确性 |
| T13 | `test_lib.cj`（package glm） | `lib.cj` | 验证 `import glm.*` 后可访问 Vec 类型及别名 |
| T14 | `test_fwd.cj`（package glm） | `fwd.cj` | 验证 256 个别名编译无重复定义，抽查 4 个家族的别名映射正确性 |

### 8.2 范围可追溯性对照表

> **GLM 源文件路径说明**：GLM 1.0.3 参考实现目录结构为 `glm/glm/detail/` 双层嵌套（即仓库根目录下的 `glm/` 子目录内包含 `glm/` 和 `glm/detail/` 等）。下表"GLM 源文件"列使用裸文件名（如 `setup.hpp`），其完整路径为 `references/glm-1.0.3/glm/glm/detail/setup.hpp`。编码阶段以 `references/glm-1.0.3/` 为参考实现根目录。

以下对照表将 roadmap §3E/§3G 定义的首轮范围逐项映射到本设计的对应章节和迁移文件，确保无范围歧义或遗漏。

**§3G 范围确认结论追溯**：Roadmap §3G 范围确认章节的关键结论已在本设计以下章节中覆盖：① **依赖闭合性声明**——§2 模块依赖分析（依赖拓扑）确认 `glm.detail` 内部无外部包引用、`glm` 单向依赖 `glm.detail`，无循环依赖；② **独立可编译性声明**——§8.3 迁移顺序与依赖说明列出了各文件的编译依赖关系，确保按阶段序贯编译可独立验证；③ **最小可行范围参数**——§3.8 别名范围分级明确 256 个别名为强制交付标准，并定义缩编触发条件与审批路径（依赖闭合、可编译性、最简可行范围三项确认已在 roadmap §3G 中完成，本设计在 §2、§8.3、§3.8 中落实对应约束）。

| Roadmap §3E 序号 | Roadmap 子范围 | GLM 源文件 | 本设计对应章节 | 本设计对应仓颉文件 | 偏离说明 |
|-----------------|--------------|-----------|--------------|----------------|---------|
| 1 | 1 | `setup.hpp` | §3.6 Shim 层、§7 D6 | `setup.cj` | 无偏离。C++ `setup.hpp` 中 1000+ 行平台/编译器检测宏首轮不迁移，仅迁移约 80-120 行配置常量（详见 roadmap 3A.1 说明）。此偏离已在 roadmap 中预声明 |
| 2 | 1 | `qualifier.hpp` | §3.1 Qualifier 体系 | `qualifier.cj` | 无偏离。C++ `storage<L,T,Q>` 模板在首轮无需映射（D23），`genTypeTrait`/`find_best_type` 等辅助设施已推迟至后续轮次（D24） |
| 3 | 2a | `compute_vector_relational.hpp` | §3.5 ComputeEqual | `compute_vector_relational.cj` | 无偏离。简化版 `ComputeEqual<T>` 移除 `IsFloat` 参数 |
| 4 | 2a | `compute_vector_decl.hpp` | §3.4 ComputeVec* 运算策略体系 | `compute_vector_decl.cj` | 无偏离。首轮仅定义类型，不被 Vec 运算符消费（D16） |
| 5 | 2a | `_vectorize.hpp` | §3.3 Functor 体系 | `vectorize.cj` | 无偏离。按分量数拆分 functor（4 × 4 = 16 个定义），首轮仅定义不消费（D16） |
| — | 2a | —（新增） | §4.3 算术运算、§4.6 `@OverflowWrapping` 标注策略 | `scalar_vec_ops.cj` | **偏离说明**：新增文件，将 scalar-op-vec 方向辅助函数（add(s,v)/sub(s,v)/mul(s,v)/div(s,v)/mod(s,v)，共 5 运算 × 4 Vec = 20 个）从 `compute_vector_decl.cj` 中独立为首轮即被消费的公共 API。已在 §4.6 补充 `@OverflowWrapping` 标注策略以确保溢出行为一致性 |
| 6 | 4 | `type_vec1.hpp` + `type_vec1.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec1.cj` | 无偏离 |
| 7 | 5 | `type_vec2.hpp` + `type_vec2.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec2.cj` | 无偏离 |
| 8 | 6 | `type_vec3.hpp` + `type_vec3.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec3.cj` | 无偏离。`.inl` 中 `#if GLM_CONFIG_SIMD` 条件包含 `type_vec_simd.inl` 由 `GLM_CONFIG_SIMD=false` 消除 |
| 9 | 7 | `type_vec4.hpp` + `type_vec4.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec4.cj` | 无偏离。同上 SIMD 条件分支消除 |
| 10 | 2b | `fwd.hpp` 标量别名部分（第 1-178 行） | §3.7 标量类型别名 | `fwd.cj`（标量别名部分） | 无偏离 |
| 11 | 8 | `fwd.hpp` 向量别名部分（第 180-507 行） | §3.8 向量类型别名 | `fwd.cj`（向量别名部分） | 无偏离。256 个别名全量定义，与 roadmap §3C 一致 |
| S1 | S | `<cassert>` shim | §3.6 Shim 层 | `shim_assert.cj` | 无偏离。新增仓颉 shim 文件 |
| S2 | S | `<limits>` shim | §3.6 Shim 层 | `shim_limits.cj` | 无偏离。新增仓颉 shim 文件 |
| S3 | S | `<cstddef>` shim（不含 `countof`） | §3.6 Shim 层 | `shim_cstddef.cj` | **偏离**：Cangjie 无 C 数组类型——GLM 中 countof 宏基于 `sizeof(array)/sizeof(array[0])` 计算 C 数组元素个数，此模式在 Cangjie 中无对应映射。所有原使用场景在迁移时删除。§3.6 已声明此决策，但上一轮 §8.2 追溯表遗漏此偏离的记录，现补充标注 |
| — | 8（新增） | —（新增） | §2 模块划分 | `lib.cj` | **偏离说明**：新增 `lib.cj` 用于 `public import` 重导出核心类型和 `scalar-op-vec` 方向辅助函数（`add`/`sub`/`mul`/`div`/`mod`）。此文件不在 roadmap 原始清单中，但为满足公共 API 面封装性而新增，不引入新的类型定义或依赖，不影响范围完整性和依赖闭合性 |
| — | — | —（全局设计决策） | §4.6 `@OverflowWrapping` 标注策略 | — | **偏离说明**：本设计在二元算术运算符上直接标注 `@OverflowWrapping`、复合赋值由编译器自动生成，与 roadmap §0.5.1 推荐的"复合赋值上标注、二元运算符委托"策略相反。此偏离由仓颉语言限制驱动（复合赋值运算符不可显式定义），已在 D3 和 §4.6 顶部正式声明 |

### 8.3 迁移顺序与依赖说明

**迁移顺序**（含增量验证节点，每阶段标注预期代码量以供编码工作量规划）：

| 阶段 | 步骤 | 文件 | 增量验证 | 预期代码量 |
|------|------|------|---------|-----------|
| 0 | 非 Vec 文件 API 快速扫描（编码启动前置） | 对 7 个非 Vec 核心文件（setup.hpp/qualifier.hpp/compute_vector_relational.hpp/compute_vector_decl.hpp/_vectorize.hpp/fwd.hpp/shim 文件）按 §1 下方「7 文件快速扫描依赖项核查清单」逐项确认无遗漏移植依赖项 | 扫描执行人：设计审议方提供核查清单，编码实施者按清单逐项确认并签字；通过标准：7 项全部确认通过，每项核查要点逐条应答；超时升级路径：发现未覆盖依赖项且 24 小时内无法确认处理方案 → 上报主 Agent + 设计审议；发现≠解决闭环原则：扫描标识的差异须以编码阶段实际编译验证为最终闭环依据 | ~0 行（扫描审查，无代码编写） |
| 1 | 基础设施（可并行） | 1. setup.cj + 3. shim_assert.cj + 4. shim_limits.cj + 5. shim_cstddef.cj | 各文件独立编译通过；`cjpm build` 无报错 | ~120 行（18 个配置常量 + shim 函数 + 类型别名） |
| 2 | 基础设施 | 2. qualifier.cj | 编译通过；确认 `Qualifier` 接口及 6 个实现类型定义正确 | ~50 行（接口 + 6 个空结构体 + Defaultp 别名） |
| 3 | 辅助工具（可并行） | 6. compute_vector_relational.cj + 7. vectorize.cj | 编译通过；`ComputeEqual` 对 `Int32`/`Float32`/`Bool` 各实例化一次确认。注：`compute_vector_relational.cj` 与 `vectorize.cj` 无相互编译依赖，可并行编译；`compute_vector_decl.cj` 依赖 `vectorize.cj`，须在阶段 4 编译 | ~100 行（ComputeEqual + 16 个 functor 结构体定义） |
| 4 | 运算策略 | 8. compute_vector_decl.cj | 编译通过；确认 compute_vec_* 结构体定义正确（首轮仅定义不消费，编译通过即足） | ~80 行（10 个 compute_vec_* 策略结构体定义） |
| 5a | Vec 类型核心结构体（实施顺序：① 数据成员 + `const init` → ② `@OverflowWrapping` 二元算术运算符 → ③ `==`/`!=` 比较运算符 → ④ `[]`/`componentAt`） | 9~12. type_vec1.cj ~ type_vec4.cj（先实现 struct 体定义） | 编译通过；对 `Vec4<Int32>` 和 `Vec4<Float32>` 各验证一次构造 + 算术 + 比较运算正确性 | **~300 行**（Vec1~Vec4 struct 体定义，含 ~70 个运算符/函数 × 4 Vec ≈ 280-320 个运算符定义。建议使用多光标编辑或脚本生成降本，详见 §4.3 效率提示） |
| 5b | Vec 类型扩展成员 + scalar-op-vec | 9~12. type_vec1.cj ~ type_vec4.cj（extend 块：位运算符 + 具名函数 `increment`/`decrement`/`bitwiseNot`/`logicalAnd`/`logicalOr`/`equalEpsilon`/`equalExact`）+ scalar_vec_ops.cj | 编译通过；验证扩展成员函数正确性；验证 `scalar-op-vec` 方向具名函数对不同操作数顺序的正确性 | **~250 行**（extend 块位运算符 + 具名函数 + Vec1 广播运算符 + scalar_vec_ops.cj 20 个函数） |
| 5c | Bool→Numeric 转换 | 12b. type_fromBoolVec.cj | 编译通过；对 Vec1~Vec4 各验证一次 `fromBoolVec` 和 `fromBoolVecQ2` 的转换结果正确性 | ~60 行（8 个工厂函数定义） |
| 6 | 公共 API + 别名 | 13. lib.cj + 14. fwd.cj | 编译通过；验证 `import glm.*` 可正确使用 Vec 类型；验证所有 256 个别名编译无重复定义 | ~350 行（lib.cj ~10 行 + fwd.cj ~340 行 256 个别名，推荐脚本生成） |
| 7 | 测试运行 | — | `cjpm test` 运行全部 `@Test` 测试用例通过 | ~500 行（测试文件合计） |

**依赖说明**：
- `setup.cj` 包含 18 个 `GLM_CONFIG_*` 编译期常量定义，**不包含** `assert` 函数（归入 `shim_assert.cj`）或 `LengthT`/`SizeT` 类型别名（归入 `shim_cstddef.cj`）。
- `shim_cstddef.cj` 无任何依赖，与 `setup.cj` 无重叠职责。
- `VArray<T, $N>` 的 `size` 属性提供编译期长度查询，等效于 C++ 中的元素计数宏。`$N` 必须为固定数值字面量，不可声明为值泛型参数。
- `compute_vector_relational.cj` 定义简化后的 `ComputeEqual<T>`（无 `IsFloat` 参数）。
- `vectorize.cj` 和 `compute_vector_decl.cj` 首轮仅定义类型，不被 Vec 运算符消费。
- **阶段 1 shim 文件 API 覆盖评估级别说明**：阶段 1 中的 4 个 shim 文件（setup.cj/shim_assert.cj/shim_limits.cj/shim_cstddef.cj）的 API 覆盖评估为**依赖项级别**（即确认每个 shim 文件提供的功能接口满足其在 Vec 运算符和公共 API 中的被消费需求），而非逐 API 级对照（不做逐函数行号级映射）。依赖项级别的评估已包含：setup.cj 提供 18 个 GLM_CONFIG_* 常量（被 qualifier.cj 和 Vec 运算符引用）、shim_assert.cj 提供 assert 函数（被 operator[] 引用）、shim_limits.cj 提供 NumericLimits<T> 和 isIec559Of<T>()（被 ComputeEqual 引用）、shim_cstddef.cj 提供 SizeT/LengthT 别名（被下游消费者使用）。此评估级别与 §1 P37 中 setup.hpp/qualifier.hpp 标记为"中"风险等级（非"无风险"）的定性一致——不声称"已逐 API 确认无遗漏"，而是以依赖闭合为验证目标。

### 8.4 参考实现使用策略

**参考实现目录**：`references/glm-1.0.3/` 包含 GLM 1.0.3 C++ 参考实现，在编码阶段按以下策略使用：

0. **前置验证**（编码启动前必须完成）：确认参考实现目录结构完整，关键路径的实现逻辑与设计假设一致。具体验证项包括：① 确认 `references/glm-1.0.3/glm/glm/detail/setup.hpp` 中 `GLM_CONFIG_CLIP_CONTROL` 的条件编译逻辑与 §7 D6 描述的决策分支一致（三层条件编译：`GLM_FORCE_DEPTH_ZERO_TO_ONE` 设置 `ZO_BIT`/`NO_BIT`，`GLM_FORCE_LEFT_HANDED` 设置 `LH_BIT`/`RH_BIT`，无额外定义时最终值为 `0x0A`）——**编码前必须读取 `setup.hpp:563-584` 的原始条件编译块，逐行确认分支走向与 `0x0A` 推导一致**；② 确认 `references/glm-1.0.3/glm/glm/detail/qualifier.hpp` 中 `storage` 模板的非 SIMD 路径仅使用 `T data[L]` 数组（与 D23 省略理由一致）；③ 确认 `references/glm-1.0.3/glm/glm/detail/type_vec2.inl` 及 `type_vec4.inl` 中构造函数宏展开后的参数列表与 §4.1 清单匹配（抽查 Vec2/Vec4 各一个）；④ 抽查 3~5 处首轮未迁移的 `#define`/`#if` 条件编译块（如 `setup.hpp` 中 `GLM_ARCH_DETECTED` 检测宏、`GLM_COMPILER` 检测宏、`GLM_PLATFORM` 检测宏），确认首轮其他文件对这些被排除块无间接引用。

   **验证失败回退步骤**：若以上任一验证项发现参考实现与设计描述不符，按以下流程处理：
   - **验证项①（CLIP_CONTROL 逻辑）失败**：以参考实现的 `#if`/`#elif`/`#else` 条件编译结果为最终依据，更新 §7 D6 中 `GLM_CONFIG_CLIP_CONTROL` 的默认值及条件分支说明，同步更新 §6 中配置常量表的映射值和用途说明列，记录于设计变更日志。
   - **验证项②（storage 模板路径）失败**：若发现非 SIMD 路径也使用了非 `T data[L]` 的实现（如条件性的结构体包装），在 §7 D23 中补充说明，更新 §8.2 范围可追溯性表的相关偏离列。
   - **验证项③（构造函数宏展开）失败**：以参考实现实际宏展开的参数列表为准，更新 §4.1 的构造函数签名清单中对应 Vec 类型的构造函数签名，同步更新 §8.2 范围表的相关描述。
   - **验证项④（条件编译块无间接引用）失败**：若发现首轮文件意外引用了被排除的 `#define`/`#if` 块定义的宏或类型，评估迁移范围是否需要扩大或补充 shim 定义，记录于设计变更日志并触发范围变更评审。
1. **行为确认**：当设计文档中的行为约定存在歧义时，以参考实现中对应 `.hpp`/`.inl` 文件的实现为最终行为参照。例如，确认 `type_vec4.inl` 中 `operator++` 的逐分量递增语义。
2. **构造函数清单验证**：§4.1 的构造函数清单已覆盖 GLSL 5.4.1 及 GLM 扩展的所有构造形态。编码阶段针对具体 VecN 类型时，应查阅参考实现中对应 `type_vecN.inl` 的构造函数宏展开，确认无遗漏的构造函数组合。
3. **运算符行为对标**：每个运算符迁移完成后，使用参考实现中的测试模式验证结果等价性——通过构造相同的输入值，对比仓颉输出与 C++ 参考实现的输出（可编写小型 C++ 测试程序编译执行，或人工对照 GLM 文档描述的数学语义）。
4. **配置宏确认**：`setup.cj` 中 18 个 `GLM_CONFIG_*` 常量的默认值以参考实现中 `setup.hpp` 的 `#define` 定义为准。当配置值与参考实现不一致时，以参考实现为准并更新设计文档中对应表格。**兜底条款**：若参考实现中的条件分支逻辑与当前描述不符（如嵌套 `#if`/`#elif`/`#else` 的条件组合产生与文档不同的计算结果），以参考实现的实际条件编译结果为准，同步更新 §7 D6 及相关章节中的配置描述。
5. **命名映射**：256 个别名与 `fwd.hpp` 中 GLM CV-qualified 类型名的映射关系以参考实现为准——编码阶段逐家族对照 `fwd.hpp` 的 `typedef` 行确认映射正确性。
6. **非首轮内容边界**：参考实现中属于后续轮次的内容（矩阵/四元数/函数库文件等）不应在首轮编码中引用。编码阶段若意外需要参考这些内容，应标记并推迟至对应轮次的设计审议。

### 8.5 首轮内容排除清单

以下表格列出 C++ GLM 中首轮**不予迁移**的所有设施，逐项说明排除理由及计划纳入的轮次。此清单为 §8.2 范围可追溯性对照表中"偏离"列的补充，覆盖所有因范围裁剪而未被映射到首轮的 C++ 设施。

| 被排除的 C++ 设施 | 对应 GLM 文件 | 排除理由 | 计划轮次 | 设计决策/章节 |
|-----------------|-------------|---------|---------|-------------|
| `storage<L,T,Q>` 模板及 SIMD 特化 | `qualifier.hpp` | Cangjie Vec 直接声明具名数据成员，无需手动选择存储类型；SIMD 路径待后续轮次重新设计 | 第 5+ 轮（SIMD 轮次） | D23、§3.1 |
| `genTypeTrait<genType>` 模板偏特化 | `qualifier.hpp` | 服务于矩阵/四元数泛型代码，首轮无矩阵/四元数类型 | 第 2-3 轮（矩阵/四元数迁移） | D24、§3.9 |
| `init_gentype<genType, type>` 模板 | `qualifier.hpp` | 同上，为单位值生成辅助设施 | 第 2-3 轮 | D24、§3.9 |
| `find_best_type` 类型选择工具 | `qualifier.hpp` | 同上 | 第 2-3 轮 | D24、§3.9 |
| 平台/编译器检测宏（~1000 行条件编译） | `setup.hpp` | 首轮仅迁移约 80-120 行配置常量，检测宏在 Cangjie 平台无对应映射 | 后续轮次按需引入 | D6、§3.6 |
| SIMD 检测及实现路径 | `setup.hpp`、`type_vec_simd.inl` 等 | `GLM_CONFIG_SIMD=false`，首轮禁用所有 SIMD 路径 | 第 5+ 轮 | D6 table entry |
| Swizzle 操作 | 散布于 Vec 定义文件 | `GLM_CONFIG_SWIZZLE=2`（disabled），Cangjie 不支持 swizzle 语法 | 后续轮次重新设计 | D6 table entry |
| 匿名 struct 特性 | `type_vecN.inl` 宏展开 | Cangjie 不支持匿名 struct，`GLM_CONFIG_ANONYMOUS_STRUCT=false` | 永久排除（Cangjie 无对应语法） | D6 table entry |
| Aligned 对齐类型暴露 | `qualifier.cj`（C++ 中为公开） | 首轮 `GLM_CONFIG_ALIGNED_GENTYPES=false`，Aligned 系列声明为 `internal` | 第 2 轮（切换配置时） | §3.1 Aligned 可见性策略 |
| C++ `<cassert>` 的 `assert` 宏 | `setup.hpp` | 被 Cangjie `if + throw` 等效替代 | 首轮已完成替代 | §3.6 `shim_assert.cj` |
| C++ `<cstddef>` `size_t`/`ptrdiff_t` | GLM 间接依赖 | 被 Cangjie `SizeT`/`LengthT` 类型别名替代 | 首轮已完成替代 | §3.6 `shim_cstddef.cj` |
| C++ `<limits>` `std::numeric_limits` | GLM 间接依赖 | 被 Cangjie `NumericLimits<T>` + `isIec559Of<T>()` 替代 | 首轮已完成替代 | §3.6 `shim_limits.cj` |
| C++ `<functional>` `std::plus` 等函数对象 | `_vectorize.hpp` | Cangjie lambda/函数引用直接替代 | 首轮已完成替代 | D7、§3.3 |
| `<`/`<=`/`>`/`>=` 逐分量比较运算符 | GLM 中未定义（在 GLSL 为具名函数） | 首轮不提供，避免语义混淆 | 后续函数库轮次（`vector_relational.hpp` 迁移） | D22、§4.5 |
| `++`/`--` 运算符重载 | `type_vecN.inl` | 不在 Cangjie 可重载运算符列表中 | 首轮以 `increment`/`decrement` 具名函数替代 | D12、§4.3 |
| `&&`/`||` 运算符重载 | `type_vecN.inl` | 同上 | 首轮以 `logicalAnd`/`logicalOr` 具名函数替代 | D12、§4.5 |
| `~` 一元运算符重载 | `type_vecN.inl` | 同上 | 首轮以 `bitwiseNot` 具名函数替代 | D12、§4.4 |
| 矩阵类型（`mat2x2`~`mat4x4` 等） | `type_mat*.hpp`/`.inl` | 超出首轮范围 | 第 2-3 轮 | Roadmap §3A |
| 四元数类型（`qua`） | `type_quat.hpp`/`.inl` | 超出首轮范围 | 第 3-4 轮 | Roadmap §3A |
| 函数库（三角函数、标准化、投影等） | `glm/gtc/*.hpp`、`glm/gtx/*.hpp` 等 | 超出首轮范围 | 第 4+ 轮 | Roadmap §3A |
| `Display`/`ToString`/`Format` 接口自定义实现 | — | 首轮依赖编译器默认字符串表示 | 后续函数库轮次统一设计 | §3.2 |
| `normalize` 等向量运算函数 | `geometric.hpp` 等 | 超出首轮范围 | 第 4+ 轮 | §9.1 |
| 跨类型复合赋值（`v += other_vec<T2,Q>`） | `type_vecN.inl` | 仓颉运算符重载不能为泛型，复合赋值仅接受同类型右操作数；跨类型复合赋值不可用。替代方案：先构造后赋值两步模式（`v = v + VecN<T,Q>(w)`） | 首轮以两步模式替代，后续不纳入（仓颉语言限制） | D15、§4.3 |
| 跨类型 Vec1 广播复合赋值（`v += vec1<T2,Q>`） | `type_vecN.inl` | 广播运算符仅接受同类型 Vec1 右操作数，跨类型广播复合赋值不可用。替代方案：`v = v + Vec1<T,Q>(w)` | 首轮以两步模式替代，后续不纳入（仓颉语言限制） | §4.3 |
| Vec1 左操作数方向广播复合赋值（`v1 += vN`） | `type_vec1.inl` | 返回类型为 VecN 与左操作数 Vec1 不匹配，编译器不自动生成复合赋值。替代方案：`v1 = v1 + vN` 两步模式 | 首轮以两步模式替代，后续不纳入（仓颉语言限制） | §4.3 |
| Bool→Numeric 隐式转换构造 | `type_vecN.inl` | 仓颉中 `Bool` 不可直接转换为数值类型（`Int32(Bool)` 不支持），跨 Vec 转换构造函数中 Bool→Numeric 产生编译错误。C++ GLM 中 `vec<2, float, Q>(bvec2)` 隐式转换可用。替代方案：`fromBoolVec`/`fromBoolVecQ2` 包级独立工厂函数提供显式转换。此为"迁移但语义降级"的设施——从隐式构造降级为显式工厂函数调用 | 首轮以显式工厂函数替代，永久降级 | §4.8、§9.4 路径 A |
| Vec1 跨类型标量复合赋值（`vec1<T,Q> += scalar_of_T2`） | `type_vec1.inl` | 仓颉编译器自动生成的 `+=` 仅接受同类型右操作数；C++ GLM 中 `operator+=(U scalar)` 允许跨类型标量复合赋值。替代方案：`v1 = v1 + T(s2)` 两步模式 | 首轮以两步模式替代，后续不纳入（仓颉语言限制） | §4.3 |
| 完全泛型多元构造函数 `template<A,B,...> vecN(A, B, ...)` — 各分量类型可独立推导 | `type_vec1.inl`~`type_vec4.inl` | 各分量类型可独立推导的完全泛型多元构造函数（如 C++ `template<A,B> vec2(A,B)` 允许 A≠B）在仓颉中无法直接映射——此泛型构造函数与已有 `const init(x: T, y: T)` 在调用方传入同类型参数时产生重载歧义，且各分量需通过 `T(v)` 转换为统一的目标类型 `T`。C++ 该模式已由标量填充构造、逐分量 const init、跨 Vec 转换构造等已有构造函数形态覆盖，无需单独映射 | 首轮覆盖（已有构造函数形态已覆盖该模式），无排除必要 | 附录 A |

**排除清单的维护责任**：此清单在后续轮次的设计审议中逐项更新——已纳入的轮次标记为"已完成"，新识别的不迁移设施追加至清单末尾。迁移实施者以本节为快速参考，确认某一 C++ 设施是否属于首轮范围。

---

## 9. 异常场景和边界条件补充

### 9.1 零向量相关行为

| 场景 | 行为约定 |
|------|---------|
| 零向量定义 | 所有分量为 `T(0)` 的 Vec 实例。对整数类型（`Int8`~`Int64`、`UInt8`~`UInt64`）和浮点类型（`Float32`/`Float64`）及 `Bool`（`false`）均适用。 |
| 零向量参与算术运算 | 零向量 + 向量 = 向量（与加法单位元一致）。零向量 - 向量 = 取负后的向量。零向量 × 标量 = 零向量。零向量 / 标量 = 零向量（除零情况按 §9.2 约定）。 |
| 零向量逐分量比较 | `ComputeEqual<T>` 在编译期 `if` 路径下对整数类型通过 `==` 直接比较，对浮点类型通过容差比较。零向量与自身比较始终返回 `true`。 |
| 零向量标准化 | 首轮不实现 `normalize` 函数。标准化场景中的零向量处理约定推迟到后续轮次定义。 |

### 9.2 除零行为

| 场景 | 行为约定 |
|------|---------|
| 整数 Vec / 标量 0 | 仓颉运行时抛 `ArithmeticException`（整数除零）。Vec 运算符不做预防性检查。 |
| 浮点 Vec / 标量 0 | 仓颉运行时返回 `±Inf`（IEEE 754 默认行为）。Vec 运算符不做预防性检查。 |
| Vec / Vec（全零分量） | 逐分量运算，每个分量独立按标量规则处理。 |
| Vec % 0（取模除零） | 整数取模除零抛 `ArithmeticException`。浮点 Vec 实例在编译期即因 `%` 不支持浮点类型而报错（§4.3 整数约束）。 |
| 零向量 / 零标量 | 与"任意向量 / 零标量"行为一致（整数抛异常，浮点返回 `±Inf`/`NaN`）。 |

### 9.3 NaN/Infinity 传播

| 场景 | 行为约定 |
|------|---------|
| NaN 参与算术运算 | 所有算术运算直接委托给仓颉原生浮点运算，严格遵循 IEEE 754 标准：`NaN + x = NaN`，`NaN - x = NaN`，`NaN * x = NaN`，`NaN / x = NaN`。 |
| NaN 参与比较运算 | `ComputeEqual` 的浮点容差比较路径使用 `abs(a - b) <= epsilonOf<T>()`。`NaN - x = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`，因此 `NaN == x`（对任意 x，含 NaN 自身）均返回 `false`。此行为与 IEEE 754 标准一致。 |
| Infinity 参与算术运算 | `Inf + Inf = Inf`，`Inf - Inf = NaN`，`Inf * 0 = NaN`，`Inf / Inf = NaN`，`Inf + finite = Inf`。严格遵循 IEEE 754 标准。 |
| Infinity 参与比较运算 | 浮点容差比较路径下，`Inf - Inf = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`。因此 `Inf == Inf` 在容差比较路径下返回 `false`（IEEE 754 标准行为：`Inf == Inf` 在 `==` 运算符层面返回 `true`，但在容差路径下因减法表达式产生 NaN 而被误判）。此为容差比较路径的已知局限性。**行为差异**：此差异不限于 Inf/NaN 边界——仓颉浮点 `==` 的容差路径对所有浮点比较场景均偏离 C++ GLM 的 IEEE 754 精确相等语义。对于有限值，容差路径在 epsilon 范围内将微差视为相等，而 C++ GLM 精确比较将微差视为不等。因此这是**全量行为偏离**，涉及所有浮点 Vec `==` 使用场景。**补救措施**：对于需要 IEEE 754 精确相等语义的场景，使用 `equalExact()` 具名函数（§4.5），该函数跳过容差路径直接使用仓颉原生 `==` 做精确分量比较。若 `const operator ==` 的容差路径因验证失败而整体回退到精确比较（§7 D29），此差异自动消除——回退路径下 `==` 行为与 C++ GLM 一致。首轮约定：`==` 的容差路径适用于有限值范围内的浮点比较，Infinity/NaN 及需精确语义的场景通过 `equalExact` 完成。

| `mod` 运算（含浮点 `mod` 包级独立函数） | 浮点 `mod` 直接委托给恒等式 `x - y * trunc(x / y)`，NaN/Infinity 传播行为由 IEEE 754 浮点运算决定。`Inf % finite` → `NaN`（因 `Inf / finite = Inf`，`trunc(Inf) = Inf`，`finite * Inf = Inf`，`Inf - Inf = NaN`）。`finite % 0` → `NaN`（因 `finite / 0 = Inf`）。`NaN % finite` → `NaN`。整数 `mod` 除零抛 `ArithmeticException`，无 NaN/Infinity 问题。首轮不做预防性检查，与 §9.2 除零行为一致。 |

**`equalExact` 与 `==` 行为差异汇总**：容差路径下，`equalExact` 与 `==` 在以下场景存在行为差异：① 有限值的微差比较——`==` 使用 `abs(a-b) <= epsilon` 的容差判定，`equalExact` 使用精确 `==`，因此微小浮点误差在 `equalExact` 下为不等、在 `==` 下可能为相等；② `Inf == Inf`——容差路径下 `==` 返回 `false`（减法产生 NaN），`equalExact` 返回 `true`（IEEE 754 精确相等）；③ `NaN == x`——容差路径下 `==` 和 `equalExact` 均返回 `false`（NaN 与任何值均不相等），行为一致。整数/Bool Vec 上两者行为完全等价（精确比较路径）。容差回退路径下两者完全等价。 |
| `NumericLimits<T>.epsilon()` 与 Infinity | `epsilon()` 的语义：对于浮点分量的容差比较，`epsilonOf<T>()` 返回固定容差 `NumericLimits<T>.epsilon()`（非缩放容差）。当 `a` 或 `b` 为 `Inf`/`NaN` 时，`abs(a-b) <= epsilonOf<T>()` 比较可能因 `Inf-Inf=NaN` 而失败。**值域局限性**：`NumericLimits<T>.epsilon()` 是相对于 1.0 量级的机器 epsilon，对远大于 1.0 的值过于宽松，对远小于 1.0 的值过于严格——详见 §3.5 机器 epsilon 容差比较的值域局限性说明段。首轮约定：`ComputeEqual` 的容差路径适用于有限值范围内的浮点比较。Infinity/NaN 的相等性判断回退到仓颉原生 `==`（调用方可通过 `equalExact` 具名函数获取 IEEE 754 精确相等语义，已在 §4.5 定义且属于首轮范围）。 |

### 9.4 类型转换边界

| 转换场景 | 行为约定 |
|---------|---------|
| 整数宽度提升 | `Int8 → Int16 → Int32 → Int64` 等，无精度损失。 | 
| 整数宽度截断 | `Int64 → Int32 → Int16 → Int8` 等，高位截断。仓颉运行时在 Debug 模式可能产生溢出检测，但在 `@OverflowWrapping` 标注下截断语义与 C++ 隐式转换一致。 |
| 无符号 ↔ 有符号互转 | `UInt32 → Int32` 等。仓颉的类型构造函数直接处理。超出有符号范围的值按 wrapping 语义截断。 |
| 浮点 → 整数 | `Float64 → Int32` 等。仓颉的类型构造函数对溢出值抛 `ArithmeticException`。C++ 中此场景是 UB。设计约定：迁移代码中若涉及浮点到整数的 Vec 转换，应在调用处确保值在目标类型的表示范围内，或通过 `clamp` 等辅助函数处理（不属于首轮范围）。 |
| 整数 → 浮点 | `Int32 → Float32` 等。大整数可能因浮点精度限制而损失精度（`Float32` 的 mantissa 为 23 位，无法精确表示超过 2^24 的整数）。此行为与 C++ 隐式转换一致，不做特殊处理。 |
| 浮点宽度提升/截断 | `Float32 ↔ Float64`。宽度提升无损，宽度截断可能损失精度。 |
| `Bool` → 数值 | 跨 Vec 转换构造中 `Bool` 不可直接转换为数值类型（仓颉中 `Int32(Bool)` 不被支持）。泛型构造函数 `public init<T2, Q2>(v: VecN<T2, Q2>)` 不受限于 T2 的具体类型——当 `T2 = Bool` 且 `T` 为数值类型时，构造函数体内的 `T(v.x)` 尝试将 `Bool` 转换为数值，将产生编译错误。**解决方案路径**（按可行性优先级排序）：<br><br>**路径 A（推荐，无编译依赖）**：不尝试在单个泛型构造函数中处理所有 T2→T 组合。接受 Bool→Numeric 在通用 `init<T2, Q2>` 中产生编译错误的固有限制（D5 延迟检查语义）。为 `VecN<Bool, Q2>`→`VecN<数值类型, Q>` 转换场景，提供**包级独立工厂函数** `fromBoolVec` 和 `fromBoolVecQ2`，其完整签名清单（Vec1~Vec4）和行为约定已在 §4.8 中正式定义。此路径完全规避编译期分支抑制依赖，对所有分量数（Vec1~Vec4）适用模式一致。**Vec1 的构造函数不对称性不影响 `fromBoolVec`**（详见 §4.8）。<br><br>**路径 B（待验证，若编译器支持）**：在非 `const` `init` 体内通过 `as` 运算符做运行时类型检测并分派——`let bOpt = v.x as Bool; if (let Some(b) <- bOpt) { this.x = if (b) { T(1) } else { T(0) } } else { this.x = T(v.x) }`。此方案的可行性依赖以下假设（均须 §10 编码前验证）：① `v.x as Bool` 对任意泛型 `T2` 编译通过（`as` 运算符始终可用）；② `if (let Some(b) <- bOpt)` 模式匹配在非 `const` 函数中编译通过；③ `T(1)`/`T(0)` 作为常量构造器对目标类型 `T` 合法。若三项验证均通过，路径 B 可无缝嵌入现有 `init<T2, Q2>` 签名，无需新增工厂函数。<br><br>**路径 C（备选）**：在 `const init` 体内利用编译期 `if` 的分支抑制行为——`if (isIec559Of<T2>()) { ... } else if (/* 检测 Bool ... */) { ... } else { ... }`。但此路径需要在 `const` 上下文中对 `T2` 做类型检测，而编译期 `if` 在 `const` 函数体中对泛型参数的检测能力受限于编译期 `is` 表达式的可用性。可行性较低，作为理论备选方案记录。<br><br>**首轮推荐**：采用路径 A（包级独立工厂函数），理由：零编译器行为依赖，所有 VecN 分量数（Vec1~Vec4）适用模式一致，调用模式自然（无需 dummy receiver）。若编码阶段路径 B 验证通过，可作为可选优化路径（将运行时检测逻辑内联到 `init<T2, Q2>` 体内，减少工厂函数调用开销）。<br><br>**跨 Q 转换说明**：§4.8 同时定义了同 Q 版本 `fromBoolVec`（Q 参数同时约束输入 Bool Vec 和输出数值 Vec）和跨 Q 版本 `fromBoolVecQ2`（输入 Bool Vec 使用 Q2、输出数值 Vec 使用 Q）。调用方根据场景选择：若输入与输出的 Qualifier 相同，使用 `fromBoolVec`；若不同（如 `PackedHighp` Bool Vec → `PackedLowp` 数值 Vec），使用 `fromBoolVecQ2`。<br><br>**§10 验证依赖**：路径 B 的三项假设均纳入 §10 设计阶段验证清单——验证项编号见 §10 `Bool→Numeric` 转换验证子节。若验证失败，路径 B 标记为"不可行"，首轮编码仅采用路径 A。首选推荐路径"的确定性表述，转为中性优先级描述。 |
| `Vec1` → `Vec2`/`Vec3`/`Vec4` | 所有分量取 `Vec1` 的单一分量值。适用于标量传播构造场景。 |

---

## 10. `isIec559Of<T>()` 取值对照表

`isIec559Of<T>()` 在 `shim_limits.cj` 中以 `const` 泛型函数形式实现，函数体内使用编译期 `if` 配合 `is` 运算符进行类型检测。各类型取值如下：

| 类型 | `isIec559Of` 值 | 说明 |
|------|--------------|------|
| `Int8` | `false` | 整数类型，非 IEC 559 |
| `Int16` | `false` | 整数类型，非 IEC 559 |
| `Int32` | `false` | 整数类型，非 IEC 559 |
| `Int64` | `false` | 整数类型，非 IEC 559 |
| `UInt8` | `false` | 整数类型，非 IEC 559 |
| `UInt16` | `false` | 整数类型，非 IEC 559 |
| `UInt32` | `false` | 整数类型，非 IEC 559 |
| `UInt64` | `false` | 整数类型，非 IEC 559 |
| `Float16` | `false` | 因 `is` 运算符检测模式仅覆盖 `Float32`/`Float64`，`isIec559Of<Float16>()` 受限于此模式返回 `false`。若后续轮次引入 Float16 支持，应扩展检测条件或改用其他方案以正确返回 `true` |
| `Float32` | `true` | IEC 60559 单精度（需验证仓颉运行时符合性） |
| `Float64` | `true` | IEC 60559 双精度（需验证仓颉运行时符合性） |
| `Bool` | `false` | 布尔类型，非 IEC 559。`isIec559Of<Bool>()` 通过编译期 `if` 的 `else` 分支返回 `false` |

**实现方式**：
```cangjie
  const func isIec559Of<T>(): Bool {
      if (T(0) is Float64 || T(0) is Float32) { true } else { false }
  }
```
该函数为单一泛型函数，不涉及重载或特化。编译期实例化时，`T(0) is Float64` 等表达式在 const 上下文中求值，零运行时开销。

**注**：C++ `is_iec559` 判断类型是否完全符合 IEEE 754 标准。仓颉的 `Float32`/`Float64` 预期符合 IEC 60559（IEEE 754），但此符合性需在目标平台上验证。若平台浮点实现有偏差，`isIec559Of<Float32>()`/`isIec559Of<Float64>()` 应回退到 `false` 以使用精确比较路径。当前设计保持编译期判断，若需运行时动态判断则需改为反射方案（不属于首轮范围）。

**设计阶段验证要求**：`isIec559Of<T>()` 的 `if (T(0) is Float64 || T(0) is Float32)` 方案依赖三项核心假设（`T(0)` const 构造、`is` 在 const 泛型中的可用性、`abs()`/`epsilon()` const 兼容性），均须在设计阶段完成编译器验证——所有验证依赖项均由 §2.1 项①③㉒⑫覆盖。

**验证时序**：三项依赖应在设计阶段完成原型验证。若依赖①或②失败 → `if (T(0) is Float64)` 方案不可行，整体回退到备选路径（所有类型精确比较 `a == b`，§3.5 备选路径）。若依赖①和②通过但依赖③失败 → 浮点容差比较从 `const operator ==` 路径中移除，通过独立的非 `const` 具名函数（如 `equalEpsilon`）提供。**风险标注**：本方案的可行性最终取决于目标编译器对 `const` 泛型上下文中 `is` 运算符和 `T(0)` 构造的支持程度。编码阶段启动前必须完成上述原型验证，验证结果决定本设计的 `const` 路径是否可行。

### 编译期 `if` 分支抑制行为综合验证

编译期 `if` 分支的非选择分支抑制行为是本设计多处依赖的核心编译器行为。以下统一列出所有依赖点及其验证要求。

#### 依赖点清单

编译期 `if` 分支抑制行为涉及 5 个依赖点（A. `ComputeEqual.callConst`、B. `isIec559Of<T>()`、C. `mod` 包级独立函数、D. 嵌套编译期 `if`、E. 构造函数 Bool→数值检测），所有依赖点的抑制验证均由 §2.1 项④⑫①③⑥⑧统一覆盖。

#### 统一验证方法

所有依赖点（A~E）的核心验证逻辑相同——验证编译期 `if` 在 `const` 上下文中的非选择分支抑制行为。统一原型测试方法详见 §2.1 编码前验证检查清单项④⑫。验证方法：以 `Float32`/`Int32`/`Bool` 分别实例化统一原型测试 `testConstIfSuppression<T>()`，三项均编译通过即视为编译期 `if` 非选择分支抑制机制对所有依赖点 A~E 均成立。

若编译期 `if` 抑制不成立，各依赖点的独立回退方案：

| 依赖点 | 回退方案 |
|-------|---------|
| A. `ComputeEqual.callConst` | `==` 退至非 `const` 精确比较；浮点容差比较由独立非 `const` 具名函数 `equalEpsilon` 提供 |
| B. `isIec559Of<T>()` | 放弃编译期类型检测，`==` 退至精确比较（与 A 回退路径一致） |
| C. `mod` 双路径 | 拆分为 `modInt`（非 `const`，使用 `%`）和 `modFloat`（非 `const`，使用 `trunc` 恒等式），调用方按类型选择 |
| D. 嵌套编译期 `if` | 与 A 回退路径一致（整体 `==` 退至精确比较） |
| E. Bool 检测 | 采用方案 B 运行时分支（已为首选方案，无需变更） |

#### mod 函数边界值验证（独立于编译期 if 抑制）

若编译期 `if` 抑制验证通过，`mod` 的浮点路径还需额外验证恒等式的数值正确性。浮点 `mod` 边界值和负操作数符号验证均由 §2.1 项⑥覆盖。

### 浮点 `mod` 实现正确性验证

`mod` 具名函数对浮点类型 Vec 的实现采用算术恒等式 `x - y * trunc(x / y)`，其中 `trunc` 取自 `std.math.trunc`（仅提供 `Float64` 版本）。对 `Float32` 分量，采用先提升至 `Float64` 计算截断再转换回 `Float32` 的精度策略。此实现策略的所有验证依赖项（`trunc` 可用性、Float32→Float64 精确保真性、负操作数正确性、编译期 `if` 分支正确性、`const` 声明）均由 §2.1 项⑥⑫覆盖。

### `equalEpsilon` 设计阶段验证

`equalEpsilon` 具名函数（§4.5）提供非 `const` 浮点容差比较能力，作为 `==` 回退路径的补充或显式容差比较 API。其所有验证依赖项（`abs()` 可用性、`epsilonOf<T>()` 编译通过性、`Inf`/`NaN` 边界行为、回退路径联动依赖）均由 §2.1 项㉒⑲覆盖，其中 `epsilonOf<T>()` 回退路径与 `equalEpsilon` 的隐式依赖链详见 §12.2/§12.3。

**验证时序**：`abs()` 可用性和 `epsilonOf<T>()` 编译通过性在 Vec 结构体编码完成后立即验证；`Inf`/`NaN` 边界行为随 §12.1 层次四异常场景验证一并执行。若 `abs()` 在 extend 块中不可用，`equalEpsilon` 无法在 extend 块中定义，需移至 struct 体内以非 `extend` 成员函数形式提供。若整数 `T` 编译错误，`equalEpsilon` 添加 `where T <: Number<T>` 约束缩小适用范围，非浮点 T 上的容差比较通过 `equalExact` 替代。

### `equalExact` 设计阶段验证

`equalExact` 具名函数（§4.5）跳过容差比较路径，直接使用仓颉原生 `==` 对每个分量做精确比较。其所有验证依赖项（组件级 `==` 可用性、行为差异可观测性、Inf/NaN 精确语义、回退路径等价性）均属低风险，随 §12.1 层次二/三测试一并覆盖。

**验证时机**：组件级 `==` 可用性和行为差异可观测性在 Vec 结构体编码完成后立即验证（作为构造-访问-运算验证的一部分）；Inf/NaN 精确语义为语言定义行为，可作为编译确认项；回退路径等价性仅在 D29 回退触发后执行回归测试。

### `@OverflowWrapping` 与 `const` 函数共存验证

`@OverflowWrapping` 溢出注解与 `const` 函数修饰符的可共存性（语法共存、语义兼容、包级独立函数共存）均由 §2.1 项⑫统一集成验证覆盖。

**验证建议**：将语法共存性和语义兼容性合并为单一原型测试函数，在 `const` 和 `non-const` 两种上下文中对比 `@OverflowWrapping` 标注的算术运算行为。若验证通过，则包级独立函数的 `const`+`@OverflowWrapping` 方案（§4.3）可行。若验证不通过，则所有 `const` 算术包级函数降级为非 `const` 版本，同时保持 `@OverflowWrapping` 标注——功能正确性不受损，仅失去编译期调用能力。扩展成员函数（`add(v,s)` 等）因声明为非 `const`，不受此验证约束。

### `@Derive[Hashable]` 在泛型 struct 上的约束传递性验证

`@Derive[Hashable]` 在泛型 struct `VecN<T, Q>` 上的自动派生依赖类型参数 `T` 的 `Hashable` 约束传递性（§3.2）。所有验证依赖项（编译通过性、HashSet 可用性、负向测试）均由 §2.1 项㉑覆盖。

### `Bool→Numeric` 转换路径 B 可行性验证

`as` 运算符运行时类型检测方案（§9.4 路径 B）的可行性依赖 `as` 运算符编译通过性、`if-let` 模式匹配可用性和 `T(1)`/`T(0)` 构造器合法性，均由 §2.1 项⑧覆盖。

**验证时序**：验证按 `as` 运算符编译通过性 → `if-let` 模式匹配可用性 → `T(1)`/`T(0)` 构造器合法性顺序串行执行。若 `as` 运算符或 `if-let` 模式匹配失败 → 路径 B 标记为"不可行"。若 `T(1)`/`T(0)` 构造器失败 → 路径 B 降级为使用具体类型的直接字面量赋值（仅在 `T` 可推断时可行）或回退至路径 A（具名工厂函数）。

**验证通过标准**：所有依赖项均编译通过，且运行时行为正确（`Bool(true)` → `T(1)`，`Bool(false)` → `T(0)`，非 `Bool` 类型原样转换）。

### Vec4 构造函数重载解析验证

Vec4 的多重重载构造函数（约 30 个签名）在泛型参数实例化时的重载解析验证（含对偶重载歧义、多元 Vec1 参数组合歧义、具体类型优先规则）由 §2.1 项⑬统一覆盖。

**回退方案**：若对偶重载分支或多元 Vec1 参数组合发现歧义，按 §4.1 定义的回退方案执行——移除 4-6 个歧义分支（保留更常用的一侧），将移除的分支改为具名工厂函数 `fromVec3AndVec1` 等。若编译器行为与"具体类型优先于泛型类型"规则预期不符，则所有 fill-from-Vec1 非泛型构造函数均需改为具名工厂函数形式。

**验证时序**：在 §2.1 检查清单第⑬项中统一验证。验证通过后，构造函数体系按当前设计编码；验证失败则按回退方案修改 Vec4 构造函数清单后重新编译验证。**系统性扫描策略**：除了 §2.1 检查清单第⑬项的原型验证外，编码阶段完成 Vec4 实现后，须新增 Vec4 构造函数全量编译验证项——对每个构造函数签名各构造一个实例验证编译通过，确保无遗漏歧义。

### 生成脚本验证依赖

`fwd.cj` 采用外部脚本自动生成 256 个别名，脚本正确性和同步性验证由 §2.1 项⑪覆盖。

---

## 11. 迁移成本评估

### 11.1 `&&`/`||` 具名函数迁移

C++ GLM 中 `&&` 和 `||` 是运算符重载，迁移到仓颉后需改为具名函数 `logicalAnd`/`logicalOr`。此语法变更对下游代码的影响和迁移模式如下：

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `a && b`（a,b 为 vec） | `a.logicalAnd(b)` | 在 Vec 类型变量上搜索 `&&` 替换为 `.logicalAnd()` |
| `a \|\| b`（a,b 为 vec） | `a.logicalOr(b)` | 在 Vec 类型变量上搜索 `\|\|` 替换为 `.logicalOr()` |
| `!a`（a 为 vec） | `!a` 或 `a.logicalNot()` | `!` 可重载，保持语法不变 |

#### 迁移模式

1. **纯语法替换**（机械可执行）：在 Vec 类型表达式中，将 `v1 && v2` 替换为 `v1.logicalAnd(v2)`，将 `v1 || v2` 替换为 `v1.logicalOr(v2)`。此替换可通过正则搜索完成，不涉及语义分析。
2. **短路语义丢失**：C++ 中 `&&`/`||` 的短路求值语义在具名函数中不保留——`logicalAnd(a, b)` 始终求值两个参数。在 GLM 向量运算场景中，所有参数均为纯表达式（无副作用），因此短路语义丢失不影响正确性。
3. **迁移影响范围**：仅影响使用 `bvec*`（`VecN<Bool, Q>`）类型布尔向量运算的代码。标量布尔值不受影响（仓颉原生 `&&`/`||` 保留）。

#### 自动迁移工具建议

可编写搜索脚本（基于正则表达式）处理以下模式：
- `(\w+)\s*&&\s*(\w+)` → `$1.logicalAnd($2)`
- `(\w+)\s*\|\|\s*(\w+)` → `$1.logicalOr($2)`

注意：此搜索替换需限定在 `bvec*` 类型变量范围内以避免误改标量 `Bool` 类型的 `&&` 表达式。在迁移实践中，建议在代码审查过程中手动标注 Vec 类型变量范围，或通过类型注解辅助搜索脚本。

### 11.2 `++`/`--` 具名函数迁移

C++ GLM 中 `++` 和 `--` 是前缀/后缀运算符重载，迁移到仓颉后需改为具名函数 `increment()`/`decrement()`。此语法变更对下游代码的影响和迁移模式如下：

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `++v`（前缀） | `v = v.increment()` | 在 Vec 类型变量上搜索前缀 `++` 替换为 `.increment()` |
| `v++`（后缀） | `v = v.increment()` | 在 Vec 类型变量上搜索后缀 `++` 替换为 `.increment()` |
| `--v`（前缀） | `v = v.decrement()` | 在 Vec 类型变量上搜索前缀 `--` 替换为 `.decrement()` |
| `v--`（后缀） | `v = v.decrement()` | 在 Vec 类型变量上搜索后缀 `--` 替换为 `.decrement()` |

#### 迁移模式

1. **前缀与后缀统一替换**：仓颉值类型中 `increment()` 和 `decrement()` 返回新向量（值语义的副本）。C++ 中前缀 `++v` 返回左值引用，后缀 `v++` 返回旧值副本。在仓颉中，两种形式均统一为 `v = v.increment()`（返回新向量后再赋值）。若原 C++ 代码依赖后缀 `++` 的"返回旧值"行为（如 `auto old = v++`），则需在迁移时拆分——`let old = v; v = v.increment()`。
2. **迁移影响范围**：影响所有使用 `vec++`、`++vec`、`vec--`、`--vec` 表达式的代码。通常用于循环计数或状态更新。
3. **`@OverflowWrapping` 继承**：`increment()`/`decrement()` 标注 `@OverflowWrapping`，行为与 C++ GLM 的 `operator++`（高位丢弃）一致。

#### C++ `++`/`--` 使用模式分类与映射

以下分类表涵盖 C++ 中 `++`/`--` 在 Vec 类型上的所有典型使用模式，逐一给出正确的仓颉映射方式和迁移工作量评估：

| 模式 | C++ 代码 | C++ 行为 | 仓颉等效代码 | 迁移工作量 | 说明 |
|------|---------|---------|-------------|-----------|------|
| **I. 独立语句（不依赖返回值）** | `v++;` `++v;` `v--;` `--v;` | 仅执行副作用（修改 v），返回值被忽略 | `v = v.increment()` / `v = v.decrement()` | 低（机械替换，搜索替换即可） | 前缀与后缀在仓颉中无差异。C++ 中前缀性能更优（无临时副本），仓颉中始终产生新向量 |
| **II. 作为右值（后缀返回旧值）** | `auto old = v++;` | old 获得 v 递增前的值，v 递增 | `let old = v; v = v.increment()` | 中（需拆分语句） | 必须解构为临时保存旧值和更新两步。不能简化为 `v.increment()` 的单一表达式 |
| **III. 作为右值（前缀返回新值）** | `auto newv = ++v;` | newv 获得 v 递增后的值，v 递增 | `v = v.increment(); let newv = v` 或 `let newv = v.increment()`（若可覆盖原变量） | 中（需拆分语句） | 若调用方只需新值且可丢弃原变量，可直接 `let newv = v.increment()` |
| **IV. 嵌套表达式** | `arr[++v] = val;` | v 先递增，然后用新值索引数组 | `v = v.increment(); arr[v] = val` | 中（需拆分表达式） | 仓颉表达式要求显式分步。可用复合赋值：`v = v.increment(); arr[v] = val` |
| **V. 循环计数** | `for(; condition; ++v) { ... }` | 循环的增量部分独立修改 v | `v = v.increment()` 作为循环增量表达式 | 低（机械替换） | 在循环的增量表达式中直接替换 |
| **VI. 函数参数** | `foo(v++);` | v 递增前的值传给 foo，然后 v 递增 | `let tmp = v; foo(tmp); v = v.increment()` | 中（需拆分语句） | 必须保存旧值副本后传递 |
| **VII. 后缀链式操作** | `v++->method();` | 对 v 递增前的旧值调用 method | `let tmp = v; v = v.increment(); tmp.method()` | 中（需拆分语句） | 通过临时变量交换方法调用方 |
| **VIII. 返回值传播** | `return v++;` `return ++v;` | 返回 v 递增前/后的值 | `let newv = v.increment(); return newv` 或 `return v.increment()` | 低-中（依赖返回值语义） | 若仅需新值，直接返回 `v.increment()`；若需旧值，先保存旧值再更新 |

**迁移工作量评估**：
- **低（机械替换）**：约占总出现次数的 60-70%。直接搜索替换即可，无需语义分析。
- **中（拆分语句）**：约占总出现次数的 30-40%。需要人工阅读上下文，理解返回值使用方式后拆分为多条语句。
- **高（涉及前缀/后缀语义差异）**：在 Vec 类型上不适用（前缀/后缀在仓颉中行为统一），但在非 Vec 标量类型场景中仍需区分。

**编码阶段建议**：
1. 先用正则搜索替换处理模式 I（独立语句）和模式 V（循环计数），覆盖大部分迁移工作。
2. 对模式 II-IV 和 VI-VIII，在代码审查中逐处人工识别并标注改造方式。
3. 对于 `Vec<Bool, Q>` 上的 `increment()`/`decrement()`，由于 Bool 不支持算术运算，在实例化时产生编译错误。迁移时需将涉及 `VecN<Bool>` 的 `++`/`--` 替换为逻辑非操作（`!`）或移除。

### 11.3 跨类型赋值差异

C++ GLM 允许从同分量数但不同分量类型的 Vec 赋值（如 `ivec2 = vec2` 通过隐式转换）。仓颉中 struct 自动生成的 `=` 仅接受完全相同类型的右操作数，跨类型赋值需显式转换：

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `ivec2 a; vec2 b; a = b;` | `let a: IVec2; let b: Vec2Float32; a = IVec2(b);` | 显式使用跨 Vec 转换构造 |
| `uvec4 a; vec4 b; a = b;` | `let a: UVec4; let b: Vec4Float32; a = UVec4(b);` | 分量级类型转换在构造函数内完成 |

此差异为机械可替换的语法变化，通过搜索 `vecTypeName =` 后跟不同 Vec 类型的赋值模式进行替换。

### 11.4 `bitwiseNot()` 迁移影响（`VecN<Bool, Q>` 场景）

`bitwiseNot()` 对 `VecN<Bool, Q>` 的行为与 C++ GLM 的 `~bvec` 存在根本性差异（详见 §3.2 已知行为差异说明）：
- C++ GLM 中 `~bvec` 因整数提升机制（`bool` → `int` → 按位取反 → 转回 `bool`，非零即 `true`）对任一分量始终返回 `true`。
- 仓颉中 `bitwiseNot()` 对 `VecN<Bool, Q>` 调用 `!` 执行逻辑否定（`!true = false`，`!false = true`），行为完全相反。

**受影响的表达式模式**：

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `~bvec`（布尔向量） | `!bvec` 或 `bvec.bitwiseNot()` | 行为完全相反。若需保持 C++ 行为，应替换为 `VecN<Bool, Q>(true)`（全 true）或直接使用 `!` 运算符（已重载） |
| `~ivec`（整数向量） | `ivec.bitwiseNot()` | 语义等价（整数 `!` 为按位取反） |

**迁移规则**：
1. 整数分量 Vec 的 `~` 直接替换为 `.bitwiseNot()`，语义等价。
2. 布尔分量 Vec 的 `~` 需根据上下文选择替换方式：
   - 若期望行为是"全 false"（与仓颉 `!` 一致），替换为 `!bvec` 或 `bvec.logicalNot()`。
   - 若期望行为是"全 true"（与 C++ `~bvec` 一致），替换为 `VecN<Bool, Q>(true)`。
   - 若无法确定，应在代码审查中标记并手动确认。

**工作量评估**：影响范围较小（`~bvec` 使用频率低于整数/浮点向量位运算），主要在代码审查阶段人工识别处理。

### 11.5 浮点容差比较与 C++ GLM 精确比较的全量行为偏离

> **注意**：本节定义的容差比较偏离为 §11.9 所述行为差异的完整形态——仓颉浮点 Vec 的 `==` 对所有浮点比较场景（有限值微差和 Inf/NaN 边界）均偏离 C++ GLM 的 IEEE 754 精确相等语义，而非仅影响 Inf/NaN 边界。§11.9 迁移模式已覆盖本节场景，无需重复审查。

浮点容差比较路径下 `Inf == Inf` 返回 `false`，与 C++ GLM 的 `==` 行为（IEEE 754 `Inf == Inf` 返回 `true`）显著偏离。此差异仅是**全量行为偏离**的一个侧面——仓颉浮点 `==` 的容差比较对有限值也在 epsilon 范围内将微差视为相等，而 C++ GLM 精确比较将微差视为不等。

#### 差异机理
`ComputeEqual` 的容差比较路径执行 `abs(a - b) <= epsilonOf<T>()`。当 `a = Inf, b = Inf` 时：`Inf - Inf = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`。因此 `Inf == Inf` 在容差路径下误判为 `false`。对于有限值，`abs(a - b) <= epsilon` 将微小浮点误差容差化，与 C++ GLM 精确 `==` 在微差场景下行为不同。

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `vec == vec`（涉及 Infinity 分量） | `v1.equalExact(v2)` | 使用 `equalExact` 跳容器差路径 |
| `any(equal(v1, v2))`（涉及 Infinity 分量） | `v1.equalExact(v2)` | 同上 |
| `v == Inf`（标量比较） | `v.equalExact(VecN(Inf))` | 通过 `equalExact` 获取 IEEE 754 精确语义 |
| `vec == vec`（有限值微差场景） | `v1.equalExact(v2)`（若需精确语义）或维持原样（若接受容差） | 有限值微差在容差路径下可能视为相等 | 

#### 迁移模式

1. **受影响范围**：影响**所有**浮点分量 Vec 在 `==` 运算符中的比较行为——有限值微差场景（容差路径将 epsilon 范围内的微差视为相等）和 Inf/NaN 边界场景（`Inf - Inf = NaN` 导致 `==` 返回 `false`）。整数/Bool 分量 Vec 的 `==` 不受影响（走精确比较路径）。
2. **自动修复**：若 `const operator ==` 的容差路径因验证失败而整体回退到精确比较（见 §7 D29），本差异自动消除。
3. **手动修复**：需要 IEEE 754 精确相等语义的场景，将 `==` 替换为 `equalExact()`。

#### 搜索规则

| 搜索模式 | 替换目标 | 优先级 |
|---------|---------|--------|
| 浮点 Vec 变量上的 `==` 表达式，且操作数可能含 `±Inf`/`NaN` | 替换为 `.equalExact()` | 低（仅在关键路径中需要精确语义时执行） |
| `==` 用于 `VecN<Float32/64>` 的通用模式 | 保持原样（有限值范围内语义正确） | — |

#### 迁移工作量评估

- **低**：大多数 GLM 用户代码中浮点 Vec 的 `==` 比较涉及有限值范围，容差路径行为正确，无需修改。
- **中**：在涉及 Infinity/NaN 边界条件的数学计算中，需将 `==` 替换为 `equalExact()`。此类场景出现频率低，但人工审查成本高于机械替换。
- **§11.9 覆盖声明**：本节定义的 `Inf == Inf` 差异为 §11.9 所描述的 `equalExact` 迁移模式的一个子集。§11.9 中"人工审查浮点 Vec `==` 使用上下文"的迁移工作已涵盖本节场景，两份工作量评估**非累加关系**，实施者按 §11.9 执行一次即可。

### 11.6 `@OverflowWrapping` 标注继承性验证不通过的备选方案成本

当前设计假设编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注（§4.6、§7 D30）。此行为依赖编译器的未文档化行为。若验证不通过，需切换到备选方案——在已有 20 个 vec-op-scalar 方向扩展成员函数上补充 `@OverflowWrapping` 标注，二元运算符委托给这些函数。

**重要说明**：add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数（`add(v,s)` 等，5 运算 × 4 Vec = 20 个）已在 §4.3 中定义为首轮范围。因此 D30 回退**无需新增函数定义**，仅需完成以下变更。

#### 备选方案变更成本

| 变更项 | 影响范围 | 工作量评估 |
|-------|---------|-----------|
| 为已有 20 个 vec-op-scalar 方向扩展成员函数补充 `@OverflowWrapping` 标注 | 各 Vec 的 extend 块，共 5 函数 × 4 Vec = 20 处标注 | 低（20 处补充标注，机械添加，约 0.5 人天） |
| 二元运算符委托目标修改：从"直接逐分量运算"改为"调用已标注的扩展成员函数" | 各 Vec 结构体内的 5 个运算符实现，修改委托目标 | 低（5 处修改，机械替换，约 0.5 人天） |
| 复合赋值运算符消除 `@OverflowWrapping` 语义（运算符不再直接标注） | 由编译器自动生成，无需修改源码 | 无 |
| `increment()`/`decrement()` 已有 `@OverflowWrapping` 标注 | 已有覆盖，不受影响 | 无 |
| 下游代码影响 | 无——公共 API 签名不变（运算符语法糖不变） | 无 |

#### 迁移工作量合计

- **若标注继承性成立**：当前设计直接使用，无额外迁移成本。
- **若标注继承性不成立**：额外成本约 1 人天（20 处标注补充 + 5 处运算符委托目标修改）。注意：此评估已修正 v8 中将"新增 20 个具名函数"计入工作量的估算——由于函数已存在，实际工作量显著低于原评估。

### 11.7 别名命名约定偏离的迁移成本

### 11.7a Vec1 广播运算迁移模式

C++ GLM 中 `vecN op vec1` 广播运算为运算符形式（如 `vec2 + vec1`），仓颉中同样以运算符形式实现（通过 `extend` 块定义广播运算符）。迁移时语法形式保持不变——`vec2 + vec1` 在仓颉中同样合法。但需注意以下差异：

| C++ GLM 运算模式 | 仓颉等效代码 | 迁移说明 |
|----------------|-------------|---------|
| `vec2 + vec1` | `vec2 + vec1` | 语法一致，零迁移成本 |
| `vec1 + vec2` | `vec1 + vec2` | 语法一致，零迁移成本 |
| `vec2 += vec1` | `vec2 += vec1` | 自动生成的复合赋值，语法一致 |
| `vecN += vec1<T2,Q>`（跨类型广播复合赋值） | `v = v + Vec1<T,Q>(w)` | 跨类型不可用，需先转换再运算两步模式 |
| `vec1 += vecN` | `v1 = v1 + vN` | 返回类型与左操作数不匹配，编译器不自动生成复合赋值 |

**矩阵迁移连锁影响评估**：Vec1 广播运算符是矩阵运算中 Vec1 广播模式的基础——矩阵×向量运算中 `mat * vec1` 需消费 `vecN op vec1` 广播。若首轮不提供此模式，矩阵轮次需单独补充约 30 个广播运算符（5 算术 × 3 VecN + 5 位运算 × 3 VecN × 2 方向），增加矩阵轮次的迁移成本。当前设计已在首轮提供此模式，矩阵迁移可零成本消费。

### 11.7b 跨类型复合赋值迁移模式

C++ GLM 中 `vecN<T> += vecN<U>` 允许跨类型复合赋值（右操作数分量类型 `U` 可与左操作数 `T` 不同），仓颉中此能力不可用。

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `ivec2 a; vec2 b; a += b;` | `let a: IVec2; var b: Vec2F32; a = a + IVec2(b)` | 先构造后运算两步模式 |
| `vec2i32 += vec2i16` | `v = v + Vec2<Int32, Q>(w)` | 跨类型复合赋值拆为 `v = v + 转换后同类型` |
| `vec2 += vec1<T2,Q>` | `v = v + Vec1<T,Q>(w)` | 跨类型 Vec1 广播复合赋值拆为两步 |
| `vec1i32 += scalar_i16` | `v1 = v1 + Int32(s)` | Vec1 跨类型标量复合赋值拆为两步 |

#### 迁移工作量评估

- **机械可替换部分**（跨类型运算符可用时，占 ~50%）：搜索 `+=`/`-=`/`*=`/`/=`/`%=` 后跟不同类型 Vec 变量的模式，替换为先构造后赋值两步模式，约 0.5 人天。
- **人工审查部分**（类型推断需人工判断，占 ~50%）：需确认右操作数类型与左操作数类型的差异，约 0.5-1 人天。
- **合计评估**：约 1.0-1.5 人天。

### 11.7c Bool→Numeric 构造降级迁移模式

C++ GLM 中 `vec<2, float, Q>(bvec2)` 允许 Bool Vec 隐式转换为数值 Vec。仓颉中此能力不可用（`Int32(Bool)` 不支持），替代为显式工厂函数 `fromBoolVec`/`fromBoolVecQ2`。

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `vec2(bvec2_var)` | `fromBoolVec<Float32, PackedHighp>(bvec2_var)` | 隐式构造→显式工厂函数 |
| `ivec3 = bvec3;` | `let i: IVec3 = fromBoolVec<Int32, PackedHighp>(bvec3_var)` | 赋值中隐式转换→显式工厂函数 |
| `vec4(bvec4_var)`（跨 Q） | `fromBoolVecQ2<Float32, PackedLowp, PackedHighp>(bvec4_var)` | 跨 Q 版本使用 `fromBoolVecQ2` |

#### 迁移工作量评估

- **中**：模式固定（`fromBoolVec`/`fromBoolVecQ2` 替代隐式构造），搜索 `vecN(bvec)` 模式后逐处替换。约 0.5 人天。

### 11.7d mod 扩展成员函数浮点路径不可用的替换成本

`v.mod(s)`（扩展成员函数）仅提供整数路径，浮点 `T` 上需改用包级独立函数 `mod(s, v)`（§4.3 标注）。此替换影响所有使用 `VecN<Float32/64>` 实例调用 `v.mod(s)` 的 C++ 迁移代码。

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `vec4.mod(scalar)` 或 `v % s`（浮点向量取模） | `mod(scalar, vec4)` 或 `v % s`（仅整数） | 若原代码使用 `%` 运算符，`v % s` 在浮点 Vec 上编译错误必须改为 `mod(s, v)`；若原代码使用具名函数 `v.mod(s)`，直接改为 `mod(s, v)` |
| `v %= s`（浮点向量） | `v = mod(s, v)` | 复合赋值不可用，拆为两步模式 |

#### 迁移工作量评估

- **低**：影响范围小（浮点 Vec 的 `mod`/`%` 使用场景）。搜索 `v.mod(` 和 `v %` 在浮点 Vec 类型上下文中的出现处，逐处替换为 `mod(s, v)`。约 0.2 人天。

本设计采用大写驼峰（PascalCase）别名命名约定（如 `BVec2`、`IVec3`），与 C++ GLM 的小写原生名（`bvec2`、`ivec3`）不一致。此偏离影响所有从 C++ GLM 向量类型名向仓颉别名的迁移代码。

#### 受影响的别名映射

以下完整映射表格覆盖所有 16 个家族 × 4 分量数的默认精度别名。精度前缀别名（`HighpXXX`/`MediumpXXX`/`LowpXXX`）的映射规则与默认精度别名一致——仅在基础名前加精度的 PascalCase 前缀。

| C++ GLM 原生名 | 仓颉 PascalCase 别名 | 映射规则 |
|---------------|---------------------|---------|
| `bvec{1,2,3,4}` | `BVec{1,2,3,4}` | 单字母家族首字母大写 |
| `ivec{1,2,3,4}` | `IVec{1,2,3,4}` | 同上 |
| `uvec{1,2,3,4}` | `UVec{1,2,3,4}` | 同上 |
| `vec{1,2,3,4}` | `Vec{1,2,3,4}` | 首字母大写（与 GLM 原生一致） |
| `dvec{1,2,3,4}` | `DVec{1,2,3,4}` | 首字母大写，保留双字母 |
| `i8vec{1,2,3,4}` | `I8Vec{1,2,3,4}` | 数字前缀家族：数字保持、字母大写 |
| `i16vec{1,2,3,4}` | `I16Vec{1,2,3,4}` | 同上 |
| `i32vec{1,2,3,4}` | `I32Vec{1,2,3,4}` | 同上 |
| `i64vec{1,2,3,4}` | `I64Vec{1,2,3,4}` | 同上 |
| `u8vec{1,2,3,4}` | `U8Vec{1,2,3,4}` | 同上 |
| `u16vec{1,2,3,4}` | `U16Vec{1,2,3,4}` | 同上 |
| `u32vec{1,2,3,4}` | `U32Vec{1,2,3,4}` | 同上 |
| `u64vec{1,2,3,4}` | `U64Vec{1,2,3,4}` | 同上 |
| `fvec{1,2,3,4}` | `FVec{1,2,3,4}` | 首字母大写 |
| `f32vec{1,2,3,4}` | `F32Vec{1,2,3,4}` | 数字前缀家族 |
| `f64vec{1,2,3,4}` | `F64Vec{1,2,3,4}` | 同上 |

#### 机械替换可行性

- **简单搜索替换不可行**：小写 GLM 名（如 `bvec2`）与 PascalCase 名（`BVec2`）无共同子串模式可被正则表达式安全匹配。简单的大小写不敏感搜索将误匹配到仓颉原生的 `Vec2` 等名称。
- **上下文感知替换策略**：推荐在迁移过程中，对每个源文件逐一识别 C++ GLM 原始类型声明并将其替换为对应的仓颉别名。由于 GLM 类型名在 C++ 代码中通常出现在变量声明、函数参数和模板具现化位置，可通过语义感知搜索（如识别类型上下文中的 `bvec`、`ivec` 等关键字）辅助批量替换。
- **迁移工具策略**：
  1. 建立完整映射表（如上表），覆盖 16 家族 × 4 分量数 × 4 精度变体。
  2. 编写搜索脚本，对 `glm/types/\*.hpp` 等源文件提取所有 GLM 类型名引用。
  3. 按映射表逐项替换为 PascalCase 形式（可使用字典映射而非正则搜索）。
  4. 替换完成后编译验证，对编译错误的人工检查漏网之鱼。

#### 迁移工作量评估

- **低**（机械可执行部分）：约 60% 的别名引用可通过上下文感知脚本安全替换（变量声明中的类型名、函数返回类型等），替换后编译验证。
- **中**（人工审查部分）：约 40% 的别名引用需要人工确认（涉及模板嵌套、宏展开、条件编译中的类型名），需逐个审查。总人工审查时间估计：对于中等规模代码库（~50 个源文件），约 0.5-1 人天。

### 11.8 跨 Q 赋值迁移模式

仓颉泛型系统不支持类型参数默认值，所有 Vec 类型的 Q 参数（Qualifier）必须显式写出。C++ GLM 中 `bvec2` 在底层模板化为 `vec<2, bool, defaultp>`，其中 `defaultp` 由默认模板参数隐式提供。迁移至仓颉后，需为每个 Vec 实例显式补全 Q 参数。

#### 需要显式补全 Q 的场景

| 场景 | C++ GLM 代码 | 仓颉等效代码 |
|------|-------------|-------------|
| 变量声明（默认精度） | `bvec2 v;` | `var v: BVec2`（通过别名隐藏 Q） |
| 变量声明（非默认精度） | `highp_bvec2 v;` | `var v: HighpBVec2`（通过别名隐藏 Q） |
| 泛型函数参数（默认精度） | `void foo(vec3 v)` | `func foo(v: Vec3<Float32, PackedHighp>)` 或 `func foo(v: Vec3Float32)` |
| 泛型函数参数（多精度） | `template<typename T, qualifier Q> void foo(vec<3, T, Q> v)` | `func foo<T, Q>(v: Vec3<T, Q>) where Q <: Qualifier` |
| 结构体/类成员 | `struct S { bvec3 v; };` | `struct S { var v: BVec3; }`（通过别名） |
| 容器元素类型 | `std::vector<bvec4>` | `ArrayList<BVec4>`（通过别名） |
| 运算符表达式中间结果 | `vec4 a = b + c;` | `var a: Vec4Float32 = b + c`（变量声明需显式类型，或通过别名） |

#### 可通过别名避免 Q 显式指定的场景

通过 `fwd.cj` 中定义的 256 个别名，以下场景可以隐藏 Q 参数：
- **局部变量声明**：`var v: BVec2 = BVec2(true, false)` — 别名自动绑定 `PackedHighp`。
- **函数返回值**：`func foo(): BVec2 { ... }` — 返回值类型使用别名。
- **容器类型**：`HashSet<BVec2>` — 泛型实参使用别名。
- **函数参数**（非泛型函数）：`func bar(v: BVec2)` — 参数类型使用别名。

#### 无法通过别名避免、必须显式写 Q 的场景

- **泛型函数**：`func foo<T, Q>(v: Vec2<T, Q>) where Q <: Qualifier` — 泛型参数必须作为类型形参传递，无法使用固定别名。
- **跨精度运算**：`let a: Vec2<Float32, PackedHighp> = v1; let b: Vec2<Float32, PackedLowp> = v2;` — 不同精度需要不同 Q 参数。
- **`VecN<T, Q>` 作为另一泛型类型的参数**：`func foo<T>(v: Vec2<T, PackedHighp>)` — 部分具现化时需显式写出 Q。

#### 搜索替换规则

| 搜索目标 | 搜索模式 | 替换策略 |
|---------|---------|---------|
| C++ GLM `bvec2` → 仓颉 `BVec2`（默认精度） | `bvec{1,2,3,4}` | 替换为 `BVec{1,2,3,4}`（PascalCase，如 §11.7 映射表） |
| C++ GLM `highp_bvec2` → 仓颉 `HighpBVec2` | `(lowp\|mediump\|highp)_(b\|i\|u\|vec\|dvec\|...)(1\|2\|3\|4)` | 替换为 `{Precision}{FamilyName}{Dim}` |
| C++ GLM 模板 `vec<2, float, highp>` → 仓颉 `Vec2<Float32, PackedHighp>` | `vec<(1\|2\|3\|4), (类型), (精度)>` | 替换为 `Vec{N}<{类型}, {Packed精度}>` |
| 跨 Vec 转换（Q 不同） | `Vec2<Float32, PackedHighp>` → `Vec2<Float32, PackedLowp>` | 通过泛型构造函数自动转换（`init<T2, Q2>(v: VecN<T2, Q2>)`） |

#### 自动化工具可行性

- **高可行性**：搜索替换规则中，C++ GLM 的小写别名（`bvec2`、`ivec3` 等）到仓颉 PascalCase 别名（`BVec2`、`IVec3`）的替换是完全机械的，可通过字典映射脚本安全执行。
- **中可行性**：模板形式（`vec<2, float, highp>` → `Vec2<Float32, PackedHighp>`）的替换需要语义解析（识别 GLM 类型名到仓颉类型的映射），建议使用 AST 级别的代码转换工具。
- **低可行性**：泛型函数参数中 `Q` 的传播（如 `template<typename Q> void foo(vec<2, float, Q>)` → `func foo<Q>(v: Vec2<Float32, Q>) where Q <: Qualifier`）需要理解 C++ 模板参数的传递关系，建议人工处理。

#### 迁移工作量评估

- **别名场景**（通过别名隐藏 Q，占 ~70%）：低，机械替换，约 0.5 人天。
- **泛型场景**（必须显式写出 Q，占 ~20%）：中，需人工确认泛型函数的 Q 参数传播，约 1-2 人天。
- **跨精度场景**（手动指定不同 Q，占 ~10%）：低-中，逐处审查，约 0.5 人天。
- **合计评估**：约 2-3 人天（包括脚本编写与审查）。

### 11.9 `equalExact` 迁移模式

C++ GLM 中 Vec 类型的 `==` 运算符使用 IEEE 754 精确相等语义——浮点分量直接通过 `==` 比较，`Inf == Inf` 返回 `true`，`NaN == NaN` 返回 `false`。迁移到仓颉后，`==` 默认使用容差比较路径（§4.5），`Inf == Inf` 因容差路径中的减法表达式产生 `NaN` 而返回 `false`。原 C++ 代码中依赖 IEEE 754 精确 `==` 语义的场景需要被识别并替换为 `equalExact()`。

#### 行为差异对照

| 比较场景 | C++ GLM `==`（IEEE 754 精确） | 仓颉 `==`（容差路径） | 仓颉 `equalExact()` |
|---------|------------------------------|---------------------|-------------------|
| 有限值微差比较 | 精确比较，微差视为不等 | 在 epsilon 范围内视为相等 | 精确比较，微差视为不等 |
| `Inf == Inf` | `true` | `false`（因 `Inf-Inf=NaN`） | `true` |
| `NaN == x`（任意 x，含 NaN） | `false` | `false`（`NaN <= epsilon` 恒 `false`） | `false` |
| 整数/Bool 比较 | 精确比较 | 精确比较（走 `else` 分支） | 精确比较（等价于 `==`） |

#### 需要替换的场景清单

| 场景 | 识别特征 | 替换策略 |
|------|---------|---------|
| **Infinity 边界值比较** | Vec 参与涉及 `±Inf` 的比较，如 `v == Vec4(Inf)` | 替换为 `v.equalExact(Vec4(Inf))` |
| **NaN 检测** | 使用 `v == VecN(NaN)` 检测 NaN（CNaN 检测在 IEEE 754 中永远返回 false，迁移后行为不变，无需替换） | 维持原样（行为一致）或不使用 `==` 检测 NaN |
| **精确相等语义要求** | 算法逻辑依赖 IEEE 754 精确比较（如坐标精确匹配判定） | 替换为 `v1.equalExact(v2)` |
| **整数/Bool Vec 比较** | 整数或 Bool 分量的 Vec `==` 比较 | 无需替换（行为等价） |
| **容差路径回退后** | 若 `const operator ==` 因 D29 回退到精确比较路径 | 无需替换（`==` 与 `equalExact` 行为完全等价） |

#### 搜索替换规则

| 搜索模式 | 替换目标 | 优先级 | 自动化可行性 |
|---------|---------|--------|-----------|
| 浮点 Vec 变量上的 `==` 表达式，且操作数可能含 `±Inf`/`NaN` | 替换为 `.equalExact()` | 中（仅在关键路径中需要精确语义时执行） | 低（需语义分析识别 Infinity/NaN 上下文） |
| 性能关键路径上的 `==`（需避免容差比较开销） | 替换为 `.equalExact()` | 低（可选优化） | 低（需人工识别） |
| 整数/Bool Vec 的 `==` | 维持原样 | — | — |

#### 迁移工作量评估

- **受影响范围已修正**：此前将影响范围限定为"涉及 Inf/NaN 边界的 ~20% 场景"——此评估基于 C++ GLM 仅在 Inf/NaN 边界偏离的误判，未反映容差比较对**所有浮点 Vec `==` 比较场景**的全量偏离。修正后的评估覆盖全部浮点 Vec 的 `==` 使用代码。
- **机械可替换部分**（有限值场景接受容差语义可保留原样）：约占总浮点 Vec `==` 使用的 ~60%。若下游代码接受容差比较语义（即允许 epsilon 范围内的微差视为相等），则无需替换，零迁移成本。
- **人工审查部分**（需替换为 `equalExact()` 的场景）：约占总浮点 Vec `==` 使用的 ~40%。需逐一审查浮点 Vec `==` 的每个使用上下文，判断是否依赖 IEEE 754 精确相等语义。涉及坐标精确匹配判定、Infinity/NaN 边界条件、序列化一致性校验、哈希键值构造等场景，必须替换为 `equalExact()`。对于中等规模代码库（~50 个源文件），人工审查时间约 1.0-2.0 人天。
- **回退路径豁免**：若 `const operator ==` 因 D29 回退到精确比较路径，`==` 与 `equalExact()` 行为完全等价，此模式下 §11.9 定义的替换策略可整体跳过（零迁移成本），但 `equalExact()` 仍保留作为语义明确的独立 API 供下游选择使用。
- **合计评估**：约 1.0-2.0 人天（人工审查），若触发 D29 回退则降为 0。

### 11.10 标量在左运算的具名函数替换

标量在左、向量在右的运算（`scalar + vec`、`scalar - vec`、`scalar / vec`）因仓颉运算符重载规则不可实现（§4.3、§7 D10），需替换为具名函数 `add(s, v)`、`sub(s, v)`、`div(s, v)` 等。

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `s + v`（s 为标量，v 为 Vec） | `add(s, v)` | 在 Vec 类型上下文中搜索标量在左、Vec 在右的 `+` |
| `s - v` | `sub(s, v)` | 同上 |
| `s * v` | `mul(s, v)` | 同上（注意：`v * s` 已在运算符层面支持，本项特指标量在左） |
| `s / v` | `div(s, v)` | 同上 |
| `s % v` | `mod(s, v)` | 同上 |

#### 与 vec-op-scalar 方向扩展成员函数的关系和选择指南

具名函数有两个方向，调用方应根据操作数顺序和上下文选择：

| 方向 | 语法 | 定义位置 | 适用场景 |
|------|------|---------|---------|
| vec-op-scalar（扩展成员函数） | `v.add(s)` | `type_vecN.cj` 的 `extend` 块 | 操作数顺序为 vec 在左、标量在右；与 `v + s` 功能等价 |
| scalar-op-vec（包级独立函数，本节主题） | `add(s, v)` | `scalar_vec_ops.cj` | 操作数顺序为标量在左、Vec 在右；覆盖二元运算符不可表达的顺序 |

**选择指南**：若 C++ 原代码中操作数顺序为 `vec + scalar`，优先使用仓颉二元运算符 `v + s`（语法最简洁）；若原代码为 `scalar + vec`，则必须使用 `add(s, v)`。`v.add(s)`（扩展成员函数）与 `v + s` 功能等价，仅在需要显式方法传递或为未来 SIMD 替换预留时使用。

#### 搜索替换规则

| 源模式 | 替换目标 | 自动化可行性 |
|-------|---------|-----------|
| 标量字面量在左（如 `3.0f + v`） | `add(3.0f, v)` | 中——可通过正则 `[0-9.]+[fF]?\s*[+\-*/%]\s*\w+` 识别 |
| 标量变量在左（如 `s + v`，s 为标量变量） | `add(s, v)` | 低——需类型推断确认左操作数为标量类型 |
| `s * v`（标量在左） | `mul(s, v)` | 中——通过左操作数非 Vec 类型的特征识别 |
| `s / v`（标量在左） | `div(s, v)` | 同 `*` |
| `s - v`（标量在左） | `sub(s, v)` | 同 `*` |
| `s % v`（标量在左） | `mod(s, v)` | 同 `*` |

#### 工作量评估

- **机械可替换部分**（标量字面量在左的场景，占 ~30%）：正则搜索替换，约 0.5 人天。
- **人工审查部分**（标量变量在左的场景，占 ~70%）：需逐处阅读代码上下文判断左操作数类型，约 1-2 人天。
- **合计评估**：约 1.5-2.5 人天，覆盖全部 5 个运算（add/sub/mul/div/mod）。

### 11.11 `fwd.cj` 脚本开发与验证工作量

§3.8 推荐使用外部脚本自动生成 `fwd.cj` 的 256 个别名定义。此路径涉及以下独立于别名映射本身的工作量：

#### 方案对比

| 方案 | 工作量 | 风险 | 推荐场景 |
|------|-------|------|---------|
| **A. 手动编码 256 个别名** | 约 1-2 人天（含批量编辑 + 逐家族审查 + 编译验证）。256 行为规律性重复代码，使用多光标编辑或列模式可在 2-4 小时内完成初版，剩下的时间用于抽查和编译验证 | 中——手动复制可能引入拼写错误（如 `PackdHighp`、`Vec4<Bool, PackedHigh>` 等），需编译验证和抽查发现 | 团队无 Python/Node 环境或脚本维护意愿不足时采用 |
| **B. 外部脚本生成（推荐）** | 约 0.5-1 人天（含编写最小脚本模板 + 人工审查生成产物 + 编译验证）。最小脚本模板已在 §3.8 末尾提供（约 40 行 Python），实施者仅需按本地路径和命名风格做微调即可投入生产 | **低**——脚本输出模式固定，只要映射表正确，256 行别名一次性生成，零手动遗漏风险。脚本一次编写，后续轮次新增别名家族时复用 | **推荐优先采用**。§3.8 已提供可直接使用的最小脚本模板，实施者适配工作量极低（约 0.5 人天） |

#### 脚本路径工作量明细

| 工作项 | 工作量 | 说明 |
|-------|-------|------|
| 脚本适配（基于模板） | 0.25 人天 | 根据本地路径、命名风格调整 §3.8 提供的 Python 模板 |
| 生成产物人工审查 | 0.25 人天 | 抽查 4 个家族各一个精度变体，确认命名约定正确 |
| 编译验证 + 别名冲突检查 | 0.25 人天 | `cjpm build` + `cjpm test` 验证全量编译通过 |
| **合计** | **0.75 人天** | 显著低于手动编码的 1-2 人天，且风险更低 |

#### 脚本生命周期与版本控制

- **脚本位置**：`scripts/gen_fwd_aliases.py`（已在 §2 初始目录结构中预占位）
- **版本控制**：生成的 `fwd.cj` 和 `scripts/gen_fwd_aliases.py` 均纳入版本控制。后续轮次新增别名家族时，先更新脚本映射表重新生成，再提交两者变更
- **CI 集成（可选）**：可在 `cjpm.toml` 或预提交 hook 中添加 `python scripts/gen_fwd_aliases.py` 调用，确保 `fwd.cj` 始终与脚本定义一致

---

### 11.12 合计评估

以下按乐观（所有验证项通过，无回退触发）、最可能（部分回退触发）、悲观（多项回退触发）三档汇总首轮迁移成本：

| 成本项 | 乐观（人天） | 最可能（人天） | 悲观（人天） | 置信度评估 |
|-------|------------|-------------|------------|-----------|
| §11.1 `&&`/`||` 具名函数迁移 | 0.3 | 0.5 | 1.0 | **高**：机械替换，仅 Bool Vec 场景影响 |
| §11.2 `++`/`--` 具名函数迁移 | 0.5 | 1.0 | 1.5 | **中高**：模式 I/V 可机械替换（~60%），II~VIII 需人工审查 |
| §11.3 跨类型赋值差异 | 0.3 | 0.5 | 0.8 | **高**：模式固定，机械可替换 |
| §11.4 `bitwiseNot()` 迁移影响 | 0.2 | 0.3 | 0.5 | **高**：影响范围小，整数/布尔分支模式清晰 |
| §11.5 浮点容差比较与 C++ GLM 精确比较的全量行为偏离[^1] | 0（已纳入 §11.9） | 0（已纳入 §11.9） | 0（已纳入 §11.9） | 已纳入 §11.9 |
| §11.6 `@OverflowWrapping` 回退成本`[^overflow]` | 0（继承性成立） | 0.5（补充标注） | 1.0（补充标注+修改委托） | **中**：依赖编译器未文档化行为（§2.1 项⑤⑫验证后确定） |
| §11.7 别名命名约定偏离 | 0.5 | 1.0 | 2.0 | **中高**：~60% 可脚本安全替换，~40% 需人工审查 |
| §11.7a Vec1 广播运算迁移 | 0（语法一致） | 0.1 | 0.5（跨类型广播复合赋值人工审查） | **高**：语法一致，仅跨类型兜底需人工 |
| §11.7b 跨类型复合赋值迁移模式 | 0.3 | 0.75 | 1.5 | **中**：~50% 机械替换，~50% 需类型推断 |
| §11.7c Bool→Numeric 构造降级迁移模式 | 0.3 | 0.5 | 0.8 | **中高**：模式固定，搜索替换为主 |
| §11.7d mod 扩展成员函数浮点路径不可用替换 | 0.1 | 0.2 | 0.3 | **高**：影响范围小，模式明确 |
| §11.8 跨 Q 赋值迁移模式 | 1.0 | 2.0 | 3.0 | **中低**：别名场景机械（~70%），泛型/跨精度需人工（~30%） |
| §11.9 `equalExact` 迁移模式 | 0.5 | 1.0 | 2.0 | **中**：~60% 接受容差无需替换，~40% 需人工审查（依赖 D29 验证结果，若 D29 回退则降为 0） |
| §11.10 标量在左运算替换 | 1.0 | 1.5 | 2.5 | **中低**：~30% 可正则替换，~70% 需人工类型推断 |
| §11.11 `fwd.cj` 脚本开发与验证 | 0.5 | 0.75 | 1.0 | **高**：最小脚本模板已提供（§3.8），微调即可使用 |
| §11.13（新增）编译器依赖验证回退成本 | 0（验证通过） | 1.0 | 3.0 | **低→中**：依赖 §2.1 25 项验证结果——验证通过后置信度骤升，触发回退则成本大增 |
| §11.15 Bool Vec 相关 API 迁移模式 | 0.1 | 0.15 | 0.2 | **高**：影响极小，替换模式明确 |
| 测试运行器配置验证 | 0.1 | 0.1 | 0.2 | **高**：一次性配置，无不确定性 |
| B2 const/extend 不对称审查工作量 | 0.3 | 0.5 | 1.0 | **中高**：审查模式清晰（11 个 API 逐处识别 const 上下文） |
| **合计** | **6.0** | **12.35** | **22.8** | **整体置信度**：乐观路径（全部验证通过）置信度高；最可能路径置信度中等；悲观路径置信度低——三项方差（5.9~22.5）反映编译器假设验证结果的不确定性，通过快速预筛（§1 预筛步骤）可及早收敛至某一确定路径 |

**说明**：
- `[^1]`：§11.5 与 §11.9 非累加关系，实际以 §11.9 为准。§11.5 已从"Inf==Inf"单一差异扩展为"浮点容差比较与 C++ GLM 精确比较的全量行为偏离"，覆盖所有浮点 Vec `==` 使用场景，与 §11.9 的迁移范围一致。两项评估不可简单求和，实施者按 §11.9 执行一次即可覆盖两份工作。自 v9 起 §11.5 行三档成本均标记为"0（已纳入 §11.9）"，合计行已从合计值中剔除 §11.5 成本。
- 乐观合计（~6.0 人天）：所有编译器行为假设均通过验证，无回退路径触发。
- 最可能合计（~12.4 人天）：D30 标注继承性回退触发 + 别名命名需适度人工审查 + 跨 Q 部分场景需人工确认 + 浮点 `==` 全量审查（§11.9 扩大范围）。
- 悲观合计（~22.8 人天）：D29 const 表达式链回退 + D30 标注继承性回退 + 编译器依赖验证多项回退 + 大面积别名人工审查 + 跨类型复合赋值人工审查 + 浮点 `==` 全量替换。
- **不包含**：基础编码工作量（Vec 结构体和运算符的仓颉实现，独立于迁移审查）、测试编写工作量（§12 定义的测试层次）。
- **B2 项说明**：const/extend 不对称的 11 个 API 的审查工作量——主要涉及识别代码中使用这些 API 的 const 上下文并评估替代方案切换成本。此项在 v11 新增纳入评估。
- **`[^overflow]` 整数溢出迁移注意事项**：关于有符号整数 `@OverflowWrapping` 与 C++ UB 的迁移注意事项、逐处审查建议及辅助搜索脚本编写建议，详见 §5.1 整数溢出段落。

### 11.13 编译器依赖验证回退成本

§10 列出的 5 个编译期 `if` 分支抑制依赖点（A~E）及 `@OverflowWrapping` 标注继承性（D30）等编译器行为假设的验证回退成本：

| 验证项 | 独立验证成本（人天） | 回退触发时额外修复成本（人天） |
|-------|------------------|-------------------------|
| ① `T(0) const 构造 + is 运算符` 验证 | 0.1（编写原型测试） | 0（整体回退精确比较，无需修复） |
| ② `abs()`/`epsilon()` const 兼容性验证 | 0.1（编写原型测试） | 0.5（回退至 `equalEpsilon` 具名函数 + 内联容差） |
| ③ 编译期 `if` 分支抑制验证 | 0.2（统一原型测试 + 三类型实例化） | 各依赖点按 §10 回退表处理，合计约 1.0 人天 |
| ④ `@OverflowWrapping` 标注继承性验证 | 0.2（编写自动复合赋值继承性原型测试） | 1.0（在 20 个已有扩展成员函数上补充标注 + 修改 5 个运算符委托目标） |
| ⑤ 浮点 `mod` 边界值验证 | 0.1（编写边界值原型测试） | 0.5（拆分为 `modInt`/`modFloat` 非 `const` 具名函数） |
| ⑥ Vec1 跨类型 fill-from-Vec1 重载冲突验证 | 0.1（编写原型测试） | 0（仅移除跨类型版本，已有同类型版本可用） |
| ⑦ Bool→Numeric 转换路径 B 验证 | 0.2（三项原型测试串行验证） | 0（路径 B 失败后回退至路径 A——具名工厂函数，已在 §9.4 中定义） |
| ⑧ `@Derive[Hashable]` 约束传递性验证 | 0.1（编写原型测试 + 负向测试） | 0（首轮目标类型均实现 `Hashable`，回退场景不存在） |
| ⑨ `const`+`@OverflowWrapping` 语法共存性验证 | 0.1（编写原型测试） | 0.5（包级独立函数降级为非 `const`，保持标注） |
| ⑩ `fromBoolVecQ2` 编译器从返回值类型推断 struct 泛型实参验证 | 0.1（编写原型测试） | 0.5（为所有 `fromBoolVecQ2`（Vec1~Vec4）的 `VecN(...)` 调用处显式标注类型参数 `<T, Q>`） |
| ⑪ 测试运行器配置验证 | 0.1（创建 `@Test` 测试文件 + 执行 `cjpm test`） | 0.1（修正 `cjpm.toml` 配置路径） |
| **合计验证成本** | **1.4 人天** | **4.2 人天（若全部回退）** |

**最优路径**（~1.4 人天）：所有验证通过，回退成本为 0。
**最可能路径**（~2.8 人天）：1~2 项回退触发（通常是 D30 继承性或依赖③的分支抑制验证），其余通过。
**最差路径**（~5.1 人天）：多项验证同时回退（多项编译器行为假设不成立）。

**编码阶段验证顺序建议**：按 §2.1 编码前验证检查清单的序号 ①→②→③→④→⑤→⑥→⑦→⑧→⑨→⑩ 的顺序逐项验证，前一项验证通过后方可进入下一项，降低并行失败的信息熵。

#### 多项回退叠加效应分析

本设计依赖 13+ 个编译器行为假设（§10 依赖点 A~E + D30 `@OverflowWrapping` 继承性 + D29 const 表达式链 + `Bool→Numeric` 路径 B + `@Derive[Hashable]` 约束传递性 + `const`+`@OverflowWrapping` 共存性 + `fromBoolVecQ2` 编译器推断等），各假设的独立回退成本已在上述表格中列出。以下评估多项回退同时触发时的叠加效应和已知冲突组合：

| 回退组合 | 叠加效应 | 额外冲突风险 | 互斥性 |
|---------|---------|------------|--------|
| D29（const 链回退）+ D30（@OverflowWrapping 继承性回退） | **正交**——两项回退影响不同运算类别（比较 vs 算术），各自独立修复，成本可简单叠加 | 无冲突。D29 使 `==` 降级为精确比较 + `equalEpsilon` 成为唯一容差路径；D30 使算术运算通过扩展成员函数实现（补充标注） | 不互斥 |
| D29 + 依赖③（编译期 if 分支抑制失败） | **级联重叠**——多项回退同时触发时，修复成本涉及比较语义、取模实现模式、泛型约束策略等多个独立维度，每个维度的修复并非单一变更所能覆盖。具体受影响的维度：① 比较语义（`==` 降级为精确比较 + `equalEpsilon` 成为唯一容差路径）；② 取模实现模式（`mod` 拆分为 `modInt`/`modFloat`）；③ 泛型约束策略（`epsilonOf<T>()` 的 `Number<T>` 约束依赖分支抑制行为）。三个维度各需独立修改 | 若依赖③和 D29 同时失败，`==` 降级为精确比较，`mod` 拆分为 `modInt`/`modFloat`，`epsilonOf<T>()` 约束策略重新评估——三项修复涉及不同代码路径，需逐项评估 | 级联重叠，最可能修复成本约 1.5 人天（三项独立修复，每项约 0.5 人天），不可简单叠加为单项回退成本 |
| D30 + 依赖④（@OverflowWrapping 继承性回退） | **重复**——两项实际指向同一验证项（D30 即依赖④），表格中已分别列出，但实施时只执行一次验证和一次修复 | 无冲突（同一验证项） | **互斥**——应视为同一回退动作的两份独立成本描述，不可叠加 |
| 依赖①（T(0) const 构造失败）+ D29 | **级联**——依赖①失败直接导致 D29 整体回退（D29 核心前提是 `T(0)` const 构造可用）。依赖①失败时 D29 自动进入回退路径，无需额外验证或修复 | 依赖①回退成本已包含在 D29 回退成本中（统一为"整体回退精确比较"） | 级联触发，只计 D29 回退成本 |
| 依赖⑦（Bool→Numeric 路径 B 失败）+ D29 | **正交**——路径 B 失败仅影响 `init<T2, Q2>` 体内优化（回退到路径 A 工厂函数），与 D29 影响比较语义无关 | 无冲突 | 不互斥 |
| 依赖⑨（const+@OverflowWrapping 共存失败）+ D30 | **重叠**——依赖⑨失败使包级独立函数降级为非 `const`，D30 回退使扩展成员函数承担算术运算主路径。两项均涉及 `@OverflowWrapping` 标注分布调整 | 低——降级的是不同函数集合（包级独立函数 vs 扩展成员函数），标注调整彼此独立 | 不互斥 |
| **三项以上同时回退**（D29 + D30 + 依赖③ + 依赖⑤） | **累积**——多项回退同时触发时，总回退成本接近悲观路径合计（约 3.5 人天）。`==` 精确比较 + 算术扩展成员函数 + `mod` 拆分 + `equalEpsilon` 常量真空，四个维度独立修复，无不可调和的冲突 | 无系统性设计冲突——各项修复影响不同的 API 面，修改不重叠 | 不互斥（各自独立） |

**核心结论**：
1. **无不可调和的冲突组合**：所有已知回退组合均在设计层面有明确修复路径，无互斥或不可并存的回退方案。
2. **成本叠加注意事项**：D29 + 依赖③ 重叠触发时只计 D29 回退成本；D30 + 依赖④ 互斥触发（实为同一验证项）只计一次修复成本。
3. **最差路径实际成本**：考虑到上述重叠和互斥关系，全部 13+ 项假设同时回退的实际修复成本约为 **5.1 人天**（与表格中"全部回退"合计一致），而非简单累加各项独立修复成本。核心原因是多项回退的修复方案共享大量底层修改（如 `==` 精确比较仅需修改一处）。
4. **编码阶段验证顺序的双重保障**：按 §2.1 检查清单建议的第⑫→⑮→①→④→⑤ 验证序，三项最关键的编译器假设（统一集成验证、编译器版本、const 表达式链和编译期 if 分支抑制）在首个验证周期即可获知结果，提早暴露最高风险项。

#### D29 + 依赖③ + D30 三重回退场景完整设计快照

本快照描述当 D29（const 表达式链不成立）、依赖③（编译期 if 分支抑制失败）和 D30（`@OverflowWrapping` 继承性不成立）三项核心编译器假设同时失败时的完整修订后设计状态。此场景是当前设计已知的最恶劣回退组合，以下逐一列出各维度的修订内容：

**修订后设计状态（三重回退场景）**：

| 设计维度 | 原设计 | 三重回退后修订 | 影响章节 |
|---------|-------|--------------|---------|
| **比较语义** | `==` 使用容差比较（`abs(a-b) <= epsilonOf<T>()`） | `==` 降级为所有类型精确比较 `a == b`；浮点容差比较仅由非 `const` `equalEpsilon` 具名函数提供 | §3.5 ComputeEqual、§4.5 `==`/`!=`、§4.5 `equalEpsilon` |
| **取模实现** | 编译期 `if` 双路径（整数 `%` + 浮点 `trunc` 恒等式） | 拆分为 `modInt`（非 `const`，整数 `%`）和 `modFloat`（非 `const`，`trunc` 恒等式）两个独立具名函数；`%` 运算符保留整数路径 | §4.3 `mod` 函数、§4.3 `%` 运算符、§7 D13 |
| **算术溢出策略** | 二元运算符标注 `@OverflowWrapping`，复合赋值自动继承 | 在已有 20 个 vec-op-scalar 方向扩展成员函数（`add(v,s)`/`sub(v,s)`/`mul(v,s)`/`div(v,s)`/`mod(v,s)`）上补充 `@OverflowWrapping` 标注，二元运算符委托给这些已标注函数 | §4.3 具名函数、§4.6 `@OverflowWrapping` 策略、§7 D30、§11.6 |
| **泛型约束策略** | `epsilonOf<T>()` 使用 `where T <: Number<T>` 约束 | 移除 `Number<T>` 约束，`epsilonOf<T>()` 返回 `T(1e-6)` 固定容差；或完全移除 `epsilonOf<T>()` 将容差内联（取决于 §3.5 路径 A/B 选择） | §3.5 `epsilonOf<T>()`、`shim_limits.cj` |
| **const 上下文比较** | `==` 在 const 上下文中支持容差比较 | const 上下文中仅支持精确 `==`，`equalEpsilon`（非 `const`）不可用；需容差比较的使用方改用路径②（精确比较）或路径③（内联比较表达式） | §4.5 const 真空警示 |
| **包级独立函数** | `mod` 等声明为 `const` 以支持编译期 `if` | 所有包级独立函数降级为非 `const`，编译期 `if` 不可用；`mod` 拆分为 `modInt`/`modFloat` | §4.3 `scalar_vec_ops.cj`、§7 D32 |

**修订后编码步骤**（三重回退场景下）：
1. 先实现 `==` 精确比较（移除容差路径），保留 `equalExact`、`equalEpsilon` 具名函数
2. 在 20 个扩展成员函数上补充 `@OverflowWrapping` 标注，修改 5 个二元运算符委托目标
3. 实现 `modInt`/`modFloat` 替代原 `mod` 双路径方案（包级独立函数降级为非 `const`）
4. 根据 §3.5 路径选择调整 `epsilonOf<T>()` 约束策略
5. 在文档中标注 const 上下文中 `equalEpsilon` 不可用

**联动修改汇总**：三重回退需修改约 10-12 处设计章节（§3.5/§4.3/§4.5/§4.6/§7 D13/D29/D30/D32/§10/§11.6/§11.12），合计额外编码工作量约 2.0-3.0 人天（已在 §11.13 悲观路径合计中覆盖）。无不可调和的冲突——三项回退的修复路径各自独立，修改范围不重叠。

### 11.14 equalEpsilon const 化备选方案成本评估

§4.5 的 ⚠ const 真空警示描述了 D29 回退触发后 `equalEpsilon`（定义在 `extend` 块中，声明为非 `const`）在 const 上下文中不可用的限制，并提出了三项缓解路径。

**方案适用场景限定**：此备选方案**仅**在 D29 回退触发的极端场景下考虑（即 `const operator ==` 的表达式链验证失败，`==` 降级为精确比较，浮点容差比较仅由非 `const` 的 `equalEpsilon` 提供）。若 D29 验证通过（`==` 内置容差比较），`equalEpsilon` 作为显式容差比较 API 保留，但其 const 化需求不再是关键问题——const 上下文中可直接使用 `==`（已内置容差比较）。

**路径①（已废弃）** — 将 `equalEpsilon` 移至 struct 体作为 `const` 实例成员函数：

**废弃声明**：此路径的可行性依赖 D29 回退由 `extend` 语法限制单独导致而非表达式链底层不可用的极端罕见条件——此前提在实际中几乎不可能独立出现。§4.5 已将此路径标注为"已废弃——仅作理论记录，不可实施"。**该路径的成本评估（~0.5 人天）已从本子节完全移除，不计入任何成本合计**。编码阶段**严禁**为此路径预留任何工作量。

**路径②（实际可行——推荐，零成本）** — 在 const 上下文中使用精确比较 `==`，放弃容差比较：

| 工作项 | 影响范围 | 工作量评估 |
|-------|---------|-----------|
| 无需任何源码修改。const 上下文中 `==` 已降级为精确比较，直接使用 | 无 | **0 人天** |

**路径③（理论路径）** — 调用方自行编写 const 内联比较表达式：

| 工作项 | 影响范围 | 工作量评估 |
|-------|---------|-----------|
| 在各 const 使用点识别浮点 Vec 容差比较需求 | 需审查全部 const 泛型函数中浮点 Vec 的 `==` 使用场景 | 中（约 0.5-1 人天——逐处审查，依赖代码库规模） |
| 为每个使用点编写内联比较表达式（如 `abs(v1.x - v2.x) <= T(1e-6) && ...`） | 每个使用点约 3-5 行代码，覆盖率依赖审查结果 | 中（约 0.5 人天——依赖发现数量，约 5-15 处） |
| **合计** | | **约 1.0-1.5 人天** |

**修正后的推荐方案**：采用路径②（精确比较 `==`）作为首选，理由：
- 路径①已废弃——可行性条件在实际中无法独立满足，成本评估已完全移除，不纳入任何决策参考。
- 路径②零实施成本，直接利用已降级的精确 `==`，不依赖任何编译器行为假设。
- 路径③成本最高（1.0-1.5 人天），仅当 const 上下文中容差比较为硬性业务需求时才考虑。

**声明**：此备选方案的成本评估仅用于架构影响分析和编码阶段决策参考，**不纳入首轮迁移成本合计**（§11.12）——因其仅在 D29 回退触发的极端场景下实施。若 D29 验证通过，此成本为零。

### 11.15 Bool Vec 相关 API 迁移模式

`VecN<Bool, Q>` 在迁移中存在若干因仓颉语言限制导致编译错误的 API，这些 API 在 C++ GLM 中对 `bvec` 类型可正常编译，但在仓颉中因类型系统差异（`Bool` 不支持算术/减法运算）而在实例化时产生编译错误。以下集中列出所有受影响的 API 及其迁移替换策略：

| 受影响 API | C++ GLM 代码 | 仓颉编译错误原因 | 迁移替换策略 |
|-----------|-------------|---------------|------------|
| `equalEpsilon` | `equalEpsilon(bvec1, bvec1)` | `Bool` 不支持 `-` 运算符 | 替换为 `==`（Bool Vec 精确比较）或 `equalExact` |
| `increment()`/`decrement()` | `++bvec` / `--bvec` | `Bool` 不支持 `+`/`-` 运算符 | 替换为 `!bvec`（逻辑翻转）或移除自增/自减语义 |
| `-`（一元取反） | `-bvec` | `Bool` 不支持一元 `-` | 移除（Bool Vec 无取反语义）；若需逻辑翻转使用 `!` |
| `%`（取模） | `bvec % scalar` | `Bool` 不支持 `%` | 移除（Bool Vec 无取模语义） |
| `mod`（具名取模） | `mod(s, bvec)` / `bvec.mod(s)` | `Bool` 不支持取模 | 移除 |
| `<<`/`>>`（移位） | `bvec << scalar` | `Bool` 不支持移位 | 移除（Bool Vec 无移位语义） |

**迁移工作量评估**：低。Bool Vec 在实际 GLM 代码中的算术运算使用频率极低（`bvec` 主要用于逻辑比较和条件选择），受影响 API 出现处极少。迁移时按上表列出的替换策略逐处替换即可，约 0.1-0.2 人天。

**搜索规则**：在对 `bvec*` 类型变量的代码中搜索 `equalEpsilon`、`increment`、`decrement`、`%`、`mod` 引用，逐处替换为上表中的替代方案。

### 11.16 const/extend 不对称 API 审查工作量

§3.2 const 上下文 API 可用性速查表列出了 12 个因定义在 `extend` 块中而丢失 `const` 修饰符的 API。其中以下 11 个 API 在 const 上下文中需要替代方案——覆盖算术方向的 vec-op-scalar 扩展成员函数 5 个（`add`/`sub`/`mul`/`div`/`mod`）、布尔逻辑 2 个（`logicalAnd`/`logicalOr`）、递增递减 2 个（`increment`/`decrement`）、位运算 1 个（`bitwiseNot`）、精确相等比较 1 个（`equalExact`）。Vec1 广播运算符虽受同样限制，但其 const 替代方案已映射回包级独立函数或二元运算符，不单独计为独立审查项。

#### 受影响的 API 清单与审查方法

| 序号 | API | const 替代方案 | 审查关注点 |
|------|-----|--------------|-----------|
| 1 | `v.add(s)` | 改用 `add(s, v)`（包级独立函数，`const`）或 `v + s` | 检查调用处是否位于 const 函数体内；若是则需替换操作数顺序 |
| 2 | `v.sub(s)` | 改用 `sub(s, v)` 或 `v - s` | 同上 |
| 3 | `v.mul(s)` | 改用 `mul(s, v)` 或 `v * s` | 同上 |
| 4 | `v.div(s)` | 改用 `div(s, v)` 或 `v / s` | 同上 |
| 5 | `v.mod(s)` | 改用 `mod(s, v)`（`const`）或 `v % s` | 同上。注意 `v % s` 对浮点 `T` 在实例化处报错，`mod(s, v)` 无此限制 |
| 6 | `v.logicalAnd(other)` | 改用 `!(v.logicalOr(other))` 或组合表达式 | 需确认逻辑等价性 |
| 7 | `v.logicalOr(other)` | 同上 | 同上 |
| 8 | `v.increment()` | 改用 `add(T(1), v)`（包级独立函数，`const`） | 注意操作数顺序交换 |
| 9 | `v.decrement()` | 改用 `sub(T(1), v)`（包级独立函数，`const`） | 同上 |
| 10 | `v.bitwiseNot()` | 改用 `!v`（`!` 为可重载运算符） | 整数分量执行按位取反，`Bool` 分量执行逻辑否定 |
| 11 | `v.equalExact(other)` | 在 struct 体内自行定义 const 版本或改用包级独立函数 | 需评估编码阶段是否需要在 const 上下文中调用 |

#### 成本评估依据

| 成本项 | 乐观（人天） | 最可能（人天） | 悲观（人天） |
|-------|------------|-------------|------------|
| 识别代码中使用上述 API 的 const 上下文 | 0.1 | 0.2 | 0.3 |
| 逐处评估替代方案切换成本并实施替换 | 0.2 | 0.3 | 0.6 |
| const 替代方案正确性编译验证 | 0 | 0 | 0.1 |
| **合计** | **0.3** | **0.5** | **1.0** |

**与 §11.12 合计表的关联**：本成本项已在 §11.12 合计表中以行标签 B2 记录，行值对应上述三档评估。此项独立于其他迁移成本项——覆盖的 API 与 §11.1~§11.11 各项无重叠，成本可累加。

#### 与 equalEpsilon const 真空路径③的重叠处理说明

当 D29 回退触发且选择 equalEpsilon const 真空路径③（§4.5 ⚠ const 真空警示——调用方自行编写 const 内联比较表达式）时，路径③涉及的审查范围（在 const 函数体中识别浮点 Vec 容差比较需求并替换为内联 `abs(v1.x - v2.x) <= T(1e-6)` 等表达式）与本节 B2 审查（识别 const 上下文中 11 个 API 的使用并切换替代方案）**存在潜在重叠**——两者均需审查同一批 const 函数体中的浮点 Vec 比较表达式。

**合并执行策略**：若 D29 回退触发且选择路径③，将 B2 审查与路径③替换合并执行，避免重复审查同一批 const 函数体。具体操作：
1. 在 B2 审查的"识别 const 上下文"步骤中，同步标记 float Vec 的 `==`/`equalExact`/容差比较使用点
2. 一次性完成替代方案切换和容差比较内联替换
3. 合计工作量按 B2 审查成本的 1.5 倍估算（而非 B2 + 路径③成本累加），覆盖两项融合审查的额外复杂度

若 D29 回退但未选择路径③（即选择路径②——在 const 上下文中使用精确比较 `==`），则无重叠问题，B2 审查独立执行，路径③成本为零。

---

## 12. 实现验证与验收策略

### 12.1 验证层次

首轮实现完成后，从以下三个层次验证正确性：

#### 层次一：编译验证
- 每个 `.cj` 文件可独立通过 `cjc` 编译（包内依赖闭合）。
- `type_vecN.cj` 在 `T = Int32`、`Float32`、`Bool` 三种分量类型及 `Q = PackedHighp`、`PackedLowp` 两种精度策略下可实例化编译通过。
- `fwd.cj` 中全部 256 个别名编译后不产生重复定义错误。
- **`Display`/`ToString`/`Format` 未实现验证**：确认 Vec1~Vec4 类型上不存在 `Display`、`ToString`、`Format` 接口的实现声明。可通过在独立测试中尝试将 Vec 实例作为 `Display` 类型参数传递产生编译错误来验证。此验证确保编译器默认表示策略无二义性。
- 验证命令：`cjpm build` 无报错。

#### 层次二：构造与访问验证
- 每种 Vec 类型（Vec1~Vec4）每种构造方式（标量填充、逐分量、跨 Vec 转换、跨分量数组合）至少构造一个实例。
- 下标运算符正/边界测试：索引 0 到 N-1 返回正确分量；索引越界触发断言。
- 具名分量访问（`x`/`y`/`z`/`w`）返回值正确。
- `componentAt` const 访问：在 `const` 函数体内调用 `componentAt(i)` 验证正确性，与 `operator[]` 取值形式行为一致。
- **`fromBoolVec`/`fromBoolVecQ2` 构造验证**：对 Vec1~Vec4 各调用一次 `fromBoolVec` 和 `fromBoolVecQ2`，验证 `VecN<Bool, PackedHighp>` 到 `VecN<Int32, PackedHighp>` 的同 Q 转换结果正确性（`true`→`T(1)`，`false`→`T(0)`），以及跨 Q 转换 `fromBoolVecQ2` 的结果正确性。

#### 层次三：运算正确性验证
- **算术运算**：对 `Vec4<Int32>` 和 `Vec4<Float32>` 分别验证 `+`、`-`、`*`、`/`、`-`（一元）的正确性。验证 `Vec4<Int32>` 的 `%`。验证复合赋值（`+=`、`-=` 等）语义与二元运算符一致。
- **Vec1 广播运算**：对 Vec2/Vec3/Vec4 各验证 VecN-op-Vec1 方向（`vec2 + vec1` 等）和 Vec1-op-VecN 方向（`vec1 + vec2` 等）的算术与位广播运算符正确性；验证 VecN `+=` Vec1 复合赋值自动生成可用；验证 Vec1 `+=` VecN 因返回类型不匹配不自动生成；验证跨类型 Vec1 广播复合赋值不可用（产生编译错误）。
- **溢出验证**：验证 `@OverflowWrapping` 标注的二元算术运算在整数溢出时 wrapping 而非抛异常。构造 `Vec2<UInt8>(255, 128) + Vec2<UInt8>(1, 128)`，期望结果为 `(0, 0)`（wrapping）。
- **位运算**：对 `Vec4<Int32>` 验证 `&`、`|`、`^`、`<<`、`>>`。验证 `<<` 的 `@OverflowWrapping` 语义（`Vec2<UInt8>(1, 128) << 1` 期望 `(2, 0)`）。
- **`bitwiseNot()`/`increment()`/`decrement()`**：验证整数分量下的正确性。验证 `Vec4<Float32>.bitwiseNot()` 产生编译错误。
- **比较运算**：验证 `==` 在整数和浮点分量下的正确性（浮点容差比较）。验证 `!=` 为 `!(==)` 的等价性。
- **`equalEpsilon`**：按三种分量类型分别验证：
  - `Float32`/`Float64` — 编译通过，容差比较行为正确（构造微差分量，epsilon 范围内相等）
  - `Int32`/`Int64` — 编译通过，行为等价于精确比较（`-`/`abs` 对整数合法）
  - `Bool` — 实例化时产生编译错误（`-` 对 `Bool` 不可用）
  
  验证 `abs()` 在 `extend` 块中的可用性（与 §4.5 设计假设一致）。**交叉引用注解**：当 `epsilonOf<T>()` 的回退路径（§3.5 兼容性策略：移除 `Number<T>` 约束、内联固定容差 `T(1e-6)`）被触发后，`equalEpsilon` 的实现需同步调整——将 `epsilonOf<T>()` 引用替换为内联固定容差 `T(1e-6)`，与 `ComputeEqual.callConst` 的回退路径保持一致。此联动修改已在 §10 `equalEpsilon` 设计阶段验证依赖④中归档。
> **⚠ 路径 A/B 切换时的测试阈值联动注意事项**：当 `epsilonOf<T>()` 的兼容性策略在路径 A（保留 `epsilonOf<T>()`，返回 `T(1e-6)` 固定容差）和路径 B（完全移除 `epsilonOf<T>()`，内联固定容差）之间切换时，`equalEpsilon` 的测试用例中部分用例的预期结果需同步调整——路径 A 使用 `epsilonOf<T>()` 返回值（动态容差），路径 B 使用硬编码 `T(1e-6)`（固定容差），两种容差在极端值域下的行为可能不同。建议在路径切换后重新运行全部 `equalEpsilon` 测试用例以确认行为一致性。
- **`equalExact`**：验证浮点 Vec 上 `equalExact(Infinity)` 返回 `true`；`equalExact(NaN)` 返回 `false`；整数/Bool Vec 上 `equalExact` 行为与 `==` 等价（均走精确比较路径）；验证 `equalExact` 与 `==` 在容差路径下的行为差异——对有限值 `equalExact` 使用精确比较（可能因浮点舍入将微差视为不等）而 `==` 使用容差比较（在 epsilon 范围内视为相等）。**回退路径等价性测试**：手动修改 `==` 实现为精确比较后，验证 `==` 与 `equalExact` 对所有输入（含 Inf/NaN）下的输出一致。
- **布尔逻辑**：对 `Vec2<Bool>` 验证 `logicalAnd`、`logicalOr`、`!` 的正确性。
- **`fromBoolVec`/`fromBoolVecQ2` 正确性验证**：验证 `fromBoolVec` 和 `fromBoolVecQ2` 在 Vec1~Vec4 各分量数上的转换正确性；验证多精度变体（`PackedHighp`/`PackedMediump`/`PackedLowp`）均编译通过；验证跨 Q 转换 `fromBoolVecQ2` 在不同 Qualifier 组合下的正确性；验证返回值参与算术运算的正确性。

#### 层次四：异常场景与边界验证（补充）
- **零向量算术**：`Vec3<Int32>(0,0,0) + Vec3<Int32>(1,2,3)` 返回 `(1,2,3)`。`Vec4<Float32>(0,0,0,0) * Float32(5)` 返回 `(0,0,0,0)`。
- **除零行为**：整数 Vec 除以 0 抛 `ArithmeticException`。浮点 Vec 除以 0 返回 `±Inf` 分量（无异常）。
- **NaN/Infinity 传播**：构造包含 `Float32.NaN` 分量的 Vec，验证 `+` 运算中 NaN 传播。构造包含 `Float32.Infinity` 分量的 Vec，验证算术运算。
- **类型转换边界**：`Vec2<Int64>(Int64.Max, Int64.Max)` 转为 `Vec2<Int32>` 验证 wrapping 截断。`Vec2<Float64>(1.79e308, -1.79e308)` 转为 `Vec2<Float32>` 验证 ±Inf 传播。
- **Bool Vec 行为**：验证 `Vec2<Bool>` 的 `&`/`|`/`^`/`!` 运算正确性。验证 `Vec2<Bool> + Vec2<Bool>` 产生编译错误。

### 12.2 验收标准

对照 roadmap §4.4 验证标准摘要：

| 验收项 | 标准 | 验证方法 |
|--------|------|---------|
| 编译通过性 | 全量编译无语法/类型错误 | `cjpm build` |
| 构造完备性 | 支持 §4.1 约定的所有构造函数形态 | 层次二测试覆盖 |
| 运算等价性 | 基本算术/位运算结果与 C++ GLM 对应类型一致（在绕过了运算符重载差异的前提下） | 层次三测试 + 与 C++ 等效代码逐值比较 |
| 溢出行为 | `@OverflowWrapping` 标注的运算在整数溢出时 wrapping 而非抛异常 | 层次三溢出验证 |
| 边界行为 | §9 约定的零向量、除零、NaN/Infinity 传播、类型转换边界行为与约定一致 | 层次四异常场景测试 |
| 别名覆盖 | `fwd.cj` 中**256 个别名全量正确定义和使用**，无重复定义或缺失错误。此为首轮强制交付标准，不可降级 | `cjpm build` + 确认每个别名家族（16 家族）至少各验证一个分量数和一个精度变体的可实例化 |
| 别名对外可见性 | 从独立测试包中通过 `import glm.BVec2` 访问别名并实例化，验证编译通过。确保 `fwd.cj` 中所有 `type` 别名均使用 `public type` 修饰符 | 在独立测试包中编写 `import glm.BVec2; let v = BVec2(true, false);` 验证编译通过 |
| equalEpsilon 正确性 | `equalEpsilon` 在浮点 Vec 上编译通过且容差比较正确；在整数 Vec 上编译通过且行为等价于精确比较；在 Bool Vec 上实例化产生编译错误 | 层次三测试 + §10 `equalEpsilon` 设计阶段验证依赖项 |
| equalExact 正确性 | 浮点 Vec 上 `equalExact(Inf)` 返回 `true`；`equalExact(NaN)` 返回 `false`；整数 Vec 上与 `==` 行为等价 | 层次三测试 + 边界值验证 |
| public const init 外部可构造 | 从独立测试包中通过 `import glm.Vec2` 导入后，`Vec2<Float32, PackedHighp>(1.0f, 2.0f)` 构造可编译通过 | 在独立测试包中编写 `import glm.Vec2` 并执行构造验证 |
| componentAt const 访问正确性 | const 函数体内调用 `componentAt(i)` 返回值与相同索引的 `operator[]` 取值形式一致；越界时触发断言 | §12.1 层次二 `componentAt` 验证项通过 |
| 公共 API 导入 | 下游消费者通过 `import glm.Vec2` 等直接导入向量类型，无需引用 `glm.detail` 包路径 | 在独立测试包中编写 `import glm.*` 测试代码，确认 `Vec2<Float32, PackedHighp>` 可通过 `glm` 包直接使用且类型完整 |
| scalar-op-vec 方向函数端到端可访问性 | `scalar_vec_ops.cj` 中的 `add`/`sub`/`mul`/`div`/`mod` 函数（5 运算 × 4 Vec = 20 个）通过 `import glm.*` 路径可端到端访问和调用，无需直接依赖 `glm.detail` 包 | 在独立测试包中通过 `import glm.*` 编写测试：调用 `add(1.0f, vec2)`、`sub(1.0f, vec2)`、`mul(2.0f, vec3)`、`div(2.0f, vec4)`、`mod(3.0f, vec2)` 各一个实例，确认编译通过且结果正确性。**回退方案**：若 `import glm.*` 无法访问 scalar-op-vec 函数，检查 `lib.cj` 中 `public import glm.detail.{ add, sub, mul, div, mod }` 的正确性；若 `public import` 重导出机制不支持，改为在 `package glm` 中定义包装函数委托给 `glm.detail` 中的对应实现 |
| 公共 API 重导出 | `lib.cj` 中的 `public import` 覆盖所有公共 API 类型（Vec1~Vec4、Qualifier 及实现类型） | 审查 `lib.cj` 的 `public import` 列表覆盖 §3.1 和 §3.2 中定义的公开类型；确认 `glm.detail` 内部类型（shim、functor、compute_vector_decl）对下游不可见 |
| 跨类型操作限制 | 跨类型运算（如 `Vec2<Int32> + Vec2<Int16>`）产生编译错误 | 编译测试 |
| `<`/`<=`/`>`/`>=` 缺失确认 | 使用这些运算符的 Vec 表达式产生编译错误 | 编译测试 |
| Bool Vec 行为一致性 | `VecN<Bool>` 各运算的行为与 §3.2 约定一致 | 层次三布尔逻辑测试 + 编译测试验证算术/移位报错 |
| Qualifier 跨 Q 转换 | 不同 Qualifier 之间（如 `PackedHighp` ↔ `PackedLowp`）的 Vec 转换构造可编译通过与正确运行 | 编写 `Vec2<Float32, PackedHighp>` 跨 Q 转换为 `Vec2<Float32, PackedLowp>` 的测试代码，验证构造及后续运算正确性 |
| 哈希集合可用性 | 整数/Bool/浮点分量 Vec 均可正常用作 `HashSet`/`HashMap` 键 | 编译测试：`HashSet<Vec2<Int32, PackedHighp>>`、`HashSet<Vec2<Float32, PackedHighp>>`、`HashSet<Vec2<Bool, PackedHighp>>` 均通过编译 |
| Hashable 契约限制文档化 | 浮点 Vec 的 Hashable 契约限制（`hashCode()` 与容差 `==` 不一致）在文档中被标注 | 审查 §3.2 Hashable 实现策略段落，确认包含浮点 Vec 的限制说明文本 |
| Vec1 广播运算符正确性 | Vec1 广播运算符（VecN-op-Vec1 和 Vec1-op-VecN 两个方向）的算术与位运算正确性；复合赋值自动生成规则正确性 | 层次三 Vec1 广播运算测试覆盖：对 Vec2/Vec3/Vec4 各验证 VecN-op-Vec1 方向算术广播（5 运算符 × 3 VecN = 15 个）和位广播（5 运算符 × 3 VecN = 15 个）；对 Vec1 验证 Vec1-op-VecN 方向算术广播（5 运算符 × 3 VecN = 15 个）和位广播（5 运算符 × 3 VecN = 15 个）；验证 VecN `+=` Vec1 复合赋值自动生成可用，Vec1 `+=` VecN 不自动生成；验证跨类型 Vec1 广播复合赋值不可用 |
| equalEpsilon-epsilonOf 回退联动验收 | 当 `epsilonOf<T>()` 的兼容性回退策略被触发时，按 §3.5 约定的路径选择执行：**路径 A**——保留 `epsilonOf<T>()`（移除 `Number<T>` 约束，返回 `T(1e-6)`），`equalEpsilon` 引用不变；**路径 B**——完全移除 `epsilonOf<T>()`，`equalEpsilon` 将 `epsilonOf<T>()` 引用替换为内联固定容差 `T(1e-6)` | 编写原型测试模拟回退路径，验证 `equalEpsilon` 在回退路径下对 `Float32`/`Float64` Vec 的容差比较行为正确；确认回退路径的联动修改与 §3.5 约定的生命周期一致 |
| const init 泛型构造可用性 | 通过 `public const init` 可在独立包（非 `glm.detail` 包）中构造 Vec2~Vec4 实例，`const init` 在非 const 上下文中可作为逐分量运行时构造函数使用 | 在独立测试包中编写 `let v = Vec2<Float32, PackedHighp>(1.0f, 2.0f)`；同时在 `const` 上下文中测试 `const init` 编译通过性 |
| mod 扩展成员函数浮点路径不可用约束 | `v.mod(s)`（扩展成员函数）在浮点类型 `T`（`Float32`/`Float64`）上实例化时产生编译错误，浮点取模必须使用包级独立函数 `mod(s, v)` | 编译测试：`Vec2<Float32, PackedHighp>(1.0f, 2.0f).mod(3.0f)` 产生编译错误；`mod(3.0f, Vec2<Float32, PackedHighp>(1.0f, 2.0f))` 编译通过 |
| `fromBoolVec`/`fromBoolVecQ2` 正确性 | Vec1~Vec4 的包级独立工厂函数 `fromBoolVec` 和 `fromBoolVecQ2` 对所有数值类型（`Int32`/`Float32` 等）正确转换：布尔 `true`→`T(1)`、`false`→`T(0)`；多精度变体均编译通过；跨 Q 版本 `fromBoolVecQ2` 在 `PackedHighp`→`PackedLowp` 等组合下正确<br/><br/>**回退路径验收**：若 `fromBoolVecQ2` 编译器的返回值类型推断失败（验证项㉕失败），则采用回退路径——显式标注类型参数 `<T, Q>` 的版本（§4.8 代码模板）。验收条件为：显式标注 `<T, Q>` 后的 `Vec2<T, Q>(...)` 构造在 Vec1~Vec4 所有 4 个跨 Q 版本上均可正确编译，且运行时转换结果与同 Q 版本一致 | 层次二构造验证 + 层次三运算验证；对各分量数 Vec 至少验证一个数值目标类型和一个跨 Q 组合；若验证项㉕失败，补充回退路径验收——对 Vec1~Vec4 各编写一个显式标注 `<T, Q>` 的 `fromBoolVecQ2` 调用，确认编译通过且结果正确 |
| `equalEpsilon` D29 回退路径 const 真空验证 | 当 D29 回退触发时，在 const 上下文中验证浮点 Vec 的 `equalEpsilon` 不可用（因非 `const` 函数），确认 `==` 已降级为精确比较；若 const 上下文需要容差比较，确认 `equalEpsilon` 已从 `extend` 块移至 struct 体内作为 `const` 函数或调用方已使用替代比较方案 | 编写 const 泛型函数测试：在 const 函数中尝试调用浮点 Vec 的 `equalEpsilon`，验证编译产生"非 const 函数不可在 const 上下文中调用"错误；验证 `==` 在 const 上下文中可用且行为为精确比较 |
| `GLM_CONFIG_CLIP_CONTROL` 编码前一致性确认 | 已确认 roadmap §3A.1 与本文档 §7 D38 值一致（均为 `0x0A`），跨文件冲突已不存在 | 人工确认 roadmap §3A.1 与 §7 D38 记录值一致 |
| `Inf == Inf` 容差路径与 D29 验证结果的条件依赖合法性 | `Inf == Inf` 在 `==` 运算符中的行为取决于 D29 验证结果——若 D29 通过（容差路径启用），`Inf == Inf` 返回 `false`（已知局限性，需通过 `equalExact` 获取 IEEE 754 精确语义）；若 D29 回退（精确比较路径），`Inf == Inf` 返回 `true`（与 C++ GLM 和 IEEE 754 一致）。两种路径均为合法交付状态，验收标准须同时覆盖：① D29 通过时——确认 `Vec3<Float32>(Float32.Inf, 0, 0) == Vec3<Float32>(Float32.Inf, 0, 0)` 返回 `false`，`equalExact` 返回 `true`；② D29 回退时——确认 `==` 返回 `true`，行为与 `equalExact` 等价 | 编写两组条件测试：① 在设计阶段原型验证中确认容差路径下 `Inf == Inf` 返回 `false`；② 在 D29 回退场景中确认精确比较路径下 `Inf == Inf` 返回 `true`。两组测试互斥执行（取决于 D29 验证结果），验收时按实际验证结果确认对应行为 |
| API 映射完整性声明精确性确认（非阻塞） | §1 P37 状态描述精确声明附录 A 的验证覆盖范围为 4/11 个核心文件（type_vec{1,2,3,4}.hpp/.inl），其余 7 个核心文件以子范围粒度映射至 §8.2/§8.5，不做逐 API 级对照。此声明为设计文档准确性的非阻塞验收项——不作为编码启动的阻塞条件，但须在编码阶段首轮迭代中确认声明与实际一致 | 审查 §1 P37 状态描述与附录 A 验证范围声明的一致性 |
| 7 文件编码启动前快速扫描 | 编码启动前对 7 个未逐 API 对照的核心文件（setup.hpp、qualifier.hpp、compute_vector_relational.hpp、compute_vector_decl.hpp、_vectorize.hpp、fwd.hpp、shim 文件）做一次快速交叉引用扫描，确认无遗漏的移植依赖项 | 逐文件按风险等级（§1 P37 已标注）审查，确认每个文件的 API 映射状态与当前设计一致；若发现遗漏依赖，更新对应设计章节并记录于范围变更日志 |

### 12.3 编译器验证依赖→设计路径选择决策映射表

本表将各验证依赖项与 §2.1 编码前验证检查清单进行交叉引用，明确每项验证结果对设计路径选择的影响。编码阶段按此表执行：先验证 → 根据验证结果选择路径 → 按路径实施对应设计。§10 中的重复验证项均以 §2.1 为唯一权威出处，不再独立重复。

| 验证依赖 | §2.1 检查项 | 验证通过→选择路径 | 验证失败→回退路径 |
|---------|-----------|-----------------|----------------|
| `isIec559Of<T>()` — `T(0)` const 构造 + `is` 运算符 | 项①③ | 路径 A（项①③通过） | 回退路径：整体精确比较（项①③失败） |
| `abs()`/`epsilon()` const 兼容性 | 项③⑫ | 路径 A：保留容差路径（项③⑫通过） | 回退路径：局部回退，`equalEpsilon` 承载（项③⑫失败） |
| 编译期 `if` 分支抑制（依赖点 A~E） | 项④⑫ | 路径 A：维持双路径（项④⑫通过） | 回退路径：单路径，`mod` 拆分（项④⑫失败） |
| `@OverflowWrapping` 标注继承性 | 项⑤⑫ | 路径 A：二元运算符标注（项⑤⑫通过） | 回退路径：扩展成员函数标注（项⑤⑫失败） |
| 浮点 `mod` 恒等式正确性 | 项⑥ | 路径 A：双路径 mod（项⑥通过） | 回退路径：`modInt`/`modFloat` 拆分（项⑥失败） |
| Vec1 跨类型 fill-from-Vec1 重载冲突 | 项⑦⑳ | 路径 A：维持同类型版本（项⑦⑳通过） | 回退路径：移除跨类型版本（项⑦⑳失败） |
| Bool→Numeric 转换路径 B — `as` 方案可行性 | 项⑧ | 路径 B：`init<T2,Q2>` 内联运行时检测（项⑧通过） | 回退路径 A：`fromBoolVec`/`fromBoolVecQ2` 工厂函数（项⑧失败） |
| `@Derive[Hashable]` 约束检查策略 | 项㉑ | 路径 A：延迟检查，维持当前设计（项㉑通过） | 回退路径：添加 `where T <: Hashable` 或移除 `@Derive`（项㉑失败） |
| Vec4 构造函数重载解析 | 项⑬ | 路径 A：当前 30 个签名（项⑬通过） | 回退路径：移除 4-6 歧义分支改工厂函数（项⑬失败） |
| `const`+`@OverflowWrapping` 语法共存 | 项⑫ | 路径 A：保留 `const` 声明（项⑫通过） | 回退路径：降级非 `const`，保持标注（项⑫失败） |
| epsilonOf 兼容性策略 | 项⑲⑫ | 路径 A：移除 `Number<T>` 约束（分支抑制有效） | 路径 B：完全移除 epsilonOf，内联固定容差（分支抑制无效） |

**使用说明**：
1. 编码前按 §2.1 检查清单顺序逐项验证（建议优先验证项①③④⑤⑫）。
2. 每项验证完成后查阅本表确定路径选择。
3. 若验证通过，按"验证通过→选择路径"列实施；若失败，按"回退路径"列修改对应设计章节。
4. 回退联动修改注意事项已在 §2.1 对应验证项的"回退方案"列中标注，实施时以 §2.1 为准。
5. 回退修改完成后在 §12.2 验收标准中补充对应回退路径的验收项。

### 12.4 测试工具

首轮验证使用仓颉内置 `@Test`/`@TestCase` 框架（`std.unittest`），编写端到端验证函数覆盖 §12.1 的验证层次。

**测试包组织结构**：
- 测试包命名空间与源码包一一对应：`tests/glm/detail/` 目录下的测试对应 `package glm.detail`，`tests/glm/` 目录下的测试对应 `package glm`。
- **对 `internal` 类型的访问策略**：需要测试 `glm.detail` 中 `internal` 可见性类型（如 AlignedHighp/AlignedMediump/AlignedLowp）的测试代码，放置在 `tests/glm/detail/` 包中，并显式 `import glm.detail.*`。此策略的假设：Cangjie 的包可见性规则允许同一包内的跨文件访问 `internal` 成员，因此测试代码可访问 `glm.detail` 中的 `internal` 声明而无需将测试目标提升为 `public`。**此假设未经验证**——依赖 Cangjie 编译器对 `internal` 可见性跨文件解析的实现策略。编码阶段需编写原型测试验证：在 `tests/glm/detail/` 目录下创建测试文件（声明 `package glm.detail`），尝试实例化 `AlignedHighp` 类型。若编译通过，假设成立；若失败，则需将 AlignedHighp/AlignedMediump/AlignedLowp 的可见性从 `internal` 提升为 `public`（或 `protected`），并相应更新 `lib.cj` 的导出列表。
- **公共 API 测试**：只需访问 `glm` 包公共 API 的测试放置在 `tests/glm/` 包中，通过 `import glm.*` 导入，遵循普通下游消费者的访问路径。
- **测试文件组织**：每个 `type_vecN.cj` 对应一个 `test_type_vecN.cj` 测试文件；shim 层的测试集中在 `test_shims.cj` 中；别名验证测试放置在 `test_fwd.cj` 中。

#### `internal` 类型测试访问回退方案

**问题**：§2.1 编码前验证检查清单中原有的"测试文件访问 `internal` 类型"验证项仅记录了未能确认的假设，回退方案简化为"将可见性从 `internal` 提升为 `public`"，缺少影响范围评估和替代方案。

**首选方案**：在 `tests/glm/detail/` 目录下创建测试文件（声明 `package glm.detail`），通过同包访问规则直接实例化 `AlignedHighp` 等 `internal` 类型。此方案无需修改源码，保持 `AlignedHighp`/`AlignedMediump`/`AlignedLowp` 的 `internal` 可见性不变。

**回退方案层级**（按优先顺序）：

| 优先级 | 方案 | 变更范围 | 影响评估 |
|-------|------|---------|---------|
| **1st** | **同包测试直接访问**（当前首选方案）——在 `tests/glm/detail/` 目录下创建测试文件，声明 `package glm.detail`，直接实例化 `AlignedHighp` 等 `internal` 类型 | 无需修改生产源码。测试文件与生产包声明同一包名即可 | **无侵入**。需验证 `cjpm test` 编译时测试文件是否与生产包同模块处理。**前提条件**：`cjpm test` 将测试源文件视为与被测包同一编译单元处理，因此 `internal` 可见性在同包内跨文件可访问。编码阶段须验证此前提 |
| **2nd** | 将测试目标类型的可见性从 `internal` 提升为 **`protected`** | 仅修改 `qualifier.cj` 中 AlignedHighp/AlignedMediump/AlignedLowp 的可见性声明（`internal` → `protected`）；无需更新 `lib.cj` 导出列表 | **前提条件**：`protected` 在当前仓颉版本中仅允许同包和子包访问。但 **在 `cjpm test` 独立编译场景下，测试文件可能被视为独立模块**，此时 `protected` 不足以跨模块访问。编码阶段须验证测试包与生产包是否为同模块处理。若确认为同模块，此方案可行；若为不同模块，`protected` 不可用，应跳过此方案直接评估 3rd 方案。**影响**：不影响公共 API 面；仅包内和子包可访问 |
| **3rd** | 将测试目标类型的可见性提升为 **`public`** | 修改 `qualifier.cj` 中 AlignedHighp/AlignedMediump/AlignedLowp 的可见性声明（`internal` → `public`）；需同步更新 `lib.cj` 的 `public import` 列表，新增 Aligned 类型导出行；需在现有 §12.2 验收标准中新增"Aligned 类型不意外暴露"的反向验证项 | **影响最大**——将三组本不应在首轮暴露的对齐类型变为 `public`，可能被下游错误使用（虽然从类型系统层面 Qualifier 接口限制可减少误用，但不能完全消除） |
| **4th** | 创建测试 helper 文件，在 `glm.detail` 包内提供 `internal` 类型的测试访问包装函数 | 在 `glm.detail` 包中新增一个 `internal` 可见性的 helper 文件（如 `detail_test_helpers.cj`），定义返回 `AlignedHighp` 等类型的工厂函数（`package glm.detail`，`internal` 可见性）；测试文件同包调用这些工厂函数 | 不修改现有类型可见性；额外引入一个仅供测试使用的 helper 文件，需在 `cjpm.toml` 或构建脚本中确保 Release 构建排除该文件（避免生产二进制中包含测试辅助代码） |

**回退方案选择条件**：
1. **优先验证同包测试访问**（1st 方案）——在编码前验证阶段编写原型测试确认 `cjpm test` 是否将测试源文件与被测包视为同模块处理。若编译通过，此方案侵入性最低，无需修改任何生产代码。
2. **判断同模块性后选择 2nd 方案**——若 1st 方案因模块隔离失败，先判断测试包与生产包是否为同模块。若确认为同模块，`protected` 方案可行，评估后采用。若为不同模块，`protected` 不足以跨模块访问，直接跳过 2nd 方案评估 3rd 方案。
3. **3rd 方案（`public` 提升）**——评估是否接受 Aligned 类型在首轮暴露。若能接受，通过文档标注"首轮仅供内部测试使用，正常消费者应使用 Packed 系列和 Defaultp"。
4. **4th 方案（helper 文件）**——若 3rd 因范围评审拒绝，采用 helper 文件方案，需额外处理 Release 构建排除逻辑。

**验证时序**：此回退方案随 §2.1 编码前验证检查清单的补充验证项⑨一并执行（验证 `internal` 类型测试访问策略）。验证步骤：① 编写原型测试尝试以 `package glm.detail` 同包访问方式实例化 `AlignedHighp`；② 若编译失败 → 按回退方案层级逐级尝试 `protected` / `public` / helper 文件。

---

---

## 附录 A：API 覆盖对照表 — type_vec1.hpp/.inl ~ type_vec4.hpp/.inl 交叉验证

> **验证范围声明**：本附录的 API 逐项覆盖对照范围限定为 **type_vec{1,2,3,4}.hpp/.inl 四个 Vec 类型文件（即首轮 11 个核心文件中的 4/11）**。首轮 11 个核心文件中其余 7 个文件（`setup.hpp`、`qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`、`fwd.hpp` 及其 shim 依赖）以子范围粒度映射至 §8.2 范围可追溯性对照表，并在 §8.5 排除清单中逐项记录未覆盖设施的排除理由。本附录不做其余 7 个文件的逐 API 级对照——其余 7 个文件的逐 API 级对照规划在第 2 轮编码阶段以本附录为模板补充完成。

本附录对照 C++ GLM 1.0.3 参考实现中 `type_vec1.hpp`/`.inl`~`type_vec4.hpp`/`.inl` 的每个公开构造函数、运算符和成员函数，逐项确认其在仓颉设计 §4.1~§4.8 中的覆盖状态。未覆盖的 API 按处理策略分类（"已映射"、"因语言限制不可实现→纳入 §8.5"、"设计决策排除→纳入 §8.5"）。

### 验证范围说明

- **参考文件**：`references/glm-1.0.3/glm/glm/detail/type_vec{1,2,3,4}.hpp`（公开 API 声明）及对应的 `.inl` 文件（实现定义）
- **验证方法**：逐函数逐运算符对照，记录每项的映射状态。`.hpp` 声明的公开 API（如 `length()` 静态函数、构造函数声明等）与 `.inl` 中的实现定义均已覆盖
- **覆盖类别**：(✓) 已映射、(⚠) 部分映射（语义降级）、(✗) 未映射
- **范围边界**：本附录仅覆盖 Vec 类型文件的 API 级对照。其余 7 个首轮核心文件的映射状态以 §8.2 范围表 + §8.5 排除清单为准

### Vec1 (`type_vec1.inl`)

| C++ 成员/运算符 | 签名 | 覆盖状态 | 仓颉对应 | 备注 |
|---------------|------|---------|---------|------|
| 默认构造 | `vec1() = default` | ✓ | 仓颉无默认构造，由 `const init(x: T)` 覆盖 | §4.1 |
| 单标量构造 | `vec1(T scalar)` | ✓ | `const init(x: T)` | §4.1 |
| 跨类型单参数构造 | `template<A> vec1(A x)` | ✓ | `init<T2,Q2>(v: Vec1<T2,Q2>)` | 经 Vec 间接转换 |
| 完全泛型双参数构造 | `template<A,B> vec1(A _x, B _y)` | ✓ | 跨分量数构造已由跨 Vec 转换构造覆盖——`Vec2(Vec1<T,Q>(x), y)`（即 `init(a: Vec1<T2,Q2>, b: T)`） | C++ 中 Vec1 接受 2 参数实际是构造 Vec2 的语义，仓颉中已通过 Vec2 的 Vec1+标量组合构造函数覆盖，无需在 Vec1 上映射 |
| `operator=` | `vec1& operator=(vec1 const&)` | ✓ | 编译器自动生成 | 同类型赋值 |
| `operator++`/`--` | `vec1& operator++()` 等 | ✓ | `increment()`/`decrement()` 具名函数 | §4.3 |
| `operator+`/`-`/`*`/`/`/`%` | 各二元运算符 | ✓ | `@OverflowWrapping` 标注的 `operator func` | §4.3 |
| `operator==`/`!=` | 比较运算符 | ✓ | `const operator ==` / `!(a == b)` | §4.5 |
| `operator[]` | `T& operator[](size_type)` | ✓ | `operator []` + `componentAt` | §4.2 |

### Vec2 (`type_vec2.inl`)

| C++ 成员/运算符 | 签名 | 覆盖状态 | 仓颉对应 | 备注 |
|---------------|------|---------|---------|------|
| 默认构造 | `vec2() = default` | ✓ | 由 `init(scalar: T)` 标量填充替代 | §4.1 |
| 单标量构造 | `vec2(T scalar)` | ✓ | `init(scalar: T)` | §4.1 |
| 双标量构造 | `vec2(T x, T y)` | ✓ | `const init(x: T, y: T)` | §4.1 |
| 跨类型双参数构造 | `template<A,B> vec2(A _x, B _y)` | ✓ | 已由 `const init(x: T, y: T)` 覆盖——调用方先将异构参数统一为目标类型 `T` 后调用同类型构造函数 | C++ 该模式已由标量填充构造、逐分量 const init、跨 Vec 转换构造等已有构造函数形态覆盖，无需单独映射 |
| 跨类型单参数构造 | `template<A> vec2(vec2<A,P> const&)` | ✓ | `init<T2,Q2>(v: Vec2<T2,Q2>)` | §4.1 |
| `operator++`/`--` | 递增递减 | ✓ | `increment()`/`decrement()` | §4.3 |
| 所有二元算术运算符 | `op(vec2)` / `op(T)` | ✓ | `@OverflowWrapping` 运算符 | §4.3 |
| Vec1 广播运算符 | `op(vec1)` / `op vec1` | ✓ | extend 块中定义 | §4.3 Vec1 广播专节 |
| 位运算符 | `&` `|` `^` `<<` `>>` | ✓ | extend 块中定义 | §4.4 |
| `~`（按位取反） | `~vec2` | ✓ | `bitwiseNot()` 具名函数 | §4.4 |
| `operator==`/`!=` | 比较 | ✓ | 同 Vec1 | §4.5 |

### Vec3 (`type_vec3.inl`) — 模式与 Vec2 一致

覆盖状态与 Vec2 高度一致，构造函数体系覆盖 GLSL 5.4.1 定义的全部组合。以下仅列出差异项：

| C++ 成员/运算符 | 覆盖状态 | 备注 |
|---------------|---------|------|
| 跨类型完全泛型多元构造 `template<A,B,C> vec3(A,B,C)` | ✓ | 已由 `const init(x: T, y: T, z: T)` 覆盖——调用方先将异构参数统一为目标类型 `T` | C++ 该模式已由已有构造函数形态覆盖，无需单独映射 |
| `vec3(vec2, T)` / `vec3(T, vec2)` 组合构造 | ✓ | §4.1 Vec3 构造函数清单已覆盖 |
| `vec3(vec1, vec1, vec1)` 组合构造 | ✓ | §4.1 已覆盖 |
| 运算符模式 | ✓ | 与 Vec2 完全一致 |
| Vec1 广播运算符 | ✓ | 已在 §4.3 覆盖 |

### Vec4 (`type_vec4.inl`) — 模式与 Vec2 一致

| C++ 成员/运算符 | 覆盖状态 | 备注 |
|---------------|---------|------|
| 跨类型完全泛型多元构造 `template<A,B,C,D> vec4(A,B,C,D)` | ✓ | 已由 `const init(x: T, y: T, z: T, w: T)` 覆盖——调用方先将异构参数统一为目标类型 `T` | C++ 该模式已由已有构造函数形态覆盖，无需单独映射 |
| 所有组合构造（Vec3+T、Vec2+Vec2、Vec1 链式组合等） | ✓ | §4.1 Vec4 构造函数清单已全覆盖 |
| 运算符模式 | ✓ | 与 Vec2 完全一致 |
| Vec1 广播运算符 | ✓ | 已在 §4.3 覆盖 |

### 未覆盖 API 汇总

| C++ API | 对应 .inl 文件 | 覆盖说明 | 处理策略 |
|---------|--------------|-----------|---------|
| `template<A,B> vec1(A,B)` | type_vec1.inl | 跨分量数构造已由 Vec2 的 Vec1+标量组合构造函数覆盖 | 首轮已覆盖 |
| `template<A,B> vec2(A,B)` | type_vec2.inl | 各分量类型可独立推导的完全泛型多元构造函数与已有 `const init(x: T, y: T)` 在调用方传入同类型参数时产生重载歧义；C++ 该模式已由标量填充构造、逐分量 const init、跨 Vec 转换构造等已有形态覆盖 | 首轮已覆盖 |
| `template<A,B,C> vec3(A,B,C)` | type_vec3.inl | 同上 | 首轮已覆盖 |
| `template<A,B,C,D> vec4(A,B,C,D)` | type_vec4.inl | 同上 | 首轮已覆盖 |

**验证结论**：type_vec1.inl~type_vec4.inl 所有公开 API 均已覆盖。完全泛型多元构造函数的各分量类型可独立推导模式（如 C++ `template<A,B> vec2(A,B)` 允许 A≠B）在仓颉中无法直接映射——此泛型构造函数与已有 `const init(x: T, y: T)` 在调用方传入同类型参数时产生重载歧义，且各分量需通过 `T(v)` 转换为统一的目标类型 `T`。C++ 该模式已由标量填充构造、逐分量 const init、跨 Vec 转换构造等已有构造函数形态覆盖，无需单独映射。

---

## 修订说明（v2）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：初始产出已知遗留 4 个问题全部未解决** | ① §8.4/§7 D6 参考实现行号错误→移除 §8.4 中全部行号标注，仅保留文件名引用；② 编译器行为假设分散→新增 §7 D37 集中表格（19 项假设），按"假设描述→所在章节→编译器依赖行为→验证状态→回退方案"组织；③ 缺少首轮内容排除清单→新增 §8.5 结构化表格，列出 22 项排除设施及排除理由/计划轮次；④ 跨 Q 等价假设影响范围表缺失→新增 §3.1 下方表格，列出 6 类受影响场景 |
| **问题 2（中等）：版本标识不一致** | 标题从"（v30）"更新为"（v2）"，新增文件头部版本号/迭代轮次/日期/上一版本标注块 |
| **问题 3（中等）：未显式参考前两次再审议历史记录** | 在 §1 概述中新增"历史参考与已知问题追踪"子节，显式引用 202606170050 和 202606190029 两次历史记录，并附加循环问题状态追踪表（P1~P6） |
| **问题 4（中等）：§4.2 末尾断言说明与 §5.1 矛盾** | 将 §4.2 末尾独立"断言行为"段落精简为一句话"断言行为统一见 §5.1 下标越界策略"，以 §5.1 作为错误处理策略的唯一来源 |
| **问题 5（中等）：equalEpsilon 验收项中缺少对 Bool Vec 编译错误的明确标注** | 将 §12.1 层次三 equalEpsilon 验证项重构为三类分量分别列表（Float32/Float64→通过、Int32/Int64→通过、Bool→编译错误），使 Bool Vec 编译错误验证显式可见 |
| **问题 6（轻微）：别名生成脚本中 Qualifier import 冗余** | 从 §3.8 脚本模板的 `import` 列表中移除 `Qualifier`，仅保留 `{ Vec1, Vec2, Vec3, Vec4 }` 和 `{ PackedHighp, PackedMediump, PackedLowp }` |

## 修订说明（v3）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：§7 D6 中 `GLM_CONFIG_CLIP_CONTROL` 默认值推导措辞"已验证正确"超前于实际验证状态，位编号与位值表达存在歧义，与 roadmap 值 `0x02` 冲突未显式协调** | ①将"文档值 0x0A 已验证正确"措辞改为"文档值 0x0A 经参考实现条件编译逻辑推导，待编码前验证项②确认"，明确区分推导结论与已验证结论；②在推导说明处补充参考实现的位定义值（`RH_BIT = 1 << 3 = 8`，`NO_BIT = 1 << 1 = 2`），消除"位编号与位值"歧义；③在 §8.4 前置验证项①中明确"编码前必须读取 `setup.hpp:563-584` 的原始条件编译块，逐行确认分支走向与 `0x0A` 推导一致"；④将 roadmap 值 `0x02` 与文档值 `0x0A` 的关系从"文档已标注"升级为"构成需显式协调的跟踪项" |
| **问题 2（中等）：标量别名与向量别名的精度前缀命名风格不一致未做说明** | 在 §3.8 开头新增"标量与向量命名风格差异说明"段落，显式声明此不一致是有意保持 GLM 源兼容性（标量侧）与仓颉生态惯例（向量侧）的折衷结果，并在 §11.7 迁移映射表中补充风格差异提示 |
| **问题 3（中等）：`equalEpsilon` 对 `VecN<Bool, Q>` 的编译错误未在迁移成本中覆盖** | ①在 §4.5 equalEpsilon 段落后新增"Bool Vec 迁移指南"提示框，说明编译失败时应替换为 `==` 或 `logicalAnd`/`logicalOr` 等；②在 §11 新增 §11.15"Bool Vec 相关 API 迁移模式"子节，集中列出 6 类 Bool Vec 编译错误 API 及替换策略，含搜索规则和工作量评估（0.1-0.2 人天）；③在 §11.12 合计评估中纳入 §11.15 成本 |
| **问题 4（中等）：Vec4 构造函数重载解析验证覆盖范围不足** | ①将 §4.1 重载解析风险描述中补充"多元 Vec1 参数组合内部歧义"风险领域；②将 §10 Vec4 重载解析验证表从 3 项扩展：依赖②从"`Vec2 + 2 标量` vs `Vec2 + Vec1 + 标量`歧义"升级为"按参数数量分组的全扫描验证"；③新增"跨 Q 构造函数 Q2=Q 特化冲突"到依赖③中；④新增"系统性扫描策略"说明，要求编码后新增 Vec4 构造函数全量编译验证项 |
| **问题 5（中等）：§2 模块依赖图中 `type_vecN → scalar_vec_ops` 箭头方向与实际概念依赖相反** | 修正 §2 模块间依赖图：新增 `scalar_vec_ops → type_vecN` 箭头（scalar_vec_ops 中的函数使用 VecN<T, Q> 类型作为参数，概念上依赖 type_vecN），并在注释中澄清此依赖是概念性的（同包内无需显式 import，编译顺序不受影响） |
| **问题 6（轻微）：`fromBoolVecQ2` 函数命名中 `Q2` 含义不直观** | 在 §4.8 行为约定中新增 `Q2` 命名说明段落，解释 Q2 指代源 Bool Vec 的 Qualifier 类型参数（`fromBoolVecWithInputQualifier` 缩写），并提供替代命名建议和文档注释自解释方案 |
| **问题 7（轻微）：`cjpm.toml` 中 `cjc-version = "1.0.5"` 缺乏版本最低要求说明** | ①在 §2 项目初始化 cjpm.toml 配置后新增版本要求说明，声明该值为设计所依赖的编译器版本号，列出低于此版本时可能不可用的 4 项关键功能（const if 分支抑制、@OverflowWrapping 继承性、@Derive 自动派生、extend 泛型语法）；②在 §2.1 编码前验证检查清单新增第⑮项"编译器版本确认"验证 |

## 修订说明（v4）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：`const init` 与跨类型构造函数 `init<T2, Q2>` 共存性分析缺失** | ①在 §3.2 `const init` 段落后新增"const init 与非 const init 共存性分析"段落，将构造函数显式分为 (A) const init（逐分量同类型初始化）和 (B) 非 const init（跨类型转换）两类，论证两类参数列表类型结构显著不同（A 接收多个 T 标量参数，B 接收单个 VecN<T2,Q2> 聚合参数），不构成重载歧义；②分析 `T(v.x)` 类型构造表达式在 const init 上下文中的不可用性，明确 (B) 类必须声明为非 const init，与 (A) 类 const init 安全共存；③在 §4.1 构造函数清单中以 `// === const 构造函数 ===` 和 `// === 非 const 构造函数 ===` 分类标注；④在 §2.1 编码前验证清单新增项⑯确认共存安全性 |
| **问题 2（一般）：版本号标识混乱——文件声称 v3 但属于第 2 次迭代** | 文件头部将"文件版本：v3 / 迭代轮次：第 3 轮"替换为双维度标注："产出内部版本号：v4"和"外部再审议迭代轮次：第 2 次（第 3 轮设计迭代）"，明确区分两个维度。问题状态追踪表新增 P23 |
| **问题 3（严重）：`%` 运算符编译器行为假设未经验证** | ①在 §2.1 编码前验证清单新增项⑰：定义包含 `%` 运算符的泛型 struct，验证编译器在定义处还是实例化处报错；②在 §4.3 `%` 运算符段落新增"编译器行为依赖与条件性移动策略"，扩展 D13 决策空间为三种可能状态（保留在 struct 体内 / 移至 extend 块 / 完全移除）；③在 §7 D13 新增"编译器行为条件性移动策略"段落，按优先级排序三种迁移路径 |
| **问题 4（一般）：`lib.cj` 的 `public import` 重导出策略依赖编译器实测行为** | 在 §2.1 编码前验证清单新增项⑱：验证 `public import` 重导出后类型的可见性和名义路径，回退方案为改用 `public type` 类型别名替代 `public import` |
| **问题 5（严重）：路径 A 的 `epsilonOf<T>()` 对整数类型不可用** | ①在 §3.5 路径 A 描述后新增"⚠ 路径 A 整数可用性分析"段落，明确 `T(1e-6)` 对 `Int32` 等整数类型编译错误，分析该表达式仅出现在编译期 if 浮点分支中、安全性依赖分支抑制验证结果；②重新评估路径 A/B 排序——路径 A 不再无条件标为"推荐"，排序取决于编码前验证项⑲结果和编译期 if 分支抑制验证状态；③补充路径 B 对整数类型的可用性分析（`T(1e-6)` 在 `equalEpsilon` 非常量函数体内无分支抑制保护，整数 T 实例化编译失败）；④在 §2.1 新增验证项⑲确认编译器行为 |
| **问题 6（一般→轻微）：Gen 脚本 `uint` 别名硬编码方式不利于后续扩展** | ①将 §3.8 脚本模板中 `SCALAR_MAP` 字典新增 `'uint': 'UInt32'` 条目，使 `uint` 参与循环生成；②移除脚本 `gen_fwd` 函数中的硬编码 `lines.append(f'public type uint = UInt32')` 行，`uint` 别名随 SCALAR_MAP 循环自动生成 |
| **问题 7（轻微）：`scalar: T` 与 `init(v: Vec1<T, Q>)` 重载歧义未做显式分析** | 在 §2.1 编码前验证清单新增项⑳：验证 Vec2~Vec4 中 `init(scalar: T)` 和 `init(v: Vec1<T, Q>)` 共存时传入 `Vec1<T, Q>` 实例优先选择 fill-from-Vec1 版本，回退方案为 fill-from-Vec1 增加区分性命名参数 |
| **问题 8（一般）：`Inf == Inf` 容差路径行为差异的消解依赖 D29 验证结果，验收标准未反映** | 在 §12.2 验收标准新增"`Inf == Inf` 容差路径与 D29 验证结果的条件依赖合法性"验收项，声明 D29 通过/回退两种路径均为合法交付，分别定义验收条件 |
| **问题 9（严重）：`@Derive[Hashable]` 约束检查策略可能与仓颉文档不一致** | ①将 §3.2 Hashable 实现策略中"编译器要求所有实例化路径中 T 必须实现 Hashable 接口"的确定性措辞修改为"编译器对 T 的 Hashable 约束检查策略尚未确认"，区分延迟检查/定义处检查两种模式并分析各自影响；②将 §7 D37 A13 从"待验证（§2.1 项⑧） / 首轮目标类型均已实现 Hashable，无回退场景"更新为"**待验证**（§2.1 项㉑） / 若编译器在定义处要求 `T <: Hashable`，需在 Vec 定义中添加约束或移除 `@Derive[Hashable]`——此项与 D5 宽松约束策略可能直接矛盾"；③在 §2.1 新增验证项㉑，明确回退方案：若定义处检查，选择移除 `@Derive[Hashable]` 改手动实现或添加 `where T <: Hashable` 约束 |
| **问题 10（轻微）：目录结构树缩进错误** | 修正 §2 初始目录结构树中 `type_vec2.cj`~`type_vec4.cj` 的缩进，使 `type_vec1.cj`~`type_vec4.cj` 处于同一缩进层级 |

## 修订说明（v5）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：Vec 与 Vec1 之间的广播运算模式完全遗漏** | ①在 §4.3 新增"Vec1 广播运算模式"段落，设计 VecN op Vec1 方向广播运算符（通过 `extend` 块定义，5 算术运算 × 3 VecN = 15 个）和 Vec1 op VecN 方向广播运算符（在 Vec1 的 `extend` 块中定义，5 算术运算 × 3 VecN = 15 个）；②在 §4.4 新增 Vec1 广播位运算模式（5 位运算 × 3 VecN × 2 方向 = 30 个运算符），标注策略与已有位运算符一致；③在 §4.6 标注策略中补充广播运算符标注方案（extend 块中直接标注 `@OverflowWrapping`），更新总结中标注计数；④明确 VecN += Vec1 复合赋值由编译器自动生成，Vec1 += VecN 因返回类型不匹配不自动生成；⑤在 §8.1 文件清单中更新 `type_vec1.cj`~`type_vec4.cj` 说明列标注广播运算符；问题状态追踪表新增 P24 |
| **问题 2（严重）：`abs()` 调用形式在代码示例中与仓颉标准库 API 不匹配** | ①将 §7 D29 A03 描述从"Float32.abs()/Float64.abs() 静态方法"修正为"std.math.abs 包级函数"；②将 D29 依赖表中 `abs(x)` 行从"Float32.abs()/Float64.abs() 静态方法须为 const 函数"修正为"std.math.abs 包级函数须为 const 函数"；③在 §8.1 文件清单 `compute_vector_relational.cj` 的依赖列新增 `std.math（abs 包级函数）`，说明列标注 `import std.math.{ abs }` 依赖；④在 §3.5 和 §4.5 代码示例中补充 `abs → std.math.abs 包级函数` 的注释标注；⑤在 §2.1 新增验证项㉒：确认 `std.math.abs` 包级函数在 const 函数体内可调用；问题状态追踪表新增 P25 |
| **问题 3（严重）：跨类型复合赋值可用性损失未评估** | ①在 §4.3 复合赋值说明段新增"跨类型复合赋值不可用"显式声明，区分 (a) 同维度跨类型复合赋值和 (b) Vec1 广播复合赋值两个子场景，分别给出替代方案（先构造后赋值两步模式）；②在 §8.5 排除清单新增 5 个条目：跨类型复合赋值、跨类型 Vec1 广播复合赋值、Vec1 左操作数方向广播复合赋值、Bool→Numeric 隐式转换构造、Vec1 跨类型标量复合赋值，分别记录排除理由和替代方案；③在 §11 新增 §11.7b"跨类型复合赋值迁移模式"子节，包含受影响表达式模式表和迁移工作量评估（约 1.0-1.5 人天）；问题状态追踪表新增 P26 |
| **问题 4（一般）：Vec 别名同名自引用风险未闭环** | ①在 §2.1 新增验证项㉓：验证 `public type Vec2 = Vec2<Float32, PackedHighp>` 同名别名的编译器行为；②在 §3.8 新增"⚠ 同名别名自引用风险说明"脚注，分析同名原因、识别编译器行为不确定性、明确验证依赖和修正策略（若编译器报歧义则使用完整包路径 `glm.detail.Vec2`）；③问题状态追踪表新增 P27，标注"从第 1 轮遗留至第 3 轮，本轮闭环" |
| **问题 5（一般）：Vec1 运算符设计完整性未做独立分析** | ①在 §4.3 末尾新增"Vec1 运算符设计专节"子节，分析 Vec1 与标量 T 的语义重叠关系（类型不同/语义意图不同/Qualifier 传播），提供调用方选择指引表（4 场景×推荐使用×理由）；②评估 Vec1 在矩阵运算中的角色——Vec1 广播是矩阵运算核心模式之一，首轮提供广播运算符为矩阵迁移预留基础；③分析矩阵迁移连锁影响——若不提供 Vec1 广播运算符将增加矩阵轮次复杂度和迁移成本；问题状态追踪表新增 P28 |
| **问题 6（一般）：Bool→Numeric 降级未在排除清单/迁移成本中覆盖** | ①在 §8.5 排除清单新增"Bool→Numeric 隐式转换构造"条目，记录排除理由（仓颉 `Int32(Bool)` 不支持）和替代方案（`fromBoolVec`/`fromBoolVecQ2` 显式工厂函数），标注为"迁移但语义降级"设施；②在 §11 新增 §11.7c"Bool→Numeric 构造降级迁移模式"子节，包含受影响表达式模式表和迁移工作量评估（约 0.5 人天）；③问题状态追踪表新增 P29 |
| **问题 7（一般）：历史严重问题 P14/P15 修复状态需抽查确认** | 经独立抽查确认：(1) P14（const init 与跨类型 init<T2,Q2> 共存性分析缺失）——v4 版 §3.2 新增了完整的共存性分析段落和构造函数分类标注，§2.1 新增验证项⑯，修复有效；(2) P15（《%》运算符编译器行为假设未经验证）——v4 版 §4.3 新增了条件性移动策略段落，§2.1 新增验证项⑰，§7 D13 扩展为三种可能状态，修复有效。两项修复状态与设计文档声明一致。后续审查应在报告中体现抽查过程以增强可信度。问题状态追踪表新增 P30 |
| **问题 8（轻微）：Vec1 跨类型标量复合赋值特殊性未被覆盖** | ①在 §8.5 排除清单新增"Vec1 跨类型标量复合赋值"条目，记录 C++ GLM 中 `operator+=(U scalar)` 允许跨类型标量复合赋值而仓颉仅支持同类型；②在 §11.7b 跨类型复合赋值迁移模式中列为子场景一并评估（`vec1<T,Q> += scalar_of_T2` 替换为 `v1 = v1 + T(s2)` 两步模式）；问题状态追踪表新增 P31 |

## 修订说明（v6）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：C++ GLM `compute_equal` 行为一致性的系统性误述** | ①§3.5 新增"C++ GLM 行为偏离声明"段，阐明 C++ GLM 1.0.3 `compute_equal` 对所有类型使用精确 `a == b`（浮点特化被注释掉），容差路径为仓颉迁移引入的全量行为偏离；②§4.5 equalExact 定义说明补充全量行为偏离声明，注明 C++ GLM 使用精确 `==`，容差行为为迁移引入；③§9.3 Infinity 参与比较运算段将偏离范围从"Inf/NaN 边界"扩展为"所有浮点比较场景"，补充有限值微差场景的偏离说明；④§11.5 标题和范围从"Inf==Inf 差异"扩展为"浮点容差比较与 C++ GLM 精确比较的全量行为偏离"，更新受影响范围、迁移模式和搜索规则；⑤§11.9 工作量评估受影响范围从"约 20%（Inf/NaN）"修正为覆盖所有使用浮点 Vec `==` 的代码（约 40% 需替换），人工审查时间从 0.5-1 人天上调至 1.0-2.0 人天；同步更新 §11.12 合计表 |
| **问题 2（一般）：§4.6 `<<` 广播位运算符计数错误** | 将总结段落中"3 个 `<<` 广播"修正为"6 个 `<<` 广播（VecN`<<`Vec1 方向 3 个 + Vec1`<<`VecN 方向 3 个）"，同步修正合计值（18→21） |
| **问题 3（轻微）：§4.3 Vec1 广播运算模式复合赋值子段表述不精确** | 将"Vec1 广播复合赋值由编译器自动生成"精确化为"Vec1 广播复合赋值仅支持同类型 `T` 右操作数（`VecN<T,Q> += Vec1<T,Q>`），编译器自动生成；跨类型版本不可用，详见 §8.5 排除清单" |
| **问题 4（轻微）：§8.3 迁移顺序表阶段 3 并行标注不精确** | 在阶段 3 增量验证列补充"`compute_vector_relational.cj` 与 `vectorize.cj` 无相互编译依赖，可并行编译；`compute_vector_decl.cj` 依赖 `vectorize.cj`，须在阶段 4 编译" |
| **问题 5（一般）：机器 epsilon 容差值域局限性未声明** | ①§3.5 末尾新增"机器 epsilon 容差比较的值域局限性"说明段，声明 `NumericLimits<T>.epsilon()` 适用于接近 1.0 量级的比较，对大值和小值分别注明局限性，并注明此为仓颉迁移新增行为；②§9.3 `NumericLimits<T>.epsilon()` 行新增值域局限性交叉引用指向 §3.5 |

## 修订说明（v7）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：`type_vecN.cj` 缺失 `std.math.abs` 依赖标注** | 在 §8.1 第 9~12 行依赖列补充 `+ **std.math（abs 包级函数，用于 equalEpsilon）**`，说明列补充"编码阶段须在 `type_vecN.cj` 文件头部添加 `import std.math.{ abs }`" |
| **问题 2（严重）：`GLM_CONFIG_CLIP_CONTROL` 协调状态声明与 roadmap 实际内容矛盾** | ①将 §1 问题状态追踪表 P7 从"✅ 已解决（v7）"降级为"🔄 持续问题（本轮 v7）"，标注两文件未同步；②将 §7 D6 中的"已协调 roadmap 维护者将 §3A.1 默认值修正为 0x0A"修正为"编码阶段实施者须同步更新 roadmap §3A.1 默认值为 0x0A"；③已验证 0x0A 正确的结论保持不变 |
| **问题 3（一般）：`@OverflowWrapping` 标注策略总结段中广播运算符计数矛盾** | 将 §4.6 总结段中"实际需标注约 15 个算术广播"修正为"实际需标注 30 个算术广播（全部均在 extend 块中直接标注 @OverflowWrapping）"，同步修正合计值（21→36） |
| **问题 4（一般）：`<<` 溢出策略标注与编译器默认行为的依赖性缺乏针对性验证项** | 在 §2.1 编码前验证检查清单新增第㉔项"`<<` 运算符默认溢出策略验证"，验证方法覆盖三种整数类型对超出位宽左移的编译器默认行为 |
| **问题 5（一般）：附录 A API 覆盖对照表缺少对 `.hpp` 文件中声明的 API 验证** | 将附录 A 标题从"type_vec1.inl~type_vec4.inl 交叉验证"扩展为"type_vec1.hpp/.inl~type_vec4.hpp/.inl 交叉验证"；在验证范围说明中补充".hpp 声明的公开 API（如 `length()` 静态函数、构造函数声明等）与 .inl 中的实现定义均已覆盖" |
| **问题 6（一般）：`equalEpsilon` 双路径依赖链跨三处章节，编码阶段联动遗漏风险仍被低估** | 在 §12.3 决策映射表第 11 行（epsilonOf 兼容性策略）新增"修改触发联动检查清单"列，分别列出路径 A 和路径 B 触发时各需修改的文件列表：路径 A 修 1 处、路径 B 合计修 6 处 |
| **问题 7（轻微）：`fromBoolVec` 对 `Bool` 目标类型的语义描述不够精确** | 在 §4.8 `T` 参数类型范围说明段末尾补充"即此函数等价于恒等映射" |
| **问题 8（轻微）：外部再审议迭代轮次计数错位** | 将文件头部外部再审议迭代轮次从"第 4 次"修正为"第 6 次" |

## 修订说明（v8）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：`GLM_CONFIG_CLIP_CONTROL` 跨文件值协调已跨 5 轮迭代仍未闭环** | ①在 §1 P7 状态从"🔄 持续问题"升级为"⚠ 依赖项——需外部协调"，声明以本文档 `0x0A` 为准，roadmap 同步不阻塞本设计；②在 §7 末尾新增 D38 正式设计决策注释，包含默认值记录、参考实现验证过程、位组合推导过程和与 roadmap 冲突的协调声明 |
| **问题 2（严重）：验证清单在 §2.1、§10、§12.3 三处重复且组织方式不一致** | ①将 §10 各验证子节的"验证方法"列替换为"对应 §2.1 检查项"列，所有原型测试方法引用指向 §2.1；②去除 §10 中与 §2.1 重复的统一原型测试代码示例，替换为引用"详见 §2.1 项④⑫"；③§12.3 映射表标注"§10 中的重复验证项均以 §2.1 为唯一权威出处"，清理表中冗余章节引用。§10 保留行为描述和回退方案等设计特有内容，不重复验证方法细节 |
| **问题 3（一般）：P37 API 映射完整性声称"已处理"但验证范围仅限 Vec 类型文件** | ①更新 §1 P37 状态描述，精确标注当前验证范围为首轮 4 个 Vec 类型文件（type_vec1~4.inl），其余 7 个核心文件的 API 覆盖状态以 §8.2 范围表 + §8.5 排除清单为准；②在附录 A 开头新增"验证范围声明"提示框，明确限定验证范围为首轮 Vec 类型文件，其余 7 个文件不做逐 API 级对照 |
| **问题 4（一般）：验收标准中缺少 Vec1 广播运算符的独立验收项** | ①在 §12.1 层次三新增"Vec1 广播运算"测试说明，覆盖 VecN-op-Vec1 和 Vec1-op-VecN 两个方向的算术与位广播运算符正确性、复合赋值自动生成规则；②在 §12.2 新增"Vec1 广播运算符正确性"验收项，明确验证范围和方法 |
| **问题 5（一般）：scalar-op-vec 方向函数在 `import glm.*` 路径下的端到端可访问性未经验收** | 在 §12.2 新增"scalar-op-vec 方向函数端到端可访问性"验收项，要求在独立测试包中通过 `import glm.*` 调用各运算函数各一个实例，并标注回退方案 |
| **问题 6（轻微）：`fromBoolVec` 函数族泛型参数推导可能引入调用方歧义** | 在 §4.8 调用语法段落新增"类型参数显式指定说明"，分析推导歧义场景（返回值上下文不明确时），建议在公共代码中始终显式指定 `T`/`Q`，并预留辅助函数备选方案 |

## 修订说明（v9）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：§11.12 迁移成本合计表存在数学矛盾** | ① 将 §11.5 行的三档成本值从"0（回退路径下为 0）/0.5/1.0"修正为"0（已纳入 §11.9）/0（已纳入 §11.9）/0（已纳入 §11.9）"，使注脚声明与合计计算一致；② 同步修正合计行：最可能 12.65→12.15，悲观 23.5→22.5；③ 在注脚 `[^1]` 末尾补充"自 v9 起 §11.5 行三档成本均标记为'0（已纳入 §11.9）'，合计行已从合计值中剔除 §11.5 成本" |
| **问题 2（一般）：`fromBoolVecQ2` 的 Vec1 构造函数类型参数依赖编译器推断行为** | ① 在 §4.8 各 VecN 的 `fromBoolVecQ2` 函数代码示例末尾添加注释标注 `[^compiler-dep]`；② 在 §4.8 末尾"类型参数显式指定说明"之后新增 `[^compiler-dep]` 脚注说明段，标注"仓颉编译器是否支持从返回值类型推断 struct 泛型参数，编码阶段须验证"以及验证失败时的回退方案（显式标注类型参数） |
| **问题 3（一般）：`equalEpsilon` 的 Path A/Path B 决策依赖链仍未全量可视化** | 在 §12.3 第 11 行联动清单列中路径 A 的触发条件后补充验证检查项："→ 验证编译期 `if` 分支抑制保护有效（§2.1 项④⑫）→ 确认整数 `T` 不进入 `epsilonOf<T>()` 调用路径 → 若抑制保护无效，回退至路径 B" |
| **问题 4（轻微）：`fromBoolVec` 对 `T = Bool` 的语义描述措辞可能误导** | 将 §4.8 第 1198 行"即此函数等价于恒等映射"修改为"即此函数的值语义等价于恒等映射（分量值保持不变，但 Qualifier 类型可能变化）"，消除跨 Q 场景中"恒等映射"表述的歧义 |

## 修订说明（v10）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：`GLM_CONFIG_CLIP_CONTROL` 基础数据冲突历经 8 轮迭代仍未解决** | ① 将 §1 P7 状态从"⚠ 依赖项——需外部协调"升级为"🔴 跟踪项——需外部协调"，明确协调责任方为 roadmap 维护者、完成时限为编码启动前（首个 `cjpm build` 前）、失败升级路径为主 Agent → 项目负责人评审；② 新增可量化完成标准：roadmap §3A.1 默认值更新为 `0x0A` 且两文件值一致方可进入编码阶段；③ 在 §7 D38 末尾新增协调责任方和时限声明；④ 在 §12.2 新增验收项"GLM_CONFIG_CLIP_CONTROL 编码前一致性确认" |
| **问题 2（严重）：API 映射完整性验证范围被高估，P37 状态描述不准确** | ① 将 §1 P37 状态描述修正为精确的"4/11 文件（type_vec1~4.inl）已完成逐 API 级对照，其余 7 个文件（setup.hpp/qualifier.hpp/compute_vector_relational.hpp/compute_vector_decl.hpp/_vectorize.hpp/fwd.hpp/shim 文件）仅以子范围粒度映射至 §8.2/§8.5"；② 在 §1 P37 新增计划说明：其余 7 个文件的逐 API 级对照规划在第 2 轮编码阶段以本附录为模板补充完成；③ 在 §12.2 新增非阻塞性验收项"API 映射完整性声明精确性确认" |
| **问题 3（一般）：`%` 运算符条件性移动策略的验证依赖覆盖不完整** | ① 扩展 §2.1 项⑰：增加分支检查步骤——若定义处报错，进一步验证 `extend` 块中定义 `%` 运算符是否也报错（路径② vs 路径③区分条件）；② 在 §7 D13 的三种迁移路径描述中，明确标注路径②（移至 extend 块）与路径③（完全移除）之间的区分条件为：若 extend 块中 `%` 也在定义处报错则走路径③，否则走路径② |
| **问题 4（一般）：编译期 `if` 分支抑制的级联连锁风险被低估** | ① 修正 §11.13 叠加效应表中 D29 + 依赖③ 组合状态为"级联重叠——多项回退同时触发时，修复成本涉及比较语义、取模实现模式、泛型约束策略等多个独立维度，每维度各需独立修改，不可简单叠加但需逐维度评估"，重新估算最可能修复成本从 0（原标注"重叠—只计一次"）修正为 1.5 人天；② 在 §2.1 验证时序建议段落中，将原"建议优先执行第①项和第⑤项"扩展为"建议优先执行第①项和第⑤项，**同时优先执行第④项（编译期 if 分支抑制验证）**——此三项的验证结果决定 D29 和多项编译器依赖的走向" |
| **问题 5（一般）：验证检查清单的三处分布重叠未完全消解** | ① §10 的"equalEpsilon 设计阶段验证"子节中，将各验证项的"验证方法"列全部替换为"对应 §2.1 检查项"引用，仅保留设计特有内容（行为描述、回退方案、依赖关系、双路径策略的触发条件）；② 将 §12.3 决策映射表中各行的"修改触发联动检查清单"列内容作为额外注意事项合并至 §2.1 清单中对应验证项的回退方案列中（在第 11 行 epsilonOf 兼容性策略的 §2.1 检查项列标注"联动修改：路径 A 修 1 处/shim_limits.cj；路径 B 修 6 处/shim_limits+type_vec1~4+callConst"）；③ 在 §2.1 检查清单前新增"§2.1 维护原则"提示框，声明"本清单是验证任务的唯一权威出处。§10 仅保留设计特有行为描述和回退方案依赖关系；§12.3 仅保留验证→设计路径选择映射。所有原型测试方法和验证过程描述以 §2.1 为准。凡在此三章节间发现内容重叠，以 §2.1 为裁决依据，其余两处应同步消重" |

## 修订说明（v11）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：GLM_CONFIG_CLIP_CONTROL 冲突声明基于过时信息，P7 跟踪前提不成立** | ① 将 §1 P7 状态从"🔴 跟踪项——需外部协调"降级为"✅ 已解决（v11）— roadmap 已同步，默认值一致为 `0x0A`"；② 删除 §7 D38 中关于 roadmap 冲突的协调声明段落（冲突已不存在）；③ 将 §12.2 CLIP_CONTROL 验收项从"编码前一致性确认"降级为"已确认一致"；④ 全文搜索所有仍引用"roadmap 记录为 0x02"的措辞并同步修正为"一致性确认" |
| **问题 2（严重）：P37 API 映射覆盖度声明与设计完整性声称存在实质性差距** | ① 在 §1 P37 状态中补充每个文件的覆盖风险等级（setup.hpp→中、qualifier.hpp→中、其余 5 文件→低）；② 在 §12.2 新增"7 文件编码启动前快速扫描"验收项；③ 整体评估结论：无高等级风险文件，编码启动前做一次快速扫描即可 |
| **问题 3（严重）：编译器行为假设密度过高导致设计确定性不足** | ① 在 §2.1 验证表后新增"验证项影响范围分类"段落（高 4 项/中 9 项/低 11 项），标注每项失败时影响章节数；② 在 §11.13 新增"三重回退场景完整设计快照"（D29 + 依赖③ + D30 同时失败时的修订后设计状态表）；③ 在 §1 新增"设计确定性声明"框（X/Y/Z 三类编码路径量化说明）；④ 将验证项⑫（统一集成验证）的优先级提升至第二位（次于编译器版本确认），更新 §2.1 验证时序建议 |
| **问题 4（一般）：§11.12 迁移成本合计表乐观场景算术不一致** | ① 将乐观合计值从 **6.0** 修正为 **5.9** 人天（逐项累加确认）；② 同步修正说明行"乐观合计（~6 人天）"→"乐观合计（~5.9 人天）" |
| **问题 5（一般）：验证检查清单三处分布的消重未彻底完成** | ① 将 §10 mod 边界值验证表的"验证方法"列替换为"对应 §2.1 检查项"列（与 equalEpsilon 验证表一致的引用化改造）；② 将 §12.3 决策映射表中各行的"验证通过→选择路径"和"验证失败→回退路径"两列精简为仅列路径编号和 §2.1 项引用，移除冗余描述 |
| **问题 6（一般）：缺少面向编码实施者的集中式快速参考** | 在 §1 概述开头新增"编码实施快速参考"框，列出编码阶段最常查阅的 20 个定位章节及使用建议（按查阅频率排序） |
| **问题 7（轻微）：equalEpsilon 双路径联动的实际复杂度仍被低估** | ① 在 §4.5 const 真空的路径①声明中增加更强否定性标注，标注为"已废弃——仅作理论记录，不可实施"；② 在 §12.1 equalEpsilon 测试项下方增加脚注，说明路径 A/B 切换时应同步调整的测试阈值；③ 将 §11.14 中路径①的成本评估完全移除（不计入任何成本合计），更新推荐方案 |

## 修订说明（v13）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（轻微）：§1 设计确定性声明中"24 项验证"与"25 项验证"自相矛盾** | 将 §1 设计确定性声明框中的"24 项验证"修正为"25 项验证"，与表格和全表 25 项验证项数量一致 |
| **问题 2（严重）：附录 A 及 §8.5 中"构造函数不能为泛型"的排除理由存在事实错误** | 将 §8.5 排除清单中完全泛型多元构造函数的排除理由从"仓颉构造函数不能为泛型（运算符重载限制）"修正为"各分量类型可独立推导的完全泛型多元构造函数（如 C++ `template<A,B> vec2(A,B)` 允许 A≠B）在仓颉中无法直接映射——此泛型构造函数与已有 `const init(x: T, y: T)` 在调用方传入同类型参数时产生重载歧义，且各分量需通过 `T(v)` 转换为统一的目标类型 `T`。C++ 该模式已由标量填充构造、逐分量 const init、跨 Vec 转换构造等已有构造函数形态覆盖，无需单独映射"。同步修正附录 A 中 Vec1~Vec4 的对应条目和验证结论段落，将覆盖状态从"✗ 未映射"修正为"✓ 已覆盖"，处理策略从"纳入 §8.5 排除清单"修正为"首轮已覆盖" |
| **问题 3（严重）：§11.12 合计表引用了不存在的版本号和无对应章节的行标签** | (a) 将 B2 行说明中的"此项在 v24 中未纳入评估，v25 新增"修正为"此项在 v11 新增纳入评估"；(b) 在 §11 末尾新增 §11.16 子节"const/extend 不对称 API 审查工作量"，列出受影响的 11 个 API、审查方法及成本评估依据 |
| **问题 4（一般）：§2.1 验证时序建议与层级说明存在逻辑矛盾** | 统一采用路径 A：先执行①③④⑤⑧独立原型验证，再执行第⑫项统一集成验证（⑫失败以集成结果为准取代独立结论）。同步修正验证时序建议和层级说明，消除逻辑歧义 |
| **问题 5（轻微）：§5.1 整数溢出建议与 §11 迁移成本无交叉引用** | 在 §11.12 合计表 §11.6 行插入 `[^overflow]` 脚注标记，在说明段落末尾新增 `[^overflow]` 脚注："关于有符号整数 `@OverflowWrapping` 与 C++ UB 的迁移注意事项及逐处审查建议，详见 §5.1 整数溢出段落" |

## 修订说明（v14）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：7 个非 Vec 核心文件的 API 映射盲区未设明确闭环节点** | ① 在 §1 P37 状态描述中新增"快速扫描闭环节点"段落，包含扫描执行人（编码实施者）、通过标准（逐文件按风险等级确认映射状态一致）、超时升级路径（24 小时内未确认处理方案上报主 Agent + 设计审议）、闭环原则（发现≠解决，以编译验证为最终依据）；② 在 §8.3 迁移顺序表新增阶段 0"非 Vec 文件 API 快速扫描"作为阶段 1 的前置步骤，含执行人/通过标准/超时升级路径 |
| **问题 2（严重）：密集的编译器行为假设缺少置信度锚点** | ① 在 §1 设计确定性声明后新增"快速预筛步骤"子节，推荐优先执行 4 项最高诊断价值验证（编译器版本确认、首次原型验证、编译期 if 分支抑制验证、统一集成验证），含预筛通过标准；② 修正 Z 类别阈值：从 `①②③⑫⑮` 改为 `①③④⑫`（与 §2.1 影响范围分类保持一致），移除低影响项 ⑮，增加阈值选择理由说明；③ 在 §11.12 成本合计表中新增"置信度评估"列，逐项标注置信度等级及依据，合计行增加整体置信度评估 |
| **问题 3（一般）：Vec 运算符重复编码缺乏降本指引** | ① 在 §4.3 Vec2 运算符模板前新增"编码实现效率建议"提示框，推荐多光标编辑、代码片段模板和脚本生成三种降本策略，量化告知四个 Vec 类型合计约 280-320 个函数/运算符定义（约 2000+ 行手动编写）；② 在 §8.3 迁移顺序表中为每个阶段新增"预期代码量"列，阶段 5a/5b 标注 ~300 行/~250 行并引用 §4.3 效率提示 |
| **问题 4（一般）：P37 整体风险评级与后续轮次依赖关系存在隐性矛盾** | ① §1 P37 中"整体评估：无高等级风险文件"措辞修正为"快速扫描闭环节点"段落，明确评估为"按风险等级逐文件快速交叉引用确认"而非"结论已确认"；② 在 §8.3 依赖说明末尾新增"阶段 1 shim 文件 API 覆盖评估级别说明"，声明 shim 文件为依赖项级别而非逐 API 级别评估，与 §1 P37 中 setup.hpp/qualifier.hpp 标记为"中"风险等级一致 |
| **问题 5（轻微）：§1 确定性声明与 §2.1 验证项分类不完全一致** | ① 将 Z 类别阈值从 `①②③⑫⑮` 修正为 `①③④⑫`（与 §2.1 影响范围分类保持一致，高影响项 = ①③④⑫）；② 同步修正定量说明中的 `①②④⑫` 为 `①③④⑫`；③ 同步修正编码优先建议中的 `①④⑤⑫` 为 `①③④⑫`（高影响项优先）；④ 在 Z 阈值行补充理由说明：原阈值中的 ⑮（低影响项）从停工条件中移除，因其失败仅影响 0-1 个章节且有独立回退方案 |
| **问题 6（轻微）：`@OverflowWrapping` 对浮点类型的行为描述忽略编译期行为影响** | 在 §4.6 浮点类型无需标注段落后新增编译期行为影响脚注，说明标注可能影响编译器 NaN/Infinity 检测优化路径，给出两种可选的编译期优化路径（移除浮点标注改为条件性标注 / 保持统一标注），并建议在 §2.1 项⑤⑫验证时同步评估编译器行为 |

## 修订说明（v12）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（中等）：§3.2 const 上下文 API 可用性速查表的事实错误未被修复** | 将 `v.increment()` 行的 const 替代方案中 `v = v + T(1)` 或 `v = add(T(1), v)` 修正为仅保留 `add(T(1), v)`（包级独立函数，声明为 `const`）；同步修正 `v.decrement()` 行的 const 替代方案中 `v = v - T(1)` 或 `v = sub(T(1), v)` 为仅保留 `sub(T(1), v)`（包级独立函数，声明为 `const`） |
| **问题 2（严重）：§2.1 编码前验证清单中 `fromBoolVecQ2` 编译器推断依赖的验证缺口未闭环** | ① 在 §2.1 验证清单新增第㉕项，验证编译器是否支持从函数返回值类型推断 struct 构造函数的泛型参数，含具体原型测试方法和回退方案（显式标注 `<T, Q>` 后重写全部 4 个跨 Q 版本函数体）；② 在 §11.13 回退成本表中新增第⑩项 `fromBoolVecQ2` 编译器推断验证及回退成本行，更新合计值（验证成本 1.4 人天、回退成本 4.2 人天）和最优/最可能/最差路径估计；③ 在 §4.8 `[^compiler-dep]` 脚注中补充验证失败的完整函数体代码模板（Vec2/Vec4 的显式 `<T, Q>` 标注后完整函数体示例），说明需覆盖 Vec1~Vec4 全部 4 个跨 Q 版本 |
| **问题 3（轻微）：§10 验证表消重工作仍不彻底** | 将 §10 中所有非设计特有的结构化验证表替换为纯文本单行引用（`isIec559Of` 验证依赖表→"均由 §2.1 项①③㉒⑫覆盖"、编译期 `if` 依赖点清单表→"均由 §2.1 项④⑫①③⑥⑧覆盖"、mod 边界值表→"由 §2.1 项⑥覆盖"、浮点 `mod` 正确性表→"由 §2.1 项⑥⑫覆盖"、`equalEpsilon` 表→"由 §2.1 项㉒⑲覆盖"、`equalExact` 表→"随 §12.1 覆盖"、`@OverflowWrapping` 共存表→"由 §2.1 项⑫覆盖"、`@Derive[Hashable]` 表→"由 §2.1 项㉑覆盖"、Bool→Numeric 路径 B 表→"由 §2.1 项⑧覆盖"、Vec4 重载表→"由 §2.1 项⑬覆盖"、生成脚本表→"由 §2.1 项⑪覆盖"），同步清理依赖序号引用以消除跨章节同步成本；同步更新 §2.1 维护原则声明为"25 项" |

## 修订说明（v15）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）：§4.3 Vec2 算术运算符模板中标量右操作数 `%` 运算符代码实现错误** | 将 `this.y / rhs` 修正为 `this.y % rhs`。同步检查 Vec1/Vec3/Vec4 的 `%` 运算符模板——模板以 Vec2 为参考，其余 Vec 无此复制遗漏（Vec3/Vec4 在后续轮次实现时以本模板为准） |
| **问题 2（一般）：§3.2 const 上下文 API 可用性速查表中 `equalExact` 的 const 替代方案指引不准确** | 将"在 struct 体内自行定义 const 版本的 equalExact 或改用包级独立函数"修正为"在 struct 体内自行定义 const 版本的 `equalExact`（D33 备选方案）或手动编写精确内联比较表达式"，与 §4.5 描述一致 |
| **问题 3（轻微）：§1 版本谱系说明与修订说明存在断档** | 在版本谱系说明中补充"版本追溯路径从 v4 起始（v1-v3 已被 v4 重构合并，不再追溯）" |
| **问题 4（轻微）：§4.3 Vec2 算术运算符模板中 `%` 参数命名与类型存在易混淆问题** | 在模板注释中补充"注：`%` 仅对整数 `T` 可用，浮点 `T` 在实例化时产生编译错误（D5 延迟检查语义）" |

## 修订说明（v16）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（一般）：P37 非 Vec 文件快速扫描的执行责任归属存在缺口** | (1) 将扫描执行责任从"编码实施者"改为"设计审议方提供核查清单，编码实施者逐项确认"；(2) 在 §1 P37 下方新增完整"7 文件快速扫描依赖项核查清单"表格（每个文件 3~5 个核查要点）；(3) 同步更新 §8.3 阶段 0 的执行人描述 |
| **问题 2（轻微）：产出未显式涵括 docs/01_roadmap.md 中首轮范围的完整性断言** | 在 §1 范围可追溯性承诺段落末尾追加全量覆盖声明：明示本方案对 roadmap §3E/3G 定义的全部首轮子范围已逐项落实，无遗漏或未约定的范围缺口 |
| **问题 3（一般）：`<<` 默认溢出策略描述不一致** | 统一两处措辞——将 §4.6 `<<` 标注策略从"默认使用 `@OverflowThrowing` 策略"改为"默认溢出策略属于编译器实现定义行为，当前设计按 `@OverflowThrowing` 假设标注，编码前通过验证项㉔确认"，与 §4.4 描述一致 |
| **问题 4（轻微）：验证时序建议与快速预筛步骤中 mod 验证的排除未做说明** | 在 §1 快速预筛步骤的"预筛通过标准"段末尾追加说明语句：解释项⑥未纳入快速预筛步骤的原因（失败影响面有限，正式安排在 §2.1 验证时序的第(2)步），消除读者疑惑 |
| **问题 5（一般）：扩展成员函数的重导出可见性依赖未在验证清单中显式覆盖** | (1) 将 §2.1 验证项⑱扩展为含子步骤 (b) 的版本——新增扩展成员函数在 `public import` 重导出后可见性的验证；(2) 在 §7 D37 新增假设条目 A20，标注为"待验证（§2.1 项⑱ 子步骤 b）"，回退方案与基础重导出一致 |
| **问题 6（轻微）：mod 扩展成员函数浮点路径不可用的迁移替换成本未量化** | 在 §11 新增 §11.7d"mod 扩展成员函数浮点路径不可用的替换成本"子节，包含受影响表达式模式表和迁移工作量评估（约 0.2 人天），同步反映在 §11.12 合计表 |
| **问题 7（轻微）：equalEpsilon const 真空的三条缓解路径与 §11.16 B2 的审查范围存在潜在重叠** | 在 §11.16 末尾新增"与 equalEpsilon const 真空路径③的重叠处理说明"子段，定义合并执行策略：将 B2 审查与路径③替换合并执行，工作量按 B2 成本的 1.5 倍估算而非累加 |
| **问题 8（轻微）：验收标准中缺少 fromBoolVecQ2 回退路径的验证项** | 在 §12.2 `fromBoolVec`/`fromBoolVecQ2` 正确性验收项中补充回退路径验收条件——若验证项㉕失败（编译器不支持从返回值类型推断），则验收显式标注 `<T, Q>` 的版本可正确编译 |
