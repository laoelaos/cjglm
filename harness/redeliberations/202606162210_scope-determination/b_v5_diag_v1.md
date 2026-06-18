# 质量审查报告

审查文件：`a_v5_output_v1.md`
审查维度：需求响应充分度、整体深度和完整性、事实正确性

---

## 问题 1（中等）：`_vectorize.hpp` 中 C++ 模板模板参数（template template parameter）的 CangJie 迁移方案未被覆盖

**所在位置**：0.1 节泛型偏特化说明（`_vectorize.hpp` 偏特化说明段落）、3E 节文件清单第 5 行

**问题描述**：
`_vectorize.hpp` 中 `functor1`/`functor2`/`functor2_vec_sca`/`functor2_vec_int` 四个模板不仅仅使用 C++ 偏特化（partial specialization），还使用了**模板模板参数（template template parameter）** 模式——模板参数中包含 `template<length_t L, typename T, qualifier Q> class vec`。文档在 0.1 节建议的"分别定义独立结构体"方案无法直接应对模板模板参数：当 `Vec1<T,Q>`、`Vec2<T,Q>` 是四个独立泛型结构体而非一个统一的 `vec<N,T,Q>` 模板时，无法用单个 `functor1` 模板统一接收它们。文档未分析此差异对 `_vectorize.hpp` 迁移的影响。

**严重程度**：中等

**改进建议**：
在 0.1 节或 3A.4 节中补充分析：
(1) 明确指出 `_vectorize.hpp` 除偏特化外还使用模板模板参数；
(2) 给出应对策略，例如：为 `Vec1`~`Vec4` 分别定义 `functor1_vec1`、`functor1_vec2` 等独立结构体，或使用宏生成各分量数的 functor 版本；
(3) 评估该策略对首轮工作量的影响。

---

## 问题 2（中等）：`compute_vector_decl.hpp` 的 `std::size_t` 依赖在文件清单中遗漏

**所在位置**：3E 节文件清单第 4 行（第 299 行）

**问题描述**：
`compute_vector_decl.hpp` 在 16 处使用 `std::size_t` 作为模板参数（第 27、30、33、36、39、42、45、48、96、108、120、132、144、156、168、177 行），但文件清单的依赖列仅列出 `<functional>` 和 `<limits>`，未记录 `<cstddef>`（`std::size_t` 来源）依赖。虽然 `std::size_t` 在实际编译中可通过 `<functional>` 传递包含获得，但作为依赖审计应显式记录，尤其是 CangJie 迁移中需确定 `std::size_t` 的对应类型。

**严重程度**：中等

**改进建议**：
在 3E 节文件清单第 4 行依赖列补充 `+ <cstddef>`（`std::size_t`），并在 0.7 节 `<cstddef>` 行的用途列补充 `compute_vector_decl.hpp`。

---

## 问题 3（一般）：`compute_vector_relational.hpp` 的 `<limits>` 依赖描述存在误导——调用方代码活跃使用 `std::numeric_limits`

**所在位置**：第 1 节层次 1 描述（第 123 行）、3E 节文件清单第 3 行（第 298 行）、4.6 节子范围 2a 说明（第 528 行）、5 节依赖图图注

**问题描述**：
文档在多处将 `compute_vector_relational.hpp` 的 `<limits>` 依赖描述为"包含但活跃代码仅执行 `a == b`，未使用 `std::numeric_limits`"。经查阅源码确认，该文件自身的活跃代码确实仅执行 `a == b`（使用 `std::numeric_limits` 的偏特化版本被注释掉）。然而，**调用方代码**（`type_vec1.inl:533`、`type_vec2.inl:894-895`、`type_vec3.inl:808-810`、`compute_vector_decl.hpp:163`）在 `operator==` 和 `compute_vec_equal` 实现中均将 `std::numeric_limits<T>::is_iec559` 作为模板实参传递给 `compute_equal`。这意味着 `<limits>` 等效替代（`shim_limits.cj`）是首轮编译的实际硬性需求，但文档的表述可能使实现者误以为 `<limits>` shim 可以延迟提供或不是编译期必需。

**严重程度**：一般

**改进建议**：
(1) 将第 1 节中的"未使用 `std::numeric_limits`"改为类似"`compute_vector_relational.hpp` 自身活跃代码未使用，但其调用方 `type_vec1-4.inl` 和 `compute_vector_decl.hpp` 通过 `compute_equal` 模板实参活跃使用 `std::numeric_limits<T>::is_iec559`，因此 `<limits>` 等效替代是首轮编译的必要依赖"；
(2) 在 3E 节文件清单第 3 行（`compute_vector_relational.hpp`）和第 6-9 行（`type_vec1-4`）的依赖列中统一标注 `<limits>` 依赖。

---

## 问题 4（一般）：0.5 节固定位宽整数与 0.7 节缺失整数溢出处理策略的衔接

**所在位置**：0.5 节（第 48-64 行）、0.7 节末行（第 80 行）

**问题描述**：
0.7 节末行提到"CangJie 溢出检测并报错（运行时异常）"，并建议"使用 `std.overflow` 包的溢出控制策略包"。但 0.5 节的固定位宽整数映射表（`Int8`→`glm::int8` 等）没有提及整数溢出语义差异。C++ 中整数溢出是未定义行为（UB），而 CangJie 默认在溢出时抛异常，这是影响向量算术运算迁移实现的核心差异。文档未说明溢出处理策略的默认选择（是否全局启用 wrapping 模式）以及该选择对 `vec<N,T,Q>` 算术运算符实现的影响。

**严重程度**：一般

**改进建议**：
在 0.5 节末补充一行说明："首轮向量算术运算（`vec + vec`、`vec - vec` 等）中的整数运算需明确溢出处理策略——建议全局采用 wrapping 算术（与 C++ UB 行为对齐的不完全等价物），或使用 `std.overflow` 的显式策略控制"。也可在 0.8 节关键适应性结论表中增加一行"整数溢出语义差异"。

---

## 需求响应充分度评估

- **显式需求均已覆盖**：类型最基础性排序（第 2 节依赖分析）、首轮范围边界及依赖闭合性（第 3-4 节）、核心文件清单（3E 节）、类型数量（3D 节）、验证标准（4.4 节）、语言特性差异（第 0 节）——均已完整响应。
- **隐式需求（可直接投入使用）**：文件清单包含子范围编号和迁移顺序说明、验证标准附带可执行步骤和代码片段、命名空间/包映射已明确——基本达到可执行水平。
- **边界情况处理**：`_swizzle.hpp` 排除的方案分析（4.5 节）、首轮规模裁减的可选路径（3E 节末注）、`type_quat.hpp` 当前排除的理由（第 1 节层次 3 注）——均处理充分。

## 整体评价

文档经过 4 轮审查迭代后质量较高，结构性错误已基本消除。上述 4 个问题中，问题 1、2 属于事实遗漏（影响实现者的判断准确性），问题 3 属于描述不精确（不影响实际结论但可能误导），问题 4 属于深度不足（未连接两个相关结论）。建议修复者在下一版本中逐一处理。
