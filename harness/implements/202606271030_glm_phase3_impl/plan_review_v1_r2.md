# 计划审查报告（v1 r2）

## 审查结果
REJECTED

## 发现

### **[严重] 问题 1：R1 `epsilon<T>()` 实现路径依赖不可编译的 `T(0)` 构造**

计划 R1 上下文指定 `epsilon<T>()` 的主实现路径为 `epsilonOf<T>(T(0))`（委托 `shim_limits.cj:25` 的 `epsilonOf`）。但 OOD §1 系统性设计约束已明确指出——**无约束泛型参数不支持 `T(0)` 构造调用**，已验证通过的是 `T(Float64(0))`（H1 验证项 25），而非 `T(0)`。在 `func epsilon<T>() where T <: FloatingPoint<T>` 泛型函数体内，`T(0)` 无法通过编译——`FloatingPoint<T>` 接口不保证 `init(Int64)` 构造器的存在。

**为什么是严重问题**：这是 R1 的核心实现路径——如果 `epsilon<T>()` 无法编译通过，R1 整个轮次失败，导致后续依赖 `epsilon`/`pi`/`cos_one_over_two` 的所有轮次（R6 的 normalize、R8 的 isnan/isinf 中的 epsilon 检测、R9 的 axis、R12 的 gtc/constants、R13 的 gtc/quaternion 等）均无法验证。

**期望的修正方向**：将主路径从 `epsilonOf<T>(T(0))` 修正为 `epsilonOf<T>(T(Float64(0)))`，使用已验证通过的 `T(Float64(0))` 字面量替代路径。备选路径（通过 `T(Float64(0))` 构造临时值后 `match` 分派）可直接升级为主路径。

### **[严重] 问题 2：gtc/ 子包 cjpm 构建验证缺失，R12-R14 存在结构性阻塞风险**

计划将 R12（gtc/constants.cj）、R13（gtc/quaternion.cj）、R14（gtc/matrix_transform.cj）直接安排在 `src/gtc/` 目录下，使用 `package glm.gtc` 声明。但 OOD §2「cjpm 子包构建预验证」明确说明——`src/gtc/` + `package glm.gtc` 的 cjpm 子包发现机制**尚未验证**（"属 cjpm 构建系统的额外不确定性，需原型验证"），并提供了降级到 `src/` 根目录 + `package glm` 的完整回退方案。

计划中完全没有提及 gtc 子包验证，也未预留验证轮次或回退方案。如果 cjpm 不支持 `src/gtc/` 子目录的子包发现，R12-R14 生成的所有文件需要改变 `package` 声明、lib.cj 的 import 路径需要重写，属于结构性变更。

**为什么是严重问题**：影响 3 个完整轮次（R12-R14），涉及 6 个文件（3 个源码 + 3 个测试），且 gtc/ 目录当前为空（从未被验证过），属于完全未知风险的构建系统行为。

**期望的修正方向**：在 R12 之前增加 gtc 子包原型验证轮次（可参考 OOD §2 的验证项 1 和验证项 2），或在计划中明确标注 gtc/ 文件的降级方案（文件放在 `src/` 根目录、使用 `package glm`），并注明一旦降级后 lib.cj 和 fwd.cj 的 import 路径变更方案。

### **[一般] 问题 3：R1 依赖链描述不完整**

计划上下文称 scalar_constants 的"依赖仅止于 setup.cj"，实际完整的依赖链包括：
- `setup.cj`（依赖存在，正确）
- `shim_limits.cj:25`（依赖 `epsilonOf<T>`，若采用 plan 的 `epsilonOf` 委托路径则必须 import）
- `std.math.cos`（用于 `cos_one_over_two<T>()` 的计算路径）
- `FloatingPoint<T>.getPI()`（用于 `pi<T>()`）

依赖链描述不完整可能导致实现过程中 import 遗漏，或对"R1 可独立完整实现"的判断过于乐观。

**期望的修正方向**：将 R1 上下文中的依赖描述补充完整，明确标注所有 import 依赖。

### **[轻微] 问题 4：R8 `conjugate` 可声明为 `const func` 未标注**

OOD §3.11 明确说明 `conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反（无 `assert`/`throw`/非 const 调用），**可声明为 `const func`**。计划 R8 上下文中未提及此优化方向。

不影响正确性，属于优化遗漏。
