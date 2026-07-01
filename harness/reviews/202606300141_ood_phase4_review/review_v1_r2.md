# R1-R2: OOD Phase 4 detail 核心函数库后三个文件审查

审查时间：2026-06-30

### 审查范围

- `cjglm/src/detail/geometric.cj` — §3.1 geometric.cj（dot/cross/normalize/length/distance/reflect/refract/faceforward）
- `cjglm/src/detail/matrix.cj` — §3.1 matrix.cj（determinant/inverse 2x2/3x3/4x4，transpose/matrixCompMult/outerProduct 为阶段二已有实现不进审查范围）
- `cjglm/src/detail/vector_relational.cj` — 新建文件

### 发现

#### [一般] vector_relational.cj 函数覆盖不完整

- **位置**：`cjglm/src/detail/vector_relational.cj`
- **描述**：仅实现了 `lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual` 四个比较函数，缺少 GLSL 8.6 规范定义的 `equal`、`notEqual`、`any`、`all`、`not` 五个函数。目前 lib.cj 第 45 行仅 `public import` 了这四个已有的符号。
  - `equal`/`notEqual`：虽然 Vec 类型已有 `==`/`!=` 运算符（逐分量精确比较），但 GLSL 规范要求以 `Vec<Bool>` 返回的顶层自由函数形式提供，且 `ext/vector_relational.cj` 提供的是带 epsilon 参数的版本（语义为近似比较），与 GLSL 的精确逐分量 `equal`/`notEqual` 属于不同语义层级。
  - `any`/`all`/`not`：这三个 Bool 向量函数（对 `Vec<Bool>` 操作）在该包层级完全缺失，虽然在 `ext/vector_relational.cj` 或 Vec 的 extend 块中也未找到对应实现。
- **建议**：补充 `equal`/`notEqual`（Vec1~Vec4 重载，返回 `VecN<Bool, Q>`，约束 `T <: Equatable<T>`）、`any`（`VecN<Bool, Q>` → `Bool`）、`all`（`VecN<Bool, Q>` → `Bool`）、`not`（`VecN<Bool, Q>` → `VecN<Bool, Q>`）。需同步更新 `lib.cj` 的 public import。注意 `any`/`all`/`not` 的 Bool 向量运算需确认 Vec 类型是否已提供 `logicalAnd`/`logicalOr` 等成员方法以复用。

#### [一般] geometric.cj normalize Vec2~Vec4 零值保护分支使用 `<=` 比较，非严格 IEEE 754 最佳实践

- **位置**：`cjglm/src/detail/geometric.cj:26,35,44`
- **描述**：Vec2~Vec4 normalize 零值保护判断条件为 `lenSq <= zero`。当 `lenSq` 为 NaN 时，IEEE 754 规定 `NaN <= zero` 的结果为 `false`，因此 NaN 输入会自然进入 `v / sqrtT(NaN)` → NaN 传播路径，行为正确。但 `lenSq <= zero` 条件对极小负零值（`-0.0`）也触发保护——`-0.0 <= 0.0` 为 `true`。虽 `dot(v,v)` 在实向量上不会产生负零（平方和总是非负），但若向量分量包含 `-0.0`（如 `Vec2(-0.0, 0.0)`），`dot(v,v) = (-0.0)*(-0.0) + 0.0*0.0 = 0.0 + 0.0 = 0.0`，其值等于 `+0.0`，`<= zero` 判断成立，返回零向量。此行为与 GLM 1.0.3 一致（GLSL 10.1.1 对零长度向量 normalize 定义为 undefined，此处保守返回零向量），不构成数学错误。
- **建议**：当前实现与设计一致，无需修改。但文档可注明 `-0.0` 分量的边界行为。

#### [一般] matrix.cj determinant/inverse 的 `Number<T>` 约束对整数类型的行为

- **位置**：`cjglm/src/detail/matrix.cj:167,171,177`
- **描述**：determinant 使用 `Number<T>` 约束（设计决策 D05），整数类型可编译。但这与 GLM C++ 的行为一致——GLM 文档中 `determinant` 的模板参数为浮点类型，但 C++ 的 `T` 在此仅为乘减运算。仓颉中整数 Mat2x2 调用 `determinant` 可编译通过；而 `inverse` 使用 `FloatingPoint<T>` 约束（需要除法），整数实例化在编译器报错。此设计与 D05/D16 一致。
- **建议**：此行为是设计决策 D05 的必然结果，无需修改。但需确保文档对 `determinant` 的整数类型行为有明确声明。

#### [轻微] geometric.cj Vec1 normalize 可读性考虑

- **位置**：`cjglm/src/detail/geometric.cj:20-22`
- **描述**：Vec1 normalize 实现为 `v * inversesqrt(dot(v, v))`，无零向量保护。按照设计文档 §3.1 和 §5 错误表，零输入时通过 IEEE 754 `0 * Inf = NaN` 自然传播 NaN。此行为与 GLM 1.0.3 一致。但代码中无注释说明此行为的"有意设计"，可能对后续维护者造成困惑（容易误判为缺少保护分支的 bug）。
- **建议**：添加一行注释说明 Vec1 normalize 零值返回 NaN 是 `0 * Inf` 的 IEEE 754 自然传播结果，与 GLM 1.0.3 行为一致。

#### [轻微] geometric.cj refract 中的变量名 `dNI` 含义不明确

- **位置**：`cjglm/src/detail/geometric.cj:80,91,102`
- **描述**：变量名 `dNI` 表示 `dot(N, I)`，但命名可读性一般。GLM 1.0.3 中类似变量通常命名为 `dNI` 或 `cosI`（因 N 和 I 均为单位向量时 `dot(N,I) = cosθ`）。
- **建议**：可考虑使用更明确的命名，如 `nDotI`，但基于"保持与 GLM 风格一致"的考虑，当前命名可接受。

#### [轻微] matrix.cj Mat4x4 inverse 中的 SubFactor 命名均为局部变量，无拷贝问题

- **位置**：`cjglm/src/detail/matrix.cj:216-233`
- **描述**：18 个 `SubFactorXX` 变量为纯标量 `T` 类型局部变量（struct 值语义），编译器在 Release 模式下应可优化为寄存器分配。无容器拷贝或动态分配，性能无问题。
- **建议**：无。

#### [轻微] vector_relational.cj 约束 `Number<T> & Comparable<T>` 比 `FloatingPoint<T>` 宽松

- **位置**：`cjglm/src/detail/vector_relational.cj:6-70`
- **描述**：关系比较函数使用 `Number<T> & Comparable<T>` 约束，允许整数和浮点类型。这与 GLSL 8.6 规范一致（关系比较对标量和向量类型的整数和浮点均适用）。但当前 `ext/vector_relational.cj`（阶段三）的 `equal`/`notEqual` 同样使用 `Number<T> & Comparable<T>` 约束。一致性好。
- **建议**：无。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 3 |

### 总评

**geometric.cj**：数学正确性验证通过。`dot`/`cross`/`normalize`/`length`/`distance`/`reflect`/`refract`/`faceforward` 的公式实现与设计文档和 GLSL 8.5 规范一致。Vec1 normalize 零值 NaN 行为与设计一致（IEEE 754 `0*Inf=NaN`），Vec2~Vec4 零向量保护分支正确。`dot` 使用 `Number<T>` 约束（D03）、其余使用 `FloatingPoint<T>` 约束（D04/D16），与设计一致。

**matrix.cj**：determinant 2x2/3x3/4x4 和 inverse 2x2/3x3/4x4 的数学公式与 GLM 1.0.3 余子式展开实现一致，验证通过。奇异矩阵求逆的 IEEE 754 NaN/Inf 传播行为与设计一致（§5 错误表）。`Number<T>`（determinant）和 `FloatingPoint<T>`（inverse）约束正确。

**vector_relational.cj**：4 个已实现的比较函数公式正确。主要问题是函数覆盖不完整——缺少 GLSL 8.6 标准的 `equal`/`notEqual`/`any`/`all`/`not` 五个函数。当前 lib.cj 仅导出了前四个比较函数，建议补充完整。

总体代码质量良好，函数签名与 OOD 设计文档一致（§3.1），数学正确性经过公式逐项验证通过。主要改进点在于 `vector_relational.cj` 的函数覆盖完整性。
