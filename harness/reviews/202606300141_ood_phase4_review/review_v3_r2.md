# R3: Phase4 ext 层级测试文件审查

审查时间：2026-06-30

### 审查范围

- `cjglm/tests/glm/ext/scalar_common_test.cj`（366 行，新建）
- `cjglm/tests/glm/ext/vector_common_test.cj`（131 行，新建）
- `cjglm/tests/glm/ext/matrix_transform_test.cj`（87 行，新建）
- `cjglm/tests/glm/ext/matrix_projection_test.cj`（153 行，新建）
- `cjglm/tests/glm/ext/matrix_clip_space_test.cj`（163 行，新建）
- `cjglm/tests/glm/ext/quaternion_common_test.cj`（192 行，扩展）
- `cjglm/tests/glm/ext/quaternion_transform_test.cj`（70 行，新建）
- `cjglm/tests/glm/ext/quaternion_trigonometric_test.cj`（74 行，扩展）

### 发现

#### [严重] `quaternion_transform_test.cj` testRotateNonIdentity 期望值数学错误

- **位置**：`cjglm/tests/glm/ext/quaternion_transform_test.cj:63-70`
- **描述**：测试 `rotate(q, pi/2, Z)` 其中 `q = (0.707, 0, 0.707, 0)`（180° 绕 (1,0,1)/√2 轴旋转），期望 `r.x ≈ 0` 且 `r.z ≈ 1.0`。经完整四元数乘法计算验证（`r * q`），正确结果为 `(0.5, 0.5, 0.5, -0.5)`，与期望值严重不符。该测试在当前形式下必然 FAILED。
- **建议**：修正为正确期望值或重新设计测试用例使用简单已知结果（如 identity q × identity rotate 等可手工验证的场景）。

#### [一般] `quaternion_transform_test.cj` testRotateZeroAxis 验证存在争议的行为

- **位置**：`cjglm/tests/glm/ext/quaternion_transform_test.cj:53-61`
- **描述**：零长度轴时实现返回 `Quat(1, 0, 0, 0)`（单位四元数）而非保留原始四元数 `q`。测试因此期望非 identity 的 `q=(1,2,3,4)` 被覆盖为单位四元数。按 GLM 1.0.3 行为，`normalize(0,0,0)` 返回零向量 → 旋转四元数 `r=identity` → `r * q = q`（原始值应保留）。当前行为与 GLM 不一致，测试验证了有争议的实现行为。
- **建议**：确认是否需要与 GLM 行为对齐（返回原始 `q`）。如确认保持当前设计，在 `deviations.md` 记录此偏差。

#### [一般] `vector_common_test.cj` Vec1/Vec4 维度完全缺失

- **位置**：`cjglm/tests/glm/ext/vector_common_test.cj:全部`
- **描述**：设计文档 §3.2 `ext/vector_common.cj` 明确要求为 Vec1~Vec4 各维度提供重载，但测试仅覆盖 Vec2 和 Vec3。Vec1、Vec4 的所有函数（min/max/fmin/fmax/fclamp/clamp/repeat/mirrorClamp/mirrorRepeat/iround/uround）均无测试用例。
- **建议**：补充 Vec1、Vec4 维度测试。至少为每个函数族覆盖一个代表性维度组合。

#### [一般] `vector_common_test.cj` fclamp 向量边界版未测试

- **位置**：`cjglm/tests/glm/ext/vector_common_test.cj:47-53, 107-114`
- **描述**：`fclamp` 有两个重载——标量边界版 `fclamp(x, minVal: T, maxVal: T)` 和向量边界版 `fclamp(x, minVal: Vec, maxVal: Vec)`。测试仅覆盖标量边界版（Vec2 和 Vec3），未测试向量边界版（`minVal`/`maxVal` 为 Vec 类型）。
- **建议**：添加向量边界版 `fclamp` 测试用例。

#### [一般] `vector_common_test.cj` fmin/fmax 多输入版本测试不足

- **位置**：`cjglm/tests/glm/ext/vector_common_test.cj:29-45`
- **描述**：`fmin` 仅测试 2 输入 Vec2 和 Vec3+标量版；`fmax` 仅测试 2 输入 Vec3。`fmin`/`fmax` 的 3 输入、4 输入向量版本无测试用例。
- **建议**：补充 `fmin`/`fmax` 的 3 输入、4 输入向量版本测试（至少覆盖 Vec2 或 Vec3 一个维度）。

#### [一般] `quaternion_common_test.cj` slerp 中点插值和退化分支未测试

- **位置**：`cjglm/tests/glm/ext/quaternion_common_test.cj:175-192`
- **描述**：slerp 仅测试插值端点（a=0 返回 x, a=1 返回 y），未验证中点的正确性。也未测试接近零角度退化分支（x ≈ y 时 sinOmega ≈ 0 应退化到 lerp）。
- **建议**：增加 slerp 中点验证（如 slerp(identity, 90°Z, 0.5) 应产生 45°Z 四元数）和退化分支测试（两个几乎相同的四元数插值）。

#### [一般] `quaternion_common_test.cj` mix 越界 clamp 未测试

- **位置**：`cjglm/tests/glm/ext/quaternion_common_test.cj:132-150`
- **描述**：设计文档 D10 明确 mix 使用 clamp 静默处理越界（与 lerp 的 assert 策略不同），但测试未验证 `a < 0` 或 `a > 1` 时 mix 的行为（应 clamp 而非抛异常）。
- **建议**：添加 `mix(x, y, -0.5)` 和 `mix(x, y, 1.5)` 的测试用例，验证结果被正确 clamp。

#### [一般] `quaternion_trigonometric_test.cj` axis round-trip 未测试

- **位置**：`cjglm/tests/glm/ext/quaternion_trigonometric_test.cj:68-74`
- **描述**：`testAngleAngleAxisRoundtrip` 仅验证角度 round-trip（`angle(angleAxis(theta, axis)) == theta`），未验证轴 round-trip（`axis(angleAxis(theta, axis)) == normalize(axis)`）。
- **建议**：补充 axis round-trip 验证。

#### [轻微] `scalar_common_test.cj` mirrorClamp/repeat/整数边界缺失

- **位置**：`cjglm/tests/glm/ext/scalar_common_test.cj:215-237`
- **描述**：mirrorClamp 缺少零值/壹值边界测试（0.0, 1.0）；repeat 缺少整数输入测试（如 `repeat(2.0)` 期望 0.0）；fclamp 缺少 minVal == maxVal 的边界场景。
- **建议**：补充上述边界测试用例以增强健壮性。

#### [轻微] `matrix_transform_test.cj` 缺少组合变换验证

- **位置**：`cjglm/tests/glm/ext/matrix_transform_test.cj:全部`
- **描述**：translate/rotate/scale/shear/lookAt 各自独立测试，无组合变换验证（如对点依次应用 translate→rotate→scale 并与手动计算结果对比）。
- **建议**：可考虑添加一个简单的组合变换测试以验证矩阵乘法链条正确性。

#### [轻微] `matrix_clip_space_test.cj` 唯一公式变体有遗漏

- **位置**：`cjglm/tests/glm/ext/matrix_clip_space_test.cj:全部`
- **描述**：部分具有唯一公式的变体未测试：`orthoLH_ZO`、`orthoRH_ZO`、`perspectiveLH_NO`、`perspectiveFovLH_NO`、`perspectiveFovRH_ZO`。当前仅测试了部分变体，但至少每个函数族有一个 ZO 和一个 NO 变体通过测试，风险较低。
- **建议**：补充上述唯一公式变体的测试。

#### [轻微] `quaternion_transform_test.cj` 缺少矩阵旋转一致性验证

- **位置**：`cjglm/tests/glm/ext/quaternion_transform_test.cj:全部`
- **描述**：四元数旋转与矩阵旋转之间无交叉一致性测试（同一 axis/angle 下 quat.rotate 与 mat.rotate 对同一向量作用结果应一致）。
- **建议**：添加交叉一致性验证测试。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 7 |
| 轻微 | 5 |

### 总评

测试文件整体质量良好，覆盖了大部分公共函数的正向路径。`scalar_common_test.cj` 覆盖尤为详尽（17 个函数族均有测试，NaN 边界覆盖全面）。`matrix_projection_test.cj` 的 round-trip 和 delegation 测试设计精巧。

主要问题集中在（1）`quaternion_transform_test.cj` 的 testRotateNonIdentity 存在数学计算错误（期望值不正确），是唯一严重问题；（2）`vector_common_test.cj` 维度覆盖不足（仅 Vec2/Vec3，缺失 Vec1/Vec4），且 fclamp 向量边界版未测试；（3）slerp 测试深度不足（缺少中点验证和退化分支）。建议优先修复严重问题后补充中等严重度的覆盖缺口。
