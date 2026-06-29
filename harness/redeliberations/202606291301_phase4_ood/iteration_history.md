## 迭代第 1 轮

1. **问题描述**：矛盾声明："全部 stub 替换完成" vs. `quaternion_exponential.cj` 保留为 stub
   - 所在位置：§1 概述（第 11 行）、§5 错误处理策略（第 557 行）、§2 包组织（第 107 行）
   - 严重程度：严重
   - 改进建议：统一关于 stub 替换范围的声明，明确是否包括 quaternion_exponential

2. **问题描述**：错误处理策略与具体设计自相矛盾：acos 输入是否 clamp
   - 所在位置：§5 错误处理策略（第 554 行）vs. §3.2 `ext/quaternion_common.cj` slerp 设计（第 340 行）
   - 严重程度：严重
   - 改进建议：在 §5 中增加 slerp clamp 例外说明，或新增设计决策条目

3. **问题描述**：`gtc/type_precision.cj` 未定义具体别名范围
   - 所在位置：§3.3 `gtc/type_precision.cj`（第 422-429 行）
   - 严重程度：严重
   - 改进建议：给出完整别名清单或引用 GLM 对应头文件精确行号范围

4. **问题描述**：引用未定义的 `Common<T>` 约束
   - 所在位置：§3.1 `common.cj` 协作关系（第 226 行）
   - 严重程度：一般
   - 改进建议：将 "`Common<T>` 约束" 改为 "`common.cj` 函数族" 或明确定义

5. **问题描述**：`T(0)/T(1)` 字面量写法与 §1.4 确立的 `T(Float64(n))` 约定不一致
   - 所在位置：全文各处函数公式（§3.1 §3.2 §4 等）
   - 严重程度：一般
   - 改进建议：统一替换为 `T(Float64(n))` 或增加简写约定声明

6. **问题描述**：`mod` 函数约束策略与现有 stub 及 GLSL 行为不一致
   - 所在位置：§3.1 `common.cj`（第 219 行）
   - 严重程度：一般
   - 改进建议：在 §7 设计决策中记录约束选择理由，或补充整数版本重载

7. **问题描述**：`geometric.cj` 约束收紧未显式标记为向后不兼容变更
   - 所在位置：§3.1 `geometric.cj` 约束策略（第 264 行）vs. 现有 stub 代码
   - 严重程度：一般
   - 改进建议：在 §7 中新增设计决策条目记录约束收紧理由

## 迭代第 2 轮

1. **问题描述**：`inversesqrt`零值输入边界条件未处理
   - 所在位置：§3.1 `exponential.cj` 职责（第244行）
   - 严重程度：严重
   - 改进建议：在§3.1或§5中明确`inversesqrt`零值输入的行为契约（与GLM一致返回Inf，或增加保护分支）
2. **问题描述**：`geometric.cj` `Vec1 normalize`语义未定
   - 所在位置：§3.1 `geometric.cj` 职责（第271行）
   - 严重程度：严重
   - 改进建议：明确选定一种语义（建议参考GLM 1.0.3源码确认行为）
3. **问题描述**：`trigonometric.cj`协作关系事实错误：`sqrt`不属于`trigonometric.cj`
   - 所在位置：§3.1 `trigonometric.cj` 协作关系（第260行）
   - 严重程度：严重
   - 改进建议：修正为`sqrt`属于`exponential.cj`，或说明`geometric.cj`直接依赖`std.math.sqrt`
4. **问题描述**：`lib.cj`更新方案存在命名冲突：`perspective/ortho/frustum`从`ext`和`gtc`同时导入
   - 所在位置：§8 `lib.cj`更新（第676行） vs. 现有`lib.cj`（第24-26行）
   - 严重程度：严重
   - 改进建议：删除第676行中`perspective`、`ortho`、`frustum`从ext的导入（gtc版本已覆盖），或通过重命名消歧
5. **问题描述**：`common.cj`函数族未从`lib.cj`导出，且`mix`存在命名冲突隐患
   - 所在位置：§8 `lib.cj`更新（第671-685行） + 现有`lib.cj`
   - 严重程度：严重
   - 改进建议：在§8中明确common.cj函数族导出策略，分析`mix`在detail和ext中的命名冲突，给出消歧方案
6. **问题描述**：`gtc/random.cj`随机数状态管理与§6"纯函数"声明矛盾
   - 所在位置：§3.3 `random.cj`职责（第427-429行）、§6并发设计（第595行）
   - 严重程度：一般
   - 改进建议：补充随机数引擎管理策略，在§6中为random.cj增加例外说明，指定种子初始化策略
7. **问题描述**：`gtc/noise.cj`排列表与梯度向量的存储/初始化方式未涉及
   - 所在位置：§3.3 `noise.cj`职责（第413-420行）
   - 严重程度：一般
   - 改进建议：补充排列表和梯度向量的存储方案（建议包级`let`常量数组），标注GLM具体行号范围，评估迁移工作量
8. **问题描述**：`matrix.cj inverse`的Mat4x4实现策略未决
   - 所在位置：§3.1 `matrix.cj`职责（第295行）
   - 严重程度：一般
   - 改进建议：明确选型——建议选择与GLM一致的余子式展开，在D05或新增决策条目中记录选择理由
9. **问题描述**：`ext/quaternion_trigonometric.cj`的`angle`/`angleAxis` stub未纳入阶段四范围
   - 所在位置：§2包组织`quaternion_trigonometric.cj`（第113行）、§3.2未出现
   - 严重程度：一般
   - 改进建议：将`angle`和`angleAxis`列入阶段四补齐范围，或在§2中注明"阶段三 stub 需在本阶段补齐"

## 迭代第 3 轮

1. **问题描述**：Vec1 normalize 零输入行为自相矛盾——第275行描述为"0 * Inf = NaN"，第278行general描述及§5错误表描述为"返回零向量"
   - 所在位置：§3.1 geometric.cj 第275行 vs. 第278行、§5 错误处理策略表 第601–603行
   - 严重程度：严重
   - 改进建议：选择方案A（统一零向量保护）或方案B（Vec1例外并加脚注），全局同步
2. **问题描述**：inversesqrt(0)返回+Inf依赖CangJie浮点除零符合IEEE 754规范，该假设未经验证且现有代码库存在反向证据
   - 所在位置：§3.1 exponential.cj 第248行、D20
   - 严重程度：严重
   - 改进建议：新增验证项确认Float64(1)/Float64(0)是否返回+Inf，并在§1.7补充为H4确定性声明或增加零值保护分支
3. **问题描述**：lib.cj更新方案中mix和exp/log/pow/sqrt跨包同符号导入存在编译风险，CangJie同名函数跨public import重载解析行为未经验证，且exp/log/pow/sqrt的冲突被完全忽视
   - 所在位置：§8 lib.cj更新代码块，§8 "关于mix命名冲突的处理"段落
   - 严重程度：严重
   - 改进建议：编写最小测试用例验证CangJie跨public import同名函数重载解析行为，将exp/log/pow/sqrt纳入冲突分析，验证失败则设计替代方案
4. **问题描述**：gtc/packing.cj仅列出函数名称，未给出任何一个函数的完整签名和实现路径
   - 所在位置：§3.3 gtc/packing.cj 第419–427行
   - 严重程度：一般
   - 改进建议：为每个packing函数补充完整签名，至少包含2–3个典例函数的完整签名作为格式示范
5. **问题描述**：gtc/random.cj ThreadLocal<Random>方案未验证CangJie中ThreadLocal是否可用、Random是否满足Send/Sync约束、种子初始化竞态问题
   - 所在位置：§3.3 gtc/random.cj 第445–447行、D19、§6
   - 严重程度：一般
   - 改进建议：新增验证项确认ThreadLocal<Random>可编译运行，补充初始化与竞态保护策略，提供备选方案
6. **问题描述**：ext/matrix_transform.cj和ext/matrix_clip_space.cj实际函数范围未明确，缺少完整函数清单
    - 所在位置：§1 核心抽象表、§3.2 ext/matrix_transform.cj 第317–326行、§3.2 ext/matrix_clip_space.cj 第337–344行
    - 严重程度：一般
    - 改进建议：列出每个ext/矩阵文件的完整函数签名清单，或明确标注与GLM 1.0.3对应头文件一致并给出参考行号

## 迭代第 4 轮

1. **问题描述**：modf/frexp/ldexp 函数在仓颉中缺少签名设计方案，编码阶段不可行动
    - 所在位置：§3.1 common.cj 职责（第85-88行）
    - 严重程度：严重
    - 改进建议：补充仓颉签名设计，建议 modf 返回 (fractional, integer) 元组，frexp 返回 (mantissa, exponent) 元组，ldexp 委托 std.math.ldexp

2. **问题描述**：奇异矩阵求逆行为在三处位置描述不一致（"零矩阵或全NaN"、"零矩阵"、"零矩阵或保留未定义值"），且偏离 GLM 1.0.3 实际 NaN 行为
    - 所在位置：§3.1 第310行、§4.3 第621行、§5 第679行
    - 严重程度：严重
    - 改进建议：统一为 IEEE 754 自然行为描述，说明奇异矩阵求逆产生 NaN/Inf 填充矩阵，函数不抛出异常

3. **问题描述**：mod 函数当前约束描述为 FloatingPoint<T>，实际代码为 Integer<T>，属事实错误
    - 所在位置：§3.1 第239行、D15 第717行
    - 严重程度：严重
    - 改进建议：修正当前约束描述为 Integer<T>，标注向后不兼容变更，评估退回影响

4. **问题描述**：trigonometric.cj 依赖图遗漏 scalar_constants.cj（pi<T>() 函数依赖）
    - 所在位置：§2 模块间依赖表（第171行）
    - 严重程度：一般
    - 改进建议：在第171行补充 scalar_constants（pi<T>() 函数）

5. **问题描述**：random.cj 种子初始化竞态风险评估不足，相同毫秒时间戳内并发调用可能产生相同随机数序列
    - 所在位置：§3.3 random.cj 随机数引擎管理（第523-524行）
    - 严重程度：一般
    - 改进建议：补充种子生成策略增强说明（如 (timestamp ^ threadId)）或明确标注已知风险并接受

6. **问题描述**：gtc/ulp.cj 泛型函数 T <: FloatingPoint<T> 在仓颉中无位操作实现路径，当前签名不可编码
    - 所在位置：§3.3 gtc/ulp.cj（第557-566行）
    - 严重程度：严重
    - 改进建议：改为具体类型重载（Float32/Float64），内部使用 toBits()/fromBits() 操作位模式，新增设计决策条目记录选择理由

## 迭代第 5 轮

1. **问题描述**：ext/scalar_common.cj 职责描述与 GLM 1.0.3 事实不符，声称包含 mix/step/smoothstep 但实际不存在，遗漏 fmin/fmax/fclamp/纹理环绕系列/iround/uround
   - 所在位置：§3.2 · ext/scalar_common.cj（第 323–326 行）
   - 严重程度：严重
   - 改进建议：以 GLM 1.0.3 ext/scalar_common.hpp 实际内容为准重新编写节，列出完整函数签名清单及约束策略；若选择性扩展/裁剪需在设计决策章节说明理由
2. **问题描述**：ext/vector_common.cj 缺乏完整函数清单，仅 3 句模糊描述，不足以指导编码
   - 所在位置：§3.2 · ext/vector_common.cj（第 328–332 行）
   - 严重程度：严重
   - 改进建议：参照 GLM 1.0.3 ext/vector_common.hpp 列出完整函数签名清单（约 20 个函数），明确每个函数的约束策略和实现路径，与 ext/scalar_common.cj 的设计描述对齐
3. **问题描述**：ext/matrix_clip_space.cj ortho 系族函数计数与 GLM 1.0.3 实际不符（文档称 11 个，实际 10 个）
   - 所在位置：§3.2 · ext/matrix_clip_space.cj（第 371 行）
   - 严重程度：一般
   - 改进建议：修正 ortho 系族计数为"10 个"
4. **问题描述**：gtc/matrix_transform.cj 函数总数（64）与分项求和结果（62）自相矛盾
   - 所在位置：§3.3（第 418 行）及 §9.1（第 847 行）
   - 严重程度：一般
   - 改进建议：核实 GLM 1.0.3 实际函数总数并统一全文表述；说明 gtc 层与 ext 层在仓颉实现中的具体关系（转发委托 vs. 独立实现 vs. 混合）

## 迭代第 6 轮

1. **问题描述**：geometric.cj 的 Vec 几何函数未纳入 lib.cj 导出
   - 所在位置：§8 lib.cj 更新（第 883-906 行）
   - 严重程度：严重
   - 改进建议：在 §8 lib.cj 更新代码块中增加 `public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}`，确认与 Quat 版本重载解析无歧义
2. **问题描述**：matrix.cj 的 determinant/inverse 未纳入 lib.cj 导出
   - 所在位置：§8 lib.cj 更新（第 883-906 行）
   - 严重程度：严重
   - 改进建议：在 §8 lib.cj 更新中增加 `public import glm.detail.{determinant, inverse}`，确认与 Quat 版本重载解析无歧义
3. **问题描述**：ext/matrix_projection.cj 函数计数与清单不一致
   - 所在位置：§3.2 ext/matrix_projection.cj 职责（第 444 行）
   - 严重程度：严重
   - 改进建议：核对 GLM 1.0.3 实际函数数量，修正计数或补充函数签名，确保清单与计数一致
4. **问题描述**：Vec1 normalize 在职责清单中缺失，形成内部矛盾
   - 所在位置：§3.1 geometric.cj 职责（第 291-294 行）vs. §5 错误表（第 781 行）
   - 严重程度：一般
   - 改进建议：在 §3.1 geometric.cj normalize 职责中补充 Vec1 版本，使职责清单、行为描述和错误表三方一致
5. **问题描述**：ext/scalar_common.cj 和 ext/vector_common.cj 的公共函数未纳入 lib.cj 导出
   - 所在位置：§8 lib.cj 更新（第 883-906 行）
   - 严重程度：一般
   - 改进建议：在 §8 lib.cj 更新中补充 ext/scalar_common.cj 和 ext/vector_common.cj 的公共函数导出
6. **问题描述**：slerp 退化条件阈值未定义，编码阶段不可直接实现
   - 所在位置：§3.2 ext/quaternion_common.cj（第 475 行）、§7 D09（第 811 行）
   - 严重程度：一般
   - 改进建议：在 §3.2 slerp 实现路径或 D09 中明确定义退化阈值表达式
7. **问题描述**：mod 浮点重载的处理策略未明确
   - 所在位置：§3.1 common.cj（第 239 行）、§7 D15（第 817 行）
   - 严重程度：一般
   - 改进建议：在 D15 中补充 `scalar_vec_ops.cj` 中既有浮点重载的处理策略说明
## 迭代第 7 轮

1. **问题描述**：lib.cj 增量更新与现有 gtc 导入在 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 上形成命名冲突，编译存在风险
   - 所在位置：§8 lib.cj 更新（第 909–910 行）、现有 lib.cj 第 23 行
   - 严重程度：严重
   - 改进建议：明确选型——方案A：gtc 层使用转发函数，lib.cj 中删除对应符号的 gtc import（修改现有行），改为从 ext 统一导入；方案B：gtc 层使用 public import 重导出，lib.cj 只从 gtc 导入，删除 ext 重复行；方案C：验证 CangJie 是否允许同函数双路径 public import，若通过则在注释中记录验证结果
2. **问题描述**：frexp<T>(x: T): (T, Int64) where T <: FloatingPoint<T> 未提供可行的实现策略，FloatingPoint<T> 不提供 toBits()/fromBits()，数学分解方案在零值/denormal/NaN/Inf 场景失效
   - 所在位置：§3.1 common.cj 职责（第 248–249 行）
   - 严重程度：严重
   - 改进建议：补充 frexp 的实现策略——对输入 x 做零值/Inf/NaN 前置检查，对合法值使用 log2 + pow 数学分解，或在 stdmath_shim.cj 中为 Float32/Float64 各提供基于 toBits() 的具体类型实现，标量版本直接委托 shim
3. **问题描述**：ext/quaternion_common.cj 的依赖关系列出了 glm.detail.trigonometric + glm.detail.geometric + ext/scalar_constants，但遗漏了 glm.detail.common（mix 和 slerp 均依赖 common.cj 的 clamp）
   - 所在位置：§2 模块间依赖表（第 187–188 行）
   - 严重程度：一般
   - 改进建议：在第 187 行依赖链中补充 glm.detail.common
4. **问题描述**：gtc/noise.cj 仅描述了 perlin 和 simplex 噪声的维度范围，未给出任何一个函数的具体仓颉签名（参数类型、返回类型、约束），编码团队无法实现
   - 所在位置：§3.3 gtc/noise.cj（第 611–615 行）
   - 严重程度：一般
   - 改进建议：补充至少每个函数的完整签名，格式参考 packing.cj 的代码块样式；GLM 1.0.3 中 Perlin 噪声返回 T（1D/2D/3D/4D 输入各返回标量 T），Simplex 噪声返回 Vec<T, Q>（各维度返回对应维度向量，1D 特殊返回标量 T）
5. **问题描述**：stdmath_shim.cj 的通用模式 (result as T).getOrThrow() 在 T = Float16 且计算中间值超过 ±65504 时抛出异常，而 GLM 1.0.3 返回 ±Inf，行为差异未被记录
   - 所在位置：§1.4 stdmath_shim.cj 模式（第 50 行）、§3.1 exponential.cj 实现路径（第 266 行）
   - 严重程度：一般
    - 改进建议：在 §1.4 或 D29 中补充 Float16 范围约束说明，标注已知行为差异，或为 Float16 添加 result > Float16.MAX → T.getInf() 保护

## 迭代第 8 轮

1. **问题描述**：lib.cj 中 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 跨包重复导入冲突未解决
   - 所在位置：§8 lib.cj 更新、现有 lib.cj 第 23 行
   - 严重程度：严重
   - 改进建议：明确选型并执行方案（推荐：修改 lib.cj 第 23 行删除 gtc import，§8 从 ext 导入；或保持 lib.cj 不变，§8 不导入这些符号改为从 gtc 统一提供），记录选型理由和验证结果

2. **问题描述**：frexp 零值/NaN/Inf/非规范化数边缘场景实现策略缺失
   - 所在位置：§3.1 common.cj 第 248 行
   - 严重程度：严重
   - 改进建议：选择数学分解加前置检查方案，或为 Float32/Float64 提供基于位操作的重载，并在 D25 中补充策略选型理由和非规范化数行为声明

3. **问题描述**：ext/quaternion_common.cj 依赖链遗漏 glm.detail.common
   - 所在位置：§2 模块间依赖表第 187 行
   - 严重程度：一般
   - 改进建议：在第 187 行依赖链中补充 glm.detail.common

4. **问题描述**：gtc/noise.cj 缺少完整函数签名
   - 所在位置：§3.3 gtc/noise.cj 第 610–615 行
   - 严重程度：一般
   - 改进建议：为每个函数补充完整签名，参考 packing.cj 的代码块样式

5. **问题描述**：ext/scalar_common.cj 的 iround/uround 负数输入行为偏离 GLM 且差异仅以行内注释记录
   - 所在位置：§3.2 ext/scalar_common.cj 第 362–364 行
   - 严重程度：一般
   - 改进建议：改用 Int64(round(x)) 公式消除负数语义偏差，或记录行为偏差并增加 @pre 约束

6. **问题描述**：stdmath_shim.cj 在 Float16 上的溢出行为差异未记录
   - 所在位置：§1.4 stdmath_shim.cj 第 50 行、D29 第 837 行
   - 严重程度：一般
   - 改进建议：在 §1.4 或 D29 中补充 Float16 溢出行为差异记录及处理策略

7. **问题描述**：mod 函数标量浮点重载的设计决策仍为"编码阶段可选"，留下不确定性
   - 所在位置：§3.1 common.cj 第 244 行、D15 第 823 行
   - 严重程度：一般
   - 改进建议：将标量浮点 mod 重载由"可选"升级为"推荐实现"，明确参数类型和约束

## 迭代第 9 轮

1. **问题描述**：`ldexp` 的 Float16 回退描述与 D29 第 850 行的设计决策及 `pow` 的描述自相矛盾，三处文字不一致导致编码团队无法确定权威描述
   - 所在位置：§3.1 common.cj 职责第 249 行
   - 严重程度：严重
   - 改进建议：将第 249 行 ldexp 的 Float16 回退描述替换为与 D29 一致的表述，说明所有浮点类型均通过 `stdmath_shim.cj` 的 `powT` 包装函数统一实现，无需特殊回退分支
2. **问题描述**：`ext/quaternion_transform.cj` rotate 的依赖关系错误（实际不依赖 `glm.ext.quaternion_geometric(cross)`），且遗漏了 normalize axis 步骤，导致非单位轴向量的 rotate 行为与 GLM 1.0.3 不一致
   - 所在位置：§2 模块间依赖表第 189 行、§3.2 rotate 职责第 492-493 行
   - 严重程度：一般
   - 改进建议：修正 §2 第 189 行依赖（删除 `glm.ext.quaternion_geometric(cross)`，改为 `glm.detail.geometric(length)`）；在 §3.2 rotate 职责中补充 axis normalize 步骤
3. **问题描述**：`mirrorRepeat` 仅描述为"分片纹理循环"，未像其他三个纹理环绕函数那样给出具体实现公式，编码团队需反向工程
   - 所在位置：§3.2 ext/scalar_common.cj 第 361 行
   - 严重程度：一般
   - 改进建议：参照其他纹理环绕函数的格式，在括号中补充 mirrorRepeat 的实现公式或注明 GLM 源码参考行号

## 迭代第 10 轮

1. **问题描述**：`lib.cj` 中 gtc/noise.cj 的 public import 引用了不存在的函数名 `{perlin, simplex}`，实际定义名为 `perlin1D`/`perlin2D`/`perlin3D`/`perlin4D`/`simplex1D`/`simplex2D`/`simplex3D`/`simplex4D`
   - 所在位置：§8 lib.cj 更新，第 929 行
   - 严重程度：严重
   - 改进建议：将 `{perlin, simplex}` 替换为完整函数名清单

2. **问题描述**：`lib.cj` 中 gtc/packing.cj 的 public import 仅导出了约 6/32 个函数且未提供设计理由
   - 所在位置：§8 lib.cj 更新，第 928 行
   - 严重程度：严重
   - 改进建议：方案 A：导出全部 packing 函数；方案 B：补充选型理由

3. **问题描述**：`lib.cj` 遗漏 gtc/round.cj 的 `ceilMultiple`/`floorMultiple` 导出
   - 所在位置：§3.3 gtc/round.cj 职责（第 695–696 行）vs. §8 lib.cj 更新（第 932 行）
   - 严重程度：严重
   - 改进建议：增加 `ceilMultiple` 和 `floorMultiple` 导出

4. **问题描述**：`lib.cj` 遗漏 gtc/type_precision.cj 的类型别名导出
   - 所在位置：§3.3 gtc/type_precision.cj（第 647–672 行）vs. §8 lib.cj 更新
   - 严重程度：严重
   - 改进建议：在 §8 lib.cj 更新中补充 type_precision.cj 的公共导出

5. **问题描述**：`gtc/matrix_transform.cj` 的"全部委托给 ext 层"声明与实际情况不符，`rotate_slow`/`scale_slow`/`shear_slow` 在 ext 层中不存在
   - 所在位置：§3.3 gtc/matrix_transform.cj（第 525 行）
   - 严重程度：严重
   - 改进建议：修正声明为"大部分委托给 ext 层，rotate_slow/scale_slow/shear_slow 需在 gtc 层独立实现"

6. **问题描述**：geometric.cj 对 sqrt 的依赖描述与依赖关系表不一致
   - 所在位置：§3.1 geometric.cj 协作关系（第 286 行、第 309 行）
   - 严重程度：一般
   - 改进建议：将文字描述中的"依赖 exponential.cj 的 sqrt"修正为"通过 `stdmath_shim.cj` 包装层调用 `sqrt`"

## 迭代第 11 轮

1. **问题描述**：`frexp` 指数计算公式 `exponent = floor(log2(abs(x)))` 产生 mantissa 在 `[1, 2)` 范围，与声明的 `[0.5, 1)` 自相矛盾
   - 所在位置：§3.1 common.cj 职责，第 248 行
   - 严重程度：一般
   - 改进建议：将公式修正为 `exponent = floor(log2(abs(x))) + 1`
2. **问题描述**：`ulp(x)` 实现公式 `T.fromBits(T(1).toBits() - T(1))` 存在类型不匹配，且仅计算 `ulp(1.0)` 常量，忽略 x 的指数信息
   - 所在位置：§3.3 gtc/ulp.cj 实现路径，第 684 行
   - 严重程度：一般
   - 改进建议：修正为基于 x 自身位模式的操作，如 `T.fromBits(x.toBits() + 1u) - x`

## 迭代第 12 轮

1. **问题描述**：§2 依赖表遗漏 gtc/matrix_transform.cj 对 glm.ext 的依赖，与 §3.3 设计正文矛盾
   - 所在位置：§2 模块间依赖（第 193 行）
   - 严重程度：一般
   - 改进建议：在第 193 行将 `matrix_transform.cj → glm.detail（...）` 修正为 `matrix_transform.cj → glm.detail + glm.ext（委托 ext/matrix_transform、ext/matrix_projection、ext/matrix_clip_space）`，或拆分为两条

## 迭代第 13 轮

1. **问题描述**：`mirrorRepeat` 实现公式与 GLM 1.0.3 源码不符，`clamp(Floor, 0, 1)` 语义与 `mod(floor(Abs), 2)` 完全不同，编码按产出公式将产生错误结果
   - 所在位置：§3.2 ext/scalar_common.cj，第 361 行
   - 严重程度：严重
   - 改进建议：修正为与 GLM 1.0.3 一致的公式：`Abs = abs(Texcoord) → Floor = floor(Abs) → Clamp = mod(Floor, T(2)) → Rest = Abs - Floor → Mirror = Clamp + Rest → mix(Rest, T(1) - Rest, Mirror >= T(1))`

2. **问题描述**：Simplex 噪声（simplex2D/3D/4D）返回类型声明为 Vec2/Vec3/Vec4，但 GLM 1.0.3 签名明确返回标量 `T`
   - 所在位置：§3.3 gtc/noise.cj，第 624~626 行
   - 严重程度：严重
   - 改进建议：将所有 simplex 函数返回类型修正为 `T`，并补充 Perlin 周期噪声重载

3. **问题描述**：`ext/matrix_projection.cj` 使用单一泛型 `T` 约束所有参数，但 GLM 中 viewport 使用独立类型参数 `U`
   - 所在位置：§3.2 ext/matrix_projection.cj，第 452~459 行
   - 严重程度：一般
   - 改进建议：为 viewport 引入独立类型参数 `U <: Number<U>`，或注释说明编码阶段需考虑类型解耦

4. **问题描述**：`ext/matrix_projection.cj` 函数签名仅列出函数名和参数名，未给出参数类型、返回类型和约束
   - 所在位置：§3.2 ext/matrix_projection.cj，第 452~459 行
   - 严重程度：一般
   - 改进建议：给出每个函数的完整仓颉签名，包括参数类型、返回类型和泛型约束

5. **问题描述**：`ext/matrix_clip_space.cj` 46 个函数仅按系族列出函数名，未给出完整参数类型签名
   - 所在位置：§3.2 ext/matrix_clip_space.cj，第 467~474 行
   - 严重程度：一般
   - 改进建议：至少为每个系族给出一个典例函数的完整签名，并标注变体差异

6. **问题描述**：`gtc/matrix_transform.cj` 的 `rotate_slow`/`scale_slow`/`shear_slow` 缺少独立签名和实现路径说明
   - 所在位置：§3.3 gtc/matrix_transform.cj，第 518 行
   - 严重程度：一般
   - 改进建议：补充每个 `_slow` 函数的完整签名，说明与标准版本的实现差异

7. **问题描述**：`gtc/type_precision.cj` 缺失 `hvec1` 别名
   - 所在位置：§3.3 gtc/type_precision.cj，第 659~665 行
   - 严重程度：轻微
   - 改进建议：补充 `hvec1` 别名以保持精度体系别名一致性

8. **问题描述**：`ldexp` 实现精度分析不足，未讨论 Float32 非规格化数精度损失
   - 所在位置：§3.1 common.cj，第 250 行
   - 严重程度：轻微
   - 改进建议：在 D29 或 §3.1 中补充 Float32 非规格化数精度损失的说明

## 迭代第 14 轮

1. **问题描述**：lib.cj 修改策略在 §8 和 §9.4 的描述自相矛盾，§8 同时声明"不修改已有行"和"需修改第 23 行"，§9.4 强化"不做任何修改"，与 D30 的修改要求冲突
   - 所在位置：§8 第 931~933 行、§9.4 第 1028 行
   - 严重程度：严重
   - 改进建议：① 删除 §8 第 931 行中的"不修改已有行"；② 将 §9.4 第 1026~1028 行修正为"增量追加策略，但需修改 lib.cj 第 23 行"并附简短理由；③ 在 §9.4 末尾引用 D30 作为详细依据

2. **问题描述**：lib.cj 导出遗漏 hvec1，与 §3.3 type_precision.cj 别名清单不一致
   - 所在位置：§8 lib.cj 更新代码块，第 980 行
   - 严重程度：一般
   - 改进建议：在第 980 行补充 `hvec1`

3. **问题描述**：stdmath_shim.cj 作为核心函数库的底层依赖，未出现在任何实施批次规划中
   - 所在位置：§8 实施批次规划（第 887~930 行）
   - 严重程度：一般
   - 改进建议：在第一批中增加 stdmath_shim.cj 条目，明确其创建时机与依赖关系

4. **问题描述**：gtc/matrix_access.cj 和 gtc/matrix_inverse.cj 的接口描述粒度不及同级模块，不足直接编码
   - 所在位置：§3.3 gtc/matrix_access.cj（第 572~575 行）、gtc/matrix_inverse.cj（第 564~566 行）
   - 严重程度：一般
   - 改进建议：matrix_access.cj 给出 2~3 个典例完整签名；matrix_inverse.cj 明确 affineInverse 适用范围和 inverseTranspose 的矩阵类型约束

## 迭代第 15 轮

1. **问题描述**：周期性 Perlin 噪声仅覆盖 4D，遗漏 1D/2D/3D 周期重载
   - 所在位置：§3.3 gtc/noise.cj，第 657–672 行
   - 严重程度：严重
   - 改进建议：为 perlin1D/perlin2D/perlin3D 各补充一个周期参数重载

2. **问题描述**：种子策略依赖未经验证的 Thread API（Thread.currentThread().id）
   - 所在位置：§3.3 gtc/random.cj，第 687 行
   - 严重程度：严重
   - 改进建议：新增验证项确认该 API 编译可行性，或替换为进程 ID / 线程局部位移量 / 仅时间戳方案

3. **问题描述**：float_distance 描述"个数"与有符号返回类型语义矛盾
   - 所在位置：§3.3 gtc/ulp.cj，第 728–729 行
   - 严重程度：中等
   - 改进建议：修正描述以匹配有符号语义，或改用无符号类型

4. **问题描述**：ulp.cj 未讨论 Float16 覆盖策略
   - 所在位置：§3.3 gtc/ulp.cj，第 726–732 行
   - 严重程度：中等
   - 改进建议：补充 Float16 重载或明确排除理由

5. **问题描述**：mix 描述存在"可能"不确定性措辞
   - 所在位置：§3.2 ext/quaternion_common.cj，第 503 行
   - 严重程度：中等
   - 改进建议：改为确定性措辞，明确使用 clamp 截断策略

6. **问题描述**：噪声命名约定变更未记录为设计决策
   - 所在位置：§3.3 gtc/noise.cj 第 655–672 行 vs. §7 设计决策
   - 严重程度：一般
   - 改进建议：在 §7 中新增设计决策记录命名拆分原因

7. **问题描述**：fwd.cj 与 type_precision.cj 的别名关系未澄清
   - 所在位置：§3.3 gtc/type_precision.cj 第 692–719 行；§2 第 166 行
   - 严重程度：一般
   - 改进建议：补充说明两者别名关系及命名空间兼容性
