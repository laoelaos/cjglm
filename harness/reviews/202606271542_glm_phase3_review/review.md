# 阶段三代码审查进度跟踪

## 审查范围

详见 `scope.md`

## 进度

| 轮次 | 状态 | 报告 | 严重 | 一般 | 轻微 | 总评 |
|------|------|------|------|------|------|------|
| R1 核心类型层 | ✅ 完成 | `review_v1.md`/`review_v1_r2.md`/`review_v1_r3.md` | 2 | 11 | 5 | 总体良好，type_quat_cast.cj 存在严重算法 bug |
| R2 ext/ 四元数函数库 | ✅ 完成 | `review_v2.md`/`review_v2_r2.md`/`review_v2_r3.md` | 0 | 12 | 6 | 实现与 OOD 高度一致 |
| R3 ext/ 通用 + gtc/ + 顶层 | ✅ 完成 | `review_v3.md`/`review_v3_r2.md`/`review_v3_r3.md` | 0 | 8 | 7 | 总体良好；fwd.cj.bak 待清理 + lib.cj 偏离 + 幂等性问题 |
| R4 测试与跨模块集成 | ✅ 完成 | `review_v4.md`/`review_v4_r2.md`/`review_v4_r3.md` | 4 | 11 | 10 | 测试基础设施严重缺陷：tests/ 不被 cjpm test 发现 |

## 详细记录

### R1 核心类型层

#### Agent 1: `type_quat.cj`（0 严重 / 4 一般 / 2 轻微）
- **总评**：实现质量良好，Hamilton 乘积、四元数除法、约束选择、T(0)/T(1) 字面量路径均与 OOD §3.1/§3.3/§3.4 及 §1 系统性设计约束严格一致
- **4 个 stub 占位**（`Quat*Vec3`/`Quat*Vec4`/`Vec3*Quat`/`Vec4*Quat`）正确抛 `Exception("stub")`
- **遗留问题**（一般）：
  - 缺失 `init<Q2>` 跨 qualifier 构造函数（OOD §3.3 item 3 承诺 vs 实际只有 `fromQual` 工厂）
  - `fromMat3`/`fromMat4` 约束使用 `Comparable<T>`（callee 强制），需同步 OOD §3.3 item 6/7 与 §3.2.1 `quatCast` 签名
  - `Vec3×Quat`/`Vec4×Quat` 直接 throw 而非走 OOD §3.4 v18 内联 conjugate/dot 路径——阶段四补齐时需重写
  - `fromMat4` 列提取下沉到 `type_quat_cast.cj`——OOD §3.3 item 7 描述应同步更新

#### Agent 2: `type_quat_cast.cj`（2 严重 / 3 一般 / 1 轻微）
- **总评**：包间依赖方向严格符合 OOD §2「`glm.gtc → glm.detail` 单向依赖」约束（实测无任何 `glm.gtc`/`glm.ext` 跨包 import），`mat3Cast`/`mat4Cast` 矩阵填充公式正确
- **严重问题**：
  1. **quatCast 算法因子 2 缩放 bug**——所有 4 个分支将非最大分量的 `/v` 模式实现为 `(非最大分量差) / (2*最大分量)` 而非 GLM 期望的 `(非最大分量差) / (4*最大分量)`，导致 round-trip 失败
  2. **测试覆盖真空**——`tests/glm/detail/test_type_quat_cast.cj`（8 个测试用例）**未被 cjpm test 发现/执行**，与 OOD §11.5「≥2 用例/函数」要求相悖
- **一般问题**：
  - `quatCast` 中 4 个 `var` 初始化 + 多次 `if` 重新赋值的控制流可优化（建议保留）
  - `quatCast(Mat4x4)` 列布局假设 `c0/c1/c2` 行为预期的一致性需文档说明（可选）
  - 工具函数 `sqrtT` 和 `zeroOrOne` 命名/使用不一致

#### Agent 3: `scalar_quat_ops.cj` + `scalar_constants.cj`（0 严重 / 4 一般 / 2 轻微）
- **总评**：实现简洁，与阶段一 `scalar_vec_ops.cj` 命名约定一致
- `scalar_quat_ops.cj`：4 函数 + `@OverflowWrapping` + `Number<T>` 约束 + `Qualifier` 约束，构造顺序与 `type_quat.cj:13` 主构造函数对齐
- `scalar_constants.cj`：3 函数实现正确（`epsilon<T>()` 委托 `epsilonOf`，`pi<T>()` 使用 `FloatingPoint<T>.getPI()` 静态方法，`cos_one_over_two<T>()` 硬编码 `0.877582561890372716` = `cos(0.5)` ✓）
- **一般问题**：
  - 标量-四元数运算因运算符重载规则采用全局函数而非 Quat 成员运算符，建议登记到 `deviations.md`
  - 可优化项：`pi<T>()`/`cos_one_over_two<T>()` 运行时类型分派可简化为 `FloatingPoint<T>` 接口调用

### R2 ext/ 四元数函数库

#### Agent 1: `quaternion_common.cj` + `quaternion_geometric.cj`（0 严重 / 5 一般 / 2 轻微）
- **总评**：实现与 OOD §3.7/§3.8 高度一致，`conjugate`/`inverse`/`lerp`/`dot`/`length`/`normalize`/`cross` 公式均与 GLM 1.0.3 一致
- **关键问题**：
  - **`slerp` 4 参数版本 `spin: Bool` 与 OOD §3.11/D22 决策 `k: Int64` 显著偏离**——OOD 三处声明 `k: Int64`，实现为 `spin: Bool`
  - `mix` 约束 `Number<T>` 较 GLM `is_iec559` 静态断言过宽
  - `lerp` 约束 `Number<T> & Comparable<T>` 较 GLM `is_iec559` 静态断言过宽
  - `length` 使用 `sqrtT` Float64 中转包装，未按 OOD §1 方案 A 直接调用 `std.math.sqrt` 重载

#### Agent 2: `quaternion_relational.cj` + `quaternion_trigonometric.cj` + `quaternion_transform.cj` + `quaternion_exponential.cj`（0 严重 / 1 一般 / 0 轻微）
- **总评**：实现与 OOD §3.6/§3.8/§3.9/§3.10 高度一致，86 行实现紧凑无冗余
- `quaternion_relational.cj`：4 函数完整实现（精确 + epsilon），与 `vector_relational.cj` 策略一致（内联 abs 模式，避免依赖 `common.cj` stub），与 OOD §3.6 对齐
- `quaternion_trigonometric.cj`：`axis` 函数公式正确，`angle`/`angleAxis` stub 正确
- `quaternion_transform.cj`：仅含 `rotate` stub
- `quaternion_exponential.cj`：4 函数全部 stub
- **一般问题**：`sqrtT` 助手走 Float64 转换路径偏离 OOD §1 方案 A

#### Agent 3: `vector_relational.cj`（0 严重 / 6 一般 / 4 轻微）
- **总评**：实现与 OOD §3.5 完全对齐，16 epsilon + 8 ULP 完整
- 16 个 epsilon 重载完整覆盖（Vec1~Vec4 × Int32/UInt32/Float32/Float64 × equal/notEqual）
- 8 个 ULP stub 正确抛 `Exception("stub")`
- 算法正确（`|x-y| < epsilon` 与 GLM `epsilonEqual` 一致）
- 依赖 `glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier}` 正确
- **一般问题**：
  - abs 内联模式重复 16 次，可抽取为包内私有辅助函数
  - ULP stub 测试覆盖不全（Vec2/Vec3/Vec4 的 stub 路径未验证）
  - 与 `ext/quaternion_relational.cj` 的 abs 内联模式未抽取共享，存在跨文件重复
  - 阶段一 `equalEpsilon` 与阶段三 `equal` epsilon 重载的约束风格不一致
  - epsilon 重载未声明 `const func`
  - 测试中 `testEqualVec1NegativeDiff` 与 `testEqualVec1ScalarEpsilon` 重复覆盖同一用例

### R3 ext/ 通用 + gtc/ + 顶层

#### Agent 1: `gtc/constants.cj` + `gtc/quaternion.cj`（0 严重 / 2 一般 / 3 轻微）
- **总评**：实现质量良好，严格遵循 OOD §3.12/§3.15 设计意图
- `constants.cj`：28 个常量函数清单与 OOD §3.12 完全一致，统一使用 `FloatingPoint<T>` 约束，模式 `(Float64(VALUE) as T).getOrThrow()` 与 OOD §1 一致；测试覆盖 56 个用例（28 × Float32/Float64）
- `quaternion.cj`：4 比较函数实现正确、7 stub 签名模板与 OOD 一致、4 转换函数重导出 `public import` 语法合法、依赖方向正确
- **一般问题**：
  - 依赖声明与 OOD §3.15 不一致：缺少 `import glm.ext.vector_relational.*` 和 `import glm.ext.scalar_constants.*` 两项
  - 4 个比较函数 `Vec4<Bool, Q>(...)` 缺少显式类型参数

#### Agent 2: `gtc/matrix_transform.cj` + `ext/matrix_*.cj` + `detail/trigonometric.cj`（0 严重 / 2 一般 / 2 轻微）
- **总评**：所有函数签名完整、stub 实现正确、约束选择合理
- `gtc/matrix_transform.cj`：64 个函数签名与 OOD §3.13 表格一致；全部 64+1+1+1+75 = 142 个 stub 正确抛 `Exception("stub")`；统一 `FloatingPoint<T>` 约束
- `trigonometric.cj`：75 个签名与 OOD §3.13.1 一致；统一 `FloatingPoint<T>` 约束
- 依赖方向正确（`glm.gtc → glm.detail` 单向，无循环）
- **一般问题**：
  - `gtc/matrix_transform.cj` import 列表未显式声明传递依赖（编译 OK 但意图表达缺失）
  - `trigonometric.cj` 头部缺少与 OOD §3.13.1 「T 类型约束策略」一致的引用说明

#### Agent 3: `fwd.cj` + `lib.cj` + `gen_fwd_aliases.py`（0 严重 / 4 一般 / 2 轻微）
- **总评**：3 个文件整体质量良好
- `fwd.cj`：9 个 Quat 别名生成完全符合 OOD §2 要求，不包含禁止的 `Quat1/2/3`、`HighpFQuat` 等错误变体；命名空间导入策略正确沿用 INT-03 模式
- `lib.cj`：原有 7 个 import 完整保留，新增 4 条 import 通过通配符策略实现 20 条 import 的功能等价覆盖
- `gen_fwd_aliases.py`：独立 `QUAT_BASE`/`QUAT_PRECISIONS` 字典避免污染 Vec 循环
- **一般问题**：
  - **`fwd.cj.bak` 备份文件含 OOD 禁止的错误变体**——【必清】
  - **`gen_fwd_aliases.py` 在 Windows 上破坏幂等性**（CRLF→LF 强制转换）——【必改】
  - `lib.cj` 行数偏离 OOD 预期（16 行 vs 28 行）——通配符导入策略所致
  - `lib.cj` 触发 17 个 unused import 编译警告
- **轻微**：OOD §2 别名描述与实际 qualifier 名称不一致（OOD 写 `Highp`/`Mediump`/`Lowp`，实际是 `PackedHighp`/`PackedMediump`/`PackedLowp`）

### R4 测试与跨模块集成

#### Agent 1: `tests/glm/detail/*`（2 严重 / 5 一般 / 2 轻微）
- **总评**：5 个测试文件 71 个 `@Test` 函数全部**未被 cjpm test 发现/执行**——严重的基础设施缺陷
- **严重问题**：
  1. **全部 5 个测试文件均未被 cjpm test 发现/执行**——71 个 @Test 函数被静默跳过
  2. **`test_type_quat_cast.cj` 仅依赖 round-trip 测试**——无法捕获 R1-Agent2 报告的 quatCast 因子 2 缩放算法 bug
- **一般问题**：
  - `test_type_quat.cj` 用例数 30 显著低于 OOD §8.2 计划 ≥40 下限（缺失 10+ 用例）
  - `test_trigonometric_stub.cj` 仅覆盖 75 个函数签名中的 16 个
  - `test_scalar_constants.cj` 缺失整数 T 异常路径测试
  - `test_scalar_quat_ops.cj` 缺失 T×Quat 反向运算符与边界用例
  - `test_type_quat.cj` 浮点 round-trip 测试未使用容差

#### Agent 2: `tests/glm/ext/*` + `tests/glm/gtc/*`（1 严重 / 3 一般 / 5 轻微）
- **总评**：7 个测试文件 810 行 111 个 `@Test` 函数整体质量良好，覆盖策略清晰
- 16 个 epsilon 重载完整覆盖（Vec1~Vec4 × equal/notEqual）
- 完整实现函数覆盖完整，边界条件（normalize 零保护、inverse 零四元数、lerp assert 越界、epsilon=0 严格小于）有针对性测试
- 56 个常量 × Float32/Float64 双类型覆盖超额满足
- **严重问题**：ULP stub 覆盖严重不完整——8 个 stub 函数中仅 1 个被测试覆盖
- **一般问题**：slerp 4 参数重载无任何测试、`gtc/test_quaternion.cj` 缺少 mat3Cast/mat4Cast/quatCast 重导出的 gtc 命名空间独立测试

#### Agent 3: `test_fwd.cj` + `test_lib.cj` + 跨模块集成（1 严重 / 3 一般 / 3 轻微）
- **总评**：跨模块依赖方向完全合规，cjpm 子包机制识别 `src/gtc/`，cjpm build 成功
- 9 个 Quat 别名逐项覆盖，gen_fwd_aliases.py 幂等
- **严重问题**：`tests/` 目录下的测试文件未被 cjpm test 发现执行——cjpm 1.1.0 工具链遵循「`src/**/*_test.cj` 下划线后缀」约定，与项目 `tests/**/test_*.cj` 前缀约定不符，导致 165+ 测试静默跳过
- **一般问题**：
  - lib.cj 的 import 与 OOD §2「20 个新增 import 清单」存在结构偏差
  - lib.cj 缺少 OOD §2 指定的 `Quat` 的 public import
  - gtc/quaternion.cj 缺少 OOD §3.15 指定的两项 ext import

### 跨模块依赖方向校验（OOD §2）
| 校验项 | 结论 |
|--------|------|
| `glm.detail` 不依赖任何上层包 | ✅ 通过 |
| `glm.ext → glm.detail` 单向 | ✅ 通过 |
| `glm.gtc → glm.detail` 单向 | ✅ 通过（但偏离 §3.15 line 1276-1277 指定的 ext import） |
| 无循环依赖 | ✅ 通过（cjpm build 成功） |
| `src/gtc/` + `package glm.gtc` 被 cjpm 子包机制识别 | ✅ 通过 |