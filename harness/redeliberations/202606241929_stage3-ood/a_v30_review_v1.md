# OOD 设计方案审查报告（v30）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** Quat<T,Q> 泛型结构体设计符合仓颉 struct 值语义规范，`T <: Number<T>` / `T <: FloatingPoint<T>` / `Q <: Qualifier` 三层泛型约束在仓颉泛型系统能力范围内。

**[通过]** `@Derive[Hashable]` 派生宏的使用与阶段一 Vec3、阶段二矩阵类型一致，`public var` 字段可见性标注满足派生宏要求。

**[通过]** extend 块定义的成员运算符（Quat×Vec3、Vec3×Quat 等）遵循仓颉左操作数类型决定运算符归属规则，正确区分成员运算符与全局函数（scalar_quat_ops.cj）的分工——标量左操作数场景通过全局函数实现。

**[通过]** 包级函数（type_quat_cast.cj）与 public import 重导出机制的配合设计，通过 D11 决策将转换函数下沉至 detail 包、gtc 包通过 `public import` 重导出，符合仓颉包模型约束（不允许循环依赖）。

**[通过]** `const init` 构造函数支持编译期求值，与阶段一/二 const 模式一致。

**[通过]** `const func` 对 conjugate 的声明可行性分析正确，参考阶段一 Vec 家族 27 个 const func 实践。

### 2. 标准库与生态覆盖

**[通过]** `std.math` 函数重载覆盖情况研究充分（Float16/Float32/Float64 三级重载确认），`radians`/`degrees` 不存在于 std.math 已明确标注。

**[通过]** `FloatingPoint<T>` 接口方法可用性已编译验证通过（v25 轮次），包括 6 个静态方法 + 3 个实例方法。

**[通过]** `Number<T>` / `FloatingPoint<T>` / `Comparable<T>` / `Equatable<T>` / `Hashable<T>` 等核心接口使用正确，约束层次合理。

**[通过]** ULP 浮点比较因仓颉无 `reinterpret_cast`/union 等价机制而标注为 stub，风险识别准确。

**[通过]** `@OverflowWrapping` 注解覆盖四元数算术运算符，与阶段一/二一致。

### 3. 语言特性可行性

**[通过]** 错误处理策略与仓颉模型一致：stub 函数统一使用 `throw Exception("stub")`，`lerp` 使用 `assert` 断言。

**[通过]** 包组织（`glm.detail` / `glm.ext` / `glm.gtc`）符合 cjpm 项目组织方式。gtc 子包的 cjpm 发现机制已标识为预验证项并有回退方案。

**[通过]** 包间依赖 DAG 严格单向（`glm.gtc → glm.detail`、`glm.ext → glm.detail`），无循环依赖（验证项 3/29 已通过）。

**[通过]** 并发设计段声明正确——值类型天然线程安全，本阶段不引入并发场景。

**[通过]** 资源管理模式无需特殊处理（值类型 + 纯算术运算）。

**[通过]** 一元 `+` 运算符不可重载、复合赋值运算符由编译器自动生成等仓颉约束已正确声明。

### 4. 设计一致性

**[通过]** 各抽象职责清晰：Quat 结构体承载四元数值、type_quat_cast.cj 承载矩阵-四元数转换、ext/ 和 gtc/ 子包分别承载扩展和标准扩展函数库。

**[通过]** 协作关系形成闭环且可追溯：§11.5 函数可用性对照表 + §11.6 四命名空间可达性矩阵 + §11.7 全函数集中参考索引形成三维追溯体系。

**[通过]** 模块间依赖方向合理：`glm.gtc → glm.detail` 单向、`glm.ext → glm.detail` 单向、`glm` 顶层聚合。

**[通过]** 行为契约完整：§5.3 边界条件表覆盖 20+ 种异常/边界场景（零四元数、非单位四元数、非旋转矩阵、反平行向量等）。

**[一般]** Vec3×Quat 和 Vec4×Quat 可用状态标注与实现依赖链不一致。§3.4 和 §11.5 将两者标记为 ✅ 可用，但实现链分析表明：Vec3×Quat 的公式 `(conjugate(q) / dot(q, q)) * v` 最终调用 Quat×Vec3 运算符（同文件内的 `*` 运算符重载），而 Quat×Vec3 依赖 geometric.cj 的 Vec3 叉乘 `cross`——该函数在阶段三为 stub，运行时抛 `Exception("stub")`。§3.4 实现链路注释明确写出"依赖链为... `Quat×Vec3` 运算符（同包）"，与 ✅ 状态标记矛盾。

- **原因**：设计正确识别了 v18 内联 conjugate/dot 路径可消除包间循环依赖，但未进一步评估该路径是否消除对 Vec3 cross stub 的运行时依赖。实质上，Vec3×Quat / Vec4×Quat 的运行时行为应与 Quat×Vec3 同为 ⚠️（编译通过但运行时抛 stub 异常），而非 ✅。

- **建议方向**：(a) 将 Vec3×Quat / Vec4×Quat 在本阶段的状态从 ✅ 修正为 ⚠️，与 Quat×Vec3 对齐；(b) §5.3 边界条件表补充条目说明 Vec3×Quat 和 Vec4×Quat 通过 Quat×Vec3 路径间接依赖 geometric.cj stub 的运行时行为；(c) §3.4 Vec extend 块运算符描述段在"实现链路注释"中明确运行时异常传播路径："编译通过，但运行时通过 Quat×Vec3 中间路径调用 geometric.cj 的 Vec3 cross stub，抛 Exception("stub")"；(d) §11.7.2 ⚠️/❌ 函数索引表中将 Vec3×Quat / Vec4×Quat 从 ✅ 表移至 ⚠️ 表；(e) §8.2 测试覆盖维度中补充 Vec3×Quat / Vec4×Quat 的 `assertThrows` 异常路径测试用例。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：Quat 结构体只负责四元数核心类型，type_quat_cast.cj 只负责转换函数，ext/ 和 gtc/ 库负责扩展函数。

**[通过]** 抽象层次恰当：18 个真完整函数构成四元数基本数学骨架，88 个 stub 函数为阶段四预留签名空间，不过度设计也不设计不足。

**[通过]** 设计便于单元测试：✅/⚠️/❌ 三档分类清晰标识测试策略，§8.2 设计了 14 个测试文件 ≥192 用例、逐函数测试映射模板和抽样策略。

**[通过]** 与迭代需求的响应充分度良好：本轮 10 个问题（3 严重 + 6 一般 + 1 建议）的修改措施已全部落实于正文对应位置。

**[通过]** 跨 Qualifier 行为统一契约（§5.6）有效解耦了 40+ 个泛型函数与跨 Qualifier 场景的逐点声明负担。

**[通过]** API 可用率增长路线图（§3.16 末尾）和 P0/P1/P2 优先级排序为阶段四提供了可执行的实施规划。

## 修改要求（REJECTED 时存在）

### 问题 1（一般）：Vec3×Quat / Vec4×Quat 可用状态与实现依赖链不一致

- **问题**：§3.4 和 §11.5 将 Vec3×Quat / Vec4×Quat 标记为 ✅ 可用，但其实现链经由 `(conjugate(q) / dot(q, q)) * v` 调用 Quat×Vec3 运算符，Quat×Vec3 依赖 geometric.cj 的 Vec3 cross（阶段三 stub），运行时实际抛 `Exception("stub")`。§3.4 v18 实现链路注释明确写出依赖链包含 `Quat×Vec3` 运算符，与 ✅ 状态矛盾。

- **原因**：设计正确解决了包间循环依赖（v18 内联 conjugate/dot 路径），但未进一步分析该路径是否消除对 Vec3 cross stub 的运行时依赖。内联 conjugate/dot 只消除了 `glm.detail → glm.ext` 的跨包 import 需求，未改变 `Quat×Vec3` 运算符内部对 geometric.cj Vec3 cross 的调用。

- **建议方向**：
  1. 将 Vec3×Quat / Vec4×Quat 的本阶段状态从 ✅ 修正为 ⚠️（编译通过但运行时抛 stub 异常），与 Quat×Vec3 一致对齐
  2. §5.3 边界条件表补充条目说明 Vec3×Quat / Vec4×Quat 通过 Quat×Vec3 依赖 geometric.cj 的校验
  3. §3.4 Vec extend 块运算符描述段的"实现链路注释"中明确运行时异常传播路径
  4. §11.7.2 ⚠️/❌ 函数索引表将 Vec3×Quat / Vec4×Quat 从 ✅ 表移至 ⚠️ 表
  5. §8.2 测试覆盖维度中补充 Vec3×Quat / Vec4×Quat 的 `assertThrows` 异常路径测试用例
  6. §3.13.2 审计表补充 Vec3×Quat / Vec4×Quat 行（当前仅列出 Quat×Vec3/Vec4）
  7. §1.2 阶段三用户能力视图中将 Vec3×Quat / Vec4×Quat 从 ✅ 改为 ⚠️ 并注明降级路径
  8. §11.5 函数可用性对照表合计行 ⚠️ 计数从 2 个更新为 4 个（Quat×Vec3 / Quat×Vec4 / Vec3×Quat / Vec4×Quat），并相应更新合计行 ❌ 计数
  9. §9a 覆盖矩阵中 `type_quat.hpp` 行 ✅ 计数从 16 修正为 14，⚠️ 计数从 1 修正为 3
  10. 同步更新 §1 表格行 ✅ 和 ⚠️ 计数以及 §3.13.2 审计结论段落中 ✅ 函数计数
