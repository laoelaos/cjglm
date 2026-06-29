# 代码审查报告（v11 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `cjglm/src/lib.cj` — G3.8b 和 G3.8c 未按设计实现。设计要求将 `import glm.ext.*` 展开为 15 个显式模块 import、`import glm.gtc.*` 展开为 3 个显式模块 import，但实际代码中两者仍保持通配符 import 原样。实现报告声称仓颉语言包机制不支持 `import glm.ext.vector_relational` 这种按文件名的导入语法（因为同一包下的文件共享 package 声明，只能导入声明名而非文件名），故回退了变更。这一偏差导致设计目标（消除 17 个 unused import 警告）未能达成。

## 修改要求

1. **`cjglm/src/lib.cj:14,16`** — G3.8b 和 G3.8c 未实施。设计指定用显式模块 import 替换通配符 import，但仓颉语言不支持按源文件路径导入同一包的模块（`vector_relational` 不是包 `glm.ext` 中的公开声明名）。期望方向：重新设计方案，例如 (a) 从各模块中按需导入具体公开符号名 `(func1, func2, ...)` 替代通配符，或 (b) 使用 `-Woff unused-import` 编译器选项抑制警告，或 (c) 调整模块内部结构使显式导入语法可行。
