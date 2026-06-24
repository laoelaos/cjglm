# 任务指令（v16）

## 动作
NEW

## 任务描述
**T13**: 提供 cjpm 子包构建的显式验证产物。

验证 `src/ext/` 下 26 个 `package glm.ext` 文件的子包路由机制是否正常，提供显式的构建验证产物。操作步骤包括：

1. **创建验证文件**：在 `src/ext/` 下创建最小测试文件 `test_ext_alias.cj`，内容为 `package glm.ext` 声明 + 一个简单导出函数（如 `public func test_alias(): Int64 { 1 }`），用于验证编译和外部导入。

2. **模式 A（唯一方案——零侵入，依赖 cjpm 自动发现）**：保持 `cjpm.toml` 当前配置（仅 `src-dir = "src"`），运行 `cjpm build`。cjpm 根据目录结构自动将 `src/ext/` 解析为 `glm.ext` 子包（参见仓颉包名解析规则），无需额外配置。若 `cjpm build` 通过，则验证完成。

3. **模式 B（回退方案——移至 src/ 根目录）**：若模式 A 失败（即 cjpm 未自动发现 `src/ext/` 子包），执行以下操作：
   - 将 `src/ext/` 下的 26 个文件移至 `src/`，"package glm.ext" 改为 "package glm"，更新内部导入路径
   - **同步更新 `tests/glm/test_ext.cj`**：该文件中所有 `ext.*` 别名（如 `ext.Mat4x4`、`ext.Vec4`）需替换为直接类型名（如 `Mat4x4`、`Vec4`），或删除该文件（若其验证目的已由其他测试覆盖）

4. **验证判定**：`cjpm build` 退出码为 0，无编译错误。若执行模式 B，还需 `cjpm test` 通过。

## 选择理由
所有其他任务已完成并验证通过（T1~T12、T14~T19 全部 PASSED）。T13 是 Route 表格中最后一个剩余任务，操作 `cjpm.toml` + `src/ext/` 构建流程，与其他任务无文件冲突。

## 任务上下文
- 诊断报告 §5 T13（02_diag.md `:541-608`）：完整的根因分析及验证方案
- `cjpm.toml` 当前配置：仅 `src-dir = "src"`，无 `package-configuration` 相关配置
- `src/ext/` 下 26 个文件（18 matrix + 8 vector）统一声明 `package glm.ext`，依赖 `import glm.detail.*`
- `tests/glm/test_ext.cj` 已存在（包含 16 个使用 `ext.*` 别名的 `@Test` 用例），但位于 `tests/glm/` 而非 `src/ext/`，不验证外部项目导入场景
- 仓颉包声明规则：目录名须与包名匹配（`package/README.md §2.1`）
- **请查阅当前版 cjpm 文档**确认子包路由机制

## 已有代码上下文
- `cjpm.toml` 路径：`C:\Develop\Software\cjglm_wp\cjglm\cjpm.toml`
- `src/ext/` 目录：`C:\Develop\Software\cjglm_wp\cjglm\src/ext/`
- 已有引用：`tests/glm/test_ext.cj` 验证了同一项目测试域内的 `ext.*` 包别名解析
- `cjpm build` 构建验证命令

---

## 修订说明（v16 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| Mode B `sub-package` 字段无 cjpm 文档支持 | 删除 Mode B（显式 `sub-package` 声明）。保留唯一方案 Mode A（cjpm 自动发现），Mode C 提升为唯一回退方案。cjpm 文档 `package-configuration` 仅用于子包编译选项（如 `output-type`、`compile-option`），不存在 `sub-package` 字段 |
| Mode C 未提及 `tests/glm/test_ext.cj` 中 `ext.*` 别名的同步处理 | 在 Mode C 中补充：同步更新 `tests/glm/test_ext.cj`，将 `ext.*` 别名替换为直接类型名，或删除该文件；验证步骤增加 `cjpm test` 检查 |
