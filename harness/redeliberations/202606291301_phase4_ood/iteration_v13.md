# 再审议判定报告（v13）

## 判定结果

RETRY

## 判定理由

组件B诊断报告共发现 7 个问题：2 个严重（mirrorRepeat 公式与 GLM 源码不符、Simplex 返回类型错误）、3 个一般（viewport 独立类型参数缺失、project/clip_space 签名粒度过粗）、2 个轻微（hvec1 缺失、ldexp 精度说明不足）。质询结果为 LOCATED，审查结论被确认，质询仅指出 §1.2 引文不精确这一轻微问题，不影响主体结论。内部循环在 1 轮后提前终止（LOCATED），说明诊断报告质量已被认可。

根据判定标准，审查报告包含严重或一般等级的问题，应判定 RETRY。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：`mirrorRepeat` 实现公式与 GLM 1.0.3 源码不符，`clamp(Floor, 0, 1)` 语义与 `mod(floor(Abs), 2)` 完全不同，编码按产出公式将产生错误结果
- **所在位置**：§3.2 ext/scalar_common.cj，第 361 行
- **严重程度**：严重
- **改进建议**：修正为与 GLM 1.0.3 一致的公式：`Abs = abs(Texcoord) → Floor = floor(Abs) → Clamp = mod(Floor, T(2)) → Rest = Abs - Floor → Mirror = Clamp + Rest → mix(Rest, T(1) - Rest, Mirror >= T(1))`

- **问题描述**：Simplex 噪声（simplex2D/3D/4D）返回类型声明为 Vec2/Vec3/Vec4，但 GLM 1.0.3 签名明确返回标量 `T`
- **所在位置**：§3.3 gtc/noise.cj，第 624~626 行
- **严重程度**：严重
- **改进建议**：将所有 simplex 函数返回类型修正为 `T`，并补充 Perlin 周期噪声重载

- **问题描述**：`ext/matrix_projection.cj` 使用单一泛型 `T` 约束所有参数，但 GLM 中 viewport 使用独立类型参数 `U`
- **所在位置**：§3.2 ext/matrix_projection.cj，第 452~459 行
- **严重程度**：一般
- **改进建议**：为 viewport 引入独立类型参数 `U <: Number<U>`，或注释说明编码阶段需考虑类型解耦

- **问题描述**：`ext/matrix_projection.cj` 函数签名仅列出函数名和参数名，未给出参数类型、返回类型和约束
- **所在位置**：§3.2 ext/matrix_projection.cj，第 452~459 行
- **严重程度**：一般
- **改进建议**：给出每个函数的完整仓颉签名，包括参数类型、返回类型和泛型约束

- **问题描述**：`ext/matrix_clip_space.cj` 46 个函数仅按系族列出函数名，未给出完整参数类型签名
- **所在位置**：§3.2 ext/matrix_clip_space.cj，第 467~474 行
- **严重程度**：一般
- **改进建议**：至少为每个系族给出一个典例函数的完整签名，并标注变体差异

- **问题描述**：`gtc/matrix_transform.cj` 的 `rotate_slow`/`scale_slow`/`shear_slow` 缺少独立签名和实现路径说明
- **所在位置**：§3.3 gtc/matrix_transform.cj，第 518 行
- **严重程度**：一般
- **改进建议**：补充每个 `_slow` 函数的完整签名，说明与标准版本的实现差异

- **问题描述**：`gtc/type_precision.cj` 缺失 `hvec1` 别名
- **所在位置**：§3.3 gtc/type_precision.cj，第 659~665 行
- **严重程度**：轻微
- **改进建议**：补充 `hvec1` 别名以保持精度体系别名一致性

- **问题描述**：`ldexp` 实现精度分析不足，未讨论 Float32 非规格化数精度损失
- **所在位置**：§3.1 common.cj，第 250 行
- **严重程度**：轻微
- **改进建议**：在 D29 或 §3.1 中补充 Float32 非规格化数精度损失的说明
