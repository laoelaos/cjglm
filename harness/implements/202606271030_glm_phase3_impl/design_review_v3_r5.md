# 设计审查报告（v3 r5）

## 审查结果
REJECTED

## 发现

### [严重] vector_relational.cj 中 epsilon 版本与 ULP 版本 equal/notEqual 在 T=Int64 时重载歧义

**问题**：`vector_relational.cj` 中 epsilon 版本（第三参数 `epsilon: T`）和 ULP 版本（第三参数 `ULPs: Int64`）的 `equal`/`notEqual` 函数在 `T = Int64` 时参数类型完全一致，编译器无法区分。

**为什么是问题**：仓颉语言重载解析规则（`func/README.md:162`）规定"类型变量约束不参与判断"，即 `where T <: Number<T> & Comparable<T>`（epsilon）与 `where T <: Number<T> & Comparable<T>`（ULP）相同的约束不能用于区分重载。当调用 `equal<Int64, Q>(v1, v2, 5)` 时，两个重载的实例化签名均为 `equal(Vec1<Int64,Q>, Vec1<Int64,Q>, Int64)`，编译器报"无唯一最佳匹配"错误。

**影响范围**：Vec1~Vec4 各 4 组（equal/notEqual × scalar ULPs），共 8 组重载歧义，直接影响所有带 ULP 参数的函数。

**期望修正**：将 ULP 版本的泛型约束从 `T <: Number<T> & Comparable<T>` 改为 `T <: FloatingPoint<T> & Comparable<T>`（ULP 比较仅对浮点类型有意义），使得当 `T = Int64` 时 ULP 版本不参与重载候选，消除歧义。

### [一般] 设计函数总数与任务描述不一致

**问题**：任务 `task_v3.md` 第 12 行描述"8 个 ULP 重载 stub"，但设计 `detail_v3.md` 中实际定义了 16 个（Vec1~Vec4 × equal/notEqual × scalar/vector ULPs = 16）。设计本身 16 个的计数是数学正确的，但与任务规格数字不一致。

**期望修正**：与任务作者确认，统一为 16 个（推荐）或按 8 个裁减（去掉 vector ULPs 重载）。建议统一为 16 个以匹配 GLM 完整 API。
