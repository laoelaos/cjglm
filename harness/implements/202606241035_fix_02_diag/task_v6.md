# 任务指令（v6）

## 动作
NEW

## 任务描述
在 `type_mat2x2.cj` 中将构造函数声明顺序从 `init(scalar)`→`const init(逐分量)`→`const init(列向量)` 调整为 `const init(逐分量)`→`const init(列向量)`→`init(scalar)`，与其他 8 个矩阵类型一致。

### 当前顺序（type_mat2x2.cj）
| 行号 | 当前顺序 | 签名 |
|------|---------|------|
| 11-14 | 1. `init(scalar: T)` | `public init(scalar: T) { ... }` |
| 16-19 | 2. `const init(逐分量)` | `public const init(a00: T, a01: T, a10: T, a11: T) { ... }` |
| 21-24 | 3. `const init(列向量)` | `public const init(c0: Vec2<T, Q>, c1: Vec2<T, Q>) { ... }` |

### 目标顺序（与其他 8 个矩阵类型一致）
| 序号 | 签名 | 说明 |
|------|------|------|
| 1. | `const init(逐分量)` | `public const init(a00: T, a01: T, a10: T, a11: T)` |
| 2. | `const init(列向量)` | `public const init(c0: Vec2<T, Q>, c1: Vec2<T, Q>)` |
| 3. | `init(scalar: T)` | `public init(scalar: T)` |

## 选择理由
Phase 4 路线表顺序（第 7 项），操作简单明确（仅调整文件中 3 个构造函数块声明顺序，不涉及行为或测试变更），是当前优先级最高的未完成任务。T3（R5）已验证通过。

## 任务上下文
- 诊断报告 §3 T7-cs 已精确定位不一致
- 其余 8 个矩阵类型顺序均为 `const init(逐分量)` → `const init(列向量)` → `init(scalar)`
- 仓颉函数重载解析与声明顺序无关，不引发编译错误，仅为风格一致性调整
- 仅操作 `type_mat2x2.cj` 一个文件

## 已有代码上下文
- 参考文件 `type_mat2x3.cj:11-24`、`type_mat3x3.cj:12-28` 等展示目标顺序
- `type_mat2x2.cj` 位于 `cjglm/src/detail/type_mat2x2.cj`
- 项目根目录：`C:\Develop\Software\cjglm_wp\cjglm`
