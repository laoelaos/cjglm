# 详细设计（v1）

## 概述

修复 `test_integration_matrix.cj:338-341` 中 `testIntegrationFromMatDeviation` 测试函数的 4 个 `@Expect` 断言预期值，使其与 OOD §3.3 声明的 DEVIATION 行为一致，并补充缺失的列向量分量断言以完全对齐单元测试。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/tests/glm/test_integration_matrix.cj` | 修改 | 修正 `testIntegrationFromMatDeviation` 的预期断言值 |

## 变更说明

### 待修改函数：`testIntegrationFromMatDeviation`（第 330-344 行）

**问题**：`Mat4x4.fromMat(Mat4x2, one)` 的 DEVIATION 行为丢弃源矩阵列 2/3 的前两行数据，但集成测试错误地预期保留这些值。

**根因**：OOD §3.3 规定 `Mat4x4←Mat4x2` 为 DEVIATION 转换，实现（`type_mat4x4.cj:235-239` 6a、`:287-291` 6b）正确构建列 2 为 `Vec4(zero, zero, one, zero)`、列 3 为 `Vec4(zero, zero, zero, one)`。但集成测试编写时未考虑 DEVIATION，直接按"主规则"构造了保留源数据的预期值。

### 具体修改点

| 行号 | 当前值 | 修改为 | 依据 |
|------|--------|--------|------|
| 338 | `@Expect(m44.c2.x, Float32(5.0))` | `@Expect(m44.c2.x, Float32(0.0))` | DEVIATION：列 2 前两行丢弃 |
| 339 | `@Expect(m44.c2.y, Float32(6.0))` | `@Expect(m44.c2.y, Float32(0.0))` | DEVIATION：列 2 前两行丢弃 |
| 340 | `@Expect(m44.c3.x, Float32(7.0))` | `@Expect(m44.c3.x, Float32(0.0))` | DEVIATION：列 3 前两行丢弃 |
| 341 | `@Expect(m44.c3.y, Float32(8.0))` | `@Expect(m44.c3.y, Float32(0.0))` | DEVIATION：列 3 前两行丢弃 |

### 新增断言

在与修改后的列 2/3 断言相邻的位置，补充以下断言以完全对齐单元测试 `test_type_mat4x4.cj:645-652`：

| 插入位置 | 断言 | 依据（单元测试行） |
|---------|------|-------------------|
| 原 342 行后 | `@Expect(m44.c2.z, Float32(1.0))` | `:647` |
| 紧跟上方 | `@Expect(m44.c2.w, Float32(0.0))` | `:648` |
| 紧跟上方 | `@Expect(m44.c3.z, Float32(0.0))` | `:651` |

说明：`c3.w=1.0` 的断言已在原第 343 行存在，无需重复添加。

### 修改后函数签名

```cangjie
@Test
func testIntegrationFromMatDeviation(): Unit {
    let src = Mat4x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let m44 = Mat4x4.fromMat(src, Float32(1.0))
    @Expect(m44.c0.x, Float32(1.0))
    @Expect(m44.c0.y, Float32(2.0))
    @Expect(m44.c1.x, Float32(3.0))
    @Expect(m44.c1.y, Float32(4.0))
    @Expect(m44.c2.x, Float32(0.0))
    @Expect(m44.c2.y, Float32(0.0))
    @Expect(m44.c3.x, Float32(0.0))
    @Expect(m44.c3.y, Float32(0.0))
    @Expect(m44.c0.z, Float32(0.0))
    @Expect(m44.c2.z, Float32(1.0))
    @Expect(m44.c2.w, Float32(0.0))
    @Expect(m44.c3.z, Float32(0.0))
    @Expect(m44.c3.w, Float32(1.0))
}
```

## 错误处理

不涉及——仅修改测试预期值，无错误处理逻辑变更。

## 行为契约

- 修改后测试应通过 `cjpm test` 运行
- 修改后的预期值与 `test_type_mat4x4.cj:633-653`（6a 单元测试）的预期值逻辑一致
- 与 `type_mat4x4.cj:235-239`（6a 实现）和 `:287-291`（6b 实现）的 DEVIATION 行为一致

## 依赖关系

- **依赖实现**：`type_mat4x4.cj:235-239`（`Mat4x4.fromMat(Mat4x2, one)` 6a 变体）
- **参考单元测试**：`test_type_mat4x4.cj:633-653`（6a 单元测试）和 `:837-857`（6b 单元测试）
- **诊断依据**：`docs/diag/impl/02_diag.md` §1 T5
