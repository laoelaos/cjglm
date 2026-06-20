# R3A: 基础设施层+标量向量运算 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/setup.cj`
- `cjglm/src/detail/qualifier.cj`
- `cjglm/src/detail/shim_limits.cj`
- `cjglm/src/detail/shim_assert.cj`
- `cjglm/src/detail/shim_cstddef.cj`
- `cjglm/src/detail/compute_vector_relational.cj`
- `cjglm/src/detail/scalar_vec_ops.cj`
- `cjglm/src/lib.cj`
- `cjglm/cjpm.toml`

审查依据：`docs/02_ood_phase0.md` §2（项目配置/包组织/公共 API 面）、§3.1（Qualifier）、§3.5（ComputeEqual）、§3.6（Shim 层）、§4.3（标量-向量运算）

### 发现

#### [轻微] cjpm.toml 版本号与 OOD §2 配置模板不一致

- **位置**：`cjglm/cjpm.toml:4`
- **描述**：OOD §2 的 cjpm.toml 模板指定 `version = "0.1.0"`，实际为 `version = "1.0.3"`。虽然语义上对齐了 GLM 1.0.3 版本号，但偏离了 OOD 模板的 "可直接拷贝使用" 约定。cjc-version 从 `"1.0.5"` 更新为 `"1.1.0"` 属合理编译器升级，不视为偏离。
- **建议**：若 project version 意图表达库版本而非实施阶段，可将 OOD §2 的模板更新为 `"1.0.3"` 以消除设计与实现的偏差。

#### [轻微] shim_assert.cj 参数命名标签与 OOD §3.6 不一致

- **位置**：`cjglm/src/detail/shim_assert.cj:3`
- **描述**：OOD §3.6 接口规范为 `assert(condition: Bool, message?: String)`，实际实现使用 `message!: String = "Assertion failed"`（`!:` 命名标签）。在仓颉中，`!: ` 要求调用方必须使用命名参数语法 `message!: "文本"`，而 `?:` 允许位置参数。此差异改变调用约定，但行为等价（默认参数保证 `message` 可省略）。
- **建议**：确认仓颉语法限制——若 `?:` 无法同时满足"有默认值"和"字符串类型"，保留当前 `!:` 写法；否则按 OOD 规范统一为 `message?: String = "Assertion failed"`。

### 文件逐项对照总结

#### 1. setup.cj / cjpm.toml — OOD §2

| 检查项 | 状态 |
|--------|------|
| `GLM_VERSION_MAJOR/MINOR/PATCH` = 1/0/3 | ✓ 正确 |
| `GLM_VERSION` = 103（= 1×100 + 0×10 + 3） | ✓ 正确 |
| `GLM_CONFIG_SIMD` = false | ✓ 与 "首轮 SIMD 不启用" 一致 |
| `GLM_CONFIG_ALIGNED_GENTYPES` = false | ✓ 与 "首轮对齐策略不启用" 一致 |
| `GLM_CONFIG_CLIP_CONTROL` = false | ✓ 合理配置 |
| 无 `LengthT`/`SizeT` 定义混入 setup.cj | ✓ 与依赖拓扑澄清一致（归入 shim_cstddef） |
| cjpm.toml `name`/`output-type`/`src-dir`/`[test] src-dir` | ✓ 与模板一致 |
| cjpm.toml `version` | ⚠ 见 [轻微] 发现 |
| 所有常量使用 `public const` | ✓ R1A 已确认修复 |

#### 2. qualifier.cj — OOD §3.1

| 检查项 | 状态 |
|--------|------|
| `interface Qualifier {}` | ✓ 标记接口，无成员 |
| `struct PackedHighp <: Qualifier {}` | ✓ |
| `struct PackedMediump <: Qualifier {}` | ✓ |
| `struct PackedLowp <: Qualifier {}` | ✓ |
| `internal struct AlignedHighp <: Qualifier {}` | ✓ internal 可见性 |
| `internal struct AlignedMediump <: Qualifier {}` | ✓ internal 可见性 |
| `internal struct AlignedLowp <: Qualifier {}` | ✓ internal 可见性 |
| `public type Defaultp = PackedHighp` | ✓ |
| 无额外依赖（仅 `package glm.detail`） | ✓ |

R1A 已验证完整，无变化。

#### 3. shim_limits.cj — OOD §3.6

| 检查项 | 状态 |
|--------|------|
| `NumericLimits<T>.epsilon(hint: T): T where T <: Number<T>` | ✓ 签名匹配 |
| `isIec559Of<T>(hint: T): Bool`（match 运行时判定） | ✓ OOD §3.6 推荐实现 |
| `epsilonOf<T>(hint: T): T where T <: Number<T>`（委托 NumericLimits） | ✓ OOD §3.6 推荐实现 |
| hint 参数辅助类型推断 | ✓ 设计决策，DV-04 记录 |
| epsilon 值正确性（Float64: 2.22e-16, Float32: 1.19e-7） | ✓ |

#### 4. shim_assert.cj — OOD §3.6

| 检查项 | 状态 |
|--------|------|
| `assert(condition: Bool, ...): Unit` | ✓ |
| 行为等价：`!condition → throw Exception` | ✓ |
| 默认消息 | ✓ "Assertion failed" |
| 参数命名标签 | ⚠ 见 [轻微] 发现 |

#### 5. shim_cstddef.cj — OOD §3.6

| 检查项 | 状态 |
|--------|------|
| `type SizeT = UInt64` | ✓ |
| `type LengthT = Int64` | ✓ |
| 无 `countof` 函数 | ✓ 与 "不单独定义" 一致 |

#### 6. compute_vector_relational.cj — OOD §3.5

| 检查项 | 状态 |
|--------|------|
| `ComputeEqual<T> where T <: Equatable<T>` | ✓ 精确比较职责 |
| `ComputeEqual.call(a, b): Bool` | ✓ `a == b` |
| `ComputeEqualNumeric<T> where T <: Number<T> & Equatable<T> & Comparable<T>` | ✓ 容差比较职责 |
| `ComputeEqualNumeric.callConst(a, b): Bool` | ✓ 两路径（浮点→epsilon，非浮点→精确） |
| 双结构体拆分 | ✓ INT-02 记录 |
| 手动 `abs` 替代 `std.math.abs` | ⚠ R1A 已记录（轻微，无功能影响） |

#### 7. scalar_vec_ops.cj — OOD §4.3

| 检查项 | 状态 |
|--------|------|
| `add`/`sub`/`mul`/`div` 各 4 重载（Vec1~Vec4），`T <: Number<T>` | ✓ 20 个函数签名正确 |
| 全部标注 `@OverflowWrapping` | ✓ |
| `mod` 整数路径（`T <: Integer<T>`）各 4 重载，标注 `@OverflowWrapping` | ✓ |
| `mod` 浮点路径（Float32/Float64/Float16 各 4 重载，使用 `fmod`） | ⚠ 超出 OOD §2 声明的 "首轮不承担浮点 mod 路径"，已在 R1B 记录，DEV-05 跟踪偏差修订 |
| 无 `const` 修饰符 | ✓ IF-02 记录 |
| 符合命名空间占用约定（仅本文件定义包级 add/sub/mul/div/mod） | ✓ |

#### 8. lib.cj — OOD §2（公共 API 面）

| 检查项 | 状态 |
|--------|------|
| `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` | ✓ |
| `public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }` | ✓ |
| `public import glm.detail.{ Defaultp }` | ✓ |
| `public import glm.detail.{ add, sub, mul, div, mod }` | ✓ |
| `public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }` | ✓ |
| 与 OOD §2 导出清单完全一致 | ✓ 精确匹配 |

### 已排除的已知偏差

以下设计偏离已在 `docs/deviations.md` 中记录或 R1/R2 中报告，不重复：

| 编号 | 关联文件 | 内容 |
|------|---------|------|
| IF-02 | `scalar_vec_ops.cj` | 标量-向量运算函数不可在 const 上下文调用 |
| IF-03 | 各 Vec 文件 | `componentAt` 不可在 const 上下文使用 |
| DV-01 | `fromBoolVec` 系列 | 需要额外 zero/one 参数 |
| DV-02 | `scalar_vec_ops.cj` | `%` 仅对整数可用（DEV-05 跟踪修订中） |
| DV-04 | `shim_limits.cj` | `isIec559Of`/`epsilonOf` 需要 hint 值参数 |
| DV-05 | `compute_vector_relational.cj` | `==` 精确比较，`equalEpsilon` 非 const |
| INT-02 | `compute_vector_relational.cj` | `ComputeEqual` 拆分为双结构体 |
| R1A#④ | `compute_vector_relational.cj` | `callConst` 手动 abs 替代 std.math.abs |
| R1B#② | `scalar_vec_ops.cj` | float mod 扩展超出 OOD 首轮范围 |
| R1B#③~⑨ | `type_vec*.cj` | 跨类型构造函数缺失、increment/decrement 签名不符 |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 0 |
| 轻微 | 2 |

### 总评

本轮审查覆盖 R3A 指定的 6 组文件（8 个源文件 + 1 个配置文件），对照 OOD §2、§3.1、§3.5、§3.6、§4.3 进行设计一致性检查。总体一致性良好，具体结论如下：

- **设计完全一致**：`qualifier.cj`、`shim_cstddef.cj`、`lib.cj` — 与 OOD 精确匹配，无任何设计偏离。
- **设计基本一致，已有偏差记录**：`setup.cj`+`cjpm.toml`（配置常量和项目结构一致，version 字段轻微偏差）、`shim_limits.cj`（DV-04 已记录）、`compute_vector_relational.cj`（INT-02 已记录）、`scalar_vec_ops.cj`（R1B/R1C 报告的问题已在跟踪中）。
- **新增 2 项轻微发现**：① cjpm.toml 版本号与 OOD 模板不一致（`"1.0.3"` vs `"0.1.0"`）；② shim_assert.cj 参数命名标签 `message!:` 与 OOD 规范 `message?:` 不一致。两项均不影响功能正确性。

所有已知的仓颉迁移限制（IF 系列）、接口偏差（DV 系列）、内部区别（INT 系列）均已通过 `docs/deviations.md` 记录，未在本报告中重复。
