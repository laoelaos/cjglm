# R1: glm.ext 扩展函数库 Phase 4 OOD 一致性审查

审查时间：2026-06-30

### 审查范围

| 文件 | 行数 | 说明 |
|------|------|------|
| `cjglm/src/ext/scalar_common.cj` | 114 | 17 个标量扩展函数（新建完整实现） |
| `cjglm/src/ext/vector_common.cj` | 214 | 20 个向量扩展函数（新建完整实现） |
| `cjglm/src/ext/matrix_transform.cj` | 99 | 矩阵变换扩展（替换 stub） |
| `cjglm/src/ext/matrix_projection.cj` | 85 | 投影矩阵扩展（替换 stub） |
| `cjglm/src/ext/matrix_clip_space.cj` | 407 | 裁剪空间矩阵扩展（替换 stub） |

参考依据：`docs/06_ood_phase4.md` §3.2、`docs/deviations.md`、`cangjie-*` 系列 skill

### 发现

#### [严重] matrix_transform.cj rotate 和 shear 使用错误的乘法顺序

- **位置**：`cjglm/src/ext/matrix_transform.cj:39`（rotate）、`cjglm/src/ext/matrix_transform.cj:63`（shear）
- **描述**：GLM 1.0.3 的 `rotate` 和 `shear` 均使用 `m * transform`（局部变换）乘法顺序。同文件中的 `translate`（`m * T`，第 7~16 行）和 `scale`（`m * S`，第 42~51 行）正确遵循了此模式。但 `rotate` 实现为 `Rot * m`（第 39 行）、`shear` 实现为 `H * m`（第 63 行），即世界/全局变换顺序。结合 `translate` 与 `rotate` 的顺序组合会产生错误结果：
  - GLM 中 `translate(rotate(m, θ, axis), v)` = `m * R * T`（先旋转再平移，旋转在物体局部空间）
  - 代码中 `translate(rotate(m, θ, axis), v)` = `result = translate(Rot * m, v)` 导致平移在旋转的全局空间进行
- **建议**：将第 39 行 `Rot * m` 改为 `m * Rot`，将第 63 行 `H * m` 改为 `m * H`，与 translate/scale 的乘法顺序一致

#### [一般] vector_common.cj 缺失 3/4 输入 fmin/fmax 向量版本

- **位置**：`cjglm/src/ext/vector_common.cj:59-107`
- **描述**：OOD §3.2 `vector_common.cj` 函数清单明确包含 4 个 NaN 安全 fmin/fmax 多输入抽象签名：
  - `func fmin<L,T,Q>(a,b,c: Vec<L,T,Q>)` → 展开为 Vec1~Vec4（4 个具体函数）
  - `func fmin<L,T,Q>(a,b,c,d: Vec<L,T,Q>)` → 展开为 Vec1~Vec4（4 个具体函数）
  - `func fmax<L,T,Q>(a,b,c: Vec<L,T,Q>)` → 展开为 Vec1~Vec4（4 个具体函数）
  - `func fmax<L,T,Q>(a,b,c,d: Vec<L,T,Q>)` → 展开为 Vec1~Vec4（4 个具体函数）
  共 16 个具体函数缺失。`scalar_common.cj` 中标量 3/4 输入 fmin/fmax 已实现（第 33~46 行和第 56~69 行），向量版本应逐分量委托之。
- **建议**：为 Vec1~Vec4 各添加 3 输入和 4 输入 fmin/fmax，逐分量调用 `ext.scalar_common` 对应标量函数

#### [一般] scalar_common.cj iround/uround 未委托 stdmath_shim.roundT

- **位置**：`cjglm/src/ext/scalar_common.cj:104-114`
- **描述**：OOD §3.2 明确指定 `iround`/`uround` 应委托 `stdmath_shim.cj` 的 `roundT` 包装函数（即 `Int64(stdmath_shim.roundT(x))` 模式），经由 `(x as Float64).getOrThrow() → std.math.round → (result as T).getOrThrow()` 三层路径。当前实现跳过 stdmath_shim 中间层，直接调用 `math.round` 在 Float64 上并将结果转型为 Int64/UInt64。功能上等价，但 Float16 溢出行为不一致——当前实现直接从 `Float64.round` 转型 `Int64` 而非经 `T` 中间类型返回。
- **建议**：修改为 `Int64(roundT(x))`/`UInt64(roundT(x))` 模式，即 `let rT = roundT(x); (rT as Int64).getOrThrow()`，确保 Float16 溢出保护一致性

#### [轻微] matrix_transform.cj 缺少 identity 函数

- **位置**：`cjglm/src/ext/matrix_transform.cj`（不存在）
- **描述**：OOD §3.2 ext/matrix_transform.cj 函数清单列有 `identity()`，但实现文件中未定义。`identity` 实际位于 `cjglm/src/gtc/matrix_transform.cj:16`。GLM 1.0.3 中 `identity` 位于 gtc 而非 ext 层（`ext/matrix_transform.hpp` 不含 `identity`），但 OOD 设计将其归入 ext 层。当前实现与 GLM 1.0.3 一致但偏离 OOD 设计。
- **建议**：在 ext/matrix_transform.cj 补加 `identity` 转发到 `Mat4x4.identity`（类型成员方法），或更新 OOD 文档将 identity 从 ext 调整至 gtc

#### [轻微] scalar_common.cj mirrorRepeat 使用间接公式计算 mod

- **位置**：`cjglm/src/ext/scalar_common.cj:96`
- **描述**：OOD 设计公式使用 `mod(Floor, T(2))`，代码实现为 `Floor - two * floor(Floor / two)`。对于 `Floor >= 0` 两者等价，但间接公式多一次 `floor` 调用且适用范围窄于通用 `mod`。
- **建议**：替换为 `mod(Floor, two)` 以匹配 OOD 设计，并利用已有 `detail.mod` 函数（如已为具体浮点类型实现 mod 重载）

#### [轻微] matrix_projection.cj project/unProject 缺少零 w 保护

- **位置**：`cjglm/src/ext/matrix_projection.cj:8、46`
- **描述**：`projectImpl` 中 `tmp.w` 可能为零（当 obj 在投影矩阵的 w=0 裁剪平面上），`ndc.x / tmp.w` 导致除零 Infinity。OOD §5 声明"不做输入有效验证"，但此处在视口变换前直接使用透视除法，零 w 场景会污染后续视口计算（Inf * 0 = NaN 传播）。GLM 1.0.3 同无保护行为一致，属于已知行为差异（见 OOD §5 错误处理策略）。
- **建议**：当前行为可接受（与 GLM 一致），但建议标注为已知风险点。不做代码修改。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 2 |
| 轻微 | 3 |

### 总评

代码实现整体质量良好，核心数学公式（clip space 46 个函数、projection 互逆变换、lookAt 视线构造、texture wrapping 算法）均与 OOD §3.2 设计一致。矩阵裁剪空间函数的 ZO/NO/LH/RH 四组变体的 depth mapping 经验证正确，4.7 节的数据流分析成果已体现在代码中。

**重大风险**：`rotate` 和 `shear` 的乘法顺序反转（`transform * m` vs GLM 的 `m * transform`）是与 GLM 1.0.3 的行为背离——translate 和 scale 使用 `m * transform`（正确），但 rotate 和 shear 使用 `transform * m`，文件内 4 个变换函数自相矛盾。此问题会导致组合变换（translate + rotate + scale）产生不正确的全局/局部混合结果，必须修复。

**中等风险**：`vector_common.cj` 缺失 16 个 fmin/fmax 多输入向量版本，属于 API 不完整。

**低风险**：其他发现涉及容差范围内的设计偏差或可读性改进，不影响功能正确性。
