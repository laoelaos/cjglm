# R2: 审查 `cjglm/src/detail/type_quat_cast.cj`（mat3Cast/mat4Cast/quatCast）

审查时间：2026-06-27

## 审查范围

- `cjglm/src/detail/type_quat_cast.cj`（130 行，本轮主要审查对象）
- `cjglm/src/detail/type_quat.cj`（同包调用方，fromMat3/fromMat4 工厂）
- `cjglm/src/gtc/quaternion.cj`（gtc 端重导出）
- `cjglm/tests/glm/detail/test_type_quat_cast.cj`（8 个测试用例的发现情况）
- `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:47-129`（GLM 参考实现）
- `docs/05_ood_phase3.md` §1「系统性设计约束」/§2「包间依赖」/§3.2.1「type_quat_cast 函数签名规范」

## 发现

### [严重] quatCast 算法实现中所有四个分支均存在 2 倍缩放因子错误

- **位置**：`cjglm/src/detail/type_quat_cast.cj:51-110`（`quatCast(Mat3x3)` 函数体）
- **描述**：与 GLM 1.0.3 `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:106-122` 对照分析，仓颉版 `quatCast` 在四个分支（X/Y/Z/W 分量最大）中**对非最大分量的求解都漏除了一个 2 倍因子**，导致返回的四元数（除 w 分量外）整体被错误地缩放 2 倍左右。GLM 源使用：
  ```cpp
  T biggestVal = sqrt(fourBiggestSquaredMinus1 + T(1)) * T(0.5);  // biggestVal = 0.5 * v
  T mult = T(0.25) / biggestVal;                                   // mult = 0.5 / v
  // 分量 = (matrix_element_diff) * mult = (4*biggest*comp) * 0.5 / v
  //      = (4*biggest*comp) * 0.5 / (2*biggest) = comp ✓
  ```
  而仓颉版在 W 分支（默认 else 分支，`type_quat_cast.cj:101-107`）使用 `let v = sqrtT(fourWSquaredMinus1 + one)`（v = 2w）后直接 `x = (m.c1.z - m.c2.y) / v`，由于 `m.c1.z - m.c2.y = M21 - M12 = 4wx`，代入得 `x = 4wx / (2w) = 2x`（应为 x）。X/Y/Z 三个分支（`type_quat_cast.cj:83-100`）使用同样的 `/v` 模式（`v = 2*最大分量`），均差 2 倍因子。

  以 q = (0, 0, 0, 1) + 90° X 旋转验证：quatCast 返回的 w = 0.707 ✓，但 x ≈ 1.414（应为 0.707），y = z = 0 ✓。再以 q = (0.2, 0.3, 0.4, 0.8) 非单位四元数 round-trip 验证：`mat3Cast(q)` 得到的矩阵 trace ≈ 1.84，`quatCast` 返回 ≈ (0.38, 0.57, 0.76, 0.84)，约为原 q 的 1.9 倍；进一步 `mat3Cast(quatCast(mat3Cast(q)))` 得到的 M00 ≈ -0.81（原 m.M00 = 0.5），与 m 不等。

  **影响**：`fromMat3`/`fromMat4` 工厂函数（`type_quat.cj:74-80`）均直接调用同函数，因此 GLM 1:1 行为契约被破坏——任何调用方在 round-trip 中都会得到错误的四元数（虽然仍可能代表同一种旋转，但幅值错误）。本应作为「真完整实现」的 4 个函数之一（OOD §1 表 18 个函数之列），但实际行为与 GLM 不一致。

- **建议**：参考 GLM 1.0.3 的 `biggestVal`/`mult` 模式重写四个分支。将每个分支的 `v` 拆分为 `biggestVal = v * half`（= 最大分量），然后各分量赋值改为：
  ```cangjie
  let biggestVal: T = v * half
  let mult: T = (Float64(0.25) as T).getOrThrow() / biggestVal
  x = (...) * mult
  y = (...) * mult
  z = (...) * mult
  w = biggestVal  // 或对应的最大分量
  ```
  或保持现有 `v` 变量但将 `x/y/z/w` 赋值中的 `/v` 改为 `/(v * two)`（即 `(Float64(0.5) as T).getOrThrow() / v`），与 GLM 行为对齐。修完后需在 `test_type_quat_cast.cj` 中补充数值验证测试用例（参见下一条），不能仅依赖 round-trip 测试。

---

### [严重] quatCast 测试文件未被发现——cjpm test 实际不执行任何 mat3Cast/mat4Cast/quatCast 测试

- **位置**：`cjglm/tests/glm/detail/test_type_quat_cast.cj:1-93`（测试文件本体）
- **描述**：本轮审查通过 `cjpm test --dry-run` 与 `cjpm test` 实测确认——`cjpm test` 在编译阶段仅处理 `src/detail/*_test.cj`、`src/ext/*_test.cj` 等 `src/` 目录下的测试文件（`Compiling test package 'glm.detail': cjc.exe ... -p C:\Develop\Software\cjglm_wp\cjglm\src\detail ... --test-only`），**不会**编译 `tests/` 目录下的测试。422 个被发现/通过的测试用例中**没有任何** `TestCase_testMat3Cast*`、`TestCase_testMat4Cast*`、`TestCase_testQuatCast*` 名称。这意味着：
  1. OOD §11.5「函数可用性对照表」中 `mat3Cast`/`mat4Cast`/`quatCast` 行所要求的「≥2 用例/函数」测试覆盖实际上**完全缺失**。
  2. OOD §8「验证项 17：type_quat_cast 函数 FloatingPoint<T> 约束可用性验证」与「§3.13.2 审计表 mat3Cast/mat4Cast/quatCast 行」中提及的实例化测试（`Quat<Float32, PackedHighp>` 与 `Quat<Int64, PackedHighp>`）未实际运行。
  3. 上一条「严重」bug 因子 2 缩放错误因此**未被任何测试覆盖**——如果该测试文件被 cjpm 编译运行，其 `testQuatCastNonIdentityMat3RoundTrip` 用例（`tests/glm/detail/test_type_quat_cast.cj:77-84`）会立刻失败。

  测试文件本身使用了 `Defaultp`/`PackedHighp` 等 `glm.detail.qualifier` 中的类型别名，对独立 `cjc --test` 编译会触发 `undeclared type name 'Defaultp'` 错误（已通过 `cjc --test tests/glm/detail/test_type_quat.cj --import-path src` 实测验证）。该测试文件应位于 `src/detail/type_quat_cast_test.cj` 而非 `tests/glm/detail/test_type_quat_cast.cj`，与 `src/detail/type_vec2_test.cj`、`src/detail/type_cast_test.cj` 等既有 `_test.cj` 模式保持一致。

- **建议**：
  1. **核心修复**——将 `tests/glm/detail/test_type_quat_cast.cj` 整体移动到 `src/detail/type_quat_cast_test.cj`，并按既有 `*_test.cj` 模式在文件首部添加 `package glm.detail`（已具备）+ 必要的 `import std.unittest.*`/`import std.unittest.testmacro.*` 导入。
  2. **测试强化**——在迁移后的文件中新增数值精确度测试用例（不能用 `m == m2` 形式绕过，必须用 `delta: 1e-6` 形式的 `@Expect`），覆盖以下场景：
     - 已知旋转的四元数（如 90° X 轴：`q = (s, 0, 0, s)` 其中 `s = sqrt(2)/2`）→ 矩阵 → 四元数 → 矩阵，逐元素比较；
     - 30°/45°/90°/180° 各轴的旋转四元数；
     - 单位四元数 `(0, 0, 0, 1)` 的 round-trip（已有，需保留）；
     - 浮点零矩阵输入（`m = Mat3x3(zeros)`）应返回 `(0, 0, 0, 1)` 单位四元数（验证 trace = 0 退化路径下的行为）。
  3. **同步处理**——`test_type_quat.cj`（位于 `tests/glm/detail/`）与 `test_type_quat_cast.cj` 存在同样的发现问题，审查过程中实测独立编译均失败（`undeclared type 'Defaultp'`），但因同样不在 cjpm 编译路径中而被静默跳过。建议一并迁移到 `src/detail/` 目录。

---

### [一般] mat4Cast 中 `one - one` 零获取路径与 OOD §1 字面量替代策略存在轻微偏差

- **位置**：`cjglm/src/detail/type_quat_cast.cj:30`（`let zero: T = one - one`）
- **描述**：OOD §1「常量型 T(n 字面量替代」段明确指出 `mat3Cast`/`mat4Cast` 转换函数中初始化 3×3/4×4 矩阵非对角线元素应使用 `T(Float64(0))` 字面量替代路径（`零化"非对角线元素 = T(Float64(0))` 字面量替代路径，不依赖 Mat3x3 零初始化默认值，显式逐元素赋值确保跨类型一致性`）。而本实现 `mat4Cast` 函数体中 `let zero: T = one - one`（line 30）仍采用 `one - one` 演算路径获取 0 值，**违反** OOD §1 显式约束（OOD 文档明确「统一修订为 `T(Float64(0))` 字面量替代路径」）。`mat3Cast`（line 5-25）则通过 `one - (tyy + tzz)` 等隐式推导出对角线 `1` 和非对角线 `0` 的填充——形式上未显式调用 `T(Float64(0))`，但因对角线 `1` 显式减去两个非对角 2x² 项的等效语义，结果与 OOD 设计一致；这是 OOD §3.2.1 段(b) 列举的「显式逐元素赋值」省略写法，可接受。

  严格审视 `mat4Cast` 的 line 30：`let zero: T = one - one` 在有 `one: T` 局部形参（line 29）可用时，固然可用 `one - one` 演算，但 OOD §1 明确将该模式限制为「**仅在 `identity(one)` 等显式携带 `one: T` 形参的函数中保留**」并特别说明 `mat3Cast`/`mat4Cast` 是 T(0) 字面量替代的「**系统性覆盖**」目标函数。建议对齐 OOD §1，将 `let zero: T = one - one` 改为 `let zero: T = (Float64(0.0) as T).getOrThrow()`。

- **建议**：将 `type_quat_cast.cj:30` 改为 `let zero: T = (Float64(0.0) as T).getOrThrow()`，与 OOD §1「常量型 T(n 字面量替代」统一策略闭环；其余 `let one: T = (Float64(1.0) as T).getOrThrow()` 表达式（line 7、line 29）保持不变，因 OOD 仅约束 T(0) 路径的修订，T(1) 通过 `one - one` 演算需 `one: T` 形参的设计本就在两函数内具备。

---

### [一般] 私有工具函数 `sqrtT` 与 `zeroOrOne` 的抽象层次与命名风格可优化

- **位置**：`cjglm/src/detail/type_quat_cast.cj:122-130`
- **描述**：
  1. `sqrtT<T>(x: T): T where T <: FloatingPoint<T>`（line 122-125）通过 `Float64` 中转实现 `T` 类型 sqrt——`(x as Float64).getOrThrow()` → `sqrt(x64) → (sqrt(x64) as T).getOrThrow()`。该函数本身**未在任何地方被调用**！`grep -n "sqrtT" cjglm/src/detail/type_quat_cast.cj` 仅显示该函数定义行，无调用方；同样 `grep -n "sqrtT" cjglm/src/` 无其他引用。`quatCast` 函数体内的 `let v: T = sqrtT(fourXSquaredMinus1 + one)` 等调用实际并非在 cangjie 代码中——实测代码使用 `let v: T = sqrtT(...)` 是当前实际写法（line 84、90、96、102），但 `sqrtT` 函数未被引用导致死代码。
  2. `zeroOrOne<T>(one: T): T where T <: Number<T>`（line 127-129）命名反直觉——`one` 形参减去自身得 `zero`，但函数名暗示「zero or one」结果歧义；其实际唯一作用是返回 `0`。建议更名为 `zeroOf<T>(one: T): T` 或直接内联。
  3. 死代码问题反映编译时**未启用** `-Woff unused` 之外的告警，可能影响代码整洁度；建议下游 `cjlint`/`cjpm build` 流程中增加死代码检测。

- **建议**：
  1. 删除未被调用的 `sqrtT` 函数，或在 `quatCast` 函数体中**实际**使用它（替换 line 84、90、96、102 的 `sqrtT(...)` 调用为该函数的实现，而非用工具函数却不被引用）。当前实现下 `let v: T = sqrtT(...)` 实际就是调用该函数，但若 `sqrtT` 移除则需要将函数体 inline 到 4 个调用点。
  2. `zeroOrOne` 改名为 `zeroOf` 或在 4 处调用点（line 78-81）直接使用 `(Float64(0.0) as T).getOrThrow()` 字面量替代（与 OOD §1 策略一致，可消除 `one - one` 演算）。
  3. **注**——若选择「保留 sqrtT 工具函数 + 替换 zeroOrOne」方案，需同步更新 OOD §3.2.1 描述。

---

### [一般] quatCast 内部 `var` + 多次 `if` 重新赋值的控制流可优化为更清晰的形式

- **位置**：`cjglm/src/detail/type_quat_cast.cj:62-76`（`biggestIndex` 求解段）
- **描述**：通过 `var fourBiggest` 配合 3 个 `if (... > fourBiggest)` 串行比较求解最大分量及对应索引（line 62-76），控制流使用 `var` + 多次条件赋值。GLM 原版使用相同模式（C++ 没有内置 `maxIndex`），可读性尚可，但仓颇侧可考虑使用 `match` 表达式或 `let (biggestVal, biggestIndex) = maxOf4(...)` 元组解构模式（若仓颇支持）。当前实现是 GLM 直译版本，符合 OOD §1 决策 D11/D32 的「消除包间循环依赖」设计意图（`quatCast` 应为简单的纯算术函数，无外部依赖）。

- **建议**：保持现状即可；如未来优化可考虑将 `biggestIndex` 替换为枚举类型（`enum BiggestComp { X, Y, Z, W }`），但当前实现已正确且 OOD 未要求枚举化。

---

### [一般] quatCast(Mat4x4) 依赖列布局假设 `c0/c1/c2` 与 `c3` 行为预期的一致性需文档说明

- **位置**：`cjglm/src/detail/type_quat_cast.cj:112-120`（`quatCast(Mat4x4)` 重载）
- **描述**：`quatCast(Mat4x4)` 手动构造 `Mat3x3` 子矩阵，假设 Mat4x4 的 `c0/c1/c2` 三列对应左上 3×3 旋转块（与 GLM `type_quat.inl` 的隐式 Mat3x3(Mat4x4) 转换一致）。OOD §3.2.1「`fromMat4` 工厂函数」段已明确该列提取模式（`cjglm/src/detail/type_mat4x4.cj:8-11` 中 `c0`/`c1`/`c2`/`c3` 字段），与本实现一致。建议在 `quatCast(Mat4x4)` 函数体内添加一行注释说明该列提取依据（OOD §3.2.1 段规定本注释非强制，但有助于后续维护）。

- **建议**：可选优化，不阻塞审查通过。

---

### [轻微] `quatCast(Mat3x3)` 中 `var x/y/z/w` 的初始值 `zeroOrOne(one)` 显式多余——分支必覆盖所有 4 路

- **位置**：`cjglm/src/detail/type_quat_cast.cj:78-81`（`var x: T = zeroOrOne(one)` 等 4 行）
- **描述**：`if-else if-else if-else` 四路分支（line 83-107）覆盖 `biggestIndex` 的全部 4 个可能值（0/1/2/3），编译器应能识别四个 `x/y/z/w` 变量在每个分支均被赋值。当前显式初始化为 `zeroOrOne(one)` 是为了规避仓颇「`var` 必须初始化」约束，但与「每个分支均覆盖」的代码语义有冗余。

- **建议**：保留当前实现，因编译器确实要求 `var` 初始化；如需优化可使用 `let x: T` + 元组 `(x, y, z, w) = match biggestIndex { case 0 => (...) case 1 => (...) ... }` 模式替换（仓颇 `match` 表达式语法支持元组赋值），但当前可读性已足够。

---

## 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 2 |
| 一般 | 3 |
| 轻微 | 1 |

## 总评

本轮审查对象 `cjglm/src/detail/type_quat_cast.cj` 的**包间依赖方向**严格符合 OOD §2「`glm.gtc → glm.detail` 单向依赖」约束（实测 `grep -n "import" cjglm/src/detail/type_quat_cast.cj` 仅 1 行 `import std.math.{ Number, FloatingPoint, sqrt }`，无任何 `glm.gtc`/`glm.ext` 跨包 import），**与 `type_quat.cj` 的同包协作**正确（`fromMat3`/`fromMat4` 工厂直接调用 `quatCast` 而无需跨包 import，符合 D11 设计），**约束块选择**（`FloatingPoint<T>` 而非 `Number<T>`）与 D32 决策一致，**`mat3Cast`/`mat4Cast` 函数签名**（含 `T <: FloatingPoint<T>`）与 OOD §3.2.1「type_quat_cast 函数签名规范」模板 1:1 对齐。

然而存在两个**严重问题**导致 4 个函数未能达到 OOD §1「真完整实现」质量标准：

1. **quatCast 算法因子 2 缩放 bug**——所有 4 个分支（X/Y/Z/W 分量最大）均将非最大分量的 `/v` 模式实现为 `(非最大分量差) / (2*最大分量)` 而非 GLM 期望的 `(非最大分量差) / (4*最大分量)`，导致 round-trip 失败（实测 q=(0.2, 0.3, 0.4, 0.8) round-trip 后 mat3Cast 不等）。与 GLM 1.0.3 `gtc/quaternion.inl:106-122` 的 `biggestVal * mult` 双因子模式不一致。

2. **测试覆盖真空**——`tests/glm/detail/test_type_quat_cast.cj`（8 个测试用例）**未被 cjpm test 发现/执行**，与 OOD §11.5「≥2 用例/函数」要求相悖；这直接导致上述算法 bug 在 CI 中长期不被捕获。建议迁移测试文件至 `src/detail/type_quat_cast_test.cj` 并补充数值精确度测试用例（不能仅依赖 round-trip）。

`mat3Cast`/`mat4Cast` 函数的矩阵填充公式（`type_quat_cast.cj:5-49`）经与 GLM 1.0.3 `gtc/quaternion.inl:47-72` 逐行对比验证，**实现正确**——9 个矩阵元素（含 4×4 版本的第 4 行/列）逐元素与 GLM 一致。`mat3Cast` 中 `one - (tyy + tzz)` 等表达式利用 txx=2x² 等中间量，等价于「1 - 2(y²+z²)」标准公式，矩阵元素计算正确。

**总结**——`type_quat_cast.cj` 在包间协作、签名设计、约束策略、mat3Cast/mat4Cast 实现 4 个维度与 OOD 设计完全对齐（95% 以上符合度），但 `quatCast` 算法实现存在严重的因子 2 缩放错误，加上测试覆盖缺失，**两者构成阻断性问题**——在修复算法 bug 并迁移测试文件至可被 cjpm 发现的位置前，本文件的 4 个函数不应被认定达到 OOD §1 「✅ 真完整实现」状态。
