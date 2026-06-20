# R3c: tests/glm/ 目录集成测试完整性审查

审查时间：2026-06-20

### 审查范围

1. `cjglm/tests/glm/detail/test_qualifier.cj`
2. `cjglm/tests/glm/detail/test_setup.cj`
3. `cjglm/tests/glm/detail/test_shim_assert.cj`
4. `cjglm/tests/glm/detail/test_shim_limits.cj`
5. `cjglm/tests/glm/detail/test_scalar_vec_ops.cj`
6. `cjglm/tests/glm/detail/test_type_vec1_broadcast_shift.cj`
7. `cjglm/tests/glm/test_fwd.cj`
8. `cjglm/tests/glm/test_lib.cj`
9. `cjglm/cjpm.toml`
10. `cjglm/.gitignore`

参考依据：`docs/02_ood_phase0.md`（GLM 1.0.3 仓颉迁移首轮 OOD 设计方案 §2）

### 发现

#### [一般] testPackedHighpCrossAssign 测试名不符实

- **位置**：`tests/glm/detail/test_qualifier.cj:29-34`
- **描述**：函数名暗示测试跨 Qualifier 类型的赋值兼容性，但实际代码仅创建三个独立的变量（high/med/low），未进行任何跨类型赋值操作，测试体实质为空（`@Expect(true, true)`）。
- **建议**：重命名函数以反映实际测试内容（如 `testQualifierInstantiations`），或补充真实的跨 Qualifier 赋值验证。

#### [严重] tests/glm/detail/ 下测试文件缺少必要 import

- **位置**：`tests/glm/detail/test_qualifier.cj:1`, `test_setup.cj:1`, `test_shim_assert.cj:1`, `test_shim_limits.cj:1`, `test_scalar_vec_ops.cj:1`, `test_type_vec1_broadcast_shift.cj:1`
- **描述**：`tests/glm/detail/` 下的 6 个测试文件均使用 `@Test` 和 `@Expect` 宏，但未导入 `std.unittest.*` 及 `std.unittest.testmacro.*`；而 `tests/glm/test_fwd.cj` 和 `test_lib.cj` 显式导入了这些模块。行为不一致，且若 cjpm 未隐式注入这些导入，将导致编译失败。
- **建议**：统一在所有使用 `@Test`/`@Expect` 的测试文件中添加 `import std.unittest.*` 和 `import std.unittest.testmacro.*`。

#### [一般] test_shim_limits 缺少整数类型 epsilon 降级路径测试

- **位置**：`tests/glm/detail/test_shim_limits.cj`
- **描述**：`NumericLimits<T>.epsilon` 在 `T` 非浮点类型时会走 `hint - hint` 降级路径返回零值。现有测试仅覆盖 `Float32` 和 `Float64` 路径，未覆盖 `Int64`、`Int32` 等整数类型的降级行为。
- **建议**：补充测试验证 `NumericLimits<Int64>.epsilon(Int64(0))` 等调用返回 `Int64(0)`。

#### [一般] test_scalar_vec_ops 对不同 Qualifier 覆盖不完整

- **位置**：`tests/glm/detail/test_scalar_vec_ops.cj:219-249`
- **描述**：现有测试仅对 `add` 操作覆盖了 `PackedMediump`（行 219）和 `PackedLowp`（行 226）。`sub`、`mul`、`div`、`mod` 四个操作在所有 Vec1-Vec4 维度上均仅使用 `Defaultp` 测试，缺乏对其他 Qualifier 类型的泛型兼容性验证。
- **建议**：为 `sub`/`mul`/`div`/`mod` 各补充至少一组 `PackedMediump`/`PackedLowp` 测试用例。

#### [轻微] test_type_vec1_broadcast_shift 缺少负位移量边界测试

- **位置**：`tests/glm/detail/test_type_vec1_broadcast_shift.cj`
- **描述**：位移操作若传入负数位移量应抛出异常或产生定义行为，但现有测试未覆盖此场景（零位移和超量位移已覆盖，缺少负位移量）。
- **建议**：补充 `<<` / `>>` 负位移量（如 `Vec1(2) << Vec2(-1, 0)`）的异常测试。

#### [轻微] cjpm.toml 与设计 §2 一致性确认

- **位置**：`cjglm/cjpm.toml`
- **描述**：经检查，`cjc-version = "1.1.0"`、`output-type = "static"`、`src-dir = "src"`、`[test] src-dir = "tests"` 配置与项目规范一致，暂未发现与设计 §2 冲突。建议最终确认 `cjc-version` 是否与 CI 环境匹配。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 3 |
| 轻微 | 2 |

### 总评

独立测试文件整体结构清晰，包声明路径与 `src/` 目录结构一致（`tests/glm/detail/ → package glm.detail`, `tests/glm/ → package glm`），测试基本覆盖了各模块的核心正向路径。存在一个严重问题——`detail/` 下测试文件缺少 `std.unittest.testmacro` 导入，可能导致编译失败或不一致行为；`testPackedHighpCrossAssign` 测试名不副实需修复。边界测试（负位移、整数 epsilon 降级、多 Qualifier 覆盖）不够完整，建议补充。`test_type_vec1_broadcast_shift.cj` 对广播位移的测试用例设计正确且覆盖了基础/边界情形。`cjpm.toml` 与 `.gitignore` 配置合理。
