根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 问题 1（严重 — 事实错误）：§3.7 `length` 函数依赖描述与 §1 自相矛盾

§3.7（行 461）`length` 函数描述称「`std.math.sqrt` 签名仅支持 Float64 输入/输出，Float32 实例需显式转换」。但 §1「Float32 与 std.math 的交互约束」段（行 59）v11 修订已明确 `std.math.sqrt` 提供 Float16/Float32/Float64 **三种重载**，且 §1 方案 A（推荐）明确指出 T=Float32 时直接调用 **无需** Float64 转换。

**改进建议**：将 §3.7 `length` 函数描述中「`std.math.sqrt` 签名仅支持 Float64 输入/输出，Float32 实例需显式转换」修订为「`std.math.sqrt` 提供 Float16/Float32/Float64 重载（见 §1 v11 修订），T=Float32 实例化时直接调用 `std.math.sqrt` 即可，无需显式 Float64 转换」。同时全文 grep 所有引用「仅支持 Float64」旧描述的段落，确保与 §1 最新策略一致。

### 问题 2（严重 — 事实错误）：§3.9 `axis` 函数依赖描述引用已废弃的 Float64 转换模式

§3.9 `axis` 函数描述（行 491）称「依赖 `std.math.sqrt`（受 §1「Float32 与 std.math 的交互约束」管辖，统一使用 `T(Float64.xxx(Float64(value)))` 模式兼容 `T = Float32`/`Float64`）」。该描述引用的是 §1 v11 **修订前**的旧策略（v10：「必须转换」），而 §1 v11 方案 A 已改为「T=Float32 时直接调用 std.math 对应重载，无需显式转换」。

**改进建议**：将 §3.9 `axis` 的依赖说明修订为「依赖 `std.math.sqrt`（§1 v11 修订确认提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用 `std.math.sqrt(Float64(tmp1))` 并 `T(...)` 转换回目标类型；T=Float64 时 `std.math.sqrt` 直接返回 Float64）；实现公式遵循 §3.9 原文的 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))` 路径」。删除「统一使用 `T(Float64.xxx(...))` 模式兼容」的表述。

### 问题 3（严重 — 事实错误）：§3.7 `length` 函数的 Float32 sqrt 处理同时存在自相矛盾的描述

§3.7 `length` 函数描述在同一段落内存在两个自相矛盾的 statement：(1)「`std.math.sqrt` 签名仅支持 Float64 输入/输出」— 错误；(2)「实现阶段明确采用 `T(Float64.sqrt(Float64(dot_qq)))` 路径或**额外声明 Float32 重载**」— 后者（Float32 重载）隐含 `std.math.sqrt` 存在 Float32 重载的事实。

**改进建议**：参照问题 1。同时建议与 §1 同步，使用统一描述模板：「`std.math.sqrt` 提供 Float16/Float32/Float64 重载（§1 v11 修订），`length` 函数在 T=Float32 实例化时直接调用 `std.math.sqrt(Float64(dot_qq))` 并 `T(...)` 转换回目标类型；T=Float64 时直接使用 `std.math.sqrt` 返回值。」

### 问题 4（一般 — 关键遗漏）：`gtc/matrix_transform.cj` 的 64 个 stub 函数无对应测试文件

§8.2 测试文件清单涵盖 13 个测试文件，覆盖所有完整实现模块和多个 stub 模块。但 `gtc/matrix_transform.cj`（64 个 stub 函数，属于阶段三最大的单一函数集合）**无对应的测试文件**。§3.13.2 审计结论也将其归入「78 个 stub」计数，但 §8.2 未列出其测试覆盖。

**改进建议**：在 §8.2 测试文件清单中新增一行（或扩展 `test_ext_quaternion_exponential.cj` 等已有文件的覆盖范围），专门覆盖 `gtc/matrix_transform.cj` 的 64 个 stub 函数。建议新增 `tests/glm/gtc/test_matrix_transform_stubs.cj`（预计用例数 ≥8，抽样覆盖 6 大类中的代表函数，验证抛 stub 异常）；也可在验收项 C 覆盖矩阵中增加特设验证步骤「随机抽样 10 个函数签名验证 `cjpm build` 引用可达」。

### 问题 5（一般 — 内部不一致）：§8.2 测试用例计算中使用 snake_case 命名，与 §3.2.1/D11 确定的 camelCase 命名矛盾

§8.2（行 1040-1043）`gtc/test_quaternion.cj` 用例数计算中使用了 snake_case 名称 `mat3_cast`/`mat4_cast`/`quat_cast`，但 §3.2.1 签名模板和 D11 决策（行 928）已明确采用 camelCase 命名 `mat3Cast`/`mat4Cast`/`quatCast`。

**改进建议**：将 §8.2 用例数计算行（行 1041）的 `mat3_cast`/`mat4_cast`/`quat_cast` 统一修订为 camelCase 形式 `mat3Cast`/`mat4Cast`/`quatCast`。同步检查全文其他章节是否仍有 snake_case 遗留引用，确保与 D11 命名约定一致。

### 问题 6（一般 — 关键遗漏）：`FloatingPoint<T>` 接口方法可用性已标为未经验证，但无闭环计划

§8 编码启动前验证项 20（行 1089）明确声明：「本验证项引用的 `FloatingPoint<T>` 接口方法清单基于 `cangjie-original-docs/...` 编写，v13 中对该文档的引用内容未纳入本轮 v14 审查范围的独立复核——下游编码者在实际调用 `FloatingPoint<T>.getMinDenormal()`/`getInf()` 等方法前应以仓颉编译器实际签名确认」。

**改进建议**：在 §8 中新增具有明确优先级的验证子节「高优先级编译前验证项」，将验证项 20 连同验证项 25（`T(Float64(n))` 语法可行性）列为「5 日内必须完成」的 P0 验证项。要求在编码阶段前先编写最小仓颉测试文件（~20 行），实例化 `FloatingPoint<Float32>.getMinDenormal()`/`getInf()`/`isInf()`/`isNaN()`/`getNaN()`/`getMinNormal()`，确认编译通过。验证结果反馈到 §3.10/§3.11 的依赖描述中更新。

### 问题 7（一般 — 关键遗漏）：测试策略缺少「已实现但被 stub 阻塞」函数类别的覆盖定义

§8.2 测试覆盖维度定义了 7 类覆盖（行 1047-1053），其中第 2 类「运算符正常路径」将 `Quat×Vec3`/`Quat×Vec4` 纳入，第 5 类「stub 函数异常路径」只覆盖明确定义为 stub 的函数。但 `Quat×Vec3`/`Quat×Vec4` 的实际情况是：代码已实现、编译可通过，但运行时因 `geometric.cj` stub 依赖而抛异常。既不属于「正常路径」，也不属于「stub 路径」。

**改进建议**：在 §8.2 测试覆盖维度中新增第 8 类「⚠️ 已实现但被 stub 阻塞函数」：覆盖 `Quat×Vec3`/`Quat×Vec4` 运算符。要求：每函数 ≥1 个编译期测试（验证 `cjpm build` 通过）+ ≥1 个运行时 `assertThrows` 测试（验证抛 `Exception("stub")`）。同时建议在 §11.5 ⚠️ 符号行（行 1415）追加「覆盖要求：编译期验证 + 运行时 assertThrows，详见 §8.2」引用。

### 问题 8（轻微 — 内部不一致）：§8.2 `test_ext_scalar_constants.cj` 用例数先后矛盾

§8.2 表中 `test_ext_scalar_constants.cj` 行（行 1018）标注「预计用例数 **≥7**」，并包含注释说明「v14 修订：Issue 8 响应——预计用例数 ≥6 修正为 ≥7——3 个泛型函数 × 2 种浮点类型 = 6 正常路径 + 1 整数类型异常路径 = 至少 7 个；按「完整实现函数：每函数 ≥2 个用例」原则应为 ≥12」。注释内部存在自相矛盾。

**改进建议**：统一用例数计算口径。按用例分配原则（完整实现函数：每函数 ≥2 个用例），3 函数 × 2 浮点类型 × 2 用例 + 1 整数异常路径 = 13，建议修订为 ≥13，并删除注释中与表内数字矛盾的说明。

## 历史迭代回顾

### 已解决的问题

以下问题在前期迭代中已被识别并已在 v11 产出中修复，当前审查不再提及：
- 文档结构问题（§修订说明与正文分离）：第 10 轮问题 1 已通过剥离修订说明至独立文件并重写正文解决
- `Mat3x3/Mat4x4` `[]` mutable 引用验证、列字段名验证：第 10 轮问题 3/4 已在 §8 编码启动前验证项中新增验证项解决
- `T(Float64(n))` 语法可行性验证：第 10 轮问题 2 已在 §8 编码验证项中新增声明解决（v15 修订）
- `identity(one: T)` 无符号溢出语义：第 10 轮问题 7 已在 §3.3 item 5 v15 修订中补充说明
- `fromVec3` 反平行分支 `normalize(t)` 归一化步骤：第 10 轮问题 8 已在 §3.3 item 8 v15 修订中补充
- 文档版本号混乱（文件名为 v10 头声称 v14）：第 10 轮问题 9 已在 v15 统一版本号
- §5.3 整型 T 行为条目缺失：第 10 轮问题 10 已在 v15 新增

### 持续存在的问题（需重点解决）

以下问题在多轮反馈中反复出现，在 v11 产出中仍未解决：

1. **§3.7 `length`/§3.9 `axis` 依赖描述与 §1 不一致**（严重）——第 3 轮问题 7（Float32 sqrt 处理）、第 6 轮问题 7（std.math 重载修订）、第 11 轮问题 1/2/3 均指向同一根因：`§1 v11` 修订了 `std.math` 重载描述但 `§3.7/§3.9` 仍保留旧描述。v11 产出仅复制 v10 内容，未落实修正。需全文 grep 所有「仅支持 Float64」旧描述并替换。

2. **测试覆盖缺口**（一般）——第 1 轮问题 4（测试设计缺失）、第 5 轮问题 5（三角函数 VecN 展开）、第 7 轮问题 4（matrix_transform 函数清单）、第 11 轮问题 4/5/6/7 均指向测试策略不完整。当前仍存在：`gtc/matrix_transform.cj` 64 个 stub 无测试覆盖、「已实现但被 stub 阻塞」函数无专门覆盖类别、snake_case 命名遗留。

3. **`FloatingPoint<T>` 接口可用性验证滞后**（一般）——第 5 轮问题 1（getMin/getInf 不存在）、第 6 轮问题 8（FloatingPoint 接口实际提供方法）、第 11 轮问题 6 持续指向该基础性假设未经验证。v11 产出虽已在 §8 标注「未独立复核」，但未安排验证计划。

### 新发现的问题

1. **§8.2 `test_ext_scalar_constants.cj` 用例数矛盾**（轻微）——注释中「按原则应为 ≥12」与表内数字 ≥7 自相矛盾，且注释自身承认矛盾而未修正。属于 v15 修订引入的新不一致。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606241929_stage3-ood\a_v11_copy_from_v10.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606241929_stage3-ood\requirement.md
