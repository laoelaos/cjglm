# 详细设计（v6）

## 概述

修复 G2.1：修正 `quaternion_common.cj:40` 中 `slerp` 4 参数签名的第 4 参数类型，从 `spin: Bool` 改为 `k: Int64`，使与 OOD §3.11 / D22 决策一致。因当前函数体为 `throw Exception("stub")`，保持 stub 状态不变。在测试文件中追加 3 个 `@Test` 用例覆盖该签名，验证 stub 异常路径。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/ext/quaternion_common.cj:40` | 修改 | `slerp` 第 4 参数 `spin: Bool` → `k: Int64` |
| `cjglm/tests/glm/ext/quaternion_common_test.cj:101` 后 | 追加 | 添加 3 个 `@Test` 用例：`testSlerp4ArgsK0`、`testSlerp4ArgsK1`、`testSlerp4ArgsKMinus1` |

## 签名变更

### 当前签名（line 40-41）
```cangjie
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

### 目标签名
```cangjie
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

**变更项**：参数名 `spin` → `k`，参数类型 `Bool` → `Int64`。函数体及 `where` 约束不变。

## 类型定义

本次任务不涉及类型定义变更。

## 错误处理

本次任务不涉及错误处理变更。函数体仍为 `throw Exception("stub")`，3 个新增测试均通过 `@ExpectThrows[Exception]` 验证。

## 行为契约

### 前置条件
- `quaternion_common.cj:40` 当前签名为 `spin: Bool`，函数体为 `throw Exception("stub")`
- `quaternion_common_test.cj:101` 为 `testSlerpStub` 函数末尾
- 无现有 4 参数 `slerp` 调用点（grep 扫描 `slerp(.*,.*,.*,` 结果为空）

### 后置条件
- `cjpm build` 编译通过（0 errors）
- `cjpm test` 全部 438+ PASSED / 0 FAILED（新增 3 个测试通过）
- `quaternion_common.cj:40` 签名为 `k: Int64`
- `quaternion_common_test.cj` 末尾包含 `testSlerp4ArgsK0`、`testSlerp4ArgsK1`、`testSlerp4ArgsKMinus1`

### 注意事项
- 无参数名引用被破坏（无现有调用点）
- 无需修改诊断文档 `03_diag.md`（修复后签名即与 OOD 一致）
- 无需修改偏差记录 `deviations.md`

## 依赖关系

- 不引入新依赖
- `Int64` 为仓颉内置类型，无需额外 import
