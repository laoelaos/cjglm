# 待办事项

---

### 严重

- [ ] S1: ext/matrix_transform.cj rotate 和 shear 乘法顺序反转 — `cjglm/src/ext/matrix_transform.cj:39,63`（R2-R1）
- [ ] S2: gtc/ulp.cj float_distance Int32 减法溢出导致异常抛出 — `cjglm/src/gtc/ulp.cj:51-57`（R2-R3）
- [ ] S3: ext/quaternion_transform_test.cj testRotateNonIdentity 期望值数学错误 — `cjglm/tests/glm/ext/quaternion_transform_test.cj:63-70`（R3-R2）
- [ ] S4: gtc/matrix_transform_test.cj testShearSlowDiagonal 期望值计算错误 — `cjglm/tests/glm/gtc/matrix_transform_test.cj:107-109`（R3-R3）

### 一般

**Core detail 源文件**
- [ ] G1: detail/common.cj roundEven 奇偶判断分支反转 — `cjglm/src/detail/common.cj:173~179`（R1-R1）
- [ ] G2: detail/vector_relational.cj 缺少 equal/notEqual/any/all/not 五个函数 — `cjglm/src/detail/vector_relational.cj`（R1-R2）
- [ ] G3: detail/geometric.cj normalize Vec2~Vec4 零值保护使用 `<=` 比较而非严格 `==` — `cjglm/src/detail/geometric.cj:26,35,44`（R1-R2）
- [ ] G4: detail/matrix.cj determinant 使用 `Number<T>` 约束允许整数类型编译 — `cjglm/src/detail/matrix.cj:167,171,177`（R1-R2）

**Ext 源文件**
- [ ] G5: ext/vector_common.cj 缺失 3/4 输入 fmin/fmax 向量版本（16 个函数） — `cjglm/src/ext/vector_common.cj:59-107`（R2-R1）
- [ ] G6: ext/scalar_common.cj iround/uround 未委托 stdmath_shim.roundT — `cjglm/src/ext/scalar_common.cj:104-114`（R2-R1）

**GTC 源文件**
- [ ] G7: gtc/ulp.cj float_distance 缺少 NaN/Inf 前置检查 — `cjglm/src/gtc/ulp.cj:51-57`（R2-R3）
- [ ] G8: gtc/type_precision.cj dquat 与 ext/quaternion_double.cj dquat 命名冲突 — `cjglm/src/gtc/type_precision.cj:86`（R2-R3）
- [ ] G9: gtc/round.cj round/ceil/floorPowerOfTwo ±0 输入丢失负零符号 — `cjglm/src/gtc/round.cj:9-11`（R2-R3）
- [ ] G10: ext/quaternion_common.cj slerp(k) 四参数版本公式与 GLM 1.0.3 需交叉验证 — `cjglm/src/ext/quaternion_common.cj:68-69`（R2-R2）
- [ ] G11: gtc/matrix_transform.cj shear API 与 ext 版本不同可能导致命名混淆 — `cjglm/src/gtc/matrix_transform.cj:29-40`（R2-R2）

**Detail 测试**
- [ ] G12: common_test.cj round(-3.5) 预期值 -3.0 与 IEEE 754 行为可能不一致 — `cjglm/tests/glm/detail/common_test.cj:275`（R3-R1）
- [ ] G13: common_test.cj testFractVec4 未对 -0.5 和 0.0 分量做断言 — `cjglm/tests/glm/detail/common_test.cj:382-387`（R3-R1）
- [ ] G14: exponential_test.cj 缺少 inversesqrtZero/sqrt(-1)/log(0)/log(-1) 等边界测试 — `cjglm/tests/glm/detail/exponential_test.cj`（R3-R1）
- [ ] G15: stdmath_shim_test.cj Float16 覆盖严重不足（25 函数中仅 7 个有 Float16 测试） — `cjglm/tests/glm/detail/stdmath_shim_test.cj`（R3-R1）
- [ ] G16: stdmath_shim_test.cj 部分 Float32 函数缺少独立测试 — `cjglm/tests/glm/detail/stdmath_shim_test.cj`（R3-R1）
- [ ] G17: trigonometric_test.cj 缺少三角恒等式验证（sin²+cos²=1 等） — `cjglm/tests/glm/detail/trigonometric_test.cj`（R3-R1）
- [ ] G18: trigonometric_test.cj Float16 asin/acos 缺少 ±1 边界测试 — `cjglm/tests/glm/detail/trigonometric_test.cj`（R3-R1）
- [ ] G19: trigonometric_test.cj Float16 atan2 缺少第二个分支测试 — `cjglm/tests/glm/detail/trigonometric_test.cj:273-275`（R3-R1）
- [ ] G20: trigonometric_test.cj Vec3/Vec4 asinh/acosh/atanh 仅测试全零向量 — `cjglm/tests/glm/detail/trigonometric_test.cj`（R3-R1）
- [ ] G21: geometric_test.cj 缺少 length(zero)/distance(p,p)/cross(parallel)/reflect 边界测试 — `cjglm/tests/glm/detail/geometric_test.cj`（R3-R1）
- [ ] G22: geometric_refract_test.cj 缺少 eta=1 无折射边界和 Vec1 测试 — `cjglm/tests/glm/detail/geometric_refract_test.cj`（R3-R1）
- [ ] G23: matrix_test.cj 缺少 3x3/4x4 Float32/Float64 determinant 测试 — `cjglm/tests/glm/detail/matrix_test.cj`（R3-R1）

**Ext 测试**
- [ ] G24: quaternion_transform_test.cj testRotateZeroAxis 验证了有争议的行为（零轴时覆盖为单位四元数而非保留原始 q） — `cjglm/tests/glm/ext/quaternion_transform_test.cj:53-61`（R3-R2）
- [ ] G25: vector_common_test.cj Vec1/Vec4 维度完全缺失 — `cjglm/tests/glm/ext/vector_common_test.cj`（R3-R2）
- [ ] G26: vector_common_test.cj fclamp 向量边界版未测试 — `cjglm/tests/glm/ext/vector_common_test.cj:47-53,107-114`（R3-R2）
- [ ] G27: vector_common_test.cj fmin/fmax 3/4 输入版本测试不足 — `cjglm/tests/glm/ext/vector_common_test.cj:29-45`（R3-R2）
- [ ] G28: quaternion_common_test.cj slerp 缺少中点验证和退化分支测试 — `cjglm/tests/glm/ext/quaternion_common_test.cj:175-192`（R3-R2）
- [ ] G29: quaternion_common_test.cj mix 越界 a<0 或 a>1 时 clamp 行为未测试 — `cjglm/tests/glm/ext/quaternion_common_test.cj:132-150`（R3-R2）
- [ ] G30: quaternion_trigonometric_test.cj axis round-trip 未测试 — `cjglm/tests/glm/ext/quaternion_trigonometric_test.cj:68-74`（R3-R2）

**GTC 测试**
- [ ] G31: gtc/matrix_transform_test.cj 委托 ext 的 50+ 函数缺乏 gtc 入口测试 — `cjglm/tests/glm/gtc/matrix_transform_test.cj`（R3-R3）
- [ ] G32: gtc/matrix_inverse_test.cj 缺少 inverseTranspose == transpose(inverse(m)) 一致性验证 — `cjglm/tests/glm/gtc/matrix_inverse_test.cj`（R3-R3）
- [ ] G33: gtc/matrix_access_test.cj 缺少 Mat2x2/Mat3x2/Mat4x3 三个类型的 row/column 测试 — `cjglm/tests/glm/gtc/matrix_access_test.cj`（R3-R3）
- [ ] G34: gtc/packing_test.cj 仅覆盖 6/18+ 函数，缺少多种打包/解包 round-trip 测试 — `cjglm/tests/glm/gtc/packing_test.cj`（R3-R3）
- [ ] G35: gtc/noise_test.cj 缺少 isFinite 验证和零向量/边界输入测试 — `cjglm/tests/glm/gtc/noise_test.cj`（R3-R3）
- [ ] G36: gtc/ulp_test.cj float_distance 缺少 NaN/Inf/负值输入测试 — `cjglm/tests/glm/gtc/ulp_test.cj`（R3-R3）
- [ ] G37: gtc/ulp_test.cj prev_float 缺少 Float64/零值/NaN/Inf 测试 — `cjglm/tests/glm/gtc/ulp_test.cj:64-68`（R3-R3）
