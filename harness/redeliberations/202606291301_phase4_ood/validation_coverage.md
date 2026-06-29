# 阶段四 OOD 需求覆盖度验证报告

> **验证对象**：`a_v16_copy_from_v15.md`（最终 OOD 设计文档）
> **验证日期**：2026-06-29
> **验证范围**：阶段四所有模块的功能、接口、行为

---

## 维度一：阶段四范围覆盖

**评分：A（完整覆盖）**

OOD 文档完整覆盖了路线图（`02_roadmap.md`）中定义的阶段四所有模块和功能：

| 路线图定义模块 | OOD 覆盖位置 | 状态 |
|---------------|-------------|------|
| common.cj | §3.1 common.cj | ✅ 完整覆盖全部 25 个函数族 + modf/frexp/ldexp 签名设计 |
| exponential.cj | §3.1 exponential.cj | ✅ 完整覆盖 pow/exp/log/exp2/log2/sqrt/inversesqrt |
| trigonometric.cj | §3.1 trigonometric.cj | ✅ 完整覆盖 sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees |
| geometric.cj | §3.1 geometric.cj | ✅ 完整覆盖 dot/cross/normalize/length/distance/reflect/refract/faceforward |
| matrix.cj (det/inv) | §3.1 matrix.cj | ✅ 完整覆盖 determinant 和 inverse（2x2/3x3/4x4） |
| ext/scalar_common.cj | §3.2 ext/scalar_common.cj | ✅ 完整覆盖 17 个函数（包含完整签名清单） |
| ext/vector_common.cj | §3.2 ext/vector_common.cj | ✅ 完整覆盖 20 个函数（包含完整签名清单） |
| ext/matrix_transform.cj | §3.2 ext/matrix_transform.cj | ✅ 覆盖 identity/translate/rotate/scale/shear/lookAt 系族 |
| ext/matrix_projection.cj | §3.2 ext/matrix_projection.cj | ✅ 覆盖 7 个函数（含独立类型参数 U） |
| ext/matrix_clip_space.cj | §3.2 ext/matrix_clip_space.cj | ✅ 覆盖 46 个函数（按系族分类） |
| ext/quaternion_common.cj | §3.2 ext/quaternion_common.cj | ✅ 补齐 mix/slerp/slerp(k) |
| ext/quaternion_transform.cj | §3.2 ext/quaternion_transform.cj | ✅ 补齐 rotate |
| ext/quaternion_trigonometric.cj | §3.2 | ✅ 额外纳入 angle/angleAxis 补齐 |
| gtc/matrix_transform.cj | §3.3 gtc/matrix_transform.cj | ✅ 覆盖 64 个函数 + _slow 变体说明 |
| gtc/matrix_inverse.cj | §3.3 gtc/matrix_inverse.cj | ✅ 覆盖 affineInverse/inverseTranspose |
| gtc/matrix_access.cj | §3.3 gtc/matrix_access.cj | ✅ 覆盖 row/column（9 个矩阵类型） |
| gtc/packing.cj | §3.3 gtc/packing.cj | ✅ 覆盖 32 个函数（完整签名清单） |
| gtc/noise.cj | §3.3 gtc/noise.cj | ✅ 覆盖 12 个函数（perlin1D~4D + simplex1D~4D + perlin 周期版） |
| gtc/random.cj | §3.3 gtc/random.cj | ✅ 覆盖 linearRand/gaussRand + ThreadLocal<Random> 引擎策略 |
| gtc/type_precision.cj | §3.3 gtc/type_precision.cj | ✅ 覆盖约 100 个类型别名（含完整清单） |
| gtc/ulp.cj | §3.3 gtc/ulp.cj | ✅ 覆盖 next_float/prev_float/float_distance/ulp |
| gtc/round.cj | §3.3 gtc/round.cj | ✅ 覆盖 6 个函数 |
| stdmath_shim.cj | §1.4 + §2 | ✅ 新增私有工具模块，为阶段四新增的内部基础设施 |
| lib.cj 更新 | §8 | ✅ 提供完整的 public import 代码块 |

**补充范围说明**：
- 本阶段额外纳入 `ext/quaternion_trigonometric.cj` 的 `angle`/`angleAxis` 补齐（§1.6 说明）
- 明确排除 `ext/quaternion_exponential.cj` 并给出理由（§1.5）
- `gtc/constants.cj` 和 `ext/scalar_constants.cj` 沿用阶段三
- 实施批次建议（4 批拓扑排序）与路线图一致

**结论**：无遗漏模块。

---

## 维度二：参考实现对齐

**评分：B（基本对齐，存在 2 处需修正的不一致）**

通过与 GLM 1.0.3 参考实现源码对照验证，发现以下问题：

### 已确认对齐的内容

1. ✅ **common 函数族**：全部 25 个函数签名与 GLM 1.0.3 `common.hpp` 一致
2. ✅ **exponential 函数族**：7 个函数完全对齐
3. ✅ **trigonometric 函数族**：14 个函数完全对齐
4. ✅ **geometric 函数族**：8 个函数对齐
5. ✅ **ext/scalar_common**：17 个函数与 GLM 1.0.3 `ext/scalar_common.hpp` 完全对齐
6. ✅ **ext/vector_common**：20 个函数与 GLM 1.0.3 `ext/vector_common.hpp` 完全对齐
7. ✅ **ext/matrix_projection**：7 个函数 + 独立 `U <: Number<U>` 类型参数与 GLM `template<typename T, typename U, qualifier Q>` 对齐
8. ✅ **ext/matrix_clip_space**：46 个函数按系族分类与 GLM 对应头文件一致
9. ✅ **gtc/matrix_transform**：纯聚合头文件定位与 GLM `gtc/matrix_transform.hpp`（仅 `#include`）一致
10. ✅ **gtc/matrix_inverse**：affineInverse/inverseTranspose 对齐
11. ✅ **gtc/packing**：32 个函数完整对齐
12. ✅ **gtc/noise**：12 个函数内容对齐（命名因仓颉限制改为 perlin1D~4D/simplex1D~4D，DS31 已记录）
13. ✅ **gtc/ulp**：具体类型重载策略正确（仓颉 `FloatingPoint<T>` 不提供 `toBits()`）
14. ✅ **gtc/random**：linearRand/gaussRand 对齐
15. ✅ **gtc/round**：6 个函数对齐
16. ✅ **acos/asin 越界保护**：正确识别仓颉 `std.math.acos` 抛异常 vs GLM 返回 NaN 的差异，增加前置检查

### 需修正的问题

**P1（中等）— `ext/matrix_transform.cj` 的 `shear` 函数签名与 GLM 1.0.3 不符**

- **OOD 描述**：`shear(m, p, l_x, l_y, l_z)` 中的 `p`、`l_x`、`l_y`、`l_z` 参数隐式类型为 `T`
- **GLM 1.0.3 实际签名**（`ext/matrix_transform.hpp:121-123` + `ext/matrix_transform.inl:127-128`）：
  ```cpp
  template<typename T, qualifier Q>
  mat<4,4,T,Q> shear(mat<4,4,T,Q> const& m, vec<3,T,Q> const& p,
                     vec<2,T,Q> const& l_x, vec<2,T,Q> const& l_y, vec<2,T,Q> const& l_z);
  ```
- **差异**：`p` 应为 `Vec3<T, Q>`（标量 `T`），`l_x/l_y/l_z` 应为 `Vec2<T, Q>`（标量 `T`）
- **影响范围**：§3.2 ext/matrix_transform.cj 职责描述及隐式签名
- **建议**：修正为完整的仓颉签名 `shear<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>): Mat4x4<T, Q>`

**P2（较低）— `shear_slow` 实现路径描述有误**

- **OOD 声称**："`shear_slow` 使用 `tan` 计算剪切因子"
- **GLM 1.0.3 实际实现**（`ext/matrix_transform.inl:127-150`）：`shear_slow` 内部仅从 `vec2` 参数提取分量构造剪切矩阵，**未使用 `tan` 函数**
- **建议**：删除或修正 `shear_slow` 的 `tan` 实现路径说法，改为与 GLM 一致的 vec2 分量提取 + 矩阵构造描述

**P3（较低）— `ext/quaternion_common.cj` 的 `slerp` 第 4 个参数 `k` 类型**

- **OOD**：`slerp<T, Q>(x, y, a, k: Int64)`
- **GLM 1.0.3**（`ext/quaternion_common.hpp`）：`slerp(qua<T,Q> const& x, qua<T,Q> const& y, T a, T k)`——`k` 为浮点类型 `T`
- **建议**：将 `slerp` 第四参数类型从 `Int64` 修正为 `T`（与 GLM 一致）

### 已确认的行为差异声明（设计有意识接受）

| 差异 | OOD 位置 | 说明 |
|------|---------|------|
| Float16 `(result as T).getOrThrow()` 溢出异常 vs GLM ±Inf | §1.4 + D29 | Float16 低精度场景极少触发，接受 |
| `uround` 负数输入抛异常 vs GLM 模运算回绕 | §3.2 ext/scalar_common.cj | 语义错误，抛异常有助于及早捕获 |
| Float32 非规格化数 `ldexp` 精度损失 | §3.1 common.cj + D29 | 非规格化数在图形计算中极少出现 |
| `iround`/`uround` 返回 Int64/UInt64 vs GLM int/uint | §3.2 ext/scalar_common.cj | 仓颉默认整数为 64 位 |
| `next_float`/`prev_float` 前缀版本（带 ULPs 参数）未覆盖 | §3.3 gtc/ulp.cj | OOD 限定范围为基本 4 函数，签名版本后续可补 |
| Float16 ULP 函数缺失 | §3.3 gtc/ulp.cj | 明确标注为已知缺失 |

---

## 维度三：已有阶段对接

**评分：A（明确定义）**

OOD 文档对与阶段一二三的对接有完整且明确的设计：

### 明确的对接接口

1. **§9.1 对阶段三的反馈影响**：逐一说明阶段三中 5 类 stub 在本阶段解锁后的行为变化
   - Quat×Vec3/Quat×Vec4 从抛 stub 变为正常（依赖 geometric.cj cross）
   - slerp/mix 从 ❌ 变为可用（依赖 trigonometric 和 geometric）
   - rotate 从 stub 变为可用（依赖 trigonometric sin/cos）
   - gtc/matrix_transform.cj 从 stub 变为可用
   - angle/angleAxis 从 stub 变为可用

2. **§9.2 对阶段二的反向兼容**：明确声明 matrix.cj 已有 27 个实现不做修改，仅替换 6 个 stub

3. **§9.3 对阶段一的反向兼容**：不修改任何 Vec 类型文件

4. **§9.4 lib.cj 导出策略**：增量追加策略 + 修改第 23 行消除命名冲突

### 明确的依赖关系

- **§2 模块间依赖表**：完整列出各模块的依赖关系和标注
- **§2 依赖方向总览**：声明 `glm.gtc → glm.detail`、`glm.ext → glm.detail`、`glm → glm.detail/gtc/ext` 的单向依赖
- **§2 与阶段三的依赖变化说明表**：列出 6 个阶段三阻塞点及本阶段解除方式
- **§8 实施批次**：4 批按拓扑依赖排序，每批标注前置依赖

### 约束继承

- **§1.4**：明确继承阶段二/三的系统性约束（字面量构造、FloatingPoint 接口、std.math Float64 委托模式）

### D16 向后不兼容变更

- geometric.cj 约束从 `Number<T>`（阶段三 stub）收紧为 `FloatingPoint<T>`，在 D16 中明确标注

---

## 维度四：文档完整性

**评分：A（完整）**

OOD 文档包含全部必要内容：

| 必要内容 | 位置 | 状态 |
|---------|------|------|
| **架构视图** | §1 | ✅ 概述、核心抽象表（类型形态、角色）、整体架构思路、三层包结构 |
| **模块目录** | §2 | ✅ 完整的文件树形结构（含 ★ 标记改动文件），每个文件的函数清单 |
| **类型定义** | §3 | ✅ 各模块类型定义、约束策略、实现路径详细描述 |
| **接口签名** | §3 | ✅ 绝大多数模块提供完整的仓颉函数签名（代码块形式） |
| **依赖关系** | §2 | ✅ 模块间依赖表、依赖方向总览、依赖变化表 |
| **数据流** | §4 | ✅ 6 个核心场景（基础调用/几何运算/矩阵逆/矩阵变换/四元数补齐/依赖变化） |
| **错误处理** | §5 | ✅ 7 类错误场景表 + 总体策略说明 |
| **并发设计** | §6 | ✅ random.cj 例外声明 + 其余纯函数声明 |
| **设计决策** | §7 | ✅ 31 项（D01~D31）完整记录，含理由和影响 |
| **实施计划** | §8 | ✅ 4 批拓扑排序 + lib.cj 更新完整代码块 |
| **已有阶段集成** | §9 | ✅ 阶段一/二/三对接说明 |
| **确定性声明** | §1.7 | ✅ H1~H6 全部已验证 |
| **本阶段不覆盖范围** | §1.5 | ✅ ext/quaternion_exponential.cj 排除声明 |
| **修订说明** | 末尾 | ✅ v1→v16 完整记录 |

### 亮点

- 函数签名映射采用完整仓颉代码块形式（如 packing.cj 的 32 个函数）
- 每个设计决策都链接到决策编号（D01~D31），形成跨章节引用链
- 错误处理与设计决策、场景描述三者一致（如 acos 越界返回 NaN + D26 + §4.5 slerp clamp 说明无矛盾）
- 已知行为差异声明清晰

---

## 维度五：可编码性

**评分：B（基本可编码，需先修正 2 处影响编码正确性的问题）**

### 正面评估

1. **函数签名明确**：所有模块的函数签名以仓颉代码块或伪代码形式给出
2. **约束策略清晰**：每个函数的 `where` 约束已指定（`FloatingPoint<T>` / `Number<T>` + `Comparable<T>` 等）
3. **实现路径详细**：每个函数的实现公式、特殊情况处理、委托路径均有说明
4. **边缘场景覆盖**：零向量 normalize、奇异矩阵求逆、acos 越界、inversesqrt 零值、frexp 边缘场景均有明确策略
5. **批次顺序清晰**：4 批拓扑排序，每批标注前置依赖
6. **lib.cj 代码块提供**：可直接复制使用的 public import 代码块
7. **6 项确定性声明**已验证（H1~H6），消除编码阶段的编译器假设风险

### 编码前必须修正的问题

1. **P1（中等）— `shear` 参数类型错误**（见维度二 P1）
   - 影响：编码人员会按 `T` 标量参数实现 `shear`，生成错误的函数签名
   - 修正：将 `shear(m, p, l_x, l_y, l_z)` 的参数类型修正为 `p: Vec3<T, Q>`, `l_x/l_y/l_z: Vec2<T, Q>`

2. **P2（较低）— `slerp` 第 4 参数类型**（见维度二 P3）
   - 影响：`slerp(x, y, a, k)` 的 `k` 若按 `Int64` 实现，调用方传入浮点数会编译报错
   - 修正：将 `k: Int64` 改为 `k: T`

3. **P3（较低）— `shear_slow` 实现路径描述有误**（见维度二 P2）
   - 影响：编码人员可能误用 `tan` 实现，与 GLM 行为不一致
   - 修正：删除 `tan` 说法

### 编码阶段需自行决策的项目（正常，不影响编码启动）

1. `ext/vector_common.cj` 实现策略：逐分量映射 vs 委托 scalar_common 函数（§3.2 已标注"编码阶段决定"）
2. 标量浮点 `mod` 重载的增益实现（§3.1 + D15：推荐实现，非强制）
3. `stdmath_shim.cj` 函数的具体命名和签名细节
4. 测试文件的组织方式

---

## 总体结论

**结果：CONDITIONAL_PASS**

### 评分汇总

| 维度 | 评分 | 级别定义 |
|------|------|---------|
| 维度一：阶段四范围覆盖 | **A** | 全部覆盖，无遗漏 |
| 维度二：参考实现对齐 | **B** | 基本对齐，存在 2 处签名/描述不一致 |
| 维度三：已有阶段对接 | **A** | 明确定义，完整清晰 |
| 维度四：文档完整性 | **A** | 包含所有必要内容 |
| 维度五：可编码性 | **B** | 基本可编码，2 处影响编码正确性问题 |

### 必须修复的问题清单（编码前必须解决）

| 编号 | 严重度 | 问题 | 位置 | 修复方案 |
|------|--------|------|------|---------|
| **F1** | **中等** | `ext/matrix_transform.cj` 的 `shear` 函数参数类型错误：`p` 实际为 `Vec3<T,Q>`（非标量 `T`），`l_x/l_y/l_z` 各为 `Vec2<T,Q>`（非标量 `T`） | §3.2 ext/matrix_transform.cj | 修正为完整仓颉签名：`func shear<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>): Mat4x4<T, Q>` |
| **F2** | **较低** | `ext/quaternion_common.cj` 的 `slerp` 第 4 参数 `k` 类型应为 `T`（浮点）而非 `Int64` | §3.2 ext/quaternion_common.cj + §8 lib.cj 导出 | 将签名中 `k: Int64` 改为 `k: T where T <: FloatingPoint<T>` |
| **F3** | **较低** | `gtc/matrix_transform.cj` 的 `shear_slow` 实现路径误称使用 `tan` 函数 | §3.3 gtc/matrix_transform.cj _slow 变体段落 | 删除"使用 `tan` 计算剪切因子"说法，改为与 GLM 一致的 vec2 分量提取描述 |

### 建议改进项目（非阻塞，建议在编码前完善）

| 编号 | 级别 | 建议 | 位置 |
|------|------|------|------|
| S1 | 建议 | `ext/matrix_transform.cj` 的 `shear` 当前缺少完整仓颉参数类型声明，仅列举参数名 | §3.2 |
| S2 | 建议 | `ext/matrix_clip_space.cj` 仅给出典例签名而非完整签名清单，编码时需参考 GLM 源码补全 46 个变体 | §3.2 |
| S3 | 建议 | `gtc/type_precision.cj` 约 100 个别名的具体 `type` 定义代码未提供（编码阶段需逐一定义） | §3.3 |
| S4 | 参考 | `ext/quaternion_common.cj` 的 `slerp` 退化阈值 `epsilon<T>()` 需确认在仓颉中可编译 | §3.2 |

### 最终裁决

**总评：CONDITIONAL_PASS**，处理完上述 F1~F3 三个问题后可上升为 **PASS**。
