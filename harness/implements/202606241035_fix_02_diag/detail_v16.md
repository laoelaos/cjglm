# 详细设计（v16）

## 概述

设计 T13 的验证方案：通过创建最小验证文件 `test_ext_alias.cj` 并执行 `cjpm build`，验证 `src/ext/` 下 26 个 `package glm.ext` 文件的子包路由机制是否正常。提供明确的模式 A（零侵入）→ 模式 B（回退——移至 `src/` 根目录）两级验证方案。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/ext/test_ext_alias.cj` | 新建 | 最小验证文件：声明 `package glm.ext` + 导出简单函数，用于验证子包编译和外部导入 |
| `cjpm.toml` | 维持不变 | 当前 `src-dir = "src"` 配置已足够，cjpm 自动发现子包（模式 A 无需修改） |
| `src/ext/*` (26 个文件) | 仅模式 B 时移动 + 修改 | 回退方案：移至 `src/`，`package glm.ext` → `package glm` |
| `tests/glm/test_ext.cj` | 仅模式 B 时更新 | 同步更新 `ext.*` 别名引用为直接类型名 |

**不做操作的文件**（仅模式 A 成功时）：
- `cjpm.toml` —— 无需任何修改
- `src/ext/` 下 26 个已有文件 —— 保持不变
- `tests/glm/test_ext.cj` —— 保持不变

## 类型定义

### test_ext_alias.cj（验证文件）
**形态**：源文件（非类型定义，仅验证文件）
**包路径**：`glm.ext`（对应目录 `src/ext/`）
**职责**：提供最小编译验证，确认 cjpm 正确发现 `src/ext/` 子包并编译 `package glm.ext`

**内容规格**：
```cangjie
package glm.ext

public func test_ext_alias(): Int64 {
    1
}
```

**可见性**：`public` 函数，可被外部项目通过 `import glm.ext.test_ext_alias.{ test_ext_alias }` 导入验证

## 验证方案

### 模式 A（优先尝试——零侵入）

**条件**：保持 `cjpm.toml` 当前配置（仅 `src-dir = "src"`）

**操作步骤**：
1. 在 `src/ext/` 下创建 `test_ext_alias.cj`（见上节内容规格）
2. 运行 `cjpm build`
3. 检查退出码是否为 0

**验证判定标准**：
- `cjpm build` 退出码为 0，无编译错误 → **模式 A 验证通过**
- 若报错（错误信息涉及 `package glm.ext` 未识别或子包路由失败） → 切换到模式 B

**确认步骤**：收到报错后，先在 cjpm 文档中搜索对应报错信息，确认确属子包路由问题（而非语法错误或导入路径问题），再切换到模式 B。

### 模式 B（回退方案——移至 `src/` 根目录）

**触发条件**：模式 A 下 `cjpm build` 失败，确认属子包路由问题

**操作步骤**：
1. 将 `src/ext/` 下的 26 个文件移至 `src/` 目录
2. 将每个文件中 `package glm.ext` 改为 `package glm`
3. 同步更新 `tests/glm/test_ext.cj`：
   - 将所有 `ext.*` 别名（如 `ext.Mat4x4`、`ext.Vec4`）替换为直接类型名（如 `Mat4x4`、`Vec4`）
   - 具体替换规则：`ext.` 前缀删除，后续类型名保持不变
   - 例如：`ext.Mat4x4` → `Mat4x4`，`ext.DMat2x2` → `DMat2x2`
   - 或：若该文件的验证目的已由其他测试覆盖，可删除该文件
4. 删除 `src/ext/test_ext_alias.cj`（验证文件的无意义导出函数不再需要）
5. 清理 `src/ext/` 目录（若为空则删除）

**验证判定标准**：
- `cjpm build` 退出码为 0，无编译错误
- `cjpm test` 退出码为 0（确认 `tests/glm/test_ext.cj` 的替换后测试仍通过）

### 外部项目验证（两种模式共用）

若模式 A 或模式 B 的 `cjpm build` 均通过，进一步验证外部导入：

1. 在 `cjglm/` 同级目录创建临时外部项目
2. 其 `cjpm.toml` 通过 `[dependencies]` 引入本地 `glm` 路径
3. 编写测试代码 `import glm.ext.test_ext_alias.{ test_ext_alias }` 并调用函数
4. 运行 `cjpm build`

**验证判定标准**：外部项目 `cjpm build` 退出码为 0，可成功导入并调用验证函数。

## 执行顺序

```
[开始] → 创建 test_ext_alias.cj → 运行 cjpm build
    ├── 成功 → [模式 A 验证通过，任务完成]
    └── 失败（子包路由错误） → [切换到模式 B]
         ├── 移动 26 个文件到 src/
         ├── 修改 package 声明
         ├── 更新 tests/glm/test_ext.cj
         ├── cjpm build
         │   ├── 成功 → cjpm test → [验证通过，任务完成]
         │   └── 失败 → [需要升级到独立子模块方案]
         └── 外部项目验证
```

## 错误处理

| 场景 | 处理方式 |
|------|---------|
| 模式 A 成功 | 任务完成，`test_ext_alias.cj` 保留作为验证产物 |
| 模式 A 失败（语法错误） | 修复语法问题，非路由问题，不应切换模式 |
| 模式 A 失败（子包路由） | 切换到模式 B |
| 模式 B 失败 | 标记为需要独立子模块方案（超出 T13 范围） |

## 依赖关系

- 依赖 `cjpm build` 命令可用
- 依赖 `cjpm test` 命令可用（仅模式 B）
- 依赖已有 `src/ext/` 下 26 个文件
- 依赖已有 `tests/glm/test_ext.cj`（仅模式 B 更新）
- 不依赖其他 T1~T19 任务
- 不修改任何已有生产代码（模式 A）或仅移动/修改包声明（模式 B），不影响其他任务
