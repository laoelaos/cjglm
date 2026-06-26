# 再审议判定报告（v6）

## 判定结果

RETRY

## 判定理由

组件B诊断报告（`b_v6_diag_v1.md`）识别出 **2 项严重 + 6 项一般 + 5 项轻微 = 13 项**质量问题，其中：

- **严重问题（2 项）**：
  - 问题1：§3.13 trigonometric.cj 函数签名缺少 `where T <: FloatingPoint<T>` 约束声明，与同文档 D25/D29/D32 已统一策略不一致，且与 §3.13.1 表头说明语义冲突
  - 问题2：§3.7 normalize 实现描述未涵盖 GLM `quaternion_geometric.inl:17-24` 零四元数保护分支，导致 §3.7 与 §5.1 边界行为契约不自洽，下游按 §3.7 字面实现零四元数将产生 NaN

- **一般问题（6 项）**：包括 Quat×Vec3 运算符公式中 `QuatVector` 符号未定义、§4.4 与 §11.4 命名空间前缀不一致、§3.10 pow 函数 GLM 公式未翻译为仓颉等价、「递归调用」措辞不准确、§1「std.math Float64-only」约束与仓颉 stdlib 实际 API 不一致、§1「FloatingPoint<T> 无任何实例方法」描述不准确

组件B质询报告（`b_v6_challenge_v1.md`）结论为 **LOCATED**，确认了诊断报告识别出的问题属实，并提出 4 项针对诊断报告本身的轻微改进建议（问题 A-D），均为对报告可操作性的补强，不构成对诊断结论的驳回。

本次判定未进入组件B内部循环（实际轮次 = 1，远小于最大轮次 12），即组件B单轮即已明确识别出严重和一般问题，未出现「多轮审议后未能定位到明确问题」的情形。

根据判定标准「审查报告包含严重或一般等级的问题」即触发 RETRY，本轮判定为 **RETRY**。

## 需要解决的问题

### 问题 1（来自诊断报告严重问题 1）

- **问题描述**：§3.13.1 trigonometric.cj 函数清单中 15 个函数（14 个单参数三角函数 + atan2 双参数）的标量签名与向量签名模板均无 `where T <: FloatingPoint<T>` 约束子句，与 §3.2.1 D32、§3.11 D29、§3.12 D25 已统一的 `where T <: FloatingPoint<T>` 策略不一致；下游编码者实现时对 T 约束决策无明确依据；整数 T 实例化将编译失败但文档无前置告警
- **所在位置**：§3.13.1 trigonometric.cj 函数清单（行 573-596 附近）所有 15 个函数的标量签名与向量签名列
- **严重程度**：严重
- **改进建议**：§3.13.1 表头新增「**T 类型约束（v11 新增）**」段，所有 15 个函数签名模板修订为 `sin<T>(x: T): T where T <: FloatingPoint<T>` 与 `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`；表行「内部依赖」列对 `std.math.{func}` 调用统一追加「**T 必须为 FloatingPoint<T>**」标注

### 问题 2（来自诊断报告严重问题 2）

- **问题描述**：§3.7 normalize 函数描述仅写「内部调用 length」，未提及 GLM `quaternion_geometric.inl:17-24` 的零四元数保护分支 `if(len <= 0) return identity`；下游按 §3.7 字面实现 `q / length(q)` 时零四元数将产生 NaN，与 §5.1 已确认的「normalize 零四元数返回 identity」契约不符；§5.3 边界条件表也缺少 normalize 零四元数行
- **所在位置**：§3.7 normalize 函数描述（行 453 附近）+ §5.3 边界条件表（行 789-805 附近）缺少 normalize 零四元数行
- **严重程度**：严重
- **改进建议**：
  1. §3.7 补充完整实现公式 `tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`，末尾新增「**实现策略（v11 补强）**」段
  2. §5.3 边界条件表新增 2 行（零四元数保护、length 极小值精度损失）

### 问题 3（来自诊断报告一般问题 3）

- **问题描述**：§3.4 运算符体系表 Quat×Vec3 行公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))` 中 `QuatVector` 符号未定义，下游需自行对照 GLM `type_quat.inl:359-366` 推导 `QuatVector = Vec3(q.x, q.y, q.z)`
- **所在位置**：§3.4 运算符体系表 Quat×Vec3 行备注列（行 367 附近）
- **严重程度**：一般
- **改进建议**：§3.4 Quat×Vec3 行备注列补充完整公式定义 `QuatVector = Vec3(q.x, q.y, q.z); uv = cross(QuatVector, v); uuv = cross(QuatVector, uv); return v + (uv * q.w + uuv) * T(Float64(2))`；同步检查 §3.4 Quat×Vec4 行

### 问题 4（来自诊断报告一般问题 4）

- **问题描述**：§4.4 行为契约示例使用 `let m3 = mat3Cast(q)` 等无命名空间前缀形式，与 §11.4 v10 已明确的「顶层 `glm` 命名空间调用」示例不一致，下游按 §4.4 字面实现若未先 `import glm.detail.*` 则编译失败
- **所在位置**：§4.4 矩阵-四元数互转行为契约示例（行 747-754 附近）
- **严重程度**：一般
- **改进建议**：§4.4 行为契约示例统一使用顶层 `glm` 命名空间调用形式（与 §11.4 v10 对齐），段首补充「前提：调用方已通过 lib.cj 完成 public import 间接访问」

### 问题 5（来自诊断报告一般问题 5）

- **问题描述**：§3.10 pow 函数依赖描述引用 GLM `quaternion_exponential.inl` line 65/78 两处 pow 调用，但未提供 line 65 仓颉等价翻译（GLM wxyz 与仓颉 Quat 主构造 xyzw 顺序差异），未提及 line 78 的 magnitude 缩放逻辑
- **所在位置**：§3.10 pow 函数依赖描述（行 497 附近）+ D21 设计决策（行 850 附近）
- **严重程度**：一般
- **改进建议**：§3.10 补充 line 65 仓颉等价 `Quat.wxyz(...)` 或 `Quat(0,0,0,...)` 翻译路径；补充 line 78 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))` 引用；D21 决策清单追加 line 65/78 翻译路径

### 问题 6（来自诊断报告一般问题 6）

- **问题描述**：§3.10 pow 描述「命名消歧与 Float64 转换」段使用「递归调用 `std.math.pow`」措辞不准确，GLM `quaternion_exponential.inl` line 65 与 line 78 是两次独立调用而非 pow self-call
- **所在位置**：§3.10 pow 函数描述「命名消歧与 Float64 转换」段（行 497 附近）
- **严重程度**：一般
- **改进建议**：将「递归调用 `std.math.pow(Float64, Float64): Float64`」修订为「**调用 `std.math.pow(Float64, Float64): Float64` 实数降级路径两次**（GLM line 65 + line 78）」

### 问题 7（来自诊断报告一般问题 7）

- **问题描述**：§1「Float32 与 std.math 的交互约束」段依据简化 README（`cangjie-std/math/README.md`）声明「std.math 数值函数仅支持 Float64 输入/输出」，但详细 API 文档（`cangjie-original-docs/std/math/math_package_api/math_package_funcs.md`）显示 `sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh` 均提供 `Float16`/`Float32`/`Float64` 重载，`pow` 提供 `Float32`/`Float64` 重载；`radians`/`degrees` 在 std.math 中不存在
- **所在位置**：§1「Float32 与 std.math 的交互约束」段（行 54-63 附近）+ §3.13.1 trigonometric.cj 表头说明（行 598 附近）
- **严重程度**：一般
- **改进建议**：
  1. §1 修订为对 T = Float32 实例化场景优先调用 std.math Float32 重载；保留 T = Float64 实例化现状；新增 `radians`/`degrees` 硬编码 π 字面量路径风险提示
  2. §3.13.1 表头说明同步修订，删除强制要求 `T(Float64.xxx(Float64(value)))` 转换模式，改为 Float32 重载优先 + 必要时 fallback 策略

### 问题 8（来自诊断报告一般问题 8）

- **问题描述**：§1 修订说明（v10）和 §3.10 多处声明「`FloatingPoint<T>` 接口本身无任何实例方法」，但 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 3-15 行明确定义接口包含 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法
- **所在位置**：§1 修订说明 v10 + §3.10 log/pow 依赖描述（行 496-497）+ D21「std::numeric_limits<T>::infinity() 等价物获取」段（行 850）+ §8 验证项 13/16/18（行 993-998）
- **严重程度**：一般
- **改进建议**：§1/§3.10/D21/§8 措辞修订为「`FloatingPoint<T>` 接口提供 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法」，D21 决策依据同步修订