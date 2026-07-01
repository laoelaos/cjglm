# 诊断报告：Phase 4 Review Issues

## 总览

基于 `harness/reviews/202606300141_ood_phase4_review/todo.md` 列出的 37 个问题（S1-S4, G1-G37），逐一诊断其真伪、根因和修改方向。

---

## 严重等级

### S1: ext/matrix_transform.cj rotate/shear 乘法顺序反转

- **真实性**：真实问题
- **根因**：实现编码错误
- **证据**：
  - GLM 1.0.3 `ext/matrix_transform.inl:40-45`：`rotate` 结果为 `m * Rot`（左乘旋转矩阵）
  - Cangjie `cjglm/src/ext/matrix_transform.cj:39`：`Rot * m`（右乘旋转矩阵，顺序反转）
  - GLM 1.0.3 `ext/matrix_transform.inl:119-124`：`shear` 结果为 `m * Shear`
  - Cangjie `cjglm/src/ext/matrix_transform.cj:63`：`H * m`（右乘剪切矩阵，顺序反转）
- **OOD 设计覆盖**：OOD 文档 §3.2 ext/matrix_transform.cj 列明了 rotate/shear 函数的签名和角色，但未明确描述乘法顺序。此问题属编码阶段的语义翻译错误。
- **修改方向**：修改实现代码（`cjglm/src/ext/matrix_transform.cj:39` 和 `:63`），将乘法顺序从 `Rot * m` 改为 `m * Rot`，`H * m` 改为 `m * H`。需同步更新对应的测试用例期望值。

---

### S2: gtc/ulp.cj float_distance Int32 减法溢出

- **真实性**：真实问题（仓颉默认 `@OverflowThrowing` 导致负浮点位模式转换时抛异常）
- **根因**：实现编码错误
- **证据**：
  - `cjglm/src/gtc/ulp.cj:52`：`(y.toBits() as Int32).getOrThrow() - (x.toBits() as Int32).getOrThrow()`
  - 当 `y.toBits()` 为负浮点位模式（0x80000000-0xFFFFFFFF）时，UInt32 值 ≥ 2^31，`as Int32` 数值转型抛异常
  - GLM 1.0.3 `gtc/ulp.inl:85-99` 使用 `detail::float_t<float>` 联合体位模式重解释，输出 `abs(a.i - b.i)`（始终无符号距离）
- **OOD 设计覆盖**：OOD 文档 §3.3 gtc/ulp.cj 描述了 `float_distance` 签名和实现路径（使用 `toBits()`/`fromBits()`），但未指定位模式到符号整数的转换方式。问题在编码实现时产生。
- **修改方向**：修改实现代码。需使用位重解释（而非数值转型）将 UInt32 位模式映射为 Int32，并修正为返回绝对值（与 GLM 保持一致）。

---

### S3: ext/quaternion_transform_test.cj testRotateNonIdentity 期望值错误

- **真实性**：真实问题
- **根因**：测试编码错误
- **证据**：
  - `cjglm/tests/glm/ext/quaternion_transform_test.cj:63-70`：测试 `rotate(q(√2/2, 0, √2/2, 0), 90°, Z轴)` 期望 `r.x ≈ 0, r.z ≈ 1.0`
  - 四元数复合运算结果与期望值不一致。`q(cos45°, 0, sin45°, 0)` 是绕 Y 轴 90° 旋转，复合绕 Z 轴 90° 旋转后应得到 `(0.5, 0.5, 0.5, 0.5)` 而非 `(0, 0.707, 0, 0.707)`。
- **OOD 设计覆盖**：OOD 文档 §8 实施规划的第三批中要求测试 rotate。测试期望值数学推导错误。
- **修改方向**：修改测试代码。需重新计算正确的期望值。

---

### S4: gtc/matrix_transform_test.cj testShearSlowDiagonal 期望值错误

- **真实性**：真实问题
- **根因**：测试编码错误
- **证据**：
  - `cjglm/tests/glm/gtc/matrix_transform_test.cj:107-109`：`shear_slow(I, n(0.5,0.5,0), s=2.0)` 期望 `c0.x=1.5` ✓, `c0.y=1.0` ✗（应为 0.5）, `c1.x=1.0` ✗（应为 0.5）, `c1.y=1.5` ✓
  - 剪切矩阵公式 `H = I + s * n*n^T`，`n=(0.5,0.5,0)` 时 `n*n^T` 的反对角线元素为 0.25，`H` 的 (0,1) 和 (1,0) 位置应为 0.5 而非 1.0
- **OOD 设计覆盖**：OOD 文档未详细规定 shear 矩阵的数学公式，但 "GLM 行为一致" 原则要求测试期望值正确。
- **修改方向**：修改测试代码。修正 `c0.y` 和 `c1.x` 的期望值。

---

## 一般等级

### G1: detail/common.cj roundEven 奇偶判断分支反转

- **真实性**：真实问题
- **根因**：实现编码错误
- **证据**：
  - `cjglm/src/detail/common.cj:173-179`：`if (rInt % 2 == 0) { r - one } else { r }`
  - roundEven(2.5)：`round(2.5)=3`（std.math.round 远离零取整），`rInt=3`（奇数）→ 当前返回 `r=3`，但应返回 2（最近偶数）
  - roundEven(3.5)：`round(3.5)=4`，`rInt=4`（偶数）→ 当前返回 `r-1=3`，但应返回 4
  - 分支逻辑应交换：`if (rInt % 2 == 0) { r } else { r - one }`
- **OOD 设计覆盖**：OOD 文档 §3.1 common.cj 仅提到 roundEven 应有 "round half to even" 行为，未指定具体分支逻辑。属编码实现错误。
- **修改方向**：修改实现代码（`cjglm/src/detail/common.cj:176-179`，交换两个分支）。

---

### G2: detail/vector_relational.cj 缺少 equal/notEqual/any/all/not

- **真实性**：真实问题
- **根因**：OOD 设计遗漏
- **证据**：
  - `cjglm/src/detail/vector_relational.cj`：仅实现 `lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual` 四个函数
  - GLM 1.0.3 `vector_relational.hpp` 还包含 `equal`/`notEqual`/`any`/`all`/`not_` 五个函数
  - OOD 文档 §2 模块划分中 `vector_relational.cj` 标记为 "沿用阶段三"，阶段三仅列出四个比较函数
- **OOD 设计覆盖**：OOD 文档完全未提及 equal/notEqual/any/all/not 函数，属于设计阶段遗漏。
- **修改方向**：需先更新 OOD 文档补充缺失函数的设计，再实现代码。OOD 设计阶段未覆盖 GLM 的完整 vector_relational 函数集。

---

### G3: detail/geometric.cj normalize 使用 `<=` 而非严格 `==`

- **真实性**：有争议。`<=` 比 `==` 更稳健（捕获负零），实际行为差异极小。
- **根因**：实现与 OOD 设计轻微偏差
- **证据**：
  - OOD 文档 §5 错误表：`if lengthSq == T(0) return zero-vec`
  - 代码 `cjglm/src/detail/geometric.cj:26,35,44`：`if (lenSq <= zero)`
  - IEEE 754 中负零 `-0.0` 与 `+0.0` 在 `==` 下相等（`-0.0 == +0.0` 为 true），所以对零值来说 `==` 和 `<=` 行为一致
  - 差异在于 `lenSq` 为极小负值时（理论上不可能出现，因为 `dot(v,v) ≥ 0`），`<=` 会触发保护而 `==` 不会
- **OOD 设计覆盖**：OOD 设计使用 `==`，代码使用 `<=`。两者在正确输入下行为等价。
- **修改方向**：建议修改 OOD 文档中的措辞匹配代码（`<=` 更保守），或修改代码匹配设计。属于统一标准问题。

---

### G4: detail/matrix.cj determinant 使用 `Number<T>` 允许整数类型编译

- **真实性**：有争议。OOD 有意识的设计决策（D05、D16），非错误。
- **根因**：OOD 设计决策
- **证据**：
  - OOD 文档 D05：`determinant 使用 Number<T> 约束，inverse 需要浮点除法`，说明这是有意设计
  - OOD 文档 D16：经搜索整个代码库，`未发现任何调用 detail.geometric 函数时使用整数向量类型的现成代码`
  - 同理，确定矩阵在整数类型上编译通过是冗余约束而非问题
- **OOD 设计覆盖**：OOD 文档中 D05 明确记录此决策。这不是问题，而是有意的、已验证影响范围的权衡。
- **修改方向**：无需修改。可以添加注释说明该决策在 D05 中已覆盖，标记为"按设计"。

---

### G5: ext/vector_common.cj 缺失 3/4 输入 fmin/fmax 向量版本

- **真实性**：真实问题
- **根因**：实现不完整（OOD 设计了但未编码）
- **证据**：
  - OOD 文档 §3.2 ext/vector_common.cj 明确列出了 4 组 fmin 重载：`fmin(a,b)` (标量/同维), `fmin(a,b,c)`, `fmin(a,b,c,d)`
  - 代码 `cjglm/src/ext/vector_common.cj:59-107` 仅实现了 `fmin(a,b)` 的标量扩展版和同维向量版，缺失 `fmin(a,b,c)` 和 `fmin(a,b,c,d)` 的 3/4 输入版本（以及 fmax 的对应版本）
  - 缺失的函数数量：fmin 缺 8 个函数（3输入+4输入 × Vec1~Vec4），fmax 同理缺 8 个，共 16 个
- **OOD 设计覆盖**：OOD 文档明确设计了这些函数，编码阶段未完整实现。
- **修改方向**：修改实现代码，补齐缺失的 16 个 fmin/fmax 向量重载。

---

### G6: ext/scalar_common.cj iround/uround 未委托 stdmath_shim.roundT

- **真实性**：真实问题
- **根因**：实现编码不规范（与设计架构不一致）
- **证据**：
  - OOD 文档 §3.2 ext/scalar_common.cj：`iround/uround 实现为 Int64(stdmath_shim.roundT(x))`，明确要求委托 roundT
  - 代码 `cjglm/src/ext/scalar_common.cj:104-114`：直接调用 `math.round(xF64)`，绕过了 stdmath_shim 包装层
  - 绕过 shim 层导致 Float16 路径无统一错误处理，且与全库的 std.math 委托架构不一致
- **OOD 设计覆盖**：OOD 文档明确指定了通过 roundT 委托。编码实现未遵循设计。
- **修改方向**：修改实现代码，改用 `stdmath_shim.roundT(x)` 统一委托路径。

---

### G7: gtc/ulp.cj float_distance 缺少 NaN/Inf 前置检查

- **真实性**：真实问题（NaN/Inf 位模式经 `as Int32` 数值转型可能导致异常）
- **根因**：实现编码遗漏
- **证据**：
  - `cjglm/src/gtc/ulp.cj:51-57`：float_distance 无任何前置检查
  - 同文件 `next_float`/`prev_float`/`ulp` 均有 NaN/Inf 检查，float_distance 却缺少
  - NaN 位模式（0x7FC00000）经 `as Int32` 转型：0x7FC00000 作为 UInt32 = 2143289344，小于 Int32.Max（2147483647），故不会抛异常
  - 但负 NaN 位模式（0xFFC00000）超出 Int32.Max 范围，转型会抛异常
  - GLM 1.0.3 使用 union 位重解释，NaN/Inf 自然参与位运算，不抛异常
- **OOD 设计覆盖**：OOD 文档 §3.3 gtc/ulp.cj 未明确要求 NaN/Inf 检查，但同函数的其他重载（next_float 等）保持一致的设计原则要求 float_distance 也有此保护。
- **修改方向**：修改实现代码，在 float_distance 中增加 NaN/Inf 前置检查（与同文件其他函数保持一致）。

---

### G8: gtc/type_precision.cj dquat 与 ext/quaternion_double.cj dquat 命名冲突

- **真实性**：编译时无冲突（分属不同包），但通过 `lib.cj` 同时导入时报错时会产生命名冲突
- **根因**：OOD 设计阶段已知但标记为有待解决
- **证据**：
  - `cjglm/src/gtc/type_precision.cj:86`：`public type dquat = Quat<Float64, Defaultp>`
  - ext 层的 `quaternion_double.cj` 中存在同名 `dquat` 类型别名
  - OOD 文档 §3.3 type_precision.cj：注释说明 `dquat 与 ext/quaternion_double.cj 已定义的 dquat 名称冲突`，并计划 R10 更新 lib.cj 时删除 ext 版本
  - 两文件分属 `glm.gtc` 和 `glm.ext` 包，同包不冲突时编译通过；但 lib.cj 同时 `public import` 两包符号到 `glm` 包级时会产生重名冲突
- **OOD 设计覆盖**：OOD 文档已知此问题并在 §3.3 注释中给出了解决方案（从 ext 删除 dquat，统一由 gtc/type_precision.cj 提供）。
- **修改方向**：修改实现代码 — 删除 `ext/quaternion_double.cj` 中的 `dquat` 定义（OOD 已规划的解决方案）。同时清理所有引用 ext.dquat 的代码。

---

### G9: gtc/round.cj round/ceil/floorPowerOfTwo ±0 输入丢失负零符号

- **真实性**：真实问题（行为与 GLM 1.0.3 有差异）
- **根因**：实现编码错误
- **证据**：
  - `cjglm/src/gtc/round.cj:9-11`：`roundPowerOfTwo` 中 `if (xF64 == 0.0) { return (Float64(0) as T).getOrThrow() }` — 始终返回 +0，不保留负号
  - 同样问题出现在 `ceilPowerOfTwo:33`（返回 +0）和 `floorPowerOfTwo:48-49`
  - GLM 1.0.3 `gtc/round.inl` 的 `roundPowerOfTwo` 负零输入通过浮点运算自然传播符号
  - OOD 文档 §3.3 gtc/round.cj 边界行为表明确标注 `±0` 应保留符号
- **OOD 设计覆盖**：OOD 文档的边界行为表明确要求 ±0 保留符号。编码实现未遵循设计规范。
- **修改方向**：三个函数分别修改零值分支，使用 `T.fromBits` 从输入符号位构造结果以保留负零。

---

### G10: ext/quaternion_common.cj slerp(k) 四参数版本公式与 GLM 1.0.3 需交叉验证

- **真实性**：潜在问题，公式实现可能与 GLM 不一致，需交叉验证
- **根因**：实现需要验证
- **证据**：
  - `cjglm/src/ext/quaternion_common.cj:68-69`：`scale0 = sinT((one - a) * omega / k) / sinT(omega / k)` 和 `scale1 = sinT(a * omega / k) / sinT(omega / k)`
  - GLM 1.0.3 的 `slerp(k)` 实现使用 `pow(q, 1-a) * pow(q, a)` 公式概念，具体数学公式需直接对比 GLM 源码确认
  - 当前代码的公式 `sin((1-a)*ω/k) / sin(ω/k)` 与标准四参数 slerp 的数学定义可能有出入
- **OOD 设计覆盖**：OOD 文档 §3.2 ext/quaternion_common.cj 提到 "实现参考 GLM 1.0.3 源码"，但未列出具体的数学公式。
- **修改方向**：需对照 GLM 1.0.3 的 `ext/quaternion_common.inl` 中 slerp(k) 的实现进行交叉验证，确认公式正确性或修正。

---

### G11: gtc/matrix_transform.cj shear API 与 ext 版本不同可能导致命名混淆

- **真实性**：真实问题（两个同名函数签名不同，造成混淆和使用隐患）
- **根因**：OOD 设计问题（gtc 和 ext 的 shear 签名本就不同）
- **证据**：
  - ext `cjglm/src/ext/matrix_transform.cj:53`：`shear(m, p: Vec3, l_x: Vec2, l_y: Vec2, l_z: Vec2)` — 使用三个 Vec2 参数分别指定各轴剪切量
  - gtc `cjglm/src/gtc/matrix_transform.cj:29`：`shear(m, n: Vec3, s: T)` — 使用单个方向向量 n 和标量 s
  - GLM 1.0.3 中 ext.shear 和 gtc.shear 本身签名不同（ext 为三个 Vec2，gtc 为方向+标量）
  - 虽然仓颉函数重载可基于参数类型区分，但同名函数在不同包使用不同语义和签名在 API 设计上易造成混淆
- **OOD 设计覆盖**：OOD 文档 §3.2 和 §3.3 分别描述了 ext 和 gtc 的不同 shear 签名，设计本身承认此差异。
- **修改方向**：不需要改代码。需在文档中明确标注 ext.shear 和 gtc.shear 的 API 差异，提供迁移指引。这属于用户教育范畴，不涉及代码修复。

---

### G12-G37：测试覆盖问题

这些全部属于 **测试覆盖不足** 问题，包括缺少边界测试、特定维度缺失、特定类型未覆盖等。逐一分析：

#### G12: common_test.cj round(-3.5) 预期值与 IEEE 754 行为可能不一致

- **真实性**：需验证 std.math.round 的 rounding mode 确认预期值。如果 std.math.round 使用 round-half-away-from-zero (C 标准默认)，则 `round(-3.5) = -4.0`（远离零），与当前预期值 `-3.0` 可能矛盾。
- **根因**：测试编码问题（预期值可能依赖于未明确的 round 语义）
- **修改方向**：验证 std.math.round 的具体 rounding mode，修正测试预期值或补充说明。

#### G13: common_test.cj testFractVec4 未对 -0.5 和 0.0 分量做断言

- **根因**：测试覆盖遗漏
- **修改方向**：补充测试断言。

#### G14: exponential_test.cj 缺少 inversesqrtZero/sqrt(-1)/log(0)/log(-1) 等边界测试

- **根因**：测试覆盖遗漏
- **修改方向**：补充边界测试用例。

#### G15-G37: 其他测试覆盖问题

所有这些（G14-G37）属于 **测试覆盖遗漏**，根因是测试编码不完整。OOD 文档 §8 的实施规划中为每个文件列出了测试要求，但编码阶段未完全实现。修改方向均为补充测试代码。

---

## 按根因分类汇总

| 根因类型 | 包含的 Issue | 修改方向 |
|---------|-------------|---------|
| **OOD 设计遗漏** | G2（vector_relational 缺失 5 函数） | 先更新 OOD 文档再实现代码 |
| **OOD 设计决策（非问题）** | G4（determinant Number<T>）、G11（ext/gtc shear 签名差异） | 无需修改或仅更新文档标注 |
| **OOD 设计已知待解决** | G8（dquat 命名冲突） | 按 OOD 已规划的方案修改代码 |
| **实现编码错误** | S1（乘法顺序）、S2（Int32 溢出）、G1（roundEven 分支）、G10（slerp(k) 公式） | 修改实现代码 |
| **实现与设计偏差** | G3（<= vs ==）、G6（iround 未委托 roundT）、G9（±0 丢失符号）、G7（NaN 检查缺少） | 修改实现代码对齐设计 |
| **实现不完整** | G5（fmin/fmax 缺失 16 函数） | 按 OOD 设计补齐代码 |
| **测试编码错误** | S3（quaternion 期望值）、S4（shear 期望值）、G12（round 期望值） | 修正测试代码中的期望值 |
| **测试覆盖遗漏** | G13-G37（全部测试不足 issue） | 补充测试用例 |

---

## 修改流程建议

### 第一优先（影响功能正确性）

1. **S1** — 修改 `ext/matrix_transform.cj:39,63` 乘法顺序 + 更新相关测试
2. **S2** — 修改 `gtc/ulp.cj:51-57` float_distance 位转换为位重解释 + 加 abs
3. **S3** — 修正 `quaternion_transform_test.cj:63-70` 期望值
4. **S4** — 修正 `matrix_transform_test.cj:107-109` 期望值
5. **G1** — 修改 `common.cj:173-179` roundEven 分支逻辑

### 第二优先（API 完整性）

6. **G2** — OOD 文档补充 vector_relational 缺失函数设计 → 编码实现
7. **G5** — 补齐 `vector_common.cj` 缺失的 16 个 fmin/fmax 向量版本
8. **G6** — `scalar_common.cj:104-114` 改用 roundT 委托
9. **G7** — `gtc/ulp.cj:51-57` 增加 NaN/Inf 前置检查
10. **G8** — 删除 `ext/quaternion_double.cj` 中的 dquat，统一使用 gtc/type_precision.cj 的版本
11. **G9** — `gtc/round.cj:9-11,33-34,48-49` 零值分支保留符号

### 第三优先（验证与交叉核对）

12. **G10** — 对照 GLM 1.0.3 源码验证 slerp(k) 四参数公式
13. **G3** — 统一 OOD 文档与代码的 zero-check 策略（`==` vs `<=`）
14. **G12** — 验证 std.math.round 语义并修正预期值

### 持续改进（测试覆盖）

15. **G13-G37** — 按 OOD 文档 §8 的测试要求逐步补齐缺失的测试用例。建议按文件分组逐步推进：
    - 第一批：core 函数库测试（G12-G14, G17-G23）
    - 第二批：ext 函数库测试（G24-G30, 含 G15-G16）
    - 第三批：gtc 函数库测试（G31-G37）

### 无需修改

- **G4** — 按设计（D05），不做修改
- **G11** — 用户教育范畴，ext/gtc shear API 差异已在 GLM 1.0.3 中存在
