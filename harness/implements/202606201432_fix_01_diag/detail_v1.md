# 详细设计（v1）

## 概述

修复 `setup.cj` 中 7 个配置常量使用 `public let` 而非 `public const` 的编码疏忽，使其与 OOD 设计 §2 的要求一致。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/setup.cj` | 修改 | 将 7 个 `public let` 替换为 `public const` |

## 修改规格

### src/detail/setup.cj:3-9

**当前内容**（7 行 `public let`）：

```cangjie
public let GLM_VERSION_MAJOR: Int64 = Int64(1)
public let GLM_VERSION_MINOR: Int64 = Int64(0)
public let GLM_VERSION_PATCH: Int64 = Int64(3)
public let GLM_VERSION: Int64 = Int64(103)
public let GLM_CONFIG_SIMD: Bool = false
public let GLM_CONFIG_ALIGNED_GENTYPES: Bool = false
public let GLM_CONFIG_CLIP_CONTROL: Bool = false
```

**预期内容**（7 行 `public const`）：

```cangjie
public const GLM_VERSION_MAJOR: Int64 = Int64(1)
public const GLM_VERSION_MINOR: Int64 = Int64(0)
public const GLM_VERSION_PATCH: Int64 = Int64(3)
public const GLM_VERSION: Int64 = Int64(103)
public const GLM_CONFIG_SIMD: Bool = false
public const GLM_CONFIG_ALIGNED_GENTYPES: Bool = false
public const GLM_CONFIG_CLIP_CONTROL: Bool = false
```

**变更操作**：全文精确替换——第 3~9 行中 `public let` → `public const`，其余内容（`package` 声明行、空白字符、缩进、类型注解、初始化表达式）均保持不变。

## 类型定义

无新增类型。所有配置常量的名称、类型、初始值均保持不变。

## 错误处理

无变更。本任务不涉及错误处理逻辑。

## 行为契约

- `public const` 与 `public let` 在初始化表达式完全相同时，运行时行为一致
- `const` 提供编译期常量语义，允许编译器更多优化机会
- 所有对 `GLM_VERSION_*` / `GLM_CONFIG_*` 的引用仍保持兼容（通过名称引用，不受声明关键字影响）
- 现有测试 `setup_test.cj` 通过名称引用这些常量，不依赖其声明为 `let` 或 `const`，将继续通过

## 依赖关系

- 依赖：无（`setup.cj` 是包内最底层的文件，无任何依赖）
- 暴露：7 个 `public const` 配置常量，供同包（`glm.detail`）内其他文件引用
- 被依赖方：`qualifier.cj`、`type_vecN.cj` 等直接引用 `GLM_CONFIG_*` 的文件——无影响，常量名称和类型均不变

## 验证方式

1. 编译通过：`cjpm build` 成功
2. 测试通过：`cjpm test` 成功（`setup_test.cj` 继续通过）
