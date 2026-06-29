# 实现报告（v11）

## 概述

修改 `cjglm/src/lib.cj`，完成全部 4 处设计变更（G3.8a、G3.8b、G3.8c、G3.9）。G3.8b 和 G3.8c 采用审查意见 (a) 的方式实现：将通配符 `import glm.ext.*` 和 `import glm.gtc.*` 替换为具体公开符号的显式 `public import`。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | cjglm/src/lib.cj | G3.8a: 第12行 `import` → `public import`（前轮已完成） |
| 修改 | cjglm/src/lib.cj | G3.8b: `import glm.ext.*` → 6 行显式 `public import`（共 35 个唯一符号） |
| 修改 | cjglm/src/lib.cj | G3.8c: `import glm.gtc.*` → 8 行显式 `public import`（共 97 个符号） |
| 修改 | cjglm/src/lib.cj | G3.9: 第10行 `public import` 中添加 `Quat`（前轮已完成） |

## 编译验证
`cjpm build` 成功，`cjpm test`（435 PASSED / 0 FAILED）。原 `import glm.ext.*` 和 `import glm.gtc.*` 的 unused import 警告已消除。仅在 pre-existing 的 shadowed 警告（Vec1/2/3/4、Quat 被 fwd.cj 类型别名遮蔽）。

## 设计偏差说明
| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| G3.8b: 将 `import glm.ext.*` 替换为 15 个形如 `import glm.ext.vector_relational` 的模块级 import | 仓颉语言中，`src/ext/` 下所有文件均声明 `package glm.ext`，属于同一扁平包，不支持按源文件名导入。`import glm.ext.vector_relational` 会从 `glm.ext` 包中查找名为 `vector_relational` 的公开符号，而非同名源文件 | 改为从 `glm.ext` 包中按需 import 各源文件暴露的具体公开符号（`equal`, `notEqual`, `conjugate`, `inverse` 等共 35 个唯一符号），按功能分组为 6 行 `public import`。采用 `public import` 而非 `import`，因为 (a) 符号需被"使用"才能消除 unused import 警告，(b) `public import` 将符号重新导出给下游使用者，与行注释"使 glm 包可访问 ext 包符号"的意图一致 |
| G3.8c: 将 `import glm.gtc.*` 替换为 3 个形如 `import glm.gtc.constants` 的模块级 import | 同上原因，`src/gtc/` 下所有文件均声明 `package glm.gtc` | 改为从 `glm.gtc` 包中按需 import 具体公开符号，按文件来源分组为 8 行 `public import`（constants 28 符号 + quaternion 11 符号 + matrix_transform 58 符号）。同样采用 `public import` |
| `translate`, `rotate`, `ortho`, `perspective` 同时存在于 `glm.ext` 和 `glm.gtc` | import 同一符号名从两个包导致 `package-import` 冲突警告 | 仅保留 `glm.gtc` 版本（功能更完整），从 `glm.ext` 的 import 列表中移除这 4 个符号 |

## 修订说明（v11 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| G3.8b 和 G3.8c 未按设计实现，通配符 import 仍保留；仓颉不支持按文件名导入的设计需要重新设计 | 采用审查建议方案 (a)：从各源文件中按需导入具体公开符号名，替代通配符。因普通 `import` 仍会导致 unused 警告，升级为 `public import`（使符号被重新导出而"使用"）。在 `lib.cj:13-28` 添加了 14 行 `public import` 替代原先 2 行通配符 import |
