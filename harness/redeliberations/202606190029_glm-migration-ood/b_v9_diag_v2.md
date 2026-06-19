# 质量审查报告（v9 — 第2轮）

## 审查范围与视角

本文档是对 `a_v9_copy_from_v8.md`（v9）的质量审查。审查侧重内部审议（组件A）未充分覆盖的维度：**需求响应充分度、事实错误/逻辑矛盾、深度与完整性，以及实际落地可实施性**，避免重复验证内部审议已确认的技术可行性等维度。

本文档基于上一轮质询意见（`b_v9_challenge_v1.md`）的批评进行修正——侧重设计内容的实质性分析而非展示层瑕疵。

---

## 发现的问题

### P1（严重）— `lib.cj` 的 `public import` 路径错误，将导致编译失败

**问题描述**：`§2 公共 API 面设计` 中 `lib.cj` 的 `public import` 语句使用了错误的包路径：

```
public import glm.detail.scalar_vec_ops.{ add, sub, mul, div, mod }
```

`scalar_vec_ops.cj` 文件声明为 `package glm.detail`（§2 模块划分已明确），因此其导出的函数（`add`/`sub`/`mul`/`div`/`mod`）的包路径为 `glm.detail`，而非 `glm.detail.scalar_vec_ops`。Cangjie 中，`glm.detail.scalar_vec_ops` 表示一个名为 `scalar_vec_ops` 的子包，但该子包不存在——所有文件均属于 `package glm.detail`。

正确的导入语法应为 `public import glm.detail.{ add, sub, mul, div, mod }`。

此错误会导致 `lib.cj` 编译失败，直接阻塞编码启动。§2 完整导出行列表中的第4行需要修正。

**所在位置**：§2 "公共 API 面设计" 小节，`lib.cj` 代码块第4行（`public import glm.detail.scalar_vec_ops.{...}`）。

**严重程度**：严重

**改进建议**：将 `public import glm.detail.scalar_vec_ops.{ add, sub, mul, div, mod }` 改为 `public import glm.detail.{ add, sub, mul, div, mod }`。同时检查文档中其他引用 `glm.detail.scalar_vec_ops` 作为包路径的位置是否需要同步修正。

---

### P2（严重）— 对参考实现验证的声明存在事实错误

**问题描述**：`§7 D6` 的 `GLM_CONFIG_CLIP_CONTROL` 配置行声明"经与 GLM 1.0.3 参考实现 `setup.hpp` 中 `#define GLM_CONFIG_CLIP_CONTROL GLM_CLIP_CONTROL_DISABLE` 的定义链验证"。但经实际查阅 `references/glm-1.0.3/glm/glm/detail/setup.hpp`，该文件中**不存在** `GLM_CLIP_CONTROL_DISABLE` 这个宏定义（使用全局搜索确认，返回零匹配）。

参考实现中 `GLM_CONFIG_CLIP_CONTROL` 的实际默认值由两个条件编译层决定：

```
#ifdef GLM_FORCE_DEPTH_ZERO_TO_ONE
  #ifdef GLM_FORCE_LEFT_HANDED → LH_ZO (0x05)
  #else → RH_ZO (0x09)
#else
  #ifdef GLM_FORCE_LEFT_HANDED → LH_NO (0x06)
  #else → RH_NO (0x0A)    // 默认路径（无 GLM_FORCE_* 定义时）
#endif
```

设计文档采用的数值 `0x0A`（RH_NO）恰好与默认路径一致，但文档声称的验证路径（`GLM_CLIP_CONTROL_DISABLE`）是虚构的。此错误直接影响设计文档中所有"已验证"声明的可信度——如果此处验证声明是错的，其他声称"已验证"的设计决策也可能依赖了不存在或未查实的参考实现内容。

**所在位置**：§7 D6，`GLM_CONFIG_CLIP_CONTROL` 配置行（约第816行），**与 roadmap 差异说明**子句。

**严重程度**：严重

**改进建议**：
1. 删除关于 `GLM_CLIP_CONTROL_DISABLE` 的错误描述。
2. 将验证说明改为准确描述：`GLM_CONFIG_CLIP_CONTROL` 的默认值依赖平台检测宏（`GLM_FORCE_DEPTH_ZERO_TO_ONE`、`GLM_FORCE_LEFT_HANDED`），在无额外定义时等效于 RH_NO = 0x0A。首轮采用 RH_NO 作为默认值。
3. 修正 roadmap 的 `0x02` 标注——它确实是错误的值，但修正理由应以实际参考实现为准。

---

### P3（中等）— `equalExact` 在使用 `Inf == Inf` 时存在隐式比较路径依赖，但回退方案未定义可验证的测试标准

**问题描述**：`§9.3` 指出在 `==` 的容差路径下 `Inf == Inf` 返回 `false`，建议使用 `equalExact()` 作为替代。`equalExact` 定义为扩展成员函数（非 `const`），其内部实现为仓颉原生 `==`。但 `equalExact` 在验证计划（§12.1 层次三）中仅列出"浮点 Vec 上 `equalExact(Infinity)` 返回 `true`"作为测试项，没有覆盖以下关键场景的验证：

- `equalExact(NaN)` 返回 `false`（IEEE 754 标准，应验证）
- `equalExact` 在整数/Bool Vec 上是否与 `==` 行为完全一致（文档声称等价，但无测试覆盖 `Vec<Bool>` 的全 true/false 边界组合）
- 当 D29 回退触发时（`==` 退至精确比较），`equalExact` 行为与 `==` "完全等价"的断言是否被测试验证

特别是第三点：文档声明在回退路径下 `equalExact` 与 `==` 完全等价。但若回退路径触发，`==` 使用精确比较 `a == b`，而 `equalExact` 也使用精确比较。因此等价性成立。但文档将两者的等价性描述为"回退路径下的结果"，而未说明在容差路径下两者行为不同。这可能导致调用方错误地认为 `equalExact` 是与 `==` 等价的冗余函数。

**所在位置**：§4.5 `equalExact` 段落、§9.3 `Inf == Inf` 行为差异部分、§12.1 层次三测试列表。

**严重程度**：中等

**改进建议**：
1. 在 §12.1 层次三中补充 `equalExact` 的 NaN 边界测试项。
2. 在 §4.5 末尾显式声明：`equalExact` 在 `==` 的默认（容差）路径下与 `==` 行为不同（浮点精确比较 vs 容差比较），仅在 D29 回退路径下行为相等。避免调用方产生"两者等价"的误解。
3. 考虑将 `equalExact` 的 NaN 测试加入层次四异常场景验证。

---

### P4（中等）— 测试组织中的包可见性假设未被验证

**问题描述**：`§12.3 测试工具` 声称对 `internal` 类型（如 AlignedHighp 等）的测试可以通过将测试文件放置在 `tests/glm.detail/` 目录下并声明 `package glm.detail` 来实现，理由为"Cangjie 的包可见性规则允许同一包内的跨文件访问 `internal` 声明"。

此假设依赖以下未经验证的前提：
1. `tests/glm.detail/` 目录下的文件声明 `package glm.detail` 时，编译器的包解析逻辑能否正确将其识别为与 `src/glm/detail/` 中的文件属于同一个包——这取决于 `cjpm.toml` 的 `src-dir` 配置和编译器的包解析策略。
2. 若编译器按文件路径推断包名（而非仅依赖 `package` 声明），则测试文件无法声明 `package glm.detail`。

若此假设不成立，则 Aligned 类型的测试将不可行，除非将其可见性提升为 `public` 或改变测试策略（如通过 `glm.detail` 内部的间接访问器测试）。

**所在位置**：§12.3 "测试工具" 小节，"对 `internal` 类型的访问策略" 段落。

**严重程度**：中等

**改进建议**：
1. 在 §10 设计阶段验证要求中新增一项，验证测试文件能否通过声明 `package glm.detail` 访问同包的 `internal` 类型。
2. 定义备选方案：若验证不通过，将 Aligned 类型的可见性提升为 `public`，或在 `glm.detail` 包内提供测试用 helper 函数（仅用于测试的 `public` 访问器函数，通过注释标注"仅用于测试"）。

---

### P5（一般）— 文档树形图存在结构不可能性（前轮已报，第9轮仍未修复）

**问题描述**：`§2 项目初始化与构建基础设施` 中的初始目录树形图仍然显示两个同级的 `src/glm/` 条目：

```
├── src/
│   ├── glm/
│   │   ├── lib.cj
│   │   └── fwd.cj
│   └── glm/
│       └── detail/
```

这在任何文件系统中都是不可能的。上一轮审查报告（`b_v9_diag_v1.md` P1）已指出此问题，v9 修订说明中未见修复记录。

**所在位置**：§2 "项目初始化与构建基础设施" 子节，初始目录结构树形图。

**严重程度**：一般

**改进建议**：将目录树修正为正确的嵌套结构（`src/glm/` 同时包含 `lib.cj`、`fwd.cj` 和 `detail/` 子目录）。

---

### P6（一般）— `countof` 被标记为首轮偏离但未说明替代 API 的可用性

**问题描述**：`§8.2` 的 S3 行将 `countof` 标注为偏离，理由为"VArray 的 `$N` 必须为固定数值字面量不可声明为值泛型参数"。但 `countof` 的功能是计算 C 数组元素个数，在 GLM 中的使用场景是 `countof(m[i])` 计算矩阵列向量或行向量的元素数。

首轮迁移不包含矩阵类型，`countof` 确实不需要。但文档的偏离理由"VArray 的 `$N` 必须为固定字面量"所解释的不可映射原因与 `countof` 的实际功能无关——`countof` 不是计算 VArray 长度，而是计算 C 数组长度。该理由的准确性存疑。

**所在位置**：§8.2 范围可追溯性对照表 S3 行、§3.6 shim_cstddef.cj 描述。

**严重程度**：一般

**改进建议**：修正偏离理由——`countof` 在 C++ 中基于 `sizeof` 实现数组元素计数，Cangjie 中无 `sizeof` 等效设施且无原生数组类型（使用 VArray），因此无直接映射。`VArray<T, $N>` 的 `size` 属性可覆盖 `countof` 在数组元素计数场景中的角色。

---

## 整体质量评价

产出在技术深度和完备性上表现优异——覆盖了 34 个设计决策、全面的行为契约定义、系统的异常场景分析和渐进式验证计划。以上发现的 6 个问题中，P1（`public import` 路径错误）和 P2（参考实现验证声明错误）属于事实性错误，将直接影响实施的可信度和编译通过性，必须在编码启动前修正。其余问题属于深度和完备性方面的补充建议。

经过修正后，本文档可达到交付标准。建议优先处理 P1 和 P2 后再进入编码阶段。
