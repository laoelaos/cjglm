# 测试审查报告（v3 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `type_vec4_test.cj:93,355` — 函数 `testVec4NotEqual` 被重复定义两次（第93行和第355行），完全相同的签名和实现。仓颉语言不允许同一包内具有相同签名的函数重复定义，这将导致编译错误，使整个 Vec4 测试套件无法编译运行。

- **[一般]** `type_vec2_test.cj` — 具名函数 `add`/`sub`/`mul` 缺少测试用例。实现文件 `type_vec2.cj` 定义了 `add(s: T)`、`sub(s: T)`、`mul(s: T)`，但测试文件中仅包含 `divNamed` 和 `modNamed`，缺少最基础的三项具名函数验证。测试报告声称覆盖了 "add, sub, mul, div, mod" 但实际不符。

- **[一般]** `type_vec2_test.cj` — Vec-Vec 按位移位 `<<`/`>>` 未测试。`&`/`|`/`^` 已测试，但 `<<`/`>>` 仅测试了标量和 Vec1 广播变体，缺少 `Vec2 << Vec2` 和 `Vec2 >> Vec2` 的用例。

- **[一般]** `type_vec2_test.cj` — 标量右操作数按位运算 `|(T)`/`^(T)` 未测试。测试仅包含 `&(T)`，缺少 `|(T)` 和 `^(T)`。

- **[一般]** `type_vec3_test.cj` — 标量右操作数按位运算 `|(T)`/`^(T)` 未测试。测试仅包含 `&(T)`，缺少 `|(T)` 和 `^(T)`。

- **[一般]** `type_vec3_test.cj` — Vec1 位广播 `|`/`^`/`<<` 未测试。仅测试了 `&(Vec1)` 和 `>>(Vec1)`，缺少 `|`、`^`、`<<` 的 Vec1 广播版本。

- **[一般]** `type_vec3_test.cj` — Vec-Vec 按位移位 `<<`/`>>` 未测试。

- **[一般]** `type_vec4_test.cj` — 标量右操作数按位运算 `|(T)`/`^(T)` 未测试。

- **[一般]** `type_vec4_test.cj` — Vec1 位广播 `|`/`^`/`<<` 未测试。仅测试了 `&(Vec1)` 和 `>>(Vec1)`。

- **[一般]** `type_vec4_test.cj` — Vec-Vec 按位移位 `<<`/`>>` 未测试。

- **[一般]** `type_vec1_test.cj` — Vec1 算术广播仅测试了 Vec2 版（`+(Vec2)`），缺少 Vec3/Vec4 版本的广播测试。Vec1 位广播仅测试了 `&(Vec2)`，缺少 `|`/`^`/`<<`/`>>` 及 Vec3/Vec4 的其他变体。

## 修改要求

1. `src/detail/type_vec4_test.cj` — 删除第355行起重复的 `testVec4NotEqual` 函数定义（或删除第93行的原始定义，保留一处），确保编译通过。

2. `src/detail/type_vec2_test.cj` — 为 `add(s)`/`sub(s)`/`mul(s)` 具名函数补充测试用例。示例模式与其他 Vec 的命名函数测试相同，使用 `v.add(Int64(3))` 调用并断言结果分量。

3. `src/detail/type_vec2_test.cj`, `type_vec3_test.cj`, `type_vec4_test.cj` — 为 Vec-Vec 按位移位 `<<`/`>>` 补充测试用例。当前 Vec1 已有 `testVec1ShiftVec` 和 `testVec1ShiftRightVec` 可作参考。

4. `src/detail/type_vec2_test.cj`, `type_vec3_test.cj`, `type_vec4_test.cj` — 为标量右操作数 `|(T)`/`^(T)` 补充测试用例。

5. `src/detail/type_vec3_test.cj`, `type_vec4_test.cj` — 为 Vec1 位广播中的 `|`/`^`/`<<` 补充测试用例。`type_vec2_test.cj` 中已有 `testVec2Vec1BitBroadcast`、`testVec2ShiftLeftVec1` 作参考。

6. `src/detail/type_vec1_test.cj` — 补充 Vec1→Vec3 和 Vec1→Vec4 的算术广播及位广播测试用例，参考已有的 `testVec1BroadcastAddVec2` 模式扩展。
