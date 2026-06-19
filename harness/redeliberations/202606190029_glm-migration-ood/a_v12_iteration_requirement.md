根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1（中等）— §4.3 残留导入路径错误
§4.3 "具名函数的定义位置与形态"子节中，`scalar-op-vec` 方向函数的导入方式仍表述为"通过 `import glm.detail.scalar_vec_ops.*` 或通过 `glm` 包统一引入"。`scalar_vec_ops.cj` 声明了 `package glm.detail`，其函数属于 `glm.detail` 包命名空间，正确的导入路径应为 `import glm.detail.{ add, sub, ... }` 或 `import glm.detail.*`。`glm.detail.scalar_vec_ops` 会被编译器解释为不存在的子包 `glm.detail.scalar_vec_ops`。

**改进建议**：将 `import glm.detail.scalar_vec_ops.*` 改为 `import glm.detail.{ add, sub, mul, div, mod }` 或 `import glm.detail.*`。同步全文搜索确认无其他残余的 `glm.detail.scalar_vec_ops` 路径引用。

### P2（中等）— 测试目录结构与仓颉包路径解析规则不匹配
§2 初始目录树形图（第 139 行）显示测试目录为 `tests/glm.detail/`（以英文句点分隔）。仓颉包声明规则要求目录路径匹配包名——`package glm.detail` 应映射到 `glm/detail/` 目录（以路径分隔符组织子目录），而非 `glm.detail/`（单目录名包含句点）。此外，§12.3（第 1714 行）同时引用了 `tests/glm.detail/` 和 `tests/glm/` 两个测试包路径，但目录树形图仅展示了 `tests/glm.detail/`，缺少 `tests/glm/`。

**改进建议**：
1. 将目录树形图和第 1714-1715 行中的 `tests/glm.detail/` 改为 `tests/glm/detail/`，使目录结构与 `package glm.detail` 的路径解析规则一致。
2. 在目录树形图中补充 `tests/glm/` 目录条目，使其与 §12.3 的文本描述一致。

### P3（一般）— §1 出现重复的 "### 设计目标" 标题
§1 概述中连续出现两个 `### 设计目标` 三级标题（第 9 行和第 13 行）。第一个标题后的内容（范围可追溯性说明）本应属于独立的子节或 §8 范围追溯的指引性声明，却被置于与第二个"设计目标"相同的标题层次下，造成结构歧义。

**改进建议**：
- 方案 A：将第一个标题改为 `### 范围可追溯性承诺`，与第二个"设计目标"区分。
- 方案 B：删除第一个 `### 设计目标` 标题，将"范围可追溯性"段落移入第二个"设计目标"段落后作为补充说明，或移入 §8 范围追溯章节。

### P4（一般）— §3.5/§3.6 残留 "`const if`" 术语未按 D34 修正
v11 P1 的修复承诺"全文将 `const if (...)` 改写为 `if (...)`"（文档摘要第 3 行、修订说明第 1886 行），并在 §7 新增 D34 设计决策记录此约定。但 §3.5（第 272 行）和 §3.6（第 339 行）仍存在 `const if` 的表述（`使用 const if 在编译期分支`、`函数体内使用 const if 配合 is 运算符`）。

**改进建议**：将上述两处 `const if` 改写为"`const` 函数中的 `if` 表达式"或"编译期 `if` 分支"，与 D34 的约定一致。

### P5（一般）— §2 模块间依赖表 scalar_vec_ops 的依赖描述不完整
§2 模块依赖图（第 92 行）声明 `scalar_vec_ops → qualifier（无包内其他依赖，仅使用 Qualifier 约束）`，但 `scalar_vec_ops.cj` 中定义的函数签名引用了 `VecN<T, Q>` 类型（如 `add(s: T, v: Vec2<T,Q>): Vec2<T,Q>`），在依赖拓扑上应依赖于 `type_vecN.cj`。虽然同一包内所有文件在编译时互见不影响编译，但依赖表描述的"无包内其他依赖"在语义上不准确。

**改进建议**：将依赖从 `scalar_vec_ops → qualifier` 修改为 `scalar_vec_ops → qualifier + type_vec1~4`，或在说明中补充"同包内函数签名引用 Vec 类型，但不构成独立编译依赖（Cangjie 包级编译模型自动包含同包所有定义）"的澄清。

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及）
- **轮次 10 P1：`const if` 为文档简写而非语法关键字** → 已通过 §7 D34 记录约定，将代码示例中的 `const if` 改写为 `if`。当前 P4 为残留遗漏（§3.5/§3.6 自然语言引用），范围更小。
- **轮次 10 P2：public import 命名冲突风险** → 已通过 §7 D35 命名空间占用声明解决。
- **轮次 10 P3：equalExact 迁移模式未覆盖** → 已在 v11 中新增 §11.9。
- **轮次 10 P4：references 前置验证缺失** → 已在 v11 中补充。
- **轮次 9 P1：lib.cj 错误导入路径** → 已在 v10 中修正。当前 P1 为 §4.3 中的残留遗漏。
- **轮次 9 P5：目录树形图重复 src/glm/ 条目** → 已修正。
- **轮次 8 P2：Vec1 构造函数不对称性** → 已补充说明。
- **轮次 5-7 的各类约束/const/extend 问题** → 已在之前轮次解决。

### 持续存在的问题
- **导入路径错误（往复出现）**：轮次 9 P1（lib.cj）→ 已修 → 当前 P1（§4.3 残留）。根因在于修复时未做全文 grep。本轮修复必须全文搜索所有 `glm.detail.scalar_vec_ops` 引用。
- **`const if` 术语残留（往复出现）**：轮次 10 P1 → D34 约定 → 当前 P4（§3.5/§3.6 自然语言残留）。根因在于修复时遗漏了非代码示例的段落。本轮修复需全文搜索 `const if`。

### 新发现的问题
- **P2（测试目录结构）**：本轮新识别，涉及仓颉包路径解析规则。
- **P3（重复标题）**：本轮新识别，属于结构清晰度问题。
- **P5（依赖描述不完整）**：本轮新识别，涉及模块依赖图的语义准确性。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606190029_glm-migration-ood\a_v11_copy_from_v10.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606190029_glm-migration-ood\requirement.md
