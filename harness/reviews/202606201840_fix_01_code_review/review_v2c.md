# R2C: 测试覆盖完整性审查

审查时间：2026-06-20

### 审查范围

1. `cjglm/src/detail/scalar_vec_ops_test.cj`
2. `cjglm/src/detail/type_vec1_test.cj`
3. `cjglm/src/detail/type_vec2_test.cj`
4. `cjglm/src/detail/type_vec3_test.cj`
5. `cjglm/src/detail/type_vec4_test.cj`
6. `cjglm/src/detail/type_fromBoolVec_test.cj`
7. `cjglm/tests/glm/detail/test_shim_assert.cj`

### 发现

#### [严重] tests/glm/detail/ 下 6 个测试文件仍未添加必要 import（前序待办未修复）

- **位置**：`tests/glm/detail/test_shim_assert.cj:1`（同组共 6 个文件：test_qualifier、test_setup、test_shim_assert、test_shim_limits、test_scalar_vec_ops、test_type_vec1_broadcast_shift）
- **描述**：前序审查 R3C（todo.md 第 17-20 行）明确指出 `tests/glm/detail/` 下的 6 个测试文件使用 `@Test` 和 `@Expect` 宏但缺少 `import std.unittest.*` 和 `import std.unittest.testmacro.*`。当前 `test_shim_assert.cj` 仍仅有 `package glm.detail` 声明，未添加任何 import 语句。经 grep 确认，该目录下全部 6 个文件均无 import 语句，前序待办完全未修复。
- **建议**：在所有 6 个文件添加：
  ```
  import std.unittest.*
  import std.unittest.testmacro.*
  ```

#### [一般] float mod 测试缺少 Qualifier 覆盖（PackedMediump/PackedLowp）

- **位置**：`src/detail/scalar_vec_ops_test.cj:177-276`
- **描述**：新增的 12 个 float mod 测试（Float32/Float64/Float16 × Vec1~Vec4）均使用 `Defaultp` 作为 Qualifier。同文件中 Int64 mod 测试已为 Vec1/Vec2/Vec3/Vec4 全部覆盖 `PackedMediump` 和 `PackedLowp`（共 8 个测试，行 327-340 及 805-854），而 float mod 的 qualifier 覆盖为零。此覆盖缺口与"与已有 Int64 测试的一致性"审查要求不符。
- **建议**：为每种 float 类型至少补充一组 `PackedMediump`/`PackedLowp` 测试，可参照 Int64 等价测试的模式。

#### [一般] float mod 测试缺少负数操作数边界覆盖

- **位置**：`src/detail/scalar_vec_ops_test.cj:177-276`
- **描述**：所有 12 个 float mod 测试均使用正数被除数（7.5）和正数向量分量（2.5, 3.0, 4.0, 5.0）。未覆盖下列边界：① 负被除数（如 `mod(Float32(-7.5), v)`）；② 负除数（如向量分量为负数）；③ 除数为零（mod by 0 应产生 NaN 或定义行为）。同文件中 Int64 部分已有 `testScalarAddNegVec1/Vec2` 和 `testScalarSubNegVec1` 覆盖负数操作数路径，但 float mod 缺乏等价测试。
- **建议**：至少补充：① 负数被除数的 float mod 测试；② 零向量的 float mod 测试。

#### [一般] fromBoolVec 测试仅覆盖 Int64 作为目标类型 T

- **位置**：`src/detail/type_fromBoolVec_test.cj:7-117`
- **描述**：全部 12 个测试用例（fromBoolVec 和 fromBoolVecQ2 的 Vec1~Vec4 及 all-false 变体）均使用 `Int64` 作为目标类型 T，`zero: Int64(0), one: Int64(1)`。未覆盖其他目标类型：`Float32`、`Float64`、`Int32` 等。虽然 DV-01 已记录了接口设计偏差（需要调用方提供 zero/one），但作为测试覆盖，至少应验证不同类型 T 下布尔分量的映射正确性。
- **建议**：补充 `Float32`、`Float64`、`Int32` 作为 T 的 fromBoolVec 测试。

#### [一般] Vec2/Vec3/Vec4 缺少越界访问测试

- **位置**：`src/detail/type_vec2_test.cj`、`src/detail/type_vec3_test.cj`、`src/detail/type_vec4_test.cj`
- **描述**：`type_vec1_test.cj:194-202` 包含 `testVec1IndexOutOfBoundsAccess`，验证索引超出范围时抛出 `Exception`。Vec2/Vec3/Vec4 的测试文件中均缺少等价的越界访问测试。虽然具体实现可能共享同一下标运算符，但缺少每个 Vec 类型的独立验证。
- **建议**：为 Vec2/Vec3/Vec4 各补充至少一个越界索引测试，确保 `v[length]` 和 `v[-1]` 等行为抛出异常。

#### [一般] Q2 版本 fromBoolVec 测试仅使用 PackedHighp 作为 Bool vec 的 Qualifier

- **位置**：`src/detail/type_fromBoolVec_test.cj:48-79; 100-117`
- **描述**：全部 6 个 `fromBoolVecQ2` 测试均使用 `PackedHighp` 作为 Bool Vec 的 Q2 限定符（如 `Vec1<Bool, PackedHighp>`），目标限定符固定为 `Defaultp`。未覆盖 `PackedMediump` 或 `PackedLowp` 作为 Q2 的组合。虽然限定符对运行时行为无影响，但作为泛型参数覆盖应验证更多组合。
- **建议**：至少补充一组使用 `PackedMediump` 或 `PackedLowp` 作为 Q2 的 fromBoolVecQ2 测试。

#### [轻微] increment/decrement 测试缺少边界值覆盖

- **位置**：`src/detail/type_vec1_test.cj:417-428`、`type_vec2_test.cj:363-376`、`type_vec3_test.cj:393-408`、`type_vec4_test.cj:430-447`
- **描述**：四个 Vec 类型的 increment/decrement 测试均使用正值（5/10/15/20）作为起点，仅验证正常自增/自减路径。缺少：① 负值起点（如 `Vec1(-5)` 递减到 `-6`）；② 溢出边界（如 `Int64.MAX_VALUE` 递增应触发 `@OverflowWrapping`）。
- **建议**：补充负值起点和溢出边界的 increment/decrement 测试。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 5 |
| 轻微 | 1 |

### 总评

新增的 12 个 float mod 测试正确验证了 Float32/Float64/Float16 三种类型在 Vec1~Vec4 上的正向路径，测试结构清晰且与 Int64 等价测试模式一致。Vec1~Vec4 的 increment/decrement 测试已按要求补充，运算符和构造测试覆盖全面。fromBoolVec 测试覆盖了 Vec1~Vec4 和 Q2 版本的基础路径。

存在 1 项严重问题：前序 R3C 待办要求为 `tests/glm/detail/` 下 6 个文件添加 `std.unittest` 导入，本轮确认完全未修复，`test_shim_assert.cj` 等文件的 `@Test`/`@Expect` 宏依赖项仍然缺失。

此外存在 5 项一般问题：float mod 缺少 qualifier 覆盖和负数/零边界测试；fromBoolVec 仅覆盖 Int64 一种 T 类型且 Q2 测试仅使用一种 qualifier 组合；Vec2/Vec3/Vec4 缺少越界访问测试。这些覆盖缺口降低了测试的可信度，建议在后续轮次补充。
