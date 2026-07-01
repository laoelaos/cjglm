# 诊断报告：Phase 4 Review Issues（v3 修订版）

## 总览

基于 `harness/reviews/202606300141_ood_phase4_review/todo.md` 列出的 37 个问题（S1-S4, G1-G37），逐一诊断其真伪、根因和修改方向。

参考文档：
- `docs/deviations.md` — 仓颉 GLM 偏差记录（用于鉴别 API 行为差异和类型限制）
- `docs/05_ood_phase3.md` — 阶段三 OOD 设计（用于追溯阶段间设计遗漏责任）
- `docs/06_ood_phase4.md` — 阶段四 OOD 设计
- `cjglm/src/` — 实现代码
- `references/glm-1.0.3/` — GLM 参考源码

---

## 严重等级

### S1: ext/matrix_transform.cj rotate/shear 乘法顺序反转

- **真实性**：真实问题
- **根因**：实现编码错误
- **证据**：
  - GLM 1.0.3 `ext/matrix_transform.inl:40-45`：`rotate` 通过 `m[0]*Rot[0][0] + m[1]*Rot[0][1] + m[2]*Rot[0][2]` 左乘旋转矩阵，等价于 `m * Rot`
  - GLM 1.0.3 `ext/matrix_transform.inl:119-124`：`shear` 同样 `m[0]*Shear[0][0] + ...` 左乘剪切矩阵，等价于 `m * Shear`
  - Cangjie `cjglm/src/ext/matrix_transform.cj:39`：`Rot * m` — 右乘旋转矩阵，顺序反转
  - Cangjie `cjglm/src/ext/matrix_transform.cj:63`：`H * m` — 右乘剪切矩阵，顺序反转
- **OOD 设计覆盖**：OOD 文档 §3.2 ext/matrix_transform.cj 列明了 rotate/shear 函数的签名和角色，但未明确描述乘法顺序。此问题属编码阶段的语义翻译错误。
- **修改方向**：修改实现代码（`cjglm/src/ext/matrix_transform.cj:39` 和 `:63`），将乘法顺序从 `Rot * m` 改为 `m * Rot`，`H * m` 改为 `m * H`。
- **副作用评估**：
  - 受影响测试文件（期望值需同步修正）：`cjglm/tests/glm/ext/matrix_transform_test.cj:57,68,82`（testRotateExt90Z, testRotateExtZeroAngle, testShearExt）
  - gtc 层 `rotate_slow`（`:43-61`）/`shear_slow`（`:77-88`）为独立实现，使用本地 `mat4Mul` 而非委托 ext.rotate/ext.shear，因此 S1 修复不影响 gtc 自有实现。gtc 测试文件 `gtc/matrix_transform_test.cj` 中通过 `public import glm.ext.*` 测试 ext 函数入口的用例（如 `testTranslateViaExt`/`testOrthoViaExt`）需同步验证
  - 向后兼容性：非兼容变更——所有调用 ext.rotate/ext.shear 且依赖结果矩阵运算的代码均受影响，但正确行为仅一种，不存在渐进式兼容方案
  - lib.cj 第 43 行已 `public import glm.ext.{translate, rotate, scale, shear, ...}`，修复后自动可见，无额外 import 修改

---

### S2: gtc/ulp.cj float_distance Int32 减法溢出

- **真实性**：真实问题（仓颉默认 `@OverflowThrowing` 导致负浮点位模式转换时抛异常）
- **根因**：实现编码错误
- **证据**：
  - `cjglm/src/gtc/ulp.cj:51`：`(y.toBits() as Int32).getOrThrow() - (x.toBits() as Int32).getOrThrow()`
  - 当 `y.toBits()` 为负浮点位模式（0x80000000-0xFFFFFFFF）时，UInt32 值 ≥ 2³¹，`as Int32` 数值转型抛异常
  - GLM 1.0.3 `gtc/ulp.inl:85-99` 使用 `detail::float_t<float>` 联合体位模式重解释，输出 `abs(a.i - b.i)`（始终无符号距离）
- **OOD 设计覆盖**：OOD 文档 §3.3 gtc/ulp.cj 描述了 `float_distance` 签名和实现路径（使用 `toBits()`/`fromBits()`），但未指定位模式到符号整数的转换方式。问题在编码实现时产生。
- **修改方向**：修改实现代码。需使用位重解释（而非数值转型）将 UInt32 位模式映射为 Int32，并修正为返回绝对值（与 GLM 保持一致）。
- **副作用评估**：
  - 受影响测试文件：`cjglm/tests/glm/gtc/ulp_test.cj:24-37,67,72`（testFloatDistanceAdjacent, testFloatDistanceAdjacentFloat64, testPrevFloat, testNextFloatZero）——当前测试仅使用正值（无负浮点），因此 S2 在测试中可能未触发异常，但这些测试的期望值依赖当前的有符号运算结果，修复为无符号绝对值后测试期望值需重新计算
  - 修复顺序依赖：S2 与 G7（float_distance 缺少 NaN/Inf 前置检查）应同时修复——G7 修复在前可消除 NaN/Inf 输入的异常，S2 修复消除正常输入的潜在溢出
  - 向后兼容性：返回类型签名不变（Int32/Int64），但语义从有符号差改为无符号绝对值。与 GLM 1.0.3 对齐后为正确行为
  - lib.cj 第 58 行 `public import glm.gtc.{next_float, prev_float, float_distance, ulp}`，修复后自动可见

---

### S3: ext/quaternion_transform_test.cj testRotateNonIdentity 期望值错误

- **真实性**：真实问题
- **根因**：测试编码错误
- **证据**：
  - `cjglm/tests/glm/ext/quaternion_transform_test.cj:63-70`：测试 `rotate(q(√2/2, 0, √2/2, 0), 90°, Z轴)` 期望 `r.x ≈ 0, r.z ≈ 1.0`
  - 四元数复合运算结果与期望值不一致。`q(cos45°, 0, sin45°, 0)` 是绕 Y 轴 90° 旋转，复合绕 Z 轴 90° 旋转后应得到 `(0.5, 0.5, 0.5, 0.5)` 而非 `(0, 0.707, 0, 0.707)`
- **OOD 设计覆盖**：OOD 文档 §8 实施规划的第三批中要求测试 rotate。测试期望值数学推导错误。
- **修改方向**：修改测试代码。需重新计算正确的期望值。
- **副作用评估**：无。仅修改测试文件 `cjglm/tests/glm/ext/quaternion_transform_test.cj`，不影响生产代码或其他测试。

---

### S4: gtc/matrix_transform_test.cj testShearSlowDiagonal 期望值错误

- **真实性**：真实问题
- **根因**：测试编码错误
- **证据**：
  - `cjglm/tests/glm/gtc/matrix_transform_test.cj:107-109`：`shear_slow(I, n(0.5,0.5,0), s=2.0)` 期望 `c0.x=1.5` ✓, `c0.y=1.0` ✗（应为 0.5）, `c1.x=1.0` ✗（应为 0.5）, `c1.y=1.5` ✓
  - 剪切矩阵公式 `H = I + s * n*n^T`，`n=(0.5,0.5,0)` 时 `n*n^T` 的反对角线元素为 0.25，`H` 的 (0,1) 和 (1,0) 位置应为 0.5 而非 1.0
- **OOD 设计覆盖**：OOD 文档未详细规定 shear 矩阵的数学公式，但 "GLM 行为一致" 原则要求测试期望值正确。
- **修改方向**：修改测试代码。修正 `c0.y` 和 `c1.x` 的期望值。
- **副作用评估**：无。仅修改测试文件 `cjglm/tests/glm/gtc/matrix_transform_test.cj`。

---

## 一般等级

### G1: detail/common.cj roundEven 奇偶判断分支反转

- **真实性**：真实问题
- **根因**：实现编码错误
- **证据**：
  - `cjglm/src/detail/common.cj:173-179`：`if (rInt % 2 == 0) { r - one } else { r }`
  - roundEven(2.5)：`round(2.5)=3`（std.math.round 使用**远离零取整**），`rInt=3`（奇数）→ 当前返回 `r=3`，但应返回 2（最近偶数）
  - roundEven(3.5)：`round(3.5)=4`，`rInt=4`（偶数）→ 当前返回 `r-1=3`，但应返回 4
  - 分支逻辑应交换：`if (rInt % 2 == 0) { r } else { r - one }`
- **OOD 设计覆盖**：OOD 文档 §3.1 common.cj 仅提到 roundEven 应有 "round half to even" 行为，未指定具体分支逻辑。属编码实现错误。
- **修改方向**：修改实现代码（`cjglm/src/detail/common.cj:176-179`，交换两个分支）。

---

### G2: detail/vector_relational.cj 缺少 equal/notEqual/any/all/not

- **真实性**：真实问题
- **根因**：阶段三 OOD 设计遗漏（非阶段四责任）
- **证据**：
  - `cjglm/src/detail/vector_relational.cj`：仅实现 `lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual` 四个函数
  - GLM 1.0.3 `vector_relational.hpp` 还包含 `equal`/`notEqual`/`any`/`all`/`not_` 五个函数
  - 阶段三设计文件 `docs/05_ood_phase3.md` 中，`detail/vector_relational.cj` 标注为"沿用阶段三"，阶段三仅列出了四个比较函数，未包含 equal/notEqual/any/all/not——**设计阶段遗漏源头在阶段三**
  - OOD 文档 §2 模块划分中 `vector_relational.cj` 标记为 "沿用阶段三"，阶段三仅列出四个比较函数。阶段四继承此设计，未新增补全。
- **OOD 设计覆盖**：OOD 文档完全未提及 equal/notEqual/any/all/not 函数，属于**阶段三设计遗漏**，阶段四沿用未补全。
- **修改方向**：需先更新 OOD 文档补充缺失函数的设计，再实现代码。OOD 设计阶段未覆盖 GLM 的完整 vector_relational 函数集。

---

### G3: detail/geometric.cj normalize 使用 `<=` 而非严格 `==`

- **真实性**：有争议。`<=` 比 `==` 更稳健（捕获负零），实际行为差异极小。
- **根因**：实现与 OOD 设计轻微偏差
- **证据**：
  - OOD 文档 §5 错误表：`if lengthSq == T(0) return zero-vec`
  - 代码 `cjglm/src/detail/geometric.cj:26,35,44`：`if (lenSq <= zero)`
  - IEEE 754 中负零 `-0.0` 与 `+0.0` 在 `==` 下相等（`-0.0 == +0.0` 为 true），因此对零值 `<=` 和 `==` 行为一致——两者均能正确识别零向量
  - `dot(v,v)` 为分量自乘之和，IEEE 754 中负×负=正、正×正=正，结果永不为负，不可能产生 `-0.0`
  - 两种写法的实际行为在正确输入下不存在差异。`<=` 的优势不在于功能区别，而在于防御性编程风格——表明"保护非正长度"的语义意图，对代码读者更清晰地传达保护条件
- **OOD 设计覆盖**：OOD 设计使用 `==`，代码使用 `<=`。两者在正确输入下行为等价。
- **修改方向**：**推荐修改 OOD 文档**中的措辞匹配代码的 `<=`。理由：两种写法在零值输入下行为一致（`-0.0 == +0.0`），`<=` 的防御性编程风格更清晰地传达"保护非正长度"的语义意图，且不改变任何实际行为。

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
- **副作用评估**：
  - 新增函数不会破坏现有接口兼容性
  - 依赖 lib.cj 第 41 行的 `public import glm.ext.{fmin, fmax, ...}`，新增重载自动被 public import 覆盖，无需额外修改 lib.cj
  - 无向后兼容性问题——仅新增重载，不修改已有函数行为

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
  - 正 NaN 位模式（0x7FC00000）作为 UInt32 = 2143289344，小于 Int32.Max（2147483647），不会抛异常
  - 但负 NaN 位模式（0xFFC00000 = 4290772992）超出 Int32.Max 范围，转型会抛异常
  - GLM 1.0.3 使用 union 位重解释，NaN/Inf 自然参与位运算，不抛异常
  - 此问题与 S2（Int32 溢出）同文件、同函数，应同时修复
- **OOD 设计覆盖**：OOD 文档 §3.3 gtc/ulp.cj 未明确要求 NaN/Inf 检查，但同函数的其他重载（next_float 等）保持一致的设计原则要求 float_distance 也有此保护。
- **修改方向**：修改实现代码，在 float_distance 中增加 NaN/Inf 前置检查（与同文件其他函数保持一致）。
- **修复顺序依赖**：应与 S2 同时修复（G7 应对 NaN/Inf 输入的保护 → S2 应对正常输入的溢出修复），建议在同一 commit 中完成两个修改。

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
- **修改方向**：删除 `ext/quaternion_double.cj` 中的 `dquat` 定义（OOD 已规划的解决方案）。清理所有引用 ext.dquat 的代码。
  - 搜索命令：`grep -r "\bdquat\b" cjglm/src/` 可识别所有引用位置
  - lib.cj 第 18 行 `public import glm.ext.{quat, dquat, ...}` 需移除 `dquat` 符号（gtc 版本的 `dquat` 由第 70 行 `public import glm.gtc.{..., dquat, ...}` 保持导入）
- **副作用评估**：
  - ext/ 层删除 dquat 后，gtc/type_precision.cj 的 dquat 为唯一来源，消除命名冲突
  - lib.cj 第 18 行需移除 ext.dquat 导入，保留 gtc.dquat（第 70 行已有）
  - 向后兼容：所有用户代码应从 gtc 导入 dquat（lib.cj 的 public import 对这个符号的变化透明），但显式 `import glm.ext.dquat` 的代码需迁移

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

### G10: ext/quaternion_common.cj slerp(k) 四参数版本与 GLM 1.0.3 存在两处差异

- **真实性**：真实问题（两个分支均与 GLM 1.0.3 不一致）
- **根因**：实现编码错误
- **证据**：
  - **问题① — 公式不同**：`cjglm/src/ext/quaternion_common.cj:68-69` 使用 `sin((1-a)*ω/k)/sin(ω/k)`，GLM 1.0.3 `ext/quaternion_common.inl:106-108` 使用 `phi = angle + k*π; scale0 = sin(angle - a*phi)/sin(angle); scale1 = sin(a*phi)/sin(angle)`。Cangjie 代码将 `k` 作为频率缩放因子，而 GLM 中 `k` 为 spin count（通过 `k*π` 叠加额外圈数），**数学上不等价**
  - **问题② — 缺少 cosTheta<0 最短路径分支**：GLM 1.0.3 `ext/quaternion_common.inl:87-91` 在 slerp 四参数版本中包含 `if (cosTheta < 0) { z = -y; cosTheta = -cosTheta }` 保护，确保取最短插值路径。Cangjie 代码 `cjglm/src/ext/quaternion_common.cj:58-71` 完全缺少此分支，当两四元数夹角 > 90° 时插值走长路径而非短路径
  - 同文件的两参数 slerp（`:42-56`）同样缺少 cosTheta<0 最短路径分支，与 GLM 1.0.3 `quaternion_common.inl:51-55` 不一致
- **OOD 设计覆盖**：OOD 文档 §3.2 ext/quaternion_common.cj 提到 "实现参考 GLM 1.0.3 源码"，但未列出具体的数学公式或 cosTheta 保护逻辑。
- **修改方向**：
  1. 修正 slerp(k) 四参数公式：`phi = omega + k * pi<T>(); scale0 = sin(omega - a * phi) / sin(omega); scale1 = sin(a * phi) / sin(omega)`
  2. 在 slerp(k) 和 slerp（两参数）中均补充 cosTheta<0 最短路径分支（取反 y 四元数）
- **优先级**：第一优先（与 S1/S2 同组），因两个 slerp 版本均存在影响正确性的问题

---

### G11: gtc/matrix_transform.cj shear API 与 ext 版本不同可能导致命名混淆

- **真实性**：真实问题（两个同名函数签名不同，造成混淆和使用隐患）
- **根因**：OOD 设计问题（gtc 和 ext 的 shear 签名本就不同）。此差异与 GLM 1.0.3 的设计一致——GLM 中 `ext.matrix_transform.shear` 和 `gtc.matrix_transform.shear` 本身签名不同，不是仓颉特有的偏差。
- **偏差记录对照**：根据 `docs/deviations.md`，此差异属于"二、接口/行为有偏差"类别。在 C++ GLM 中，gtc 和 ext 的 shear 函数签名不同（gtc 使用方向向量+标量模式，ext 使用三 Vec2 模式），这与仓颉版本一致。因此**这不是仓颉迁移引入的偏差，而是 GLM 自身的 API 设计**。
- **证据**：
  - ext `cjglm/src/ext/matrix_transform.cj:53`：`shear(m, p: Vec3, l_x: Vec2, l_y: Vec2, l_z: Vec2)` — 使用三个 Vec2 参数分别指定各轴剪切量
  - gtc `cjglm/src/gtc/matrix_transform.cj:29`：`shear(m, n: Vec3, s: T)` — 使用单个方向向量 n 和标量 s
  - GLM 1.0.3 中 ext.shear 和 gtc.shear 本身签名不同（ext 为三个 Vec2，gtc 为方向+标量）
  - 虽然仓颉函数重载可基于参数类型区分，但同名函数在不同包使用不同语义和签名在 API 设计上易造成混淆
- **OOD 设计覆盖**：OOD 文档 §3.2 和 §3.3 分别描述了 ext 和 gtc 的不同 shear 签名，设计本身承认此差异。
- **修改方向**：不需要改代码。需在 `docs/deviations.md` 中新增偏差记录，纳入"二、接口/行为有偏差"类别，说明两个 shear 的差异与 GLM 1.0.3 一致，提供迁移建议模板。

---

### G12: common_test.cj round(-3.5) 预期值与 IEEE 754 行为

- **真实性**：**非问题**——Cangjie `std.math.round` 的 rounding mode 为"四舍五入"（round-half-towards-positive-infinity），测试期望值 `round(-3.5) = -3.0` 与此 rounding mode 一致。
- **根因**：非问题，测试期望值正确。
- **证据**：
  - 仓颉标准库文档：`round(x: Float64): Float64` 描述为"四舍五入"，未明确指定 tie-breaking 模式
  - 实际行为验证（通过测试传递确认）：`@Expect(round(Float64(-3.5)), Float64(-3.0))` 成立，说明 round(-3.5) 返回 -3.0（即 round-half-towards-positive-infinity 语义）
  - GLM 1.0.3 使用 C++ `std::round`（round-half-away-from-zero，round(-3.5) = -4.0），但 Cangjie 标准库的语义不同不属于库问题——这是 `docs/deviations.md` 应记录的偏差
  - `docs/deviations.md` 当前无任何关于 `std.math.round` 取整模式的偏差记录，应新增
- **OOD 设计覆盖**：OOD 文档 §3.1 common.cj 标注 roundEven 的依赖为 `std.math.round`，未讨论取整模式兼容性。
- **修改方向**：无需修改测试代码。建议在 `docs/deviations.md` 中新增偏差记录：Cangjie `std.math.round` 使用 round-half-towards-positive-infinity，与 C++ `std::round`（round-half-away-from-zero）在负半轴 tie-breaking 行为不同。roundEven 的校正逻辑需考虑此差异。

---

## 测试覆盖问题（G13-G37 逐条诊断）

### G13: common_test.cj testFractVec4 未对 -0.5 和 0.0 分量做断言

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：`cjglm/tests/glm/detail/common_test.cj:382-387`——`testFractVec4` 输入向量 `(1.3, 2.7, -0.5, 0.0)`，仅对 `x`(0.3) 和 `y`(0.7) 做断言，未对 `z`(-0.5) 和 `w`(0.0) 做断言
- **修改方向**：补充 `@Expect(r.z, Float64(0.5))` 和 `@Expect(r.w, Float64(0.0))` 断言

### G14: exponential_test.cj 缺少 inversesqrtZero/sqrt(-1)/log(0)/log(-1) 等边界测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：`cjglm/tests/glm/detail/exponential_test.cj`——已验证存在 `inversesqrt(0)` 测试（line 50）但无 log(0)/log(-1) 边界；`log(Int32(1))` 的隐式小数截断测试已存在
- **修改方向**：补充 log(0) 期望值为 -Inf、log(-1) 期望值为 NaN 等边界测试（注：`inversesqrt(0)` 测试 `testInversesqrtZero` 已存在于 `exponential_test.cj:49-52`）

### G15: stdmath_shim_test.cj Float16 覆盖严重不足（25 函数中仅 7 个有 Float16 测试）

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **偏差记录对照**：根据 `docs/deviations.md`，Cangjie 的 `std.math` 对 Float16 的支持通过 `T(Float64(n))` 字面量替代路径实现（见 `docs/05_ood_phase3.md` 中 H1 验证），除 `pow` 外大多数函数均提供 Float16 重载。Float16 覆盖不足属于测试遗漏，非语言限制。
- **证据**：`cjglm/tests/glm/detail/stdmath_shim_test.cj`——`cjpm test --list` 确认仅 7 个函数有 Float16 测试
- **修改方向**：对所有 25 个 stdmath_shim 函数补充 Float16 版本测试

### G16: stdmath_shim_test.cj 部分 Float32 函数缺少独立测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **偏差记录对照**：无相关偏差——Float32 在 Cangjie 中有完整支持，属于纯测试遗漏。
- **证据**：`cjglm/tests/glm/detail/stdmath_shim_test.cj`——部分函数（如 `atan2T`）缺少 Float32 独立测试
- **修改方向**：补充缺失的 Float32 版本独立测试

### G17: trigonometric_test.cj 缺少三角恒等式验证（sin²+cos²=1 等）

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 sin²+cos²=1、tan=sin/cos、1+tan²=sec² 等三角恒等式在 Vec1~Vec4 上的验证

### G18: trigonometric_test.cj Float16 asin/acos 缺少 ±1 边界测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：对 Float16 的 asin(±1) 和 acos(±1) 补充边界测试，验证返回 ±π/2 和 0/π

### G19: trigonometric_test.cj Float16 atan2 缺少第二个分支测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：`cjglm/tests/glm/detail/trigonometric_test.cj:273-275`——仅测试一个 atan2 分支
- **修改方向**：补充 atan2 在第二象限和第四象限的输入测试

### G20: trigonometric_test.cj Vec3/Vec4 asinh/acosh/atanh 仅测试全零向量

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 Vec3/Vec4 的非零向量 asinh/acosh/atanh 测试

### G21: geometric_test.cj 缺少 length(zero)/distance(p,p)/cross(parallel)/reflect 边界测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 length(零向量)=0、distance(p,p)=0、cross(平行向量)=零向量、reflect(垂直入射) 等边界测试

### G22: geometric_refract_test.cj 缺少 eta=1 无折射边界和 Vec1 测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 eta=1（无折射，光线直穿）、eta 导致全内反射、Vec1 维度测试

### G23: matrix_test.cj 缺少 3x3/4x4 Float32/Float64 determinant 测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 Mat3x3/Mat4x4 在 Float32/Float64 下的 determinant 测试

### G24: quaternion_transform_test.cj testRotateZeroAxis 验证了有争议的行为

- **真实性**：真实问题（零轴时的行为存在设计争议）
- **根因**：设计争议（未明确零轴是否应保留原 q 或返回单位四元数）
- **偏差记录对照**：根据 `docs/deviations.md`，Cangjie 的 `cross(零向量, v)` 行为取决于实现。该问题涉及 `ext/quaternion_transform.cj` 中 `rotate` 函数的零轴保护（涉及 `normalize(zero)` → `cross(parallel, v)` 等边界），这是一个已知的库行为边界问题，非 Cangjie 特有偏差。
- **证据**：`cjglm/tests/glm/ext/quaternion_transform_test.cj:53-61`——测试验证了零轴时返回单位四元数而非保留 q
- **修改方向**：需明确设计决策，在 OOD 文档中规定零轴行为，然后对齐测试/实现

### G25: vector_common_test.cj Vec1/Vec4 维度完全缺失

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 Vec1 和 Vec4 的 fmin/fmax/fclamp 测试

### G26: vector_common_test.cj fclamp 向量边界版未测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：`cjglm/tests/glm/ext/vector_common_test.cj:47-53,107-114`——fclamp 向量边界版本的断言不完整
- **修改方向**：补充 fclamp 的边界值测试

### G27: vector_common_test.cj fmin/fmax 3/4 输入版本测试不足

- **真实性**：真实问题
- **根因**：测试覆盖遗漏（与 G5 联动——fmin/fmax 3/4 输入版本本身未实现，故无测试）
- **证据**：`cjglm/tests/glm/ext/vector_common_test.cj:29-45`
- **修改方向**：在 G5 修复（补齐 16 个缺失函数）后，同步补充对应的测试

### G28: quaternion_common_test.cj slerp 缺少中点验证和退化分支测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 slerp(a=0.5) 中点验证、cosTheta → 1 线性插值退化分支、cosTheta < 0 取反分支测试

### G29: quaternion_common_test.cj mix 越界 a<0 或 a>1 时 clamp 行为未测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：`cjglm/tests/glm/ext/quaternion_common_test.cj:132-150`——无越界 clamp 断言
- **修改方向**：补充 a=-0.5 和 a=1.5 的 clamp 行为测试

### G30: quaternion_trigonometric_test.cj axis round-trip 未测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：`cjglm/tests/glm/ext/quaternion_trigonometric_test.cj:68-74`
- **修改方向**：补充 axis(angleAxis(angle, axis)) round-trip 测试

### G31: gtc/matrix_transform_test.cj 中 ext 重导出函数缺乏 gtc 入口测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：
  - 测试文件 `cjglm/tests/glm/gtc/matrix_transform_test.cj`：当前仅对 ext 重导出函数测试了 `translate`（`testTranslateViaExt:124-131`）和 `ortho`（`testOrthoViaExt:134-138`）
  - `cjglm/src/gtc/matrix_transform.cj:3` 通过 `public import glm.ext.*` 将 ext 层的 `translate`/`rotate`/`scale`/`shear`/`lookAt`/`lookAtRH`/`lookAtLH`/`ortho`/`frustum`/`perspective`/`pickMatrix` 等重导出至 `glm.gtc` 包
  - gtc 层自有实现（非重导出）的函数：`identity`（`:16`）、`shear`（`:29`，n+s 版本）、`rotate_slow`（`:43`）、`scale_slow`（`:64`）、`shear_slow`（`:77`）——以上 5 个函数已有独立测试用例
  - 缺少 gtc 入口测试的 ext 重导出函数：`rotate`、`scale`、`shear`（ext 三 Vec2 版本）、`lookAt`、`lookAtRH`、`lookAtLH`、`frustum`、`perspective`、`pickMatrix` 等
- **修改方向**：对 ext 重导出函数补充 gtc 入口的委托路径测试（如 `gtc.rotate(m, angle, axis)`、`gtc.scale(m, v)` 等），验证通过 `glm.gtc` 命名空间调用 ext 函数时行为正确。gtc 自有实现的 5 个函数已有测试，无需重复补充。

### G32: gtc/matrix_inverse_test.cj 缺少 inverseTranspose == transpose(inverse(m)) 一致性验证

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充恒等式一致性验证

### G33: gtc/matrix_access_test.cj 缺少 Mat2x2/Mat3x2/Mat4x3 三个类型的 row/column 测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充缺失矩阵类型的 row/column 测试

### G34: gtc/packing_test.cj 仅覆盖 6/18+ 函数，缺少多种打包/解包 round-trip 测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充所有 18+ 打包函数的 round-trip 测试

### G35: gtc/noise_test.cj 缺少 isFinite 验证和零向量/边界输入测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 isFinite、零向量、边界输入测试

### G36: gtc/ulp_test.cj float_distance 缺少 NaN/Inf/负值输入测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **修改方向**：补充 float_distance 在 NaN(正/负)、Inf(正/负)、负浮点输入下的测试（与 S2/G7 联动，应在修复后补充）

### G37: gtc/ulp_test.cj prev_float 缺少 Float64/零值/NaN/Inf 测试

- **真实性**：真实问题
- **根因**：测试覆盖遗漏
- **证据**：`cjglm/tests/glm/gtc/ulp_test.cj:64-68`——prev_float 仅测试 Float32(1.0) 的相邻值
- **修改方向**：补充 Float64/零值(±0)/NaN/Inf 的 prev_float 测试

---

## 按根因分类汇总

| 根因类型 | 包含的 Issue | 修改方向 |
|---------|-------------|---------|
| **OOD 设计遗漏（阶段三）** | G2（vector_relational 缺失 5 函数） | 先更新 OOD 文档再实现代码 |
| **OOD 设计决策（非问题）** | G4（determinant Number<T>）、G11（ext/gtc shear 签名差异） | 无需修改或仅更新文档标注 |
| **OOD 设计已知待解决** | G8（dquat 命名冲突） | 按 OOD 已规划的方案修改代码 |
| **实现编码错误** | S1（乘法顺序）、S2（Int32 溢出）、G1（roundEven 分支）、G9（±0 丢失符号） | 修改实现代码 |
| **实现与设计偏差** | G6（iround 未委托 roundT）、G7（NaN 检查缺少） | 修改实现代码对齐设计 |
| **OOD 文档修正** | G3（<= vs ==） | 修改 OOD 文档对齐代码 |
| **实现不完整** | G5（fmin/fmax 缺失 16 函数） | 按 OOD 设计补齐代码 |
| **实现编码错误** | G10（slerp(k) 公式 + 缺少 cosTheta<0 分支） | 修正公式并补充最短路径分支，第一优先 |
| **测试编码错误** | S3（quaternion 期望值）、S4（shear 期望值） | 修正测试代码中的期望值 |
| **测试覆盖遗漏** | G13-G37（全部测试不足 issue） | 补充测试用例 |
| **非问题（测试正确）** | G12（round(-3.5) 期望值正确，匹配 Cangjie std.math.round 语义） | 无需修改测试 |

---

## 修改流程建议

### 第一优先（影响功能正确性）

按"库行为正确性"和"测试正确性"分组：

**库行为正确性组：**
1. **S1** — 修改 `ext/matrix_transform.cj:39,63` 乘法顺序 + 更新相关测试
   - 受影响测试：`ext/matrix_transform_test.cj`（testRotateExt90Z, testRotateExtZeroAngle, testShearExt）
2. **S2 + G7（合并）** — 修改 `gtc/ulp.cj:51-57` float_distance：
   - 修复 G7：增加 NaN/Inf 前置检查（与 `next_float`/`prev_float`/`ulp` 保持一致）
   - 修复 S2：位转换为位重解释 + 加 abs
   - 两个问题位于同一文件同一函数，应同时修复
   - 受影响测试：`gtc/ulp_test.cj`（testFloatDistanceAdjacent, testFloatDistanceAdjacentFloat64, testPrevFloat, testNextFloatZero）——期望值可能需要调整

3. **G10** — 修正 `ext/quaternion_common.cj:68-69` slerp(k) 公式为 `sin(angle - a*phi)/sin(angle)` + 补充两参数及四参数 slerp 的 cosTheta<0 最短路径分支
   - 受影响测试：`ext/quaternion_common_test.cj`（期望值需重新计算）

**测试正确性组：**
4. **S3** — 修正 `quaternion_transform_test.cj:63-70` 期望值
5. **S4** — 修正 `matrix_transform_test.cj:107-109` 期望值
6. **G1** — 修改 `common.cj:173-179` roundEven 分支逻辑

### 第二优先（API 完整性）

7. **G2** — OOD 文档补充 vector_relational 缺失函数设计 → 编码实现
8. **G5** — 补齐 `vector_common.cj` 缺失的 16 个 fmin/fmax 向量版本
9. **G6** — `scalar_common.cj:104-114` 改用 roundT 委托
10. **G8** — 删除 `ext/quaternion_double.cj` 中的 dquat，统一使用 gtc/type_precision.cj 的版本
11. **G9** — `gtc/round.cj:9-11,33-34,48-49` 零值分支保留符号

### 第三优先（统一与文档）

13. **G3** — 修改 OOD 文档中 normalize 零值保护策略为 `<=`（与代码对齐，`-0.0 == +0.0` 下两者行为一致，`<=` 更清晰地传达"保护非正长度"的防御语义）
14. **G12** — 无需修改代码，在 `docs/deviations.md` 中新增 `std.math.round` 取整模式偏差记录
15. **G11** — 在 `docs/deviations.md` 中新增 ext/gtc shear API 差异记录

### 持续改进（测试覆盖）

按修复紧迫性和联动态势分组：

**与第一优先联动的测试补全：**
- G36（float_distance NaN/Inf/负值测试）— 应与 S2+G7 修复后同步补充
- G37（prev_float Float64/零值/NaN/Inf 测试）— 纯测试补充

**core 函数库测试分批：**
- 第一批：common.cj 测试补全（G12/G13）
- 第二批：exponential_test.cj 边界测试（G14）
- 第三批：stdmath_shim_test.cj 类型维度补充（G15/G16）
- 第四批：trigonometric_test.cj 恒等式验证和分支补全（G17-G20）

**几何/矩阵测试分批：**
- 第一批：geometric_test.cj 边界测试 + reflect_test.cj（G21/G22）
- 第二批：matrix_test.cj 类型维度补全（G23）
- 第三批：matrix_access_test.cj 类型维度补全（G33）
- 第四批：matrix_inverse_test.cj 恒等式验证（G32）

**ext 测试分批：**
- 首批：quaternion 测试（G24/G28/G29/G30）
- 次批：vector_common_test.cj 维度补全（G25/G26/G27，与 G5 修复联动）
- 后续：matrix_transform_test.cj gtc 入口测试（G31）

**gtc 测试分批：**
- 首批：packing_test.cj 函数覆盖（G34）
- 次批：noise_test.cj 边界测试（G35）

### 文档标记（无需修改代码）

- **G4** — 按设计（D05），不做修改，可添加注释标记 "按设计"
- **G11** — 用户教育范畴，ext/gtc shear API 差异已在 GLM 1.0.3 中存在，需在 deviations.md 添加偏差记录
- **G12** — Cangjie std.math.round 取整模式差异（round-half-towards-positive-infinity 而非 away-from-zero），需在 deviations.md 添加偏差记录

---

## 修订说明（v3）

| 质询意见 | 回应 |
|---------|------|
| **严重：S1 副作用评估事实错误** | 已修正。原描述称 `rotate_slow`/`shear_slow` "委托 ext 的 rotate/shear"，经代码确认：`gtc/matrix_transform.cj:43-61` 的 `rotate_slow` 和 `:77-88` 的 `shear_slow` 均为独立实现，使用本地 `mat4Mul` 而非调用 ext.rotate/ext.shear。S1 修复不影响 gtc 自有实现。已更新为"gtc 自有实现不受影响"，仅保留 gtc 测试中通过 `public import glm.ext.*` 访问 ext 函数入口的用例需同步验证。 |
| **中等：G14 修改方向与证据自相矛盾** | 已修正。原修改方向要求补充 `inversesqrt(0)` 断言，但证据已确认 `testInversesqrtZero` 存在于 `exponential_test.cj:49-52`（包含 `@Expect(isInf(r), true)`）。已删除该条目，修改方向仅保留 log(0)/log(-1) 边界测试，并添加注明确认 inversesqrt(0) 测试已存在。 |
| **中等：G31 诊断信息严重不足** | 已补充。新增证据引用：函数清单来自 `gtc/matrix_transform.cj` 代码分析——自有实现 5 个（`identity`/:16、`shear`/:29、`rotate_slow`/:43、`scale_slow`/:64、`shear_slow`/:77）均有独立测试；ext 重导出函数（`translate`/`rotate`/`scale`/`shear`/`lookAt`/`lookAtRH`/`lookAtLH`/`ortho`/`frustum`/`perspective`/`pickMatrix` 等）当前仅覆盖 translate 和 ortho。修改方向已明确区分两类测试。 |
| **中等：S2 与 G7 优先级矛盾** | 已修正。G7 从第二优先提升至第一优先，与 S2 合并为同一条目（"S2 + G7（合并）"），位于第一优先库行为正确性组第 2 项。修改流程建议中已移除第二优先中的 G7 条目，并更新了优先级编号。 |
| **轻微：G10 分类过于保守，且缺少 cosTheta<0 分支问题** | 已修正。G10 从"待验证"改为"实现编码错误"（确认问题），涵盖两处差异：(1) 四参数 slerp 公式与 GLM 不等价——Cangjie `sin((1-a)*ω/k)/sin(ω/k)` vs GLM `sin(angle - a*(angle + k*π))/sin(angle)`；(2) 两参数及四参数 slerp 均缺少 cosTheta<0 最短路径分支（GLM `quaternion_common.inl:51-55`、`:87-91` 均有）。G10 已归入第一优先库行为正确性组，汇总表分类更新。 |
| **轻微：G3 dot(v,v) 生成 -0.0 的论证不成立** | 已修正。删除了"dot 运算因浮点舍入产生 -0.0"的错误论据（IEEE 754 中负×负=正，dot(v,v) 永不为负）。替换为正确论据：(1) `-0.0 == +0.0` 在 IEEE 754 中为 true，因此 `<=` 与 `==` 在零值输入下行为一致；(2) `<=` 的优势在于防御性编程语义（保护非正长度），而非功能区别。修改方向及优先级描述已同步更新。 |

---

## 修订说明（v4）

| 质询意见 | 回应 |
|---------|------|
| **严重：汇总表 G3 修改方向与正文/优先级建议矛盾（第三次迭代仍未修复）** | 已修正。从"实现与设计偏差"行中移出 G3，新增"OOD 文档修正"类别行，修改方向改为"修改 OOD 文档对齐代码"，与正文第 122 行（推荐修改 OOD 文档）和优先级第 488 行（修改 OOD 文档）保持一致。G6/G7 保留在"实现与设计偏差"行，修改方向不变。 |

## 修订说明（v2）

| 质询意见 | 回应 |
|---------|------|
| **Q1（严重）：G10 分类矛盾** | 已修正。G10 从"实现编码错误"改为"待验证"分类，汇总表新增"待验证"行。证据：经对照 GLM 1.0.3 `ext/quaternion_common.inl:105-108`，确认 Cangjie 代码的 `sin((1-a)*ω/k)/sin(ω/k)` 公式与 GLM 的 `sin(angle - a*phi)/sin(angle)`（其中 `phi = angle + k*pi`）数学上不等价。但需验证 GLM 公式的语义目的是否为 spin count 累加——当前归类为"待验证"，验证确认后升级。 |
| **Q2（严重）：G14-G37 缺乏逐条诊断** | 已为 G13-G37 共 25 个 issue 逐条补充：真实性、根因类型、修改建议，多数精简至 1-2 行。G14/G24/G31 等涉及源代码文件的条目保持必要的证据引用。 |
| **Q3（中等）：未引用 deviations.md** | 已在 G11、G15、G16、G24 等涉及 API 行为差异或类型限制的条目中对照 deviations.md 进行评估。G11（shear API 差异）确认来源于 GLM 本身，非仓颉特有偏差；G15（Float16 覆盖）对照偏差记录确认 Float16 路径不存在语言限制；G16（Float32 测试）无相关偏差记录；G24（零轴行为）对照偏差记录确认涉及库行为边界。 |
| **Q4（中等）：G3 修改建议方向不明确** | 已选定单一方向——修改 OOD 文档匹配代码的 `<=`。理由：IEEE 754 中 `dot(v,v)` 理论上可因浮点舍入产生 `-0.0`，`<=` 可捕获此边界，优于 `==` 的严格相等判断。 |
| **Q5（中等）：G2 根因未区分阶段责任** | 已关联 `docs/05_ood_phase3.md` 确认：vector_relational 的 equal/notEqual/any/all/not 缺失属于阶段三的设计遗漏（阶段三仅设计 4 个比较函数），阶段四继承且未补全。OOD 文档完全未提及这些函数。 |
| **Q6（中等）：S1/S2 缺少测试回归影响分析** | 已补充。S1 影响 `ext/matrix_transform_test.cj` 的 3 个测试（testRotateExt90Z, testRotateExtZeroAngle, testShearExt）；S2 影响 `gtc/ulp_test.cj` 的 4 个含 float_distance 的测试（期望值需重新计算）。 |
| **Q7（中等）：G12 诊断未完成** | 已完成。查阅 Cangjie `std.math.round` 文档（"四舍五入"语义），结合测试传递确认 `round(-3.5) = -3.0`，判定该语义为 round-half-towards-positive-infinity。测试期望值与此一致，故 G12 为"非问题"。建议在 deviations.md 新增取整模式偏差记录。 |
| **Q8（轻微）：G8 缺少引用搜索方法** | 已补充。搜索命令：`grep -r "\bdquat\b" cjglm/src/` 可识别所有引用位置。 |
| **Q9（轻微）：G10 优先级标注缺少升级条件** | 已补充。G10 在修改流程建议中标注"验证后升级组"，注明验证确认公式错误后升级至第一优先。 |
| **Q10（轻微）：G11 缺少具体文档修改方案** | 已补充。指明在 `docs/deviations.md` 的"二、接口/行为有偏差"类别中新增偏差记录，说明 ext/gtc shear API 差异与 GLM 1.0.3 一致。 |
| **Q11（严重）：缺少关键修复方案副作用评估** | 已补充覆盖 S1、S2、G5、G8 的副作用评估。内容包括：(1) 受影响测试文件清单——S1 影响 ext/matrix_transform_test.cj，S2 影响 gtc/ulp_test.cj；(2) 修复顺序依赖——S2 与 G7 位于同一文件同一函数，应同时修复；(3) 向后兼容性——S1 和 S2 为非兼容变更（行为从错误纠正为正确），但正确行为仅一种，无渐进式兼容方案；(4) 同步修改的辅助代码——lib.cj 的 import 对 S1/S2 自动可见，G8 需移除 lib.cj:18 的 ext.dquat。 |
| **Q12（中等）：优先级排序缺少合理性论证** | 已重新组织：(1) 第一优先按"库行为正确性"和"测试正确性"分组，新增"验证后升级组"含 G10；(2) G7 移至与 S2 同优先级组（同一文件同一函数，应同时修复）；(3) G13-G37 按"与优先修复联动的测试"、"core 函数库测试"、"几何/矩阵测试"、"ext 测试"、"gtc 测试"做二级分组，每批内按修复紧迫性排列。 |
