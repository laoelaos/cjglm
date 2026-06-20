# R2B: compute_vector_decl.cj 和 vectorize.cj 代码审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/compute_vector_decl.cj` — 向量运算策略结构体（52 个 struct）
- `cjglm/src/detail/vectorize.cj` — Functor 工具类型（16 个 struct）
- `cjglm/src/detail/compute_vector_decl_test.cj` — 26 个测试函数
- `cjglm/src/detail/vectorize_test.cj` — 17 个测试函数
- `docs/02_ood_phase0.md` — OOD 设计文档（§3.3 Functor 体系, §3.4 ComputeVec\* 运算策略体系, D16）

### 发现

#### [一般] compute_vector_decl_test.cj 测试覆盖不均衡 — 多数运算仅覆盖 Vec1 维度

- **位置**：`cjglm/src/detail/compute_vector_decl_test.cj`
- **描述**：13 个运算策略中，mod、and、or、xor、shift_left、shift_right 6 个仅测试 Vec1 维度；div 仅覆盖 Vec1/Vec2；add/sub/mul/equal/nequal/bitwise_not 有部分维度缺失。完整覆盖矩阵如下（✓=已覆盖，✗=未覆盖）：

  | Op | Vec1 | Vec2 | Vec3 | Vec4 |
  |----|------|------|------|------|
  | Add | ✓ | ✗ | ✗ | ✓ |
  | Sub | ✓ | ✓ | ✓ | ✗ |
  | Mul | ✓ | ✓ | ✓ | ✗ |
  | Div | ✓ | ✓ | ✗ | ✗ |
  | Mod | ✓ | ✗ | ✗ | ✗ |
  | And | ✓ | ✗ | ✗ | ✗ |
  | Or | ✓ | ✗ | ✗ | ✗ |
  | Xor | ✓ | ✗ | ✗ | ✗ |
  | ShiftLeft | ✓ | ✗ | ✗ | ✗ |
  | ShiftRight | ✓ | ✗ | ✗ | ✗ |
  | Equal | ✓ | ✓ | ✗ | ✓ |
  | NEqual | ✓ | ✓ | ✗ | ✓ |
  | BitwiseNot | ✓ | ✗ | ✗ | ✓ |

  对比 vectorize_test.cj（所有 16 个 Functor 在全部 4 个维度均有覆盖），compute_vector_decl_test 的维度覆盖存在明显不均衡。
- **建议**：为每个运算补充 Vec2/Vec3/Vec4 维度的正向测试（至少每运算 1 个缺失维度），确保 13×4 覆盖矩阵无空白。当前 gap 涉及约 25 个缺失维度的测试用例。

#### [轻微] 类型覆盖单一 — 仅 Int64 和 Float32

- **位置**：`cjglm/src/detail/compute_vector_decl_test.cj`、`cjglm/src/detail/vectorize_test.cj`
- **描述**：compute_vector_decl_test.cj 的 26 个测试中 24 个使用 Int64、2 个使用 Float32；vectorize_test.cj 的 17 个测试全部使用 Int64。未对 Int32、Float64、UInt64 等主要数值类型进行测试，也未对 Bool 类型的 Vec 进行 Functor1 测试（验证 R≠T 场景）。
- **建议**：补充 Int32（有符号整数代表）、Float64（双精度浮点代表）各一到两个正向测试，覆盖主要类型族。

#### [轻微] Qualifier 覆盖单一 — 仅 Defaultp (PackedHighp)

- **位置**：`cjglm/src/detail/compute_vector_decl_test.cj`、`cjglm/src/detail/vectorize_test.cj`
- **描述**：两测试文件全部使用 `Defaultp`（即 `PackedHighp`）。未使用 `PackedMediump` 或 `PackedLowp` 验证 Q 参数的编译期类型独立性。
- **建议**：各补充至少一个使用 `PackedMediump` 的测试用例，验证 Q 参数不影响运算结果。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 1 |
| 轻微 | 2 |

### 总评

compute_vector_decl.cj 和 vectorize.cj 的实现与 OOD 设计一致：

1. **compute_vector_decl.cj**（52 个 struct）— 完整定义了 13 个运算 × 4 个维度的策略结构体，每个提供静态 `call` 方法，类型约束正确（Number\<T\>/Integer\<T\>/Equatable\<T\> 按运算语义选择），Functor 使用合理。`callConst` 在 ComputeVec\* 中不需要（OOD §3.4 仅要求 `call`）。运算策略 struct 命名遵循 C++ 惯例（compute_vec_*N）。"首轮仅定义不消费"的设计意图被尊重——当前无任何 Vec 运算符代码引用这些类型。

2. **vectorize.cj**（16 个 struct）— 完整定义了 4 类 Functor（Functor1/Functor2/Functor2VecSca/Functor2VecInt）× 4 维度，每类提供静态 `call` 方法，`where Q <: Qualifier` 约束一致。与 OOD §3.3 完全匹配。

3. **vectorize_test.cj** — 覆盖全面，16 个 Functor 全部在 4 个维度上至少有一个正向测试。

4. **compute_vector_decl_test.cj** — 超过 OOD 基线（仅要求"编译通过"）验证了运行时正确性，但维度覆盖存在明显不均衡（13 个运算中 6 个仅测 Vec1）。类型（仅 Int64/Float32）和 Qualifier（仅 Defaultp）覆盖单一。

生产代码质量良好，测试覆盖有提升空间。
