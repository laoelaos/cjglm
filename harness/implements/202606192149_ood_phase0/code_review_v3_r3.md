# 代码审查报告（v3 r3）

## 审查结果
REJECTED

## 发现

- **[严重]** `type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj` — 跨类型转换构造函数完全缺失
  设计规格为每个 Vec 类型定义了 `init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier` 等跨类型构造函数（Vec1 缺 4 个、Vec2 缺 6 个、Vec3 缺 12 个、Vec4 缺大量）。实际代码仅包含 `const init(x: T)`、`init(scalar: T)` 和 `init(v: Vec1<T, Q>)`（同类型），用户无法执行 `Vec2<Float64, HP>(Vec2<Int64, HP>(1,2))` 等跨类型构造。这是设计的核心 API 契约缺失，严重影响可用性。

- **[一般]** `scalar_vec_ops.cj` — 所有 20 个函数缺少 `const` 限定符
  设计规格为 `public const func add<T, Q>(...)`，代码中全部为 `public func` 无 `const`，失去编译期求值能力。

- **[一般]** `type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj` — 缺少一元 `+()` 运算符
  设计规格中 Number<T> extend 块包含 `public operator func +(): VecN<T, Q> { this }`，实际代码未实现。

- **[一般]** `type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj` — `%` 运算符约束层级偏离设计
  设计将 `%` 放在 `T <: Number<T>` extend 块中，实际代码放在 `T <: Integer<T>` 块。虽语义更精确（模运算仅对整数有效），但属设计偏离且未在实现报告中声明。

- **[一般]** `type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj` — 移位运算符签名偏离设计
  设计规定 `<<(rhs: VecN<T, Q>)` / `>>(rhs: VecN<T, Q>)`，实际代码使用 `<<(shift: Int64)` / `<<(rhs: VecN<Int64, Q>)` 等，签名不匹配设计规格。

## 修改要求

1. **`type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj` struct 体**：按详细设计补充所有 `init<T2, Q2>` 跨类型转换构造函数。Vec1 需补充从 Vec1~Vec4 的 4 个泛型构造，Vec2 需补充 6 个泛型构造，Vec3 和 Vec4 需按设计补充全部泛型构造。每个构造函数实现体使用 `T(v.x)` 显式类型转换。

2. **`scalar_vec_ops.cj`**：为全部 20 个函数添加 `const` 限定符，将 `public func` 改为 `public const func`。

3. **`type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj`**：在 Number<T> extend 块中补充 `public operator func +(): VecN<T, Q> { this }`。

4. **`type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj`**：将 `%` 运算符移回 Number<T> extend 块以匹配设计，或在实现报告中明确声明设计偏离及理由。

5. **`type_vec1.cj` / `type_vec2.cj` / `type_vec3.cj` / `type_vec4.cj`**：将移位运算符签名修正为设计规格的 `<<(rhs: VecN<T, Q>)` / `>>(rhs: VecN<T, Q>)`，或在实现报告中明确声明设计偏离及理由。
