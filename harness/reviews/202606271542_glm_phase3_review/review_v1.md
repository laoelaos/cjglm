# R1.1: Quat<T,Q> 结构体实现审查

审查时间：2026-06-27

### 审查范围

| 文件 | 行数 | 职责 |
|------|------|------|
| `cjglm/src/detail/type_quat.cj` | 162 | `Quat<T,Q>` 结构体定义 + extend 块（运算符/工厂/比较） |

**主依据**：`docs/05_ood_phase3.md` §3（核心抽象，§3.1/§3.3/§3.4）、§1「系统性设计约束（T(0)/T(1) 字面量替代）」

**辅助参照**：`cjglm/src/detail/type_vec3.cj`（阶段一 Vec3 风格基线）、`cjglm/src/detail/type_mat3x3.cj`（阶段二 Mat 风格基线）、`cjglm/src/detail/type_quat_cast.cj`（callee 约束传递关系）

### 发现

#### [严重] 无

无逻辑错误、数据丢失、崩溃风险或安全漏洞。Hamilton 乘积与四元数除法公式均与 GLM 1.0.3 数学定义一致，详见「正确性细节」附录。

#### [一般] 跨 Qualifier 构造函数 `init<Q2>` 缺失，以 `fromQual` 工厂替代

- **位置**：`cjglm/src/detail/type_quat.cj:56-64`（与 OOD §3.3 item 3 不符）
- **描述**：OOD §3.3 item 3 明确要求「**跨 Qualifier 构造 `init<Q2>(q: Quat<T,Q2> where Q2 <: Qualifier)`**——跨 Qualifier 同类型构造，纯赋值」。但实现中**未提供该 `init` 构造函数**，而是在 extend 块中提供静态工厂 `fromQual<Q2>(q: Quat<T, Q2>): Quat<T, Q> where Q2 <: Qualifier`（第 61-63 行）。两处 API 形态偏差：
  1. 调用方无法使用 OOD 承诺的 `Quat<Float32, Highp>(q_of_PackedHighp)` 构造语法，必须改写为 `Quat<Float32, Highp>.fromQual(q_of_PackedHighp)`。
  2. 静态工厂无法在 `const` 上下文使用（OOD 段落对阶段三所有「跨 Qualifier 调用需通过显式转换解决」的契约中默认构造函数是 const 可用路径）。
- **建议**：补充 `init<Q2>(q: Quat<T, Q2> where Q2 <: Qualifier) { this.x = q.x; this.y = q.y; this.z = q.z; this.w = q.w }` 构造函数（与 OOD §3.1 数据成员公开可见性一致，符合 OOD 段落「跨 Qualifier 行为一致性保证」）。`fromQual` 可保留作为别名（与矩阵家族 `fromMat` 风格对齐），但 `init` 必须存在。

#### [一般] `Vec3×Quat` / `Vec4×Quat` 实现路径与 OOD §3.4 不一致

- **位置**：`cjglm/src/detail/type_quat.cj:140-152`
- **描述**：OOD §3.4「Vec extend 块成员运算符」段明确要求 `Vec3×Quat` / `Vec4×Quat` 的实现为「`(conjugate(q) / dot(q, q) * v`」（**v18 内联逆四元数计算路径消除包间循环依赖**），最终通过同包 `Quat×Vec3` 运算符完成旋转从而**传播 stub 异常**。实现中两处函数体均为「`throw Exception("stub")`」（第 143、150 行），直接抛出 stub 而**未实现** OOD 承诺的 `conjugate(q) / dot(q, q) * v` 调用链。端到端运行时行为相同（均抛 stub），但实现路径偏离 OOD 设计意图。
- **额外影响**：
  1. 失去对 `conjugate`（已在 `quaternion_common.cj` 中实现）/ `dot`（已在 `quaternion_geometric.cj` 中实现）函数正确性的间接调用链验证。
  2. 阶段四补齐时需重新编写函数体（从「直接 throw」改为「计算 + 委托 `Quat×Vec3`」），而非仅将 `Quat×Vec3` 内部 stub 替换为正常实现即可。
- **建议**：按 OOD §3.4 v18 路径实现：
  ```cangjie
  // Vec3×Quat 伪码
  let qInv = conjugate(rhs) / dot(rhs, rhs)  // conjugate 与 dot 均为纯算术
  return qInv * this  // 委托 Quat×Vec3，最终抛 stub
  ```
  这样阶段四 `geometric.cj` 完整实现后，**仅替换** `Quat×Vec3` 内部 `cross` stub，Vec3×Quat 即可自动生效。

#### [一般] `fromMat3` / `fromMat4` 约束签名与 OOD §3.3 item 6/7 偏差

- **位置**：`cjglm/src/detail/type_quat.cj:73-81`
- **描述**：OOD §3.3 item 6 / item 7 明确规定 `fromMat3` / `fromMat4` 的签名为「`where T <: FloatingPoint<T>, Q <: Qualifier`」，但实现使用「`where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`」（第 73 行）。该偏差**编译期必需**——`type_quat_cast.cj:65, 69, 73` 中 `quatCast` 实现需通过比较 `fourXSquaredMinus1 > fourBiggest` 等 `>` 运算找出最大元素，要求 `T` 实现 `Comparable<T>` 接口；当前 `fromMat3` / `fromMat4` 透传调用 `quatCast`（`type_quat.cj:75, 79`）因此必须满足被调方的约束。
- **问题定性**：
  1. 偏差根源——OOD 文档与 `type_quat_cast.cj` 实现未同步，OOD §3.3 item 6/7 仅写 `FloatingPoint<T>` 而 OOD §3.2.1 `quatCast` 签名也仅写 `FloatingPoint<T>`（参见 `docs/05_ood_phase3.md:546-548`），实际 `quatCast` 实现需要 `Comparable<T>`，实现与 OOD 文档两侧均需更新。
  2. 用户影响——`Quat<Int64, PackedHighp>.fromMat3(m)` 仍然编译期拒绝（`Int64` 不实现 `FloatingPoint<Int64>`），但额外不放过所有不实现 `Comparable<T>` 的浮点类型——这与 OOD §3.3 段落「整型 T 实例化时编译报类型不匹配错误」的承诺等价。
- **建议**：
  1. 同步更新 OOD §3.3 item 6/7 与 §3.2.1 `quatCast` 签名为 `FloatingPoint<T> & Comparable<T>`，与 `type_quat_cast.cj` 实际约束一致。
  2. 当前实现可保留（无功能错误），但需在「偏差声明」段记录该差异。

#### [一般] `init(s: T, v: Vec3<T, Q>)` 未声明为 `const`，与 OOD §3.3 item 2 不符

- **位置**：`cjglm/src/detail/type_quat.cj:20-25`
- **描述**：OOD §3.3 item 2 明确要求「**标量+向量构造 `const init(s: T, v: Vec3<T,Q>)`**」。但实现为 `public init`（第 20 行，无 `const` 修饰符）。与主构造函数 `const init(x: T, y: T, z: T, w: T)`（第 13 行）的不对称性导致：
  1. `const val q = Quat<Float32, PackedHighp>(0.0f, v)` 在阶段三编译期失败。
  2. 与项目矩阵家族风格不一致——`type_mat3x3.cj:130` 的 `identity(one: T)` 同样需要 const 上下文，但已通过非 const 工厂实现。
- **建议**：将该 init 声明为 `public const init`（函数体仅访问 `v.x`/`v.y`/`v.z` 公开字段与赋值，**完全 const 可调用**，与 Vec3 主构造函数 `const init(x: T, y: T, z: T)` 模式一致）。如确因 Vec3 字段 const-eval 受限无法 const-ify，需在 OOD §3.3 item 2 增补「非 const」说明并在「偏差声明」段记录。

#### [轻微] `fromMat4` 实现路径未走 OOD §3.3 item 7 承诺的「手动列提取」

- **位置**：`cjglm/src/detail/type_quat.cj:78-80`
- **描述**：OOD §3.3 item 7 明确说明 `fromMat4` 应「**直接读取 m.c0/m.c1/m.c2 三列... 构建 Mat3x3<T,Q>(Vec3<T,Q>(...), Vec3<T,Q>(...), Vec3<T,Q>(...))，再调用同包 `quatCast(mat3x3)` 转换为四元数**」。但实现直接 `quatCast(m)`（第 79 行），由 `type_quat_cast.cj:112-120` 的 `quatCast<T, Q>(m: Mat4x4<T, Q>)` 重载内部完成 3×3 子矩阵提取并转发到 Mat3x3 重载。
- **影响**：端到端行为完全相同（`type_quat_cast.cj:114-119` 实现了 OOD 描述的列提取与构造过程）。属于「职责下沉」式实现调整——列提取从 `type_quat.cj` 下沉到 `type_quat_cast.cj`，符合 OOD §1「gtc/quaternion.cj 与 type_quat_cast.cj 的协作设计」段中「同包内可见，无 import 需求」的包间解耦原则。
- **建议**：保留当前实现（更优），同步更新 OOD §3.3 item 7 描述为「调用同包 `type_quat_cast.quatCast(Mat4x4)` 重载，列提取与 Mat3x3 构造在 callee 内部完成」，避免文档与实现长期偏离。

#### [轻微] `wxyz` 工厂未声明为 `const`

- **位置**：`cjglm/src/detail/type_quat.cj:29-31`
- **描述**：OOD §3.3 item 10 未对 `wxyz` 是否为 `const func` 作出明确规定。实现为非 const 工厂（第 29 行），函数体仅调用主构造函数 `Quat(x, y, z, w)`（而主构造函数是 `const init`），**完全 const 可调用**。声明为 const 后可在 `const val` 初始化中使用。
- **建议**：建议声明为 `public static const func wxyz(w: T, x: T, y: T, z: T): Quat<T, Q>`，与 OOD §3.1 「编译期查询函数」段对 `const func` 推广使用方向一致。属于可读性/可用性改进，无功能影响。

### 正确性细节附录

| 检查项 | 结论 | 备注 |
|-------|------|------|
| Hamilton 乘积公式（line 99-106） | ✅ 正确 | 逐分量展开与 GLM 1.0.3 `type_quat.inl` 公式逐项吻合：`result.x = w1*x2 + x1*w2 + y1*z2 - z1*y2` 等 |
| 四元数除法公式（line 109-117） | ✅ 正确 | `q1/q2 = q1*conjugate(q2) / ‖q2‖²` 展开与实现 line 110-116 各项吻合（含 `n2` 计算） |
| 数据布局 xyzw（line 8-11） | ✅ 正确 | 字段声明顺序 `x, y, z, w` 与 OOD §3.1 一致（GLM 默认布局） |
| `wxyz` 参数顺序与内部转置（line 29-31） | ✅ 正确 | 形参 `(w, x, y, z)` → 内部 `Quat(x, y, z, w)` 与 OOD §3.3 item 10 一致 |
| `init(s, v)` 标量作为 w 分量（line 20-25） | ✅ 正确 | `this.w = s` 字段映射与 OOD §3.3 item 2 一致 |
| `length() = 4`（line 27） | ✅ 正确 | 与 OOD §3.1 一致 |
| `[]` 边界检查 0 ≤ i < 4（line 33-53） | ✅ 正确 | assert + match fallthrough `throw` 双保险，与 Vec3 模式一致 |
| 4 个 stub 抛 `Exception("stub")`（line 121, 126, 143, 150） | ✅ 正确 | 与 OOD §3.4 一致 |
| `@OverflowWrapping` 标注（line 88-137） | ✅ 正确 | 二元算术运算符均标注，与 OOD §3.4 + 阶段一/二风格一致 |
| T(0) 字面量替代路径使用 | ✅ 正确 | `type_quat.cj` 中仅 `identity`（line 67-70）使用 `one - one` 演算，其余函数均不构造常量型 T(0)/T(1)（T(0)/T(1) 的构造已下沉到 `type_quat_cast.cj`），与 OOD §1「仅对已有 `one: T` 形参的函数保留 `one - one`」原则一致 |
| `Equatable<T>` 约束（line 154） | ✅ 正确 | 与 OOD §3.4「`==` → `Equatable<T>`」一致，且与 `type_vec3.cj:146` 风格一致 |
| `@Derive[Hashable]` + `public var`（line 6-11） | ✅ 正确 | 与 OOD §3.1 一致，且与阶段一/二 Vec/Mat 9 矩阵类型风格一致（200+ 处统一实践） |
| extend 块约束分组 | ✅ 正确 | 4 个 extend 块分别按「无约束 / `Number<T>` / `FloatingPoint<T> & Comparable<T>` / `Equatable<T>`」分组，与 OOD §1 约束选择策略及阶段一/二风格一致 |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 4 |
| 轻微 | 2 |

### 总评

`type_quat.cj` 整体实现质量**良好**，核心数学逻辑（Hamilton 乘积、四元数除法、约束选择、T(0)/T(1) 字面量路径）均与 OOD §3.1/§3.3/§3.4 及 §1 系统性设计约束**严格一致**，且与阶段一 Vec3（`type_vec3.cj`）和阶段二 Mat 家族（`type_mat3x3.cj` 等 9 个文件）的代码风格高度统一。4 个 stub 占位（`Quat*Vec3` / `Quat*Vec4` / `Vec3*Quat` / `Vec4*Quat`）按 OOD 约定正确抛 `Exception("stub")`。

**主要遗留问题**集中在 **OOD 文档与实现的双向同步**：
- `init<Q2>` 构造函数缺失（OOD §3.3 item 3 承诺 vs 实际只有 `fromQual` 工厂）—— 属于 API 形态偏差，建议补齐。
- `fromMat3` / `fromMat4` 约束使用 `Comparable<T>`（callee 强制），OOD 文档 §3.3 item 6/7 与 §3.2.1 `quatCast` 签名均需同步更新。
- `Vec3×Quat` / `Vec4×Quat` 实际直接 throw 而非走 OOD §3.4 v18 内联 conjugate/dot 路径——阶段四补齐时需重写函数体（从 throw 改为委托 `Quat×Vec3`）。
- `fromMat4` 列提取下沉到 `type_quat_cast.cj`（实现路径优化）——OOD 文档 §3.3 item 7 描述应同步更新。

上述问题均**不阻塞**阶段三发布（无逻辑错误、无运行时风险），属于「OOD 文档与实现双向同步」类清理项。建议在阶段三文档冻结前完成 OOD 文档与 `type_quat.cj`/`type_quat_cast.cj` 实现的同步修订，并将上述差异纳入 `docs/deviations.md` 暂存记录。
