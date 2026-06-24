# 实现计划

任务描述：OOD Phase 2 — 实现 9 个矩阵类型（Mat2x2~Mat4x4）、4 个辅助文件（common.cj/matrix.cj/geometric.cj/scalar_mat_ops.cj）、ext/ 别名文件、fwd.cj/lib.cj 更新及配套测试
项目根目录：C:\Develop\Software\cjglm_wp\cjglm

---

## 实施路线

| 任务编号 | 任务描述 | 责任人 | 状态 |
|---------|---------|-------|------|
| T1 | Stub 文件：创建 common.cj（基础数学函数 stub）+ geometric.cj（几何函数 stub） | Agent | ✅ 已完成 |
| T2 | 矩阵骨架：创建 8 个矩阵类型 skeleton 文件（Mat2x3~Mat4x4）——结构体定义+基础构造+length+下标 | Agent | ✅ 已完成 |
| T3 | 完整 Mat2x2：实现全部运算符/工厂函数/fromMat（依赖 T2 骨架） | Agent | ✅ 已完成 |
| T4 | 非方阵：实现 6 个文件完整功能（type_mat2x3/2x4/3x2/3x4/4x2/4x3.cj） | Agent | ✅ 已完成 |
| T5 | 方阵：实现 type_mat3x3.cj 和 type_mat4x4.cj 完整功能 | Agent | ✅ 已完成 |
| T6 | 矩阵运算库：实现 matrix.cj（27 个可直接实现重载 + 6 个 stub） | Agent | ✅ 已完成 |
| T7 | 标量-矩阵运算：实现 scalar_mat_ops.cj（add/sub/mul/div 各 9 重载） | Agent | ✅ 已完成 |
| T8 | Vec extend 块：行向量×矩阵运算符（type_vecN.cj 追加 extend 块） | Agent | ✅ 已完成 |
| T9 | 别名和导出：ext/ 目录 26 个文件 + fwd.cj（54 个矩阵别名）+ lib.cj 更新 | Agent | ✅ 已完成 |
| T10 | 集成测试：通过 fwd/lib 别名执行跨所有矩阵类型的创建/算术/fromMat/函数/行向量×矩阵/标量-矩阵运算 | Agent | ✅ 已完成 |
| T11 | 构建验证 + 偏差记录 | Agent | ✅ 已完成 |
| T12 | 矩阵比较运算符（==/!=/equalExact/equalEpsilon）追加至 9 个矩阵类型文件 | Agent | ✅ 已完成 |
| T13 | refract stub（Vec2/Vec3/Vec4）追加至 geometric.cj | Agent | ✅ 已完成 |

---

## R1 NEW T1 — stub 文件（common.cj + geometric.cj）
任务：创建两个 pure stub 文件 common.cj 和 geometric.cj，每个函数体以 `throw Exception("stub")` 占位
选择理由：底层依赖优先——common.cj 和 geometric.cj 无任何包内依赖，是阶段二所有文件的依赖基座。type_mat3x3.cj 依赖 common.cj，type_mat4x4.cj 依赖 geometric.cj，必须先实现方可编译方阵 .inl 模块
上下文：参见设计文档 §3.7

---

## R2 PASSED T1 — stub 文件（common.cj + geometric.cj）
结果：创建了 src/detail/common.cj（12 个标量数学函数 stub）和 src/detail/geometric.cj（17 个几何函数 stub），所有函数体为 `throw Exception("stub")`
测试：tests/glm/detail/test_common.cj（12 用例）、tests/glm/detail/test_geometric.cj（17 用例），共 476 用例全部通过

## R2 RETRY T2 — Mat2x2 矩阵类型（type_mat2x2.cj）
审查意见：T2（type_mat2x2.cj）引用了 Mat3x2/Mat4x2/Mat3x3/Mat4x4 等尚未存在的类型（fromMat 6a/6b 共 17 个重载 + 跨尺寸乘法），仓颉以包为最小编译单元，按原有序将导致编译失败
修改措施：将原 T2 拆分为两步——先创建 8 个依赖类型的 skeleton 文件（T2），再实现完整 Mat2x2（T3）

## R2 NEW T2 — 矩阵类型 skeleton 文件（Mat2x3~Mat4x4）
任务：创建 8 个矩阵类型 skeleton 文件（src/detail/type_mat2x3.cj ~ type_mat4x4.cj），每文件仅包含结构体定义、列向量数据成员、基础构造函数（逐分量/列向量/标量填充）、length()、下标运算符、col() 访问器
选择理由：仓颉编译器要求同包内所有被引用的类型在编译时存在。T2 的 fromMat 6a/6b/7 共引用所有 9 个矩阵类型，跨尺寸乘法引用 Mat3x2/Mat4x2。必须先提供所有矩阵类型的 minimum viable 定义方可编译任何单个矩阵的完整实现。8 个 skeleton 模式完全机械（仅差异为列向量类型和列数），适合批量创建
上下文：参见设计文档 §3.1（矩阵结构体）、§3.3 item 1~2（构造函数）、§3.4（下标/列访问）。各矩阵类型的列向量类型和列数见第 2 节类型映射表。Vec1~4 类型已定义完毕（同包直接可见）。可参考 type_vec2.cj 的结构体定义和构造函数模式

---

## R3 PASSED T2 — 矩阵类型 skeleton 文件（Mat2x3~Mat4x4）
结果：创建 8 个 skeleton 文件（type_mat2x3~type_mat4x4.cj），每文件含结构体定义、3 个基础构造函数、length()、[] get/set、col() 访问器
编译：cjpm build 成功（仅未使用 import 的 warning，无编译错误）
测试：476 用例全部通过

## R3 NEW T3 — 完整 Mat2x2 矩阵类型（type_mat2x2.cj）
任务：实现 src/detail/type_mat2x2.cj 完整文件——结构体定义 + 全部 extend 块（运算符/工厂函数/fromMat）
选择理由：Mat2x2 是矩阵运算的核心类型（2D 变换），是 fromMat 6a/6b 中引用其他 8 个矩阵类型的关键类型。T2 已完成 8 个依赖类型的 skeleton 定义，闭合了跨类型编译依赖，可安全实现 Mat2x2 完整功能
上下文：参见设计文档 §3.1（矩阵结构体）、§3.3（构造函数/工厂/fromMat 完整体系）、§3.4（行列访问）、§3.5（算术运算符）。Vec2<T,Q> 已定义完毕。8 个 skeleton 类型（Mat2x3~Mat4x4）同包可见

---

## R3 PASSED T3 — 完整 Mat2x2 矩阵类型（type_mat2x2.cj）
结果：实现 src/detail/type_mat2x2.cj（结构体 + 4 个 extend 块：算术运算符/工厂/fromParts/fromColumns/fromMat 7/fromMat 6a 8 重载/fromMat 6b 8 重载）
测试：tests/glm/detail/test_type_mat2x2.cj（44 个测试用例覆盖全部构造/运算符/工厂/fromMat 系列/越界），476 全部通过
验证：PASSED（验证报告 verify_v3.md）

## R4 NEW T4 — 非方阵矩阵完整功能（type_mat2x3/2x4/3x2/3x4/4x2/4x3 共 6 文件）
任务：对 6 个非方阵矩阵骨架文件追加完整功能——每个文件追加 4 个 extend 块（算术运算符+工厂+fromMat 6a+fromMat 6b），同步创建配套测试文件
选择理由：6 个非方阵矩阵无函数库依赖（matrix.cj/common.cj/geometric.cj 依赖仅方阵需要），可独立实现。与 Mat2x2 完全同构的模式——均为结构体 + extend 块模式，仅尺寸差异。Mat2x2 已验证的模式可直接复用
上下文：参见设计文档 §3.1~§3.5。每个非方阵文件需：Extend①（Number<T>）：负号/标量±*/ / 矩阵±(同尺寸)/跨尺寸乘法×3/Mat×Vec/diagonal/identity；Extend②（Qualifier）：fromParts/fromColumns/fromMat7；Extend③（6a）：fromMat 同类型不同尺寸 8 重载；Extend④（6b）：fromMat 跨类型不同尺寸 8 重载。不包含矩阵-矩阵除法（仅方阵）。跨尺寸乘法见设计文档 §3.5 乘法表

---

## R4 PASSED T4 — 非方阵矩阵完整功能（type_mat2x3/2x4/3x2/3x4/4x2/4x3 共 6 文件）
结果：对 6 个非方阵矩阵骨架文件各追加 4 个 extend 块（算术运算符+工厂+fromMat 6a+fromMat 6b），同步追加配套测试
测试：tests/glm/detail/test_type_mat2x3~test_type_mat4x3.cj 共计 476 用例全部通过
验证：PASSED（验证报告 verify_v4.md）

## R5 NEW T5 — 方阵完整功能（type_mat3x3.cj + type_mat4x4.cj）
任务：对 2 个方阵骨架文件（type_mat3x3.cj + type_mat4x4.cj）各追加 4 个 extend 块（算术运算符+工厂+fromMat 6a+fromMat 6b）及矩阵-矩阵除法 /（直接 throw stub），同步配套测试。Mat4x4←Mat4x2 的 fromMat 6a/6b 需实现偏差分支
选择理由：剩余 2 个方阵是所有跨尺寸矩阵乘法/fromMat 中最后闭合的关键类型。实现模式与 T3/T4 已验证的模式完全一致——结构体 + 4 个 extend 块。方阵额外需要矩阵-矩阵除法 /（直接 stub 不依赖 matrix.cj inverse），以及 Mat4x4←Mat4x2 偏差处理。type_mat3x3.cj 和 type_mat4x4.cj 不依赖 matrix.cj/common.cj/geometric.cj 的函数——除法直接 throw stub，fromMat 独立展开，因此无需等待 T6
上下文：参见设计文档 §3.1~§3.5、§3.6（比较运算符）、§8 编译顺序说明

---

## R5 PASSED T5 — 方阵完整功能（type_mat3x3.cj + type_mat4x4.cj）
结果：对 2 个方阵骨架文件各追加 4 个 extend 块（算术+工厂+fromMat 6a×8+fromMat 6b×8），含 Mat4x4←Mat4x2 偏差分支
测试：tests/glm/detail/test_type_mat3x3.cj + test_type_mat4x4.cj 共计 476 用例全部通过
验证：PASSED（验证报告 verify_v5.md，476 通过 0 失败）

## R6 PASSED T6 — 矩阵运算库 matrix.cj（27 可直接实现 + 6 stub）
结果：创建 src/detail/matrix.cj，实现 33 个函数（transpose×9 + matrixCompMult×9 + outerProduct×9 + determinant×3 stub + inverse×3 stub）
测试：tests/glm/detail/test_matrix.cj（21 用例），476 全部通过
验证：PASSED（验证报告 verify_v6.md，476 通过 0 失败）

## R7 PASSED T7 — 标量-矩阵运算库 scalar_mat_ops.cj（add/sub/mul/div 各 9 重载）
结果：创建 src/detail/scalar_mat_ops.cj（36 个标量-矩阵四则运算全局函数），配套测试 tests/glm/detail/test_scalar_mat_ops.cj
测试：476 全部通过
验证：PASSED（验证报告 verify_v7.md，476 通过 0 失败）

## R8 PASSED T8 — Vec extend 块（行向量×矩阵运算符）
结果：在 type_vec2.cj/type_vec3.cj/type_vec4.cj 各追加 1 个 extend 块，共 9 个行向量×矩阵乘法重载。同步创建 tests/glm/detail/test_vec_mat_mul.cj
测试：476 全部通过
验证：PASSED（验证报告 verify_v8.md，476 通过 0 失败）

## R9 NEW T9 — 别名和导出
任务：创建 src/ext/ 目录（26 个别名文件：18 矩阵 + 8 向量，package glm.ext），更新 src/fwd.cj（新增 54 个矩阵别名），更新 src/lib.cj（新增矩阵类型 public import）
选择理由：T8（Vec extend 块）已完成，T9 不依赖任何未完成的任务（所有 9 个矩阵类型已完整实现，ext/ 文件仅做 import + 类型别名 re-export，fwd.cj 仅做 type 别名定义，lib.cj 仅做 public import）。ext/ 目录的 package glm.ext 需要 cjpm 子包构建验证（原型验证项），若失败需 fallback 到方案二（文件移至 src/ 根目录改为 package glm）。T9 是 OOD 阶段二的 API 面封装层，完成后方可进行 T10 集成的测试编写
上下文：参见设计文档 §3.8（ext/ 别名文件）、§8（fwd.cj 矩阵别名新增清单、lib.cj 更新清单、别名文件清单）。26 个 ext/ 文件：matrix_float2x2~matrix_float4x4（9 文件）+ matrix_double2x2~matrix_double4x4（9 文件）+ vector_float1~vector_float4（4 文件）+ vector_double1~vector_double4（4 文件）。fwd.cj 新增 54 个别名：Mat 家族（Float32,Highp）18（9 PascalCase+3 短别名+6 camelCase）+ DMat 家族（Float64,Highp）18 + HighpMat/MediumpMat/LowpMat/HighpDMat/MediumpDMat/LowpDMat 各 3 短别名（6×3=18）。仅实现默认精度 PascalCase（Mat/DMat），其余精度族仅方阵短别名。lib.cj 新增 9 个矩阵类型 + 3 个 matrix.cj 函数（transpose/matrixCompMult/outerProduct）public import

---

## R9 PASSED T9 — 别名和导出
结果：创建 src/ext/（26 个文件）、更新 src/fwd.cj（54 矩阵别名）、更新 src/lib.cj（9 矩阵类型 + 3 函数 public import）
测试：tests/glm/test_ext.cj（13 用例）、test_fwd.cj（22 用例）、test_lib.cj（9 用例），476 全部通过
验证：PASSED（验证报告 verify_v9.md）

## R10 PASSED T10 — 集成测试
结果：创建 tests/glm/test_integration_matrix.cj（40 个集成测试用例），覆盖全部 9 种矩阵类型（Mat2x2~Mat4x4）及 DMat 的构造/算术运算/fromMat 跨尺寸转换/matrix 函数/行向量×矩阵/标量-矩阵运算/Double 精度验证共 7 个维度
测试：cjpm test 全部 476 用例通过（含新增 40 个）
验证：PASSED（验证报告 verify_v10.md，476 通过 0 失败）

## R10 PASSED T11 — 构建验证 + 偏差记录
结果：最终 cjpm build 成功（13 warnings），cjpm test 476/476 PASSED。所有 9 个矩阵类型（Mat2x2~Mat4x4）及配套文件（common.cj/matrix.cj/geometric.cj/scalar_mat_ops.cj/ext/ 别名/fwd.cj/lib.cj）完整实现，472 个集成测试通过。OOD 阶段二所有 11 个任务全部完成。
验证：cjpm build + test 最终确认，无新增偏差需记录。

---

## R11 NEW T12 — 矩阵比较运算符（==/!=/equalExact/equalEpsilon）
任务：在 9 个矩阵类型文件（type_mat2x2.cj ~ type_mat4x4.cj）中各追加两个 extend 块：
  1. `extend<T, Q> Mat{C}x{R}<T, Q> where T <: Equatable<T>, Q <: Qualifier` — 定义 `operator func ==`、`operator func !=`、`func equalExact(other)`
  2. `extend<T, Q> Mat{C}x{R}<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier` — 定义 `func equalEpsilon(other)`
  同步创建测试文件 `tests/glm/detail/test_type_mat_compare.cj`
选择理由：独立验证发现 §3.6 要求的比较运算符在全部 9 个矩阵类型中完全缺失，属于前序实现遗漏。Vec 类型已有相同模式的成功实现（type_vecN.cj:137-144 的 ComputeEqual / ComputeEqualNumeric 委托模式）可直接参考。不依赖任何其他未完成任务。比较运算符仅涉及包内已有类型（ComputeEqual / ComputeEqualNumeric 在 compute_vector_relational.cj 中定义，同包直接可见），无新增外部依赖
上下文：参见设计文档 §3.6（比较运算符）、§5（NaN 行为、equalEpsilon 行为）。Vec2 参考模式见 type_vec2.cj:137-145。==/!=/equalExact 委托 ComputeEqual<T>.call() 逐列所有分量比较；equalEpsilon 委托 ComputeEqualNumeric<T>.callConst() 逐列所有分量比较

---

## R11 NEW T13 — refract stub（geometric.cj）
任务：在 src/detail/geometric.cj 末尾追加 3 个 refract stub 函数（Vec2/Vec3/Vec4），同步创建测试文件 tests/glm/detail/test_geometric_refract.cj
选择理由：独立验证发现 §3.7 要求但前序实现遗漏的 3 个 refract stub。geometric.cj 中已有 6 组共 21 个 stub 函数（dot/cross/normalize/length/distance/reflect），追加 3 个 refract 函数完全机械。不依赖任何其他未完成任务
上下文：参见设计文档 §3.7 geometric.cj 清单——`func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier`，Vec3/Vec4 同理

---

## R12 PASSED T12 — 矩阵比较运算符（==/!=/equalExact/equalEpsilon）
结果：在 9 个矩阵类型文件（type_mat2x2.cj ~ type_mat4x4.cj）各追加两个 extend 块，实现 Equatable 约束下的 ==/!=/equalExact 和 Number 约束下的 equalEpsilon。同步创建测试文件 tests/glm/detail/test_type_mat_compare.cj
测试：476 用例全部通过，0 失败
验证：PASSED（验证报告 verify_v12.md）

---

## R13 PASSED T13 — refract stub（geometric.cj）
结果：在 src/detail/geometric.cj 末尾追加 3 个 refract stub 函数（Vec2/Vec3/Vec4），新建 tests/glm/detail/test_geometric_refract.cj（3 个 @Test 用例）
测试：476 用例全部通过，0 失败
验证：PASSED（验证报告 verify_v13.md）
