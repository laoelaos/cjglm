# 任务指令（v8）

## 动作
NEW

## 任务描述
批量替换/新建 11 个源文件及其对应测试文件（将 plan.md 中原 Tasks 7~17 合并为一轮实现）。

## 文件清单

### A. 修改现有 stub → 完整实现（7 个文件）

| 文件 | 现有内容 | 实现要点 |
|------|---------|---------|
| `src/detail/geometric.cj` | 21 个 stub（dot/cross/normalize/length/distance/reflect/refract/faceforward） | dot: Vec1~Vec4 返回 T，Number<T> 约束。cross: Vec3 返回 Vec3。normalize Vec2~Vec4: v/length(v) + 零向量保护返回零向量。normalize Vec1: v * inversesqrt(dot(v,v))，无保护→NaN。length: sqrt(dot(v,v))。distance: length(p0-p1)。reflect: I-2*dot(N,I)*N。refract: 条件公式 k>=0 时返回 eta*I - (eta*dot(N,I)+sqrt(k))*N，否则零向量。faceforward: dot(Nref,I)<0 ? N : -N。全部 FloatingPoint<T> 约束（dot 除外）。|
| `src/ext/matrix_transform.cj` | 1 个 stub（translate） | 实现 translate(m, v) + 新增 rotate/scale/shear/lookAt/lookAtRH/lookAtLH（对标 GLM ext/matrix_transform.hpp 共 6 函数），全部委托 gtc/matrix_transform.cj 或直接自实现。FloatingPoint<T> 约束。数学公式见 OOD 设计 §3.2。 |
| `src/ext/matrix_clip_space.cj` | 1 个 stub（ortho） | 实现 ortho（2D） + 新增 frustum/perspective/perspectiveFov/infinitePerspective/tweakedInfinitePerspective（共 46 函数），委托 gtc/matrix_transform.cj 或直接实现。数学公式见 OOD 设计 §3.2。 |
| `src/ext/matrix_projection.cj` | 1 个 stub（perspective） | 实现 projectZO/NO/unProjectZO/NO/pickMatrix（共 7 函数），委托 gtc/matrix_transform.cj 或直接实现。注意 viewport 参数使用独立类型 U <: Number<U>。|
| `src/ext/quaternion_common.cj` | 已有 conjugate/inverse/lerp/isnan/isinf，3 个 stub（mix/slerp/slerp(k)） | mix: 使用 clamp(a,0,1) 后 `x*(1-a)+y*a`（静默处理越界，与 lerp 的 assert 策略不同）。slerp: dot→clamp→acos→omega→sin→退化判断(epsilon)→sin((1-a)ω)/sinΩ * x + sin(aω)/sinΩ * y。slerp(k): 含附加参数 k 扩展球面插值。依赖 trigonometric.cj acos/sin 和 geometric.cj cross。|
| `src/ext/quaternion_trigonometric.cj` | 已有 axis，2 个 stub（angle/angleAxis） | angle: `2*acos(clamp(w,-1,1))`。angleAxis: halfAngle=angle/2 → Quat(cos(halfAngle), sin(halfAngle)*axis.x, ...)。依赖 trigonometric.cj acos/sin/cos。|
| `src/ext/quaternion_transform.cj` | 1 个 stub（rotate） | rotate(q, angle, axis): normalize axis → halfAngle → sinHalf/cosHalf → 构造单位四元数 → 旋转四元数乘法。依赖 trigonometric.cj sin/cos 和 geometric.cj length。零轴保护返回单位四元数。|
| `src/gtc/matrix_transform.cj` | 277 行，64 个 stub 函数签名 | 替换全部 64 个 stub 为完整实现。基础变换（identity/translate/rotate/rotate_slow/scale/scale_slow/shear/shear_slow/lookAt/LH/RH 共 11）委托 ext 层或自实现。ortho/frustum/perspective/perspectiveFov/infinitePerspective/tweakedInfinitePerspective 系族（共 46）直接实现列主序矩阵公式。projectZO/NO/unProjectZ0/NO/pickMatrix（共 7）直接实现。详见 OOD 设计 §3.3。|

### B. 新建文件（4 个文件）

| 文件 | 实现要点 |
|------|---------|
| `src/ext/vector_common.cj` | 20 个向量公共扩展函数：3/4 输入 min/max、fmin/fmax/fclamp 系列、纹理环绕 clamp/repeat/mirrorClamp/mirrorRepeat、iround/uround。Vec1~Vec4 逐分量委托 scalar_common 对应标量函数。约束：min/max 用 Number<T>&Comparable<T>，其余 FloatingPoint<T>。iround/uround 返回 Int64/UInt64 向量。详见 OOD 设计 §3.2。 |
| `src/gtc/matrix_inverse.cj` | affineInverse(m: Mat4x4): 上三角 3x3 逆 + 平移处理。inverseTranspose(m: Mat3x3/Mat4x4): transpose(inverse(m))。FloatingPoint<T> 约束。 |
| `src/gtc/matrix_access.cj` | row(m, index)/column(m, index)：所有 9 个矩阵类型重载（Mat2x2~Mat4x4 及非方阵）。row 返回行向量（维度=列数），column 返回列向量（维度=行数）。|
| `tests/glm/ext/vector_common_test.cj` | 新建测试文件，每种函数选代表维度验证逐分量正确性。 |

### C. 替换 stub 测试为真实测试（现有测试文件修改）

| 测试文件 | 操作 | 说明 |
|---------|------|------|
| `tests/glm/detail/geometric_test.cj` | 21 个 stub 测试 → 真实测试 | dot/cross/normalize/length/distance/reflect/refract/faceforward 各维度真实断言 |
| `tests/glm/detail/geometric_refract_test.cj` | 3 个 stub 测试 → 真实测试 | refract Vec2~Vec4 真实计算断言 |
| `tests/glm/ext/quaternion_common_test.cj` | 3 个 stub 测试（mix/slerp/slerp(k)） → 真实测试 | mix 边界验证 + slerp 插值连续性 + slerp(k) 扩展参数 |
| `tests/glm/ext/quaternion_trigonometric_test.cj` | 2 个 stub 测试（angle/angleAxis） → 真实测试 | angle(angleAxis(θ,axis)) = θ 互逆验证 |
| `tests/glm/ext/quaternion_transform_test.cj` | 若存在 stub 测试则替换 | rotate 零轴保护 + 90° 旋转再逆旋转验证 |
| `tests/glm/gtc/matrix_transform_test.cj` | 若存在 stub 测试则替换 | 每系族选 1~2 典型签名验证 + _slow 变体与常规版一致验证 |

### D. 新建测试文件（为新建源文件配套）

| 测试文件 | 说明 |
|---------|------|
| `tests/glm/ext/matrix_transform_test.cj` | translate/rotate/scale/shear/lookAt 各选典型用例 |
| `tests/glm/ext/matrix_clip_space_test.cj` | ortho/perspective/frustum 各选一个互逆验证 |
| `tests/glm/ext/matrix_projection_test.cj` | project/unProject 互逆 + pickMatrix 选区验证 |
| `tests/glm/gtc/matrix_inverse_test.cj` | affineInverse + inverseTranspose 恒等验证 |
| `tests/glm/gtc/matrix_access_test.cj` | row/column 互逆验证 |

## 选择理由
合并原本 11 个独立轮次（plan.md Tasks 7~17）为一轮。依据 OOD 设计 §8 的批次划分：Batch 3（geometric → ext matrix → ext quaternion → gtc/matrix_transform）主依赖链 + Batch 2（vector_common）+ Batch 4（matrix_inverse/access）。文件间虽有内部依赖（如 quaternion 依赖 geometric 的 cross），但在同批内按顺序实现可自然消解。大幅减少轮次数从 11→1。

## 任务上下文

### 已有代码上下文

**已就绪的依赖项**：
- `glm.detail` 包：Vec1~Vec4 类型、Mat2x2~Mat4x4 类型、Quat 类型、common.cj（133 函数完整）、exponential.cj（35 函数完整）、trigonometric.cj（75 函数完整）、matrix.cj（determinant/inverse 完整）、stdmath_shim.cj（25 泛型包装函数）
- `glm.ext` 包：scalar_common.cj（17 函数完整）、quaternion_geometric.cj（dot/length/normalize/cross）
- `glm.gtc` 包：constants.cj（常量）、quaternion.cj（eulerAngles/roll/pitch/yaw/ lookAt 等）

**当前测试状态**：435 tests 全部通过。

**关键代码模式**（项目已有共识）：
1. 泛型字面量构造使用 `(Float64(n) as T).getOrThrow()` 而非 `T(n)`
2. 所有 std.math 委托通过 `stdmath_shim.cj` 包装层（已改用 `math.sqrt()` 全限定调用避免同名遮蔽）
3. 向量逐分量操作使用 `VecN(v.x op, v.y op, v.z op, v.w op)` 模式
4. `inverse` 使用 `FloatingPoint<T>` 约束（需要除法）
5. `iround`/`uround` 通过 roundT 包装函数委托 std.math.round，返回 Int64/UInt64

### 关键设计约束
1. **geometric.cj normalize Vec2~Vec4 零向量保护**：返回零向量；**Vec1 normalize** 无保护，自然产生 NaN
2. **acos/asin 越界保护**：已经在 trigonometric.cj 中实现（返回 NaN），此处的 slerp clamp dot 是调用方数值稳定措施
3. **slerp 退化分支**：`sinOmega < epsilon<T>()` 时退化为 lerp
4. **mix vs lerp 差异**：mix 使用 clamp(a,0,1) 静默处理越界，lerp 使用 assert
5. **gtc→ext 委托关系**：gtc/matrix_transform.cj 的函数可委托 ext 层等同名函数，但 _slow 变体（rotate_slow/scale_slow/shear_slow）需在 gtc 层独立实现
6. **lib.cj 第 23 行修改**：不在本批范围（留待最后一批处理）
7. **奇异矩阵**：inverse 依赖 IEEE 754 NaN 传播，不显式检查零行列式
8. **gtc/matrix_access.cj 非方阵**：row 返回向量维度=矩阵列数，column 返回向量维度=矩阵行数

### 参考实现来源
GLM 1.0.3 对应文件：
- `detail/func_geometric.inl` → geometric.cj
- `ext/vector_common.hpp + .inl` → ext/vector_common.cj
- `ext/matrix_transform.hpp` → ext/matrix_transform.cj
- `ext/matrix_clip_space.hpp` → ext/matrix_clip_space.cj
- `ext/matrix_projection.hpp` → ext/matrix_projection.cj
- `ext/quaternion_common.hpp + .inl` → ext/quaternion_common.cj (mix/slerp)
- `ext/quaternion_transform.hpp + .inl` → ext/quaternion_transform.cj (rotate)
- `ext/quaternion_trigonometric.hpp + .inl` → ext/quaternion_trigonometric.cj (angle/angleAxis)
- `gtc/matrix_transform.hpp + .inl` → gtc/matrix_transform.cj
- `gtc/matrix_inverse.hpp + .inl` → gtc/matrix_inverse.cj
- `gtc/matrix_access.hpp + .inl` → gtc/matrix_access.cj

### 实施顺序建议
1. detail/geometric.cj + 测试（无外部依赖，仅需 stdmath_shim）
2. ext/vector_common.cj + 测试（依赖 scalar_common，已在 R6 完成）
3. gtc/matrix_inverse.cj + gtc/matrix_access.cj + 测试（依赖 matrix.cj determinant，已在 R7 完成）
4. ext/matrix_transform.cj + ext/matrix_clip_space.cj + ext/matrix_projection.cj + 测试（简单委托层）
5. ext/quaternion_common.cj + ext/quaternion_trigonometric.cj + ext/quaternion_transform.cj + 测试（依赖 geometric 和 trigonometric）
6. gtc/matrix_transform.cj + 测试（依赖 ext 全部就绪，最后执行）
