# R3: OOD Phase 4 detail 层级测试文件审查 (v3 r1)

审查时间：2026-06-30

### 审查范围

- `cjglm/tests/glm/detail/common_test.cj` (746 行)
- `cjglm/tests/glm/detail/exponential_test.cj` (221 行)
- `cjglm/tests/glm/detail/stdmath_shim_test.cj` (462 行)
- `cjglm/tests/glm/detail/trigonometric_test.cj` (834 行)
- `cjglm/tests/glm/detail/geometric_test.cj` (215 行)
- `cjglm/tests/glm/detail/geometric_refract_test.cj` (44 行)
- `cjglm/tests/glm/detail/matrix_test.cj` (1348 行)

参考：`docs/06_ood_phase4.md`（§3.1 各函数行为定义，§5 错误处理策略）、`docs/deviations.md`

### 发现

#### [一般] common_test.cj:testRound — round(-3.5) 预期值 -3.0 与 IEEE 754 round-half-away-from-zero 行为不一致

- **位置**：`cjglm/tests/glm/detail/common_test.cj:275`
- **描述**：`round(Float64(-3.5))` 预期值为 `Float64(-3.0)`。IEEE 754 roundTiesToAway 和 roundTiesToEven 对 -3.5 均返回 -4.0。若仓颉 `std.math.round` 实现 round-half-away-from-zero（与 GLM C++ 的 `std::round` 一致），此测试将失败；若采用非标准舍入方向，此测试虽通过但行为与 GLM C++ 存在未记录的偏差。
- **建议**：验证仓颉 `std.math.round` 对 -3.5 的实际舍入行为。若结果为 -4.0，应更正测试为 `Float64(-4.0)`；若结果为 -3.0（非标准舍入），应在 `deviations.md` 中记录此行为差异。

#### [一般] common_test.cj:testFractVec4 — 对 -0.5 和 0.0 分量缺少断言

- **位置**：`cjglm/tests/glm/detail/common_test.cj:382-387`
- **描述**：`Vec4(1.3, 2.7, -0.5, 0.0)` 作为 fract 输入，仅对前两分量做了断言（r.x=0.3, r.y=0.7），后两分量（r.z 对应 `fract(-0.5)` 应为 0.5，r.w 对应 `fract(0.0)` 应为 0.0）未检查。属于不完整测试。
- **建议**：补充 `@Expect(r.z, Float64(0.5))` 和 `@Expect(r.w, Float64(0.0))`。

#### [一般] exponential_test.cj — 多种边界场景缺失

- **位置**：`cjglm/tests/glm/detail/exponential_test.cj`
- **描述**：
  - 缺少 Float32 标量 `inversesqrtZero` 测试（+Inf 返回）
  - 缺少 Float16 标量 `inversesqrtZero` 测试
  - 缺少 Vec2/Vec3/Vec4 `inversesqrt` 零值注入测试（逐分量 Inf）
  - 缺少 `sqrt(-1)` → NaN 测试（负输入）
  - 缺少 `log(0)` → -Inf 测试
  - 缺少 `log(-1)` → NaN 测试
  - 缺少 Vec1 `inversesqrtZero` 测试（Vec1 行为与标量一致，应覆盖）
- **建议**：补充上述边界场景测试用例。这些是 GLSL 8.2 节定义的边界行为，对数值稳定性和函数契约验证至关重要。

#### [一般] stdmath_shim_test.cj — Float16 覆盖严重不足

- **位置**：`cjglm/tests/glm/detail/stdmath_shim_test.cj`
- **描述**：OOD 设计定义 25 个 stdmath_shim 包装函数，要求覆盖 Float16/Float32/Float64 三种类型。实际 Float16 仅覆盖了 `sqrtT`、`expT`（含溢出测试）、`powT`、`sinT`、`sinhT`、`floorT`（此处属于 Group 4 舍入组，但 `floorT` 的 Float16 测试在 `testFloorTFloat16` 命名下以 `sinhT` 测试函数名出现，命名混乱）。大量函数缺少 Float16 版本：`logT`、`exp2T`、`log2T`、`cosT`、`tanT`、`asinT`、`acosT`、`atanT`、`atan2T`、`coshT`、`tanhT`、`asinhT`、`acoshT`、`atanhT`、`ceilT`、`roundT`、`truncT`、`absT`、`fmodT`。
- **建议**：为每种缺少 Float16 版本的包装函数补充 `test<Func>TFloat16` 测试用例，确保 25 个包装函数 × 3 种浮点类型的全覆盖。

#### [一般] stdmath_shim_test.cj — 部分 Float32 函数缺少测试

- **位置**：`cjglm/tests/glm/detail/stdmath_shim_test.cj`
- **描述**：以下包装函数缺少 Float32 版本测试：`logT`（仅有 Float64）、`log2T`、`cosT`（仅有 Float64）、`tanT`、`asinT`、`acosT`、`atanT`、`atan2T`、`sinhT`、`coshT`、`tanhT`、`asinhT`、`acoshT`、`atanhT`、`ceilT`、`roundT`、`truncT`、`absT`、`fmodT`。虽然部分函数通过 `testAllShimNoStackOverflowInBatch` 隐式调用了 Float64 版本，但缺少 Float32 的验证。
- **建议**：为上述函数补充 Float32 版本的独立测试。

#### [一般] trigonometric_test.cj — 缺少三角函数恒等式验证

- **位置**：`cjglm/tests/glm/detail/trigonometric_test.cj`
- **描述**：审查重点明确要求"三角恒等式验证"。当前没有以下常识性恒等测试：
  - `sin²x + cos²x ≈ 1`（多个角度）
  - `tan(x) ≈ sin(x)/cos(x)`
  - `atan(tan(x)) ≈ x`（在定义域内）
  - `asin(sin(x)) ≈ x`（在定义域内）
  - `sin(2x) = 2*sin(x)*cos(x)`
- **建议**：对每个恒等式使用 epsilon 容差（如 `1e-10` for Float64）进行验证，增强对三角函数实现正确性的信心。

#### [一般] trigonometric_test.cj — Float16 asin/acos 缺少边界测试

- **位置**：`cjglm/tests/glm/detail/trigonometric_test.cj`
- **描述**：Float64 和 Float32 有独立的边界测试（asin(±1)、acos(±1)），但 Float16 没有。仅有 `asin(0.0)` 和 `acos(1.0)` 的标准路径测试。缺少 `asin(1.0)`、`asin(-1.0)`、`acos(-1.0)` 的 Float16 测试。
- **建议**：补充 Float16 的 asin/acos 边界值测试。

#### [一般] trigonometric_test.cj — Float16 atan2 缺少第二个分支测试

- **位置**：`cjglm/tests/glm/detail/trigonometric_test.cj:273-275`
- **描述**：`testAtan2Float16` 仅有 `atan2(Float16(0.0), Float16(1.0)) == Float16(0.0)` 一个断言。Float64 和 Float32 版本额外有 `atan2(1.0, 0.0) == pi/2` 断言，Float16 版本缺失此测试。
- **建议**：补充 `@Expect(atan2(Float16(1.0), Float16(0.0)), Float16(1.5707963267948966))`。

#### [一般] trigonometric_test.cj — Vec3/Vec4 asinh/acosh/atanh 仅测试全零输入

- **位置**：`cjglm/tests/glm/detail/trigonometric_test.cj`
- **描述**：Vec1 和 Vec2 的 asinh/acosh/atanh 测试使用常规输入（0 或 1），但 Vec3/Vec4 版本全部使用 `Vec3(0.0, 0.0, 0.0)` / `Vec4(0.0, 0.0, 0.0, 0.0)` 全零向量。全零输入不能验证逐分量映射的正确性（无法检测分量索引错位或映射错误）。
- **建议**：为 Vec3/Vec4 的 asinh/acosh/atanh 使用非零不同值（如 `Vec3(0.0, 1.0, 2.0)`）以确保逐分量应用正确。

#### [一般] geometric_test.cj — 缺少若干边界场景

- **位置**：`cjglm/tests/glm/detail/geometric_test.cj`
- **描述**：
  - 缺少 `length(zero-vec)` → 0 测试
  - 缺少 `distance(p, p)` → 0 测试
  - 缺少 `cross(parallel_vecs)` → zero-vec 测试
  - 缺少 `reflect(I, N)` 当 I 与 N 平行（反射回退方向）的测试
- **建议**：补充上述边界场景。

#### [一般] geometric_refract_test.cj — 缺少全等折射边界和 Vec1 测试

- **位置**：`cjglm/tests/glm/detail/geometric_refract_test.cj`
- **描述**：
  - 当 `eta = 1` 且 I 垂直入射（N 与 I 平行）时，`refract(I, N, 1)` 应返回 I。此"无折射"边界未测试。
  - Vec1 refract 版本未测试。
- **建议**：补充无折射边界（`eta=1, I=N`）测试。Vec1 refract 可选择性测试（因几何意义有限）。

#### [一般] matrix_test.cj — 缺少 3x3/4x4 Float32/Float64 determinant 测试

- **位置**：`cjglm/tests/glm/detail/matrix_test.cj`
- **描述**：2x2 有 Float32 和 Float64 determinant 测试（`testDeterminantMat2x2Float32/64`，行 276-287），但 3x3 和 4x4 仅有 Int64 版本。缺少浮点 3x3/4x4 行列式的数值正确性验证。
- **建议**：为 3x3 和 4x4 补充 `Float32`/`Float64` 版本的 determinant 测试，使用已知行列值的矩阵构造（如对角矩阵或 Vandermonde 矩阵）。

#### [轻微] matrix_test.cj:testInverseMat3x3 — 奇异矩阵 NaN 检测仅检查一个分量

- **位置**：`cjglm/tests/glm/detail/matrix_test.cj:305-312`
- **描述**：全 1 的奇异 3x3 矩阵求逆后仅检查 `r00 != r00`（NaN检测）。可检查所有 9 个分量均为 NaN，与 `testInverseSingularMat3x3NaN`（行 522-533）的做法一致。
- **建议**：扩展 NaN 检测覆盖全部 9 个矩阵元素。

#### [轻微] matrix_test.cj — identity 检查未覆盖非对角零元素

- **位置**：`cjglm/tests/glm/detail/matrix_test.cj:315-393`
- **描述**：`testInverseMat4x4`（行 315-353）和 `testInverseMat4x4Full`（行 355-393）对逆×原矩阵的结果乘积仅检查对角元素 `r00/r11/r22/r33`，未显式检查非对角元素为零。虽然不是严重问题（至少验证了 identity 的逆为 identity），但完整验证应包含非对角检查。
- **建议**：补充 `@Expect(abs(r01) < eps, true)` 等非对角检查。实际在 `testInverseMat2x2`（行 290-302）中已做此检查，应保持风格一致。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 12 |
| 轻微 | 2 |

### 总评

测试文件整体质量良好，覆盖了大多数公共函数的正向路径和部分边界场景，与 OOD 设计文档的行为规范一致（如 asin/acos 越界返回 NaN、inversesqrt 零值返回 +Inf、Vec1 normalize 零值返回 NaN、矩阵奇异返回 NaN 等均已正确测试）。测试使用 `@Expect`/`@ExpectThrows` 断言，风格一致。

主要改进空间集中在三方面：（1）**Float16 浮点类型覆盖严重不足**——`stdmath_shim_test.cj` 中 25 个包装函数大量缺少 Float16 版本测试；（2）**边界场景覆盖有系统性缺口**——`exponential_test.cj` 缺少 `sqrt(-1)`/`log(0)`/`inversesqrtZero` 向量版等关键边界测试；（3）**三角恒等式验证完全缺失**——`trigonometric_test.cj` 应在 epsilon 容差下验证 `sin²+cos²=1` 等关系以增强对数学实现正确性的信心。

上述问题均为覆盖度增强型，未发现逻辑错误或行为与 OOD 设计不一致的严重问题。建议在后续迭代中逐步补齐。
