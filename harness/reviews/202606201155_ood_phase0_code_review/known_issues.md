# 已知但暂不解决的问题

### K1 == 使用精确比较而非 Epsilon 容差比较
- **位置**: `type_vec1~4.cj`（`==` 运算符）
- **描述**: 代码使用 `ComputeEqual<T>.call`（精确 `a == b`），而 OOD 设计 §3.5/§4.5 的完整方案要求在 `==` 中通过 `ComputeEqual.callConst` 对浮点 T 使用 Epsilon 容差比较。但 IEEE 754 精确相等语义与 C++ GLM 1.0.3 的 `==` 行为一致，且容差比较是"仓颉迁移新增的全量行为偏离"。当前精确比较在功能正确性上可接受，待设计确认是否实际需要 Epsilon 路径后再决定是否调整。
- **影响**: 浮点 Vec 的 `==` 使用精确相等而非近似相等；用户需显式调用 `equalEpsilon()` 获取容差比较
- **建议**: 待设计团队确认 Epsilon 容差 `==` 是否为必要行为

### K2 shim_limits.cj 函数签名从 const 无参改为 hint 参数
- **位置**: `cjglm/src/detail/shim_limits.cj`
- **描述**: 设计 §3.5 原型为 `const func isIec559Of<T>(): Bool`（无参，const），实际实现为 `public func isIec559Of<T>(hint: T): Bool`（带实例参数，非 const）。此改动使编译期 `if` 分支中无法调用该函数。若未来需要编译期分支，需同步改造。
- **建议**: 待 §2.1 项③（`isIec559Of` 核心依赖验证）的验证结果确定后再决定是否恢复 const 版本

### K3 ComputeEqual.callConst 拆分到 ComputeEqualNumeric
- **位置**: `cjglm/src/detail/compute_vector_relational.cj`
- **描述**: 设计原文同时包含 `call` 和 `callConst` 在 `ComputeEqual<T>` 中，实际代码将 `callConst` 独立为 `ComputeEqualNumeric<T>`（追加 `Comparable<T>` 约束）。此拆分源于手动实现 abs 需要 `<` 比较符。
- **建议**: 若编译器验证通过且设计确认 const 路径可行，合回；否则确认当前拆分方案为正式设计
