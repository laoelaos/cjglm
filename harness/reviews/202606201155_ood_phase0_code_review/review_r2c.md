# R2C: fromBoolVec 实现与 OOD 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/type_fromBoolVec.cj` — fromBoolVec/fromBoolVecQ2 包级独立工厂函数
- `cjglm/src/detail/type_fromBoolVec_test.cj` — 对应单元测试

### 设计依据

`docs/02_ood_phase0.md` §4.8 Bool→Numeric 转换工厂函数 `fromBoolVec`

### 发现

#### [严重] 函数签名与 OOD 设计 §4.8 不一致

- **位置**：`cjglm/src/detail/type_fromBoolVec.cj:3`
- **描述**：实现为所有 8 个函数额外添加了 `zero: T, one: T` 参数，设计明确规定仅接收 `v: VecN<Bool, Q>` 单一参数，函数体内硬编码 `T(1)`/`T(0)`。设计签名（§4.8）与实现签名对比：
  ```
  // 设计（§4.8）：
  public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>): Vec1<T, Q> where Q <: Qualifier
  // 实现：
  public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier
  ```
  此偏离导致：① API 契约被改变——调用方需额外传入 `zero`/`one` 而不再使用约定的 `T(0)`/`T(1)`；② 调用方可传入任意值（如 `Int64(42)` 作为 `one`），破坏了设计的转换语义（`true→T(1)`, `false→T(0)`）。
- **建议**：移除所有 `zero`/`one` 参数，函数体直写 `T(1)`/`T(0)`。按设计 §4.8 修改 each 函数体：
  ```cangjie
  // 设计版本（以 Vec1 同 Q 为例）
  public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>): Vec1<T, Q> where Q <: Qualifier {
      Vec1(if (v.x) { T(1) } else { T(0) })
  }
  ```
  `fromBoolVecQ2` 同理，保持 `VecN<T, Q>(...)` 显式标注形式即可（已在实现中正确使用）。

#### [一般] 测试未验证核心 T(1)/T(0) 转换语义

- **位置**：`cjglm/src/detail/type_fromBoolVec_test.cj:9`
- **描述**：测试用例均传入 `Int64(0)`/`Int64(1)` 作为 `zero`/`one` 参数。由于当前实现将此职责委派给调用方，测试仅验证"传入的值被正确映射"，而非验证设计的核心语义——`true` 应被转换为 `T(1)`、`false` 应被转换为 `T(0)`。若签名修复后，测试用例应验证 `T(1)`/`T(0)` 构造本身的行为。
- **建议**：按设计修复签名后，测试更新为：
  ```cangjie
  let vb = Vec1<Bool, Defaultp>(true)
  let r = fromBoolVec<Int64, Defaultp>(vb)
  @Expect(r.x, Int64(1))
  ```
  同时对各数值目标类型（Int32、Float32 等）验证 `T(1)`/`T(0)` 构造的正确性。

#### [轻微] 显式 return 关键字使用

- **位置**：`cjglm/src/detail/type_fromBoolVec.cj:4`（以及各函数体）
- **描述**：函数体使用显式 `return` 关键字，而项目其他文件（如 `type_vec1.cj`）采用仓颉隐式返回风格（最后一个表达式即为返回值）。
- **建议**：移除显式 `return`，与项目风格一致：`Vec1(if (v.x) { T(1) } else { T(0) })`。

### 已确认的设计符合项

以下方面与 OOD 设计一致，无问题：

| 检查项 | 结果 |
|--------|------|
| Bool Vec → T Vec 转换方向 | ✓ 同 Q（fromBoolVec）和跨 Q（fromBoolVecQ2）均已实现 |
| Vec1~Vec4 四个分量数版本 | ✓ 各 2 版本（同 Q + 跨 Q），共 8 个函数 |
| 函数为非 const 包级独立函数 | ✓ 符合设计 §4.8"函数体不依赖 const 修饰符" |
| @OverflowWrapping 标注 | ✓ T(1)/T(0) 构造无溢出风险，不标注正确 |
| fromBoolVecQ2 使用 VecN\<T, Q\>(...) 显式标注 | ✓ 匹配设计 §4.8 回退路径（显式标注类型参数） |
| public 可见性 | ✓ 可在 lib.cj 中通过 public import 对外暴露 |
| 参数 `v` 使用 const 引用（值类型） | ✓ Vec 为 struct 按值传递，符合设计 |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 1 |
| 轻微 | 1 |

### 总评

`type_fromBoolVec.cj` 实现了完整的 8 个函数（Vec1~Vec4 × 同 Q/跨 Q），分量覆盖正确，跨 Q 版本已采用显式类型参数标注（匹配设计回退路径）。**核心缺陷**是函数签名偏离设计——实现通过 `zero: T, one: T` 参数将 `T(1)`/`T(0)` 的构造职责委派给调用方，而设计明确规定函数体内直写 `T(1)`/`T(0)`。此偏离改变了公共 API 契约。测试用例因签名差异而未能验证设计的核心语义。建议优先修复签名和测试，使实现与设计 §4.8 完全对齐。
