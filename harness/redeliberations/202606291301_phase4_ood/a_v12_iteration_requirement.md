根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

1. **（中等 — 事实错误）frexp 指数计算公式错误**：文档声明的 mantissa 范围为 `[0.5, 1)`，但给出的指数公式 `exponent = floor(log2(abs(x)))` 实际产生 mantissa 在 `[1, 2)` 范围，与声明自相矛盾。验证：以 x=8.0 验证 — `floor(log2(8)) = 3`，`mantissa = 8/2³ = 1.0`，不在 `[0.5, 1)` 内。正确的公式应为 `exponent = floor(log2(abs(x))) + 1`，此时 `mantissa = 8/2⁴ = 0.5 ∈ [0.5, 1)`。建议：将 `exponent = floor(log2(abs(x)))` 修正为 `exponent = floor(log2(abs(x))) + 1`。所在位置：§3.1 common.cj 职责，第 248 行。

2. **（中等 — 事实错误）ulp(x) 实现公式不适用于任意 x**：文档描述的 `ulp(x)` 公式为 `T.fromBits(T(1).toBits() - T(1))`，存在类型不匹配（`T(1).toBits()` 返回无符号整数，`T(1)` 为浮点数，两者不能直接相减），且仅计算 `ulp(1.0)` 常量而非与 x 的指数相关的 `ulp(x)`。对于 x ≠ 1.0，ULP 应为 `ulp(1.0) * 2^exponent(x)`。建议：将 `ulp(x)` 实现路径修正为基于 x 自身位模式的操作，如正数 `ulp(x) = T.fromBits(x.toBits() + 1u) - x`（等价于 `next_float(x) - x`），或使用 `next_float`/`prev_float` 推导。所在位置：§3.3 gtc/ulp.cj 实现路径，第 684 行。

3. **（轻微 — 边缘场景遗漏）uround 负数输入行为与 GLM 不一致**：文档声称 `iround`/`uround` 的实现"与 GLM 行为一致"，但未验证 `UInt64(negative_rounded_value)` 在仓颉中的行为。仓颉默认溢出策略为 `@OverflowThrowing`，浮点到无符号整数的转换在值为负数时抛出 `ArithmeticException`，而 GLM C++ 的 `unsigned int(round(x))` 对负数采取模运算回绕。建议：在 §3.2 ext/scalar_common.cj 或 D24 中补充 `uround` 负数输入的行为声明，明确选型。所在位置：§3.2 ext/scalar_common.cj，第 362–368 行。

4. **（轻微 — 完整性遗漏）ext/quaternion_trigonometric.cj 未出现在 §2 依赖表中**：`ext/quaternion_trigonometric.cj`（angle/angleAxis 补齐）已在 §2 包组织（第 128 行）和 §3.2（第 497–504 行）中描述，但在 glm.ext 依赖表中缺少对应条目。根据 §3.2 的描述，其依赖关系为 `glm.detail.trigonometric（acos/sin/cos）+ glm.detail.common（clamp）`。建议：在 §2 glm.ext 依赖表中补充条目。所在位置：§2 模块间依赖，glm.ext 依赖清单，第 181–189 行。

## 历史迭代回顾

- **已解决的问题**（出现在历史反馈但当前反馈中不再提及的问题）：
  - 第1轮：stub 替换范围矛盾声明、acos 输入 clamp 冲突、type_precision 未定义、Common<T> 虚构约束、T(0)/T(1) 字面量统一、mod 约束不一致、geometric 约束收紧
  - 第2轮：inversesqrt 零值行为、Vec1 normalize 语义、trigonometric 协作关系错误、lib.cj 命名冲突、common.cj 导出、random 状态管理、noise 排列表、inverse 实现策略、quaternion_trigonometric 纳入范围
  - 第3轮：Vec1 normalize 全局同步、inversesqrt(0) 验证与 H4 声明、跨包重载解析验证、packing 完整签名、random ThreadLocal 方案、ext 矩阵函数清单
  - 第4轮：modf/frexp/ldexp 签名设计、奇异矩阵求逆行为统一、mod 约束事实错误修正、trigonometric 依赖 scalar_constants、random 种子初始化增强、ulp 改为具体类型重载
  - 第5轮：scalar_common 重新编写、vector_common 完整清单、ortho 计数修正、gtc 函数总数同步
  - 第6轮：geometric/determinant/inverse 导出、projection 计数修正、Vec1 normalize 补充、scalar/vector_common 导出、slerp 阈值定义、mod 浮点重载策略
  - 第7轮：lib.cj 冲突（部分）、frexp 边缘场景策略、quaternion_common 依赖遗漏、noise 完整签名、stdmath_shim Float16 差异记录
  - 第8轮：frexp 零值/NaN/Inf 前置检查策略、mod 浮点重载升级为推荐实现
  - 第9轮：ldexp Float16 回退描述统一、rotate 依赖关系修正、mirrorRepeat 公式补充
  - 第10轮：noise 导出函数名修正、packing 导出补充、round 导出补充、type_precision 导出补充、gtc 委托声明修正、geometric sqrt 依赖描述修正
  - 上述第4轮 ulp 泛型不可编码问题（已通过改为具体类型重载解决）与第11轮 ulp 公式本身错误属于不同问题层面

- **持续存在的问题**（需重点解决）：
  - **frexp 实现正确性**：第7-8轮关注边缘场景缺失（已解决），第11轮发现指数计算公式本身错误（`floor(log2(abs(x)))` 应加 1），问题未彻底解决
  - **ulp 实现正确性**：第4轮关注泛型不可编码（已解决），第11轮发现公式推导本身错误（类型不匹配、忽略 x 指数），属于新的问题层面
  - **uround 负数输入行为**：第8轮关注负数输入偏离 GLM（仅行内注释记录），第11轮提供更完整的仓颉文档证据确认默认溢出策略，需明确选型
  - **依赖表完整性**：第4/7/8轮曾分别遗漏 scalar_constants/common 等依赖条目，第11轮遗漏 quaternion_trigonometric，需系统性检查避免重复遗漏

- **新发现的问题**：
  - 发现4：ext/quaternion_trigonometric.cj 依赖表条目缺失（此前轮次未发现该文件在依赖表中的缺失）

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v11_copy_from_v10.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
