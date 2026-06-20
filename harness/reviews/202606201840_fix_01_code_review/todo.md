# 待办事项

---

- [ ] T3: test_fwd.cj 测试用例使用硬编码相对路径读取源文件 — 来源：R1C，位置：`tests/glm/test_fwd.cj:240,249`

  `testFwdHeaderComments` 和 `testFwdFamilyComments` 通过 `File.readFrom(Path("src/fwd.cj"))` 读取文件，路径相对于测试运行工作目录，在非根目录启动测试时导致误报。

- [ ] T4: compute_vector_decl_test.cj 测试维度覆盖不均衡 — 来源：R2B，位置：`src/detail/compute_vector_decl_test.cj`

  13 个运算策略中，mod/and/or/xor/shift_left/shift_right 仅测试 Vec1 维度；div 仅覆盖 Vec1/Vec2；add/sub/mul/equal/nequal/bitwise_not 有部分维度缺失。对比 vectorize_test.cj 全部 16 个 Functor 在 4 维度全覆盖，存在明显不均衡。

- [ ] T5: float mod 测试覆盖不完整 — 来源：R2C，位置：`src/detail/scalar_vec_ops_test.cj:177-276`

  新增的 12 个 float mod 测试存在以下覆盖缺口：(1) 全部使用 `Defaultp` 作为 Qualifier，缺少 `PackedMediump`/`PackedLowp` 覆盖，而同文件 Int64 mod 测试已有完整 qualifier 覆盖；(2) 全部使用正数操作数，缺少负数被除数、负数除数、除数为零的边界测试。

- [ ] T6: fromBoolVec 测试类型及 Qualifier 覆盖不足 — 来源：R2C，位置：`src/detail/type_fromBoolVec_test.cj`

  全部 12 个测试均使用 `Int64` 作为目标类型 T，未覆盖 `Float32`/`Float64`/`Int32` 等其他类型。Q2 版本 6 个测试全部使用 `PackedHighp` 作为 Bool vec 的 Qualifier，未覆盖 `PackedMediump`/`PackedLowp` 组合。

- [ ] T7: Vec2/Vec3/Vec4 缺少越界访问测试 — 来源：R2C，位置：`src/detail/type_vec{2,3,4}_test.cj`

  `type_vec1_test.cj` 包含越界访问测试，但 Vec2/Vec3/Vec4 的测试文件均缺少等价测试，未验证 `v[length]` 和 `v[-1]` 等行为是否抛出异常。

- [ ] T8: gen_fwd_aliases.py 与 fwd.cj 存在同步风险 — 来源：R3C，位置：`cjglm/scripts/gen_fwd_aliases.py` ↔ `cjglm/src/fwd.cj`

  脚本未生成文件头注释和家族分组注释，而 `fwd.cj` 中的这些注释是手动添加的；脚本使用命名空间导入 `import glm.detail` 与 OOD 示例的命名导入不一致。脚本与输出文件之间无同步契约，任意一方的修改将导致另一方不一致。

- [ ] T10: type_cast.cj 在 OOD 设计中无对应定位 — 来源：R3C，位置：`cjglm/src/detail/type_cast.cj`

  文件定义了 16 个 `castVec1`~`castVec4` 包级函数，但 OOD §4.1 仅描述构造函数式跨类型转换方案，OOD §8.1 文件清单也未列出此文件。其存在位置、命名约定、函数签名模式和设计意图均无设计文档可追溯。
  用户意见：修复OOD
