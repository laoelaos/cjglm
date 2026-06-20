# 审查范围界定

## 审查目标
对 `202606192149_ood_phase0` 分支（相对于 `main` 分支）的 GLM 仓颉迁移首轮代码变更进行代码审查。

## 审查依据
- `docs/02_ood_phase0.md` — GLM 1.0.3 仓颉迁移首轮 OOD 设计方案

## 审查重点
依据 OOD 设计文档逐项验证代码实现是否与设计一致：

1. **Qualifier 体系**：接口 + 空结构体实现；`internal` 可见性策略；`Defaultp` 别名
2. **Vec 结构体系**：数据成员声明；`const init` 构造函数；`length()` 静态函数；泛型参数 `T, Q` 用法
3. **构造函数体系**：逐分量 `const init`；跨类型转换 `init<T2,Q2>`；`VecN<Bool,Q>` 初始化；fill-from-Vec1 重载
4. **下标运算符 `[]`**：取值/赋值两种形式
5. **二元算术运算符**：`+`/`-`/`*`/`/`/`%`；`@OverflowWrapping` 标注；复合赋值自动生成
6. **位运算符**：`&`/`|`/`^`/`<<`/`>>` 在 extend 块中定义；`bitwiseNot()` 具名函数
7. **比较运算符**：`==` 通过 ComputeEqual；`!=` 定义为 `!(a == b)`
8. **`increment()`/`decrement()`**：具名函数替代 `++`/`--`
9. **`logicalAnd()`/`logicalOr()`**：替代 `&&`/`||`
10. **`mod()`**：具名函数替代 `%` 的浮点版本
11. **scalar_vec_ops**：add/sub/mul/div/mod(s, v) 包级函数
12. **compute_vector_relational**：ComputeEqual 实现
13. **type_fromBoolVec**：fromBoolVec / fromBoolVecQ2
14. **fwd.cj**：256 个 public type 别名的正确性（命名约定、无自引用歧义）
15. **lib.cj**：public import 重导出策略
16. **shim_*.cj**：断言、limits、cstddef 替代实现
17. **setup.cj**：配置常量
18. **测试覆盖**：单元测试是否覆盖了设计说明中的各类场景

## 审查排除范围
- `harness/` 目录（实施过程工件）
- `docs/` 中非设计文档的文件
- 非 `cjglm/` 目录下的变更

## 背景
本分支实现了 OOD Phase 0 的设计编码（v1~v10 共 10 个版本的渐进式实现），包含 GLM 核心基础设施层、Vec1~Vec4 向量类型系统、标量-向量运算、类型别名体系及其单元测试。
