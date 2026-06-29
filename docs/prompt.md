## 范围

启动再审议框架，通用模式，执行如下任务：

我想用另一门语言重新实现
@/references/glm-1.0.3
你先帮我确定一下这个项目中哪些类型是比较基础的，应该首先被迁移的，且迁移的范围是比较合适的。
你只需要确定范围就可以，不要开展具体的设计和实现工作。

## OOD

### 阶段一
启动再审议框架，执行OOD流程，不使用initial_artifact模式，完成如下任务：

我要把 @references\glm-1.0.3 用仓颉重新实现。接下来计划迁移 @docs\01_roadmap.md 中的首轮，你来做本次迁移的OOD

在流程启动阶段，不要尝试读取文档和代码，直接开始
### 修复历史
@Harness\redeliberations\202606200218_phase1-ood\iteration_history.md 修复可能的乱码，添加可能缺失的迭代轮次记录，之后从a组件输出读取修改结果为每个记录添加修改结果
### 阶段一ia
启动再审议框架，执行OOD流程，使用initial_artifact模式，导入 @harness\redeliberations\202606170050_glm-migration-ood\a_v15_design_v1.md 完成如下任务：

上一轮OOD再审议迭代流程的历史记录：@harness\redeliberations\202606170050_glm-migration-ood\iteration_history.md
我要把 @references\glm-1.0.3 用仓颉重新实现。接下来计划迁移 @docs\01_roadmap.md 中的首轮，你来做本次迁移的OOD

在流程启动阶段，不要尝试读取文档和代码，直接开始
### 后续阶段
启动再审议框架，执行OOD流程，不使用initial_artifact模式，完成如下任务：

我要把：@references\glm-1.0.3 用仓颉重新实现。
实现路线图：@docs\02_roadmap.md，现已经实现了阶段一，项目在：@cjglm
在：@docs 中有技术决策依据文档、仓颉限制导致的实现偏差文档、之前阶段的OOD文档
接下来计划迁移阶段二，你来做本次迁移的OOD

在流程启动阶段，不要尝试读取文档和代码，直接开始
### 后续阶段ia
启动再审议框架，执行OOD流程，使用initial_artifact模式，导入 @docs\04_ood_phase2.md 完成如下任务：

我要把：@references\glm-1.0.3 用仓颉重新实现。
实现路线图：@docs\02_roadmap.md，现已经实现了阶段一，项目在：@cjglm
在：@docs 中有技术决策依据文档、仓颉限制导致的实现偏差文档、之前阶段的OOD文档
接下来计划迁移阶段二，你来做本次迁移的OOD
之前轮次OOD再审议迭代流程的历史记录：
@harness\redeliberations\202606210006_OOD_stage2_migration\iteration_history.md
harness\redeliberations\202606221209_OOD_stage2_migration_v2\iteration_history.md

在流程启动阶段，不要尝试读取文档和代码，直接开始

## 实现

### ood实现
启动审议式实现流程，完成：

@docs\04_ood_phase2.md该OOD设计
项目根目录应为：@cjglm，文档在：@docs，参考项目在：@references\glm-1.0.3
项目实施历史中因仓颉限制导致的实施偏差在：@docs\deviations.md
需要提示 Agent 本次实施中的偏差需要依据偏差文档开头的指示添加到相应位置。
在启动 Plan Agent 时候需要提示其需要在 plan.md 开头添加详细的实施路线表格，之后每次进展打勾确认

在流程启动阶段，不要尝试读取文档和代码，直接开始
### 修复问题
启动审议式实现流程，完成：

修复 @docs\diag\impl\02_diag.md 该审议文件中的问题，
项目根目录应为：@cjglm，OOD文档：@docs\02_ood_phase0.md，参考项目在：@references\glm-1.0.3
项目实施历史中因仓颉限制导致的实施偏差在：@docs\deviations.md
本次实施中的偏差需要依据偏差文档开头的指示添加到相应位置。
在启动 Plan Agent 时候需要提示其需要在 plan.md 开头添加详细的实施路线表格，之后每次进展打勾确认

在流程启动阶段，不要尝试读取文档和代码，直接开始

## 代码审查

### 审查
启动审议式代码审查流程，从当前分支到main分支：
依据：@docs\04_ood_phase2.md 该OOD设计。
可以参考路线图：@docs\02_roadmap.md，偏差说明：@docs\deviations.md
自行决定需要启动多少轮，每次并行启动3个agent，每个agent执行一轮，直到完成。
### 整理
将所有的的 review_v{*}.md 文件中的严重和一般问题整理到 todo.md 中
你需要保留题目、位置、描述，忽略其中的建议。

## 问题定位

### 首轮
启动再审议框架，执行问题定位流程，不要进入initial_artifact模式，定位：

@harness\reviews\202606271542_glm_phase3_review\todo.md
其中的问题，是真实存在？误报？还是OOD文档存在着矛盾、偏差、不完善或是错误？抑或是其他问题？
实现偏差注明文档：@docs\deviations.md，OOD文档：@docs\02_ood_phase0.md，
该OOD设计所实现的项目：@cjglm，该项目是参考项目：@references\glm-1.0.3 的迁移实现。
你只需要输出问题定位的结果以及修改的流程和建议。

在启动流程的过程中，不要尝试阅读文档，直接启动流程。
### 首轮2
启动再审议框架，执行问题定位流程，不要进入initial_artifact模式，定位：

@harness\reviews\202606231847_ood_phase2_review\todo.md 其中的问题
实现偏差注明文档：@docs\deviations.md，OOD文档：@docs\04_ood_phase2.md，
该OOD设计所实现的项目：@cjglm，该项目是参考项目：@references\glm-1.0.3 的迁移实现。

在启动流程的过程中，不要尝试阅读文档，直接启动流程。
### 修复历史
@Harness\redeliberations\202606200218_phase1-ood\iteration_history.md 修复可能的乱码，添加可能缺失的迭代轮次记录，之后从a组件输出读取修改结果为每个记录添加修改结果