# 计划审查报告（v16 r1）

## 审查结果
REJECTED

## 发现

### [一般] Mode B `package-configuration` 语法与 cjpm 文档不一致

Plan R16 NEW T13 的 Mode B 指定如下配置：
```toml
[package.package-configuration]
sub-package = ["ext"]
```
但 cjpm 文档 §6.5 中的 `package-configuration` 是一个子包名→编译选项的映射表：
```toml
package-configuration = { "myapp.utils" = { compile-option = "-O2" } }
```
文档中不存在 `sub-package` 字段。若 Mode A（自动发现）失败，Implementer 将基于此错误语法尝试 Mode B，导致额外排查时间或配置被 cjpm 忽略。应删除或修正 Mode B 配置方案，或者核实 cjpm 实际支持的子包注册机制。

### [轻微] Mode C 降级方案未提及测试文件影响

若 Mode C（移至 `src/`）被触发，26 个文件从 `package glm.ext` 改为 `package glm` 后，`tests/glm/test_ext.cj` 中使用的 `ext.Mat4x4`、`ext.Vec4` 等子包别名将无法解析，该文件会编译失败。Plan 应补充说明此情景下需同步更新 `tests/glm/test_ext.cj`。

## 修改要求（REJECTED）

### 必须修正的问题

**问题 1：Mode B `package-configuration` 中 `sub-package` 字段无文档支持**

- **问题**：Plan 指定 `sub-package = ["ext"]` 作为 cjpm 子包注册配置，但 cjpm 文档 §6.5 仅展示了 `package-configuration` 作为子包→编译选项的映射表，不存在 `sub-package` 字段。
- **为什么是问题**：如果 Mode A 失败（即 cjpm 未自动发现 `src/ext/` 为 `glm.ext` 子包），Implementer 将使用错误的配置语法，浪费排查时间且无法解决问题。目前没有证据表明 cjpm 支持此类配置。
- **修正方向**：方案 A：删除 Mode B，将 Mode C 提升为次选方案（因为自动发现是 cjpm 唯一文档化的子包机制）。方案 B：在有确定文档/实测证据的前提下，修正为正确的 cjpm 子包声明语法。

### 应当修正的问题

**问题 2：Mode C 未提及对 `tests/glm/test_ext.cj` 的影响**

- **问题**：Mode C 提到"调整内部导入路径"但未覆盖测试文件中的 `ext.*` 别名引用。
- **为什么是问题**：执行 Mode C 后执行 `cjpm test` 会因 `ext.*` 无法解析而失败，导致验证不完整。
- **修正方向**：在 Mode C 中补充：将 `tests/glm/test_ext.cj` 中的 `ext.*` 别名替换为直接引用，或删除该文件（如果其验证目的已由其他测试覆盖）。
