# R3B: Vec 类型体系设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/type_vec1.cj`
- `cjglm/src/detail/type_vec2.cj`
- `cjglm/src/detail/type_vec3.cj`
- `cjglm/src/detail/type_vec4.cj`
- `cjglm/src/detail/type_fromBoolVec.cj`

审查依据：`docs/02_ood_phase0.md` §3.2, §4.1, §4.2, §4.4, §4.5, §4.6, §4.8

### 发现

#### [严重] Vec1~Vec4 全部缺失 OOD §4.1 规定的跨类型构造函数体系

- **位置**：`cjglm/src/detail/type_vec1.cj:7` ~ `type_vec4.cj:7`
- **描述**：各 Vec 类型仅实现了 3 个构造函数（标量填充、`const init` 逐分量、fill-from-Vec1 同类型），OOD §4.1 完整构造函数清单中 Vec2 要求 9 个、Vec3 要求 15 个、Vec4 要求 30 个。所有 `public init<T2, Q2>(...) where Q2 <: Qualifier` 跨类型构造函数（包括跨 Vec 类型转换、多元 Vec1 组合、VecN 截断构造）全部缺失。

  | Vec 类型 | 现有构造函数数 | OOD 要求数 | 缺失数 |
  |---------|-------------|-----------|-------|
  | Vec1 | 1 (`const init(x: T)`) | 5 | 4（跨类型构造 ×4） |
  | Vec2 | 3 | 9 | 6 |
  | Vec3 | 3 | 15 | 12 |
  | Vec4 | 3 | 30 | 27 |

  示例缺失：`Vec2<T, Q>` 缺少 `init<T2, Q2>(v: Vec2<T2, Q2>)`、`init<T2, Q2>(a: Vec1<T2, Q2>, b: T)`、`init<T2, Q2>(v: Vec3<T2, Q2>)`、`init<T2, Q2>(v: Vec4<T2, Q2>)` 等。

- **建议**：对照 OOD §4.1 完整清单逐项补充跨类型构造函数。`T(v.x)` 类型转换路径已在 OOD §9.4 矩阵中定义。

#### [一般] `increment()`/`decrement()` 签名与 OOD 设计不一致

- **位置**：`cjglm/src/detail/type_vec1.cj:146-153`, `type_vec2.cj:125-134`, `type_vec3.cj:132-141`, `type_vec4.cj:139-150`
- **描述**：OOD §4.3/§4.6 明确设计为返回新向量的纯函数：`increment(): VecN<T,Q>` / `decrement(): VecN<T,Q>`，标注`@OverflowWrapping`，调用方使用 `v = v.increment()`。但代码实现为原地修改：`public mut func increment(): Unit`。两种语义的使用模式不兼容——按 OOD 设计的调用方写出 `v = v.increment()` 会导致 `Unit` 赋值给 `VecN` 编译错误。
- **建议**：将 `increment()`/`decrement()` 改为返回新向量 `VecN<T,Q>`（非 `mut`），如 `VecN(this.x + (-(!(this.x - this.x))), ...)`。或在 deviations.md 中记录此 API 偏差。

#### [轻微] `static length()` 缺少 `const` 修饰符

- **位置**：`cjglm/src/detail/type_vec1.cj:14`, `type_vec2.cj:26`, `type_vec3.cj:30`, `type_vec4.cj:34`
- **描述**：OOD §3.2 规定 `const public static func length(): Int64`。代码为 `public static func length()`，缺少 `const`。仓颉语言支持 `static const` 函数（const README §3.2 规则 2），因此该修饰符理论上可标注。缺失 `const` 使 `length()` 不能在 const 表达式中作为编译期常量使用。
- **建议**：补充 `const` 修饰符：`const public static func length(): Int64 { 1 }`。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 1 |
| 轻微 | 1 |

### 总评

Vec 类型体系的核心结构（数据成员命名、`length()`、下标运算符、算术/位/比较运算符体系）与 OOD 设计基本一致。主要问题集中在两个方面：(1) 跨类型构造函数体系全量缺失，这是 §4.1 设计的核心部分，影响 Vec 类型转换链路的完整性；(2) `increment`/`decrement` 的原地修改语义与 OOD 设计的新向量返回语义不兼容，属于 API 契约偏差。`fromBoolVec.cj` 的 8 个工厂函数实现与 OOD §4.8 一致。
