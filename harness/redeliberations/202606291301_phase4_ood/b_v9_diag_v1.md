# 质量审查报告 — v9（第 9 轮）

**审查对象**：阶段四 OOD 设计方案 `a_v9_copy_from_v8.md`
**审查视角**：需求响应充分度、事实/逻辑一致性、深度与完整性（侧重落地编码维度）

---

## 问题清单

### P1（严重）— `ldexp` 的 Float16 回退描述与 D29 及 `pow` 设计自相矛盾

**所在位置**：§3.1 common.cj 职责第 249 行 vs. §3.1 exponential.cj pow 描述第 267 行 vs. D29 第 850 行

**问题描述**：
- 第 249 行 `ldexp` 实现路径中写："当 `T = Float16` 时依赖 `pow` 的 `exp(T(exp) * log(T(2)))` 回退路径"
- 但第 267 行 `pow` 的描述已改为通过 `stdmath_shim.cj` 的 `powT` 统一实现，"Float16/Float32/Float64 三种浮点类型经同一双向转型路径处理，**无需特殊回退分支**"
- D29（第 850 行）也明确记录："无特殊 Float16 回退分支"

此三处矛盾表明第 249 行的 ldexp 描述是 v7→v2 修订中未同步更新的过时文字残留。编码团队同时看到"无特殊回退"和"exp(b*log(a)) 回退"两种说法时将无法确定哪一个是权威描述。

**严重程度**：严重 — 正文与设计决策矛盾，编码阶段不可行动。

**改进建议**：将第 249 行 ldexp 的 Float16 回退描述替换为与 D29 一致的表述。建议为："所有浮点类型（Float16/Float32/Float64）均通过 `stdmath_shim.cj` 的 `powT` 包装函数统一实现，无需特殊回退分支。"

---

### P2（一般）— `ext/quaternion_transform.cj` rotate 的依赖关系与 GLM 事实不符，且遗漏 normalize axis 步骤

**所在位置**：§2 模块间依赖表第 189 行、§3.2 rotate 职责第 492-493 行

**问题描述**：
1. **依赖关系错误**：第 189 行列出的 `glm.ext.quaternion_geometric（cross）` 依赖在 GLM 1.0.3 的 rotate 实现中不存在。经查阅 GLM 1.0.3 `quaternion_transform.inl`（第 1-22 行），rotate 内部使用 `glm::length(Tmp)` 做轴向量归一化检查（`detail.geometric` 的 length），**完全不涉及 cross 函数**。§3.2 第 492-493 行的实现路径也确实只使用了 sin/cos，未使用 cross。

2. **遗漏 normalize axis 步骤**：GLM 1.0.3 rotate 的实现中（第 8-16 行），当轴向量长度偏离 1 超过 0.001 时做自动归一化。§3.2 第 492-493 行的描述直接使用 `axis.x / axis.y / axis.z`，未提及 normalize 步骤。若编码团队按此描述实现，对非单位轴向量的 rotate 行为将与 GLM 1.0.3 不一致。

**严重程度**：一般 — 依赖关系虽不影响编码流程（跨包 import 多余符号无害），但设计描述遗漏 normalize axis 是实际行为差异，且经过 8 轮审查均未被发现。

**改进建议**：
- 修正 §2 第 189 行依赖，删除 `glm.ext.quaternion_geometric（cross）`，改为 `glm.detail.geometric（length）`
- 在 §3.2 rotate 职责中补充 axis normalize 步骤：说明 rotate 内部应先计算 `axisLen = length(axis)`，若偏离 1 则对轴向量归一化，符合 GLM 1.0.3 的行为

---

### P3（一般）— `ext/scalar_common.cj` 的 `mirrorRepeat` 缺少具体实现公式

**所在位置**：§3.2 ext/scalar_common.cj 第 361 行

**问题描述**：mirrorRepeat 仅描述为"分片纹理循环"，未给出具体数学公式。其他三个纹理环绕函数（clamp、repeat、mirrorClamp）均在括号中标注了明确公式（如 `clamp(Texcoord, 0, 1)`、`fract(Texcoord)`、`fract(abs(Texcoord))`）。经查阅 GLM 1.0.3 `scalar_common.inl` 第 142-151 行，mirrorRepeat 的实际实现涉及 `abs` → `mod(floor(Abs), 2)` → `Rest = Abs - Floor` → `Mirror = Clamp + Rest` → `mix(Rest, 1-Rest, Mirror >= 1)` 的组合逻辑，并非简单公式可概括。"分片纹理循环"的描述不足以指导编码团队实现正确的行为。

**严重程度**：一般 — 单函数缺失公式，但函数本身逻辑较复杂（GLM 约 10 行），编码团队需要自行反向工程或查阅 GLM 源码。

**改进建议**：参照其他纹理环绕函数的格式，在括号中补充 mirrorRepeat 的实现公式，或直接给出代码级伪代码。例如："`Rest = Texcoord - floor(Texcoord); Mirror = mod(floor(abs(Texcoord)), 2); mix(Rest, 1-Rest, Mirror >= 1)`" 或注明"参考 GLM 1.0.3 `scalar_common.inl` 第 142-151 行"。

---

## 整体质量评价

经过 8 轮迭代审查，文档的整体质量已经很高。需求响应充分（架构/模块/接口/场景/集成全部覆盖），仓颉特性与限制的考量细致（H1-H6 确定性声明、stdmath_shim 模式、泛型→具体类型回退策略等均已记录）。

本轮发现的 3 个问题均为前序审查未覆盖到的细节死角：
- P1 是跨轮次修订遗留的文字同步问题
- P2 是 rotate 函数深层实现细节（normalize axis 步骤）在多次审查中未被对照 GLM 源码确认
- P3 是纹理函数中唯一缺少公式的个例

这 3 个问题修正后，文档应具备直接指导编码实施的成熟度。
