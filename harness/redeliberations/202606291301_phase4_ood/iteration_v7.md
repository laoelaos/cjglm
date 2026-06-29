# 再审议判定报告（v7）

## 判定结果

RETRY

## 判定理由

诊断报告共发现 6 个问题：P1（严重）lib.cj 增量更新与现有 gtc 导入形成命名冲突，P2（严重）frexp 缺乏可行实现路径，P3（一般）依赖关系表遗漏 glm.detail.common，P4（一般）gtc/noise.cj 函数签名未定义，P5（一般）stdmath_shim.cj 的 Float64→Float16 转型可能运行时崩溃，P6（轻微）isnan/isinf 描述矛盾。质询结果为 LOCATED，确认所有问题有效。实际轮次（1）未达到最大轮次（12），但问题本身已确认存在。因包含严重和一般等级问题，不符合 PASS 条件，需重新运行组件 A。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：lib.cj 增量更新与现有 gtc 导入在 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 上形成命名冲突，编译存在风险
- **所在位置**：§8 lib.cj 更新（第 909–910 行）、现有 lib.cj 第 23 行
- **严重程度**：严重
- **改进建议**：明确选型——方案A：gtc 层使用转发函数，lib.cj 中删除对应符号的 gtc import（修改现有行），改为从 ext 统一导入；方案B：gtc 层使用 public import 重导出，lib.cj 只从 gtc 导入，删除 ext 重复行；方案C：验证 CangJie 是否允许同函数双路径 public import，若通过则在注释中记录验证结果

- **问题描述**：frexp<T>(x: T): (T, Int64) where T <: FloatingPoint<T> 未提供可行的实现策略，FloatingPoint<T> 不提供 toBits()/fromBits()，数学分解方案在零值/denormal/NaN/Inf 场景失效
- **所在位置**：§3.1 common.cj 职责（第 248–249 行）
- **严重程度**：严重
- **改进建议**：补充 frexp 的实现策略——对输入 x 做零值/Inf/NaN 前置检查，对合法值使用 log2 + pow 数学分解，或在 stdmath_shim.cj 中为 Float32/Float64 各提供基于 toBits() 的具体类型实现，标量版本直接委托 shim

- **问题描述**：ext/quaternion_common.cj 的依赖关系列出了 glm.detail.trigonometric + glm.detail.geometric + ext/scalar_constants，但遗漏了 glm.detail.common（mix 和 slerp 均依赖 common.cj 的 clamp）
- **所在位置**：§2 模块间依赖表（第 187–188 行）
- **严重程度**：一般
- **改进建议**：在第 187 行依赖链中补充 glm.detail.common

- **问题描述**：gtc/noise.cj 仅描述了 perlin 和 simplex 噪声的维度范围，未给出任何一个函数的具体仓颉签名（参数类型、返回类型、约束），编码团队无法实现
- **所在位置**：§3.3 gtc/noise.cj（第 611–615 行）
- **严重程度**：一般
- **改进建议**：补充至少每个函数的完整签名，格式参考 packing.cj 的代码块样式；GLM 1.0.3 中 Perlin 噪声返回 T（1D/2D/3D/4D 输入各返回标量 T），Simplex 噪声返回 Vec<T, Q>（各维度返回对应维度向量，1D 特殊返回标量 T）

- **问题描述**：stdmath_shim.cj 的通用模式 (result as T).getOrThrow() 在 T = Float16 且计算中间值超过 ±65504 时抛出异常，而 GLM 1.0.3 返回 ±Inf，行为差异未被记录
- **所在位置**：§1.4 stdmath_shim.cj 模式（第 50 行）、§3.1 exponential.cj 实现路径（第 266 行）
- **严重程度**：一般
- **改进建议**：在 §1.4 或 D29 中补充 Float16 范围约束说明，标注已知行为差异，或为 Float16 添加 result > Float16.MAX → T.getInf() 保护
