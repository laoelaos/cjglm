# R3b: 审查 fwd.cj 类型别名与 OOD 设计一致性

审查时间：2026-06-20

### 审查范围

- `cjglm/src/fwd.cj` — 300 个 public type 别名定义（44 标量 + 256 向量）
- `cjglm/tests/glm/test_fwd.cj` — 别名测试文件
- `cjglm/scripts/gen_fwd_aliases.py` — 别名生成脚本
- `docs/02_ood_phase0.md` §3.8 — 别名命名约定与生成规范
- `docs/deviations.md` CL-11 — 同名别名自引用修正记录

### 发现

#### [一般] 生成脚本 gen_fwd_aliases.py 未同步 CL-11 修复

- **位置**: `cjglm/scripts/gen_fwd_aliases.py:42-43（生成 import 行和别名行）`
- **描述**: 验证项 ㉓ 确认编译器将同名别名 `Vec2 = Vec2<Float32, PackedHighp>` 右侧的 `Vec2` 解析为正在定义的别名自身，导致歧义错误。实际 `fwd.cj` 已应用 CL-11 修复：(1) 使用 `import glm.detail`（命名空间导入）替代 `import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }`（名称导入）；(2) 别名定义中使用 `detail.Vec1<T, Q>` 前缀而非裸 `Vec1<T, Q>`。但 `gen_fwd_aliases.py` 仍生成旧格式：`import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 和 `Vec1<T, Q>`（无 `detail.` 前缀）。若重新运行脚本将覆盖 CL-11 修复，导致编译失败。
- **建议**: 更新 `gen_fwd_aliases.py` 以匹配 CL-11 修复后的格式：(1) 将 import 改为 `import glm.detail`；(2) 别名定义中使用 `detail.Vec1<T, Q>` 格式。同时更新 OOD 设计文档 §3.8 中的 Python 模板（第 657 行和 675 行）以对齐。

#### [一般] fwd.cj 缺少 OOD 设计规定的文件头部注释

- **位置**: `cjglm/src/fwd.cj:1`
- **描述**: OOD 设计 §3.8 明确要求 fwd.cj 包含头部注释：`// fwd.cj — GLM 兼容类型别名（自动生成）` 和 `// 注意：此文件由脚本自动生成，手动修改请谨慎`。当前 fwd.cj 以 `package glm` 开头，无任何注释。缺乏头部注释降低了文件的可识别性，且未标注"自动生成"警示会增加手动误修改风险。
- **建议**: 在前两行添加头部注释：`// fwd.cj — GLM 兼容类型别名（自动生成）` 和 `// 注意：此文件由脚本自动生成，手动修改请谨慎`。同步更新脚本的 `OUTPUT` 模板。

#### [一般] fwd.cj 缺少 OOD 设计规定的家族分组注释

- **位置**: `cjglm/src/fwd.cj:51`
- **描述**: OOD 设计 §3.8 规范要求按家族分组并以 `// === {FamilyName} family ===` 注释头分隔。当前 fwd.cj 的 256 向量别名按家族顺序排列但无任何分组注释，导致文件可读性降低。例如第 51 行从 `BVec1` 直接开始，无 `// === B family ===` 提示；第 67 行 `IVec1` 前也无分隔。
- **建议**: 在每组向量家族前添加形如 `// === B family ===`、`// === Vec family ===` 的分组注释注释。同步更新脚本以保持一致性。

#### [一般] 测试文件 test_fwd.cj 使用了 detail.VecN 但未导入 glm.detail 子包

- **位置**: `cjglm/tests/glm/test_fwd.cj:201,207,213,219`
- **描述**: 测试文件在 `testFwdGenericVec1Accessible` 等 4 个测试函数中使用 `detail.Vec1<Float32, PackedHighp>`, `detail.Vec2<Int32, PackedHighp>`, `detail.Vec3<Bool, PackedHighp>`, `detail.Vec4<Float64, PackedLowp>` 引用泛型 Vec 类型。但该文件仅有 `package glm` 声明而缺少 `import glm.detail` 语句。根据仓颉包机制（§4.5），使用子包命名空间限定须显式导入子包。缺少该导入可能导致编译期 `detail` 未解析错误。
- **建议**: 在测试文件 import 块中添加 `import glm.detail`，或改为使用 `lib.cj` 重导出的无前缀形式 `Vec1<Float32, PackedHighp>`。

#### [轻微] gen_fwd_aliases.py 与设计文档模板的格式差异

- **位置**: `cjglm/scripts/gen_fwd_aliases.py:28-31,47`
- **描述**: OOD 设计 §3.8 的 Python 模板包含家族分组注释（`// === Scalar aliases ===`、`// === {fam} family ===`）和头部注释，但实际 `gen_fwd_aliases.py` 无任何注释生成逻辑，且输出采用紧凑格式（无分组、无注释）。此外，设计模板将标量别名置于 `SCALAR_PRECISIONS` 外循环中（按类型分组），而实际脚本将 `SCALAR_PRECISIONS` 置于外循环中（按精度分组），导致别名输出顺序不同：设计模板为 `int8/highp_int8/mediump_int8/lowp_int8` 分组，实际脚本为 `int8/int16/.../highp_int8/highp_int16/...` 分组。
- **建议**: 对齐脚本输出格式与设计模板规范——增加分组注释、调整标量输出顺序、统一 `OUTPUT` 模板。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 4 |
| 轻微 | 1 |

### 总评

fwd.cj 的类型别名定义在**正确性层面质量很高**：300 个 public type 别名（44 标量 + 256 向量）全部正确定义，命名严格遵守 §3.8 PascalCase 约定，无 VecVec/DVecVec/FVecVec 自引用错误，CL-11 修复（`detail.` 前缀）已正确应用，跨精度变体覆盖完整。抽查 17 条别名定义与生成脚本映射表一致，零错误。

主要问题集中在**可维护性层面**：CL-11 修复后生成脚本 `gen_fwd_aliases.py` 未同步更新（若重新运行将破坏 CL-11 修复），文件缺少设计文档规定的头部注释和分组注释，测试文件可能因缺少 `import glm.detail` 而编译失败。建议优先同步脚本与输出文件格式，然后补全文件注释，最后修复测试文件的导入缺失。
