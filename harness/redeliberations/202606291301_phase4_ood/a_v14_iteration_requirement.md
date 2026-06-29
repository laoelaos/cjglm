根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

组件B诊断报告识别出以下质量问题：

**P0（必须修复）：**
1. [严重] `ext/scalar_common.cj` 的 `mirrorRepeat` 实现公式与 GLM 1.0.3 源码不符——产出使用 `clamp(Floor, 0, 1)`，GLM 使用 `mod(floor(Abs), 2)`，语义完全不同。编码按产出公式将产生错误结果。修正为：`Abs = abs(Texcoord) → Floor = floor(Abs) → Clamp = mod(Floor, T(2)) → Rest = Abs - Floor → Mirror = Clamp + Rest → mix(Rest, T(1) - Rest, Mirror >= T(1))`。
2. [严重] `gtc/noise.cj` 的 Simplex 噪声（simplex2D/3D/4D）返回类型声明为 `Vec2/Vec3/Vec4`，但 GLM 1.0.3 签名明确返回标量 `T`。修正为所有 simplex 函数返回 `T`，并补充 Perlin 周期噪声重载。

**P1（推荐修复）：**
3. [中等] `ext/matrix_projection.cj` 使用单一泛型 `T` 约束所有参数，GLM 中 viewport 使用独立类型参数 `U`。为 viewport 引入 `U <: Number<U>`，或注释说明类型解耦可能性。
4. [中等] `ext/matrix_projection.cj` 函数签名仅列出函数名和参数名，未给出参数类型、返回类型和约束。参照 `ext/scalar_common.cj` 格式给出每个函数的完整仓颉签名。
5. [中等] `ext/matrix_clip_space.cj` 46 个函数仅按系族列出函数名，未给出完整签名。至少为每个系族给出一个典例函数的完整签名并标注变体差异。

**P2（建议修复）：**
6. [中等] `gtc/matrix_transform.cj` 的 `rotate_slow`/`scale_slow`/`shear_slow` 缺少独立签名和实现路径说明。补充每个 `_slow` 函数的完整签名，说明与标准版本的实现差异。
7. [轻微] `gtc/type_precision.cj` 缺失 `hvec1` 别名（其他精度系列均包含 vec1 别名）。
8. [轻微] `ldexp` 未讨论 Float32 非规格化数精度损失。在 D29 或 §3.1 中补充说明。

质询确认：以上诊断结论均被确认（LOCATED），证据充分、逻辑自洽。

## 历史迭代回顾

- **已解决的问题**：无（v13 为 v12 的直接复制，未做任何修改）
- **持续存在的问题**：
  - mirrorRepeat 公式错误：迭代 9 引入（v9→v10），此后历经 5 轮审查均未验证；迭代 13 再次指出，仍未修复
  - Simplex 返回类型错误：迭代 7 引入（错误假设），历经 5 轮审查未质疑；迭代 13 再次指出，仍未修复
  - matrix_projection viewport 类型参数：迭代 13 首次指出，仍未修复
  - matrix_projection/matrix_clip_space 签名粒度：迭代 13 首次指出，仍未修复
  - _slow 变体签名缺失：迭代 13 首次指出，仍未修复
  - hvec1 缺失、ldexp 精度说明：迭代 13 首次指出，仍未修复
- **新发现的问题**：本轮无新增问题

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v13_copy_from_v12.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
