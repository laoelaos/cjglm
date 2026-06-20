# 任务指令（v1）

## 动作
NEW

## 任务描述
修复 `docs/diag/impl/01_diag.md` #3 — setup.cj 配置常量使用 `public let` 而非 `public const`

文件路径：`C:\Develop\Software\cjglm_wp\cjglm\src\detail\setup.cj`
预期修改：将第 3~9 行的 7 个 `public let` 逐一替换为 `public const`。

## 选择理由
- 最简单的修复任务，不依赖其他任何任务
- 快速验证任务管线（plan→task→code→verify）全线畅通
- OOD 设计 §2 明确要求 `setup.cj` "仅包含 `const` 配置常量"
- 无运行时行为差异，零风险

## 任务上下文
诊断项 #3 原文：
> **位置**：`cjglm/src/detail/setup.cj:3-9`
> **根因**：OOD 设计 §2 明确指定 `setup.cj`"仅包含 `const` 配置常量"，§2.1 依赖拓扑澄清也重申"`setup.cj` 仅包含 `const` 配置常量"。当前 7 个配置项全部使用 `public let`，但初始化表达式均为字面量（`Int64(1)`、`false`、`Int64(103)` 等），语法上完全可替换为 `public const`。此偏差未在 `deviations.md` 中记录——既非仓颉语言限制，也非设计阶段已知偏差。属编码阶段的疏忽。
> **修复提示**：将 7 个 `public let` 逐一替换为 `public const`，所有初始值均为合法的 const 表达式

## 已有代码上下文
当前 `setup.cj` 内容（7 个配置常量全部使用 `let`）：

```cangjie
package glm.detail

public let GLM_VERSION_MAJOR: Int64 = Int64(1)
public let GLM_VERSION_MINOR: Int64 = Int64(0)
public let GLM_VERSION_PATCH: Int64 = Int64(3)
public let GLM_VERSION: Int64 = Int64(103)
public let GLM_CONFIG_SIMD: Bool = false
public let GLM_CONFIG_ALIGNED_GENTYPES: Bool = false
public let GLM_CONFIG_CLIP_CONTROL: Bool = false
```

预期修改后：

```cangjie
package glm.detail

public const GLM_VERSION_MAJOR: Int64 = Int64(1)
public const GLM_VERSION_MINOR: Int64 = Int64(0)
public const GLM_VERSION_PATCH: Int64 = Int64(3)
public const GLM_VERSION: Int64 = Int64(103)
public const GLM_CONFIG_SIMD: Bool = false
public const GLM_CONFIG_ALIGNED_GENTYPES: Bool = false
public const GLM_CONFIG_CLIP_CONTROL: Bool = false
```

## 验证方式
1. 编译通过：`cjpm build` 成功
2. 测试通过：`cjpm test` 成功（现有测试 `setup_test.cj` 应继续通过）
