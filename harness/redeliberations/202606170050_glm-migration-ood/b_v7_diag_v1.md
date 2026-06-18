# 质量审查诊断报告 — v7

**审查对象**：`a_v7_design_v2.md`（GLM 1.0.3 仓颉迁移首轮 OOD 设计方案）
**审查视角**：落地可行性、需求响应充分度、事实正确性、深度与完整性
**当前迭代**：第 7 轮

---

## 问题 1（严重）— `bitwiseNot()` 对 `VecN<Bool, Q>` 的行为等价性声明存在事实错误

**所在位置**：§3.2（第 134 行）、§4.4（第 425-426 行）

**问题描述**：设计文档多处声明 `bitwiseNot()` 在 `VecN<Bool, Q>` 上使用 `!` 运算符"语义与 C++ GLM 的 `~bvec` 一致"。此声明与 C++ 实际行为不符。

在 C++ GLM 中，`operator~` 对 `bvec` 的每个分量执行 `~v[i]`。C++ `bool` 经整数提升为 `int` 后取反再转回 `bool`，因此 `~bvec(true, false)` 实际计算结果为 `bvec(true, true)`——**始终全为 `true`**。

在仓颉中，`!` 对 `Bool` 执行逻辑否定——`!true = false`，`!false = true`。因此 `bitwiseNot()` 对 `VecN<Bool, Q>` 的输出**恰好相反**。

两种行为完全不同："始终全 true"与"逐分量取反"不可混为一谈。若编码阶段按此文档描述使用 `!` 实现 `bitwiseNot()`，`VecN<Bool, Q>` 的迁移代码将产生与 C++ GLM 不一致的计算结果。

**改进建议**：选择以下方案之一修正：
1. 修正 `bitwiseNot()` 对 `VecN<Bool, Q>` 的实现——使其行为匹配 C++ `~bvec`（即每个分量始终返回 `true`）。但此方案使 `bitwiseNot()` 对于 Bool 类型无实际用途。
2. 保留 `!` 实现（逻辑否定），但在文档中明确标注此为**已知行为差异**，说明 C++ `~bvec` 因整数提升机制产生"始终 true"的行为在仓颉中没有等价物，`VecN<Bool, Q>` 的按位取反意义薄弱，采用逻辑否定替代。
3. 直接排除 `VecN<Bool, Q>` 的 `bitwiseNot()`（在实例化时报编译错误），与 `increment()`/`decrement()` 的处理方式一致。此举消除语义混淆，且 Bool 分量的按位取反在实际图形学应用中极少使用。

**验证依据**：`references/glm-1.0.3/glm/glm/detail/compute_vector_decl.hpp:178-186`（`compute_vec_bitwise_not` 实现为 `v[i] = ~v[i]`），C++ 标准 `[expr.unary.op]`（`~` 对 `bool` 执行整数提升）。

---

## 问题 2（严重）— `GLM_CONFIG_CLIP_CONTROL` 默认值 `0x02` 与 GLM 源码不一致

**所在位置**：§7 D6（第 560 行）

**问题描述**：设计文档声明 `GLM_CONFIG_CLIP_CONTROL` 的首轮推荐值为 `0x02（=GLM_CLIP_CONTROL_RH_NO）`。但根据 GLM 源码定义：

```
GLM_CLIP_CONTROL_ZO_BIT = (1 << 0) = 1
GLM_CLIP_CONTROL_NO_BIT = (1 << 1) = 2
GLM_CLIP_CONTROL_LH_BIT = (1 << 2) = 4
GLM_CLIP_CONTROL_RH_BIT = (1 << 3) = 8

GLM_CLIP_CONTROL_RH_NO = GLM_CLIP_CONTROL_RH_BIT | GLM_CLIP_CONTROL_NO_BIT = 8 | 2 = 10 = 0x0A
```

`0x02` 对应的是 `NO_BIT`（`NEGATIVE_ONE_TO_ONE`）单独取值，而非 `RH_NO`（`RIGHT_HANDED | NEGATIVE_ONE_TO_ONE`）。正确的 `RH_NO` 值为 `0x0A`。此错误若进入编码，将导致裁剪空间配置错误（丢失 `RH_BIT`，使坐标系约定变为非预期的组合）。

注意：此值与 roadmap `docs/01_roadmap.md:349` 中记载的值一致，说明该错误随 roadmap 传入设计文档。设计文档在 7 轮审查中未检出此误差。

**改进建议**：将 `GLM_CONFIG_CLIP_CONTROL` 的首轮推荐值从 `0x02` 修正为 `0x0A`（或十进制 `10`），并标注其语义为 `RH_BIT | NO_BIT`。

**验证依据**：`references/glm-1.0.3/glm/glm/detail/setup.hpp:563-571`。

---

## 问题 3（一般）— `isIec559Of<T>()` 的 const `is` 方案可行前提尚未验证

**所在位置**：§3.5（第 206-210 行）、§3.6（第 224-229 行）、§7 D19（第 659-663 行）

**问题描述**：设计主路径使用 `const if (T(0) is Float64 || T(0) is Float32 || T(0) is Float16)` 实现编译期类型判定。此方案依赖两个先决条件：① `T(0)` 在 const 上下文中对所有目标类型（含 `Bool`）合法；② `is` 运算符在 const 函数上下文中可参与编译期求值。条件②在仓颉语言规范中尚无明确表述（`is` 本质是运行时类型检查运算符，在 const 上下文中是否可按"编译期类型恒真/恒假"方式求值，需编译器行为验证）。

设计文档声明了备选路径（全部使用精确比较），因此此风险有缓解措施。但主路径方案的可行性作为设计核心假设之一，尚未在目标编译器上验证，编码阶段可能面临方案切换成本。

**改进建议**：建议在编码前优先编写 `isIec559Of<T>()` 的原型测试代码，在目标仓颉编译器上验证 const `is` 方案的可行性。若验证通过则沿用主路径；否则将备选路径提升为默认方案。此验证应纳入首轮编码实施计划的第一批任务。

---

## 整体质量评价

设计文档本身结构完整、覆盖全面，经过 7 轮迭代审查后，此前轮次指出的构造函数完整性、`@OverflowWrapping` 策略矛盾、缺失 `<`/`<=`/`>`/`>=` 覆盖、`countof` 方案不可行等严重/一般问题已得到妥善修复。当前遗留的问题主要为**事实正确性层面**——上述问题 1 和问题 2 均涉及对 C++ GLM 源码行为或常量值的引用不准确，可能直接导致编码后的程序行为与预期不符。建议修复人优先处理上述两个严重问题，并在问题 3 对应的 `isIec559Of<T>()` 原型验证完成后更新设计方案。
