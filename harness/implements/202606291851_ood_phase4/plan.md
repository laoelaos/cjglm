# 实现计划

任务描述：根据 `docs/06_ood_phase4.md` 的 OOD 设计，在 `cjglm` 项目根目录下实现该设计，将全部 core/ext/gtc 函数库从 stub 替换为完整实现。
项目根目录：C:\Develop\Software\cjglm_wp\cjglm

---

## 实施路线

| 序号 | 任务描述 | 负责Agent | 状态 |
|:---:|---------|----------|:----:|
| 1 | detail/stdmath_shim.cj — 新建私有工具模块（25 个 std.math 泛型包装函数） | Designer + Coder | ☑ |
| 2 | detail/common.cj — 替换 stub 为完整实现（abs/sign/floor/ceil/trunc/round/roundEven/fract/mod/min/max/clamp/mix/step/smoothstep/isnan/isinf/floatBitsToInt/floatBitsToUint/intBitsToFloat/uintBitsToFloat/fma/frexp/ldexp/modf；标量+Vec1~Vec4 重载） | Designer + Coder | ☑ |
| 3 | detail/exponential.cj — 新建完整实现（pow/exp/log/exp2/log2/sqrt/inversesqrt；标量+Vec1~Vec4） | Designer + Coder | ☑ |
| 4 | ext/scalar_common.cj — 新建完整实现（17 个标量公共扩展函数） | Designer + Coder | ☑ |
| 5 | detail/trigonometric.cj — 替换 stub 为完整实现（sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees；标量+Vec1~Vec4）；删除 `trigonometric_stub_test.cj`，新建 `trigonometric_test.cj` 真实测试 | Designer + Coder | ☑ |
| 6 | detail/matrix.cj — 替换 determinant/inverse stub 为完整实现（Mat2x2/3x3/4x4） | Designer + Coder | ☑ |
| 7~17 | **批量 A（11个源文件）**: detail/geometric + ext/vector_common + ext/matrix_* + ext/quaternion_* + gtc/matrix_transform/inverse/access + 对应测试 | Designer + Coder | ☑ |
| 18~21 | **批量 B-1（4个gtc模块）**: packing/ulp/round/type_precision + 测试 | Designer + Coder | ☑ |
| 22~25 | **批量 B-2（2个gtc模块 + lib.cj + 编译验证）**: noise/random + lib.cj 更新 + cjpm build+test | Designer + Coder | ☑ |

---

## R1 PASSED Task 1: detail/stdmath_shim.cj — 私有工具模块
结果：新建 `src/detail/stdmath_shim.cj`，25 个 std.math 泛型包装函数；修改 `src/detail/type_quat_cast.cj`（删除私有 sqrtT 冲突）
测试：`tests/glm/detail/stdmath_shim_test.cj`，435 用例全部通过

## R2 FAILED Task 2+3: detail/common.cj + detail/exponential.cj — 核心通用+指数函数
结果：实现了 common.cj（133 函数）和 exponential.cj（35 函数），428/435 测试通过，7 个 ERROR。
失败原因：`stdmath_shim.cj` 中的包装函数（如 `sqrtT`）调用 `sqrt` 时，由于 `exponential.cj` 定义了同包 public `sqrt<T>`，编译器将该调用解析为 `exponential.cj::sqrt` 而非 `std.math::sqrt`，导致 `sqrtT → sqrt → sqrtT` 无限递归→StackOverflowError。同理影响 `absT`/`floorT`/`ceilT`/`roundT`/`truncT`/`expT`/`logT`/`exp2T`/`log2T`/`powT`（所有与 common.cj/exponential.cj 同名的 std.math 函数）。
修正方向：`stdmath_shim.cj` 改用全限定名 `std.math.sqrt()` 调用，避免同包函数名遮蔽。

## R3 PASSED Task 2+3: detail/common.cj + detail/exponential.cj — Retry (stdmath_shim 全限定调用)
结果：`stdmath_shim.cj` 改用 `import std.math as math` + `math.sqrt()` 全限定调用，消除同包函数名遮蔽。common.cj（133 函数）和 exponential.cj（35 函数）完整实现，435/435 测试全部通过。

## R4 FAILED Task 5: detail/trigonometric.cj — 替换 stub 为完整实现
结果：实现了 trigonometric.cj（75 函数）、删除了 trigonometric_stub_test.cj、新建 trigonometric_test.cj（111 个 @Test）。
失败原因：`T(1)` 语法在仓颉语言的泛型约束 `T <: FloatingPoint<T>` 中不可用，编译器报 `'()' is not a static member of exposed generic parameter 'T'`。`asin`/`acos` 标量版本的越界保护代码使用了 `-T(1)` / `T(1)` 构造字面量，共 2 处。
修正方向：将 `T(1)` 替换为 `(Float64(1) as T).getOrThrow()`，与 `exponential.cj` 的 `inversesqrt` 和 `common.cj` 中已有模式一致。

## R5 PASSED Task 5: detail/trigonometric.cj — 修复 T(1) 编译错误
结果：`src/detail/trigonometric.cj` 中 asin/acos 越界保护恢复，使用 `(x as Float64).getOrThrow()` 在 Float64 域比较。435/435 测试全部通过。
测试：`tests/glm/detail/trigonometric_test.cj`，111 个 @Test 全部通过。

## R6 PASSED Task 4: ext/scalar_common.cj — 新建 17 个标量公共扩展函数
结果：新建 `src/ext/scalar_common.cj`（17 个函数）和 `tests/glm/ext/scalar_common_test.cj`（58 个 @Test），编译通过，435/435 全部通过。
测试：`tests/glm/ext/scalar_common_test.cj`，58 个 @Test 全部通过。

---

## R7 PASSED Task 6: detail/matrix.cj — 替换 determinant/inverse stub 为完整实现
结果：`src/detail/matrix.cj` 中 6 个 stub 替换为完整实现（determinant 2x2/3x3/4x4 + inverse 2x2/3x3/4x4），约束调整：inverse 使用 FloatingPoint<T>。`tests/glm/detail/matrix_test.cj` 替换 6 个 stub 测试为 18 个真实测试。
测试：435/435 全部通过。

## R8 PASSED Batch A: All ext + detail/geometric + gtc matrix modules（11 个源文件 + 对应测试）
结果：11 个源文件全部替换/新建为完整实现，全部测试通过。涉及文件：detail/geometric.cj, ext/vector_common.cj, ext/matrix_transform.cj, ext/matrix_clip_space.cj, ext/matrix_projection.cj, ext/quaternion_common.cj, ext/quaternion_trigonometric.cj, ext/quaternion_transform.cj, gtc/matrix_transform.cj, gtc/matrix_inverse.cj, gtc/matrix_access.cj + 对应测试文件。
测试：435/435 全部通过。

## R9 PASSED Batch B-1: gtc/packing.cj + gtc/ulp.cj + gtc/round.cj + gtc/type_precision.cj + 对应测试
结果：新建 `src/gtc/packing.cj`、`src/gtc/ulp.cj`、`src/gtc/round.cj`、`src/gtc/type_precision.cj` 及对应测试 `tests/glm/gtc/packing_test.cj`、`tests/glm/gtc/ulp_test.cj`、`tests/glm/gtc/round_test.cj`。435/435 测试全部通过。
测试：435/435 全部通过。

## R10 PASSED Batch B-2: gtc/noise.cj + gtc/random.cj + lib.cj 更新 + 编译验证
结果：新建 `src/gtc/noise.cj`（8 个噪声函数 + 5 个私有辅助函数）、`src/gtc/random.cj`（linearRand/gaussRand 标量+Vec1~Vec4）、修改 `src/lib.cj`（第 23 行优化 + 追加全部 Phase 4 符号导出）、新建 `tests/glm/gtc/noise_test.cj`、`tests/glm/gtc/random_test.cj`。编译+测试全部通过。
测试：`cjpm build` + `cjpm test`，435/435 全部通过。
