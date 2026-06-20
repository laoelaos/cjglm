# R3a: lib.cj 公共 API 重导出与 OOD 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/lib.cj` — public import 重导出策略
- `cjglm/tests/glm/test_lib.cj` — 公共 API 可用性测试
- `cjglm/src/detail/qualifier.cj` — Aligned 系列 `internal` 可见性确认
- `cjglm/src/detail/scalar_vec_ops.cj` — 命名空间占用确认
- `cjglm/tests/glm/test_fwd.cj` — 并行测试参考
- `docs/02_ood_phase0.md` — 设计文档对照

### 发现

#### [一般] test_lib.cj 仅覆盖 Vec2，未覆盖 Vec1/Vec3/Vec4 的重导出验证

- **位置**：`cjglm/tests/glm/test_lib.cj:7-17`
- **描述**：lib.cj 通过 `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 重导出了全部四个 Vec 类型，但 test_lib.cj 仅测试了 Vec2 的构造和分量访问。虽然 test_fwd.cj 通过别名（如 `Vec1 = detail.Vec1<Float32, PackedHighp>`）间接测试了 Vec1/Vec2/Vec3/Vec4 的可访问性，但 test_lib.cj 作为 lib.cj 公共 API 的专用测试文件，应直接验证所有四个泛型 Vec 类型通过 `package glm` 命名空间可直接构造和访问。
- **建议**：补充 Vec1、Vec3、Vec4 的基本构造与分量访问测试。

#### [一般] test_lib.cj 未覆盖 sub/mul/div/mod 包级函数

- **位置**：`cjglm/tests/glm/test_lib.cj:13-17`
- **描述**：lib.cj 通过 `public import glm.detail.{ add, sub, mul, div, mod }` 重导出了全部五个 scalar_vec_ops 包级函数，但测试仅覆盖了 `add(s, v)`。sub、mul、div、mod 四个函数未被测试，无法确认它们在 `package glm` 命名空间下的可用性。
- **建议**：对 sub、mul、div 各补充一条类似 `add` 的测试用例；对 mod 补充一条整数类型（如 `Int32`）的测试用例。

#### [一般] test_lib.cj 在 package glm 内无法验证下游 `import glm.*` 可达性

- **位置**：`cjglm/tests/glm/test_lib.cj:1`
- **描述**：test_lib.cj 声明 `package glm`，与 lib.cj 同属一个包，因此测试代码可直接访问所有同包声明，但这并不能验证下游消费者通过 `import glm.*` 是否能正确访问这些 `public import` 重导出的类型和函数。后者需要在独立包（如 `test.glm.import_test`）的测试文件中通过 `import glm.*` 导入后方可验证。
- **建议**：在 `tests/` 下创建独立包的测试文件（如 `tests/import_test/glm_import_test.cj`），通过 `import glm.*` 导入后验证 Vec1~Vec4、Qualifier 实现类型、scalar_vec_ops 函数、fromBoolVec/fromBoolVecQ2 均可正常使用。

#### [轻微] test_lib.cj 未覆盖 fromBoolVecQ2

- **位置**：`cjglm/tests/glm/test_lib.cj:20-24`
- **描述**：lib.cj 同时重导出了 `fromBoolVec` 和 `fromBoolVecQ2`，但测试仅覆盖了 `fromBoolVec`。`fromBoolVecQ2` 作为跨 Q 版本的工厂函数，具有不同的泛型签名 `func fromBoolVecQ2<T, Q, Q2>(...)`，建议补充测试验证其可通过 `package glm` 命名空间正确解析。
- **建议**：补充一条 fromBoolVecQ2 的测试用例（例如使用不同 Q/Q2 实参）。

#### [轻微] test_lib.cj 未覆盖 PackedMediump/PackedLowp

- **位置**：`cjglm/tests/glm/test_lib.cj:27-31`
- **描述**：lib.cj 重导出了 `PackedHighp, PackedMediump, PackedLowp` 三个 Qualifier 实现类型，以及 `Defaultp` 别名。测试仅验证了 `PackedHighp` 和 `Defaultp`，未验证 `PackedMediump` 和 `PackedLowp` 的可访问性。
- **建议**：补充 PackedMediump 和 PackedLowp 的简单使用测试。

### 通过项（无问题）

- **lib.cj public import 列表** — 与 OOD 设计文档完全一致，覆盖 Vec1~Vec4、Qualifier/PackedHighp/Mediump/Lowp、Defaultp、add/sub/mul/div/mod、fromBoolVec/fromBoolVecQ2。
- **Aligned 系列可见性** — qualifier.cj 中 AlignedHighp/AlignedMediump/AlignedLowp 声明为 `internal`，lib.cj 中未导出，设计正确。
- **命名空间占用约定** — `scalar_vec_ops.cj` 是 `glm.detail` 包中唯一定义包级函数 `add`/`sub`/`mul`/`div`/`mod` 的文件；`type_vecN.cj` 中的 `add`/`sub`/`mul`/`div`/`mod` 为扩展成员函数（非包级函数），不违反约定。
- **fwd.cj 可见性** — 与 lib.cj 同属 `package glm` 且均为 `public type`，自动对外可见，无需额外导入。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 3 |
| 轻微 | 2 |

### 总评

lib.cj 的 `public import` 重导出策略完全符合 OOD 设计文档规范，Aligned 系列 `internal` 可见性策略和命名空间占用约定均正确。主要问题集中在 test_lib.cj 的测试覆盖不完整——它仅测试了约三分之一的公共 API 项目（Vec2、add、fromBoolVec、PackedHighp/Defaultp），其余 Vec1/Vec3/Vec4、sub/mul/div/mod、fromBoolVecQ2、PackedMediump/PackedLowp 均未覆盖。此外，由于测试与生产代码同属 `package glm`，无法验证下游 `import glm.*` 场景下的重导出传播正确性，建议在独立包中补充集成测试。
