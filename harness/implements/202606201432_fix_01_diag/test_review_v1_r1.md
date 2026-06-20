# 测试审查报告（v1 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `src/detail/setup_test.cj:46-48` — 测试专用常量 `GLM_NOT_SIMD`、`GLM_NOT_ALIGNED`、`GLM_NOT_CLIP` 声明为 `public const`，但该文件位于 `src/` 目录下（见 `cjpm.toml` 中 `src-dir = "src"`），编译后成为 `glm.detail` 包的公开 API 的一部分，造成测试产物污染生产包命名空间。

- **[一般]** `tests/glm/detail/test_setup.cj` — 该测试文件仅包含基本的取值验证（7 个常量的值检查），未覆盖 `const` 编译期语义（如组合表达式、类型兼容性、交叉引用一致性），与 `src/detail/setup_test.cj` 的完整测试集不一致。作为独立的测试套件，其覆盖范围不足。

## 修改要求

### 问题 1：`src/detail/setup_test.cj:46-48` — public const 污染命名空间

**问题**：三行 `public const GLM_NOT_*` 声明将测试中间产物暴露为包公开 API。

**原因**：`setup_test.cj` 位于 `src/` 下，被 `cjpm` 视为生产包源码，其 `public` 声明会被同包下其他文件可见，可能导致命名冲突或使用者误用。

**修正方向**：移除 `public` 关键字，使用包私有可见性（无修饰符）或将 `private` 限制在同一文件内：

```cangjie
private const GLM_NOT_SIMD: Bool = !GLM_CONFIG_SIMD
private const GLM_NOT_ALIGNED: Bool = !GLM_CONFIG_ALIGNED_GENTYPES
private const GLM_NOT_CLIP: Bool = !GLM_CONFIG_CLIP_CONTROL
```

### 问题 2：`tests/glm/detail/test_setup.cj` — 测试覆盖不足

**问题**：该文件仅验证 7 个常量的静态值，未覆盖：
- `const` 编译期语义（使用常量的组合表达式）
- 类型兼容性（`Int64` 和 `Bool` 复合运算）
- 交叉引用一致性（版本编码校验）

**原因**：作为独立测试套件的一部分，缺少对 `const` 特性的充分验证，若后续回归可能导致 `const` 语义缺陷漏测。

**修正方向**：补充 const 编译期语义测试，参考 `src/detail/setup_test.cj` 第 44-87 行的测试逻辑补充至本文件。
