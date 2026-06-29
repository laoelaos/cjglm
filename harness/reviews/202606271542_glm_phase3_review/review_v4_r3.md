# R4 R3: test_fwd.cj + test_lib.cj + 跨模块集成依赖方向校验

审查时间：2026-06-27

### 审查范围

- `cjglm/tests/glm/test_fwd.cj`（473 行，70 个 `@Test`）
- `cjglm/tests/glm/test_lib.cj`（263 行，38 个 `@Test`）
- `cjglm/src/lib.cj`（16 行）公共导入机制验证
- `cjglm/src/fwd.cj`（335 行）9 个 Quat 别名核查
- `cjglm/src/detail/`、`cjglm/src/ext/`、`cjglm/src/gtc/` 包间依赖方向 grep 校验
- `cjglm/cjpm.toml` 子包发现机制
- 依据：`docs/05_ood_phase3.md` §2「模块间依赖」+ §2「cjpm 子包构建预验证」+ §3.15 line 1273-1279

### 发现

#### [严重] test_fwd.cj / test_lib.cj 等 tests/ 目录下测试文件不被 cjpm test 发现执行

- **位置**：`cjglm/cjpm.toml:8-9` 配置 `[test] src-dir = "tests"`，但 cjpm 1.1.0 工具链仅识别 `src/**/*_test.cj`（以下划线 `_test.cj` 为后缀）的测试文件
- **实测证据**：
  - `cjpm test` 输出 `Summary: TOTAL: 422`，全部来自 `src/detail/*_test.cj`（13 个文件，sum=422）；`tests/glm/detail/*.cj` 1002 个 `@Test` 一个都不执行
  - `target/release/unittest_bin/` 仅含 `glm.detail$test.cjo`、`glm.detail.exe`，`glm$test.cjo`、`glm.ext$test.cjo`、`glm.gtc$test.cjo` 全部缺失（`incremental-cache.json` 中后三者 timestamp 为空 `-9223372036854775808`）
  - 本轮审查目标 `tests/glm/test_fwd.cj`（70 测试）+ `tests/glm/test_lib.cj`（38 测试）+ `tests/glm/test_ext.cj`（16 测试）+ `tests/glm/test_integration_matrix.cj`（41 测试）+ `tests/glm/ext/*.cj`（5 文件）+ `tests/glm/gtc/*.cj`（2 文件）**全部不执行**
- **描述**：依据仓颉工具链官方文档（`.opencode/skills/cangjie-toolchains/cjpm/README.md:203`）——「测试文件以 `_test.cj` 结尾，放在 `src/` 目录下」。`tests/` 目录下的 `test_*.cj` 前缀命名是项目自定义约定，不被 cjpm 工具链识别。`docs/03_ood_phase1.md:148` 声称「此完整配置确保 `cjpm test` 可正确发现位于 `tests/glm/detail/` 和 `tests/glm/` 目录下的 `@Test` 标注测试用例」与 cjpm 1.1.0 实际行为不符。本轮审查的 165+ 测试无法通过 `cjpm test` 验证执行，相当于「编译通过但运行空跑」状态
- **建议**：(a) 将 `tests/glm/test_fwd.cj` 等迁移至 `src/glm/` 下并改名为 `src/glm/test_fwd_test.cj`（以下划线后缀命名）；或 (b) 编写 `cjpm.toml` 配置，使 cjpm 识别 `tests/` 目录的 `test_*.cj` 命名约定（若 cjpm 1.1.0 支持，需验证）；或 (c) 将 test_fwd.cj 和 test_lib.cj 测试内容合并到 `src/detail/` 现有 `_test.cj` 文件中（不推荐，破坏 test_*.cj 自定义约定的语义）

#### [一般] lib.cj 的 import 与 OOD §2「20 个新增 import 清单」存在结构偏差

- **位置**：`cjglm/src/lib.cj:10-16`
- **描述**：OOD §2 明确列出 20 个独立 import（`mat3Cast/mat4Cast/quatCast` 一项 + `trigonometric` 一项 + 13 项 ext + 3 项 gtc + 2 项 detail 共 20 行独立 import），实际 `lib.cj` 用 3 行通配符 import 替代：`public import glm.detail.{mat3Cast, mat4Cast, quatCast}` (3 个具名) + `import glm.detail.{sin, cos, ...}` (15 个具名三角函数) + `import glm.ext.*` (通配符替代 13 项) + `import glm.gtc.*` (通配符替代 3 项)
- **影响**：编译期产生 unused import 警告：`warning: unused import 'glm.ext.*'`（`lib.cj:14`）、`warning: unused import 'glm.gtc.*'`（`lib.cj:16`）。通配符语义上能正确重导出 ext/gtc 下全部 `public` 符号至 glm 命名空间（cjpm build 成功、cjpm test --no-run 成功可证明），但与 OOD 设计偏离
- **建议**：在 `lib.cj` 中按 OOD §2 列出 20 个独立具名 import 以保持设计与实现 1:1 对照；即使更多 unused 警告（`cjpm` 通配符的 public re-export 语义可能被工具链识别不足），仍以 OOD 为准

#### [一般] lib.cj 缺少 OOD §2 指定的 `Quat` 的 public import

- **位置**：`cjglm/src/lib.cj:10`
- **描述**：OOD §2 line 304 明确写「`public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数」，实际 `lib.cj:10` 仅 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`，**未导入 `Quat`**
- **影响**：当前能编译通过是因为 `tests/glm/test_lib.cj:252,259` 使用 `Quat<Float64, Defaultp>(...)` 语法时，Cangjie 编译器将 `Quat` 解析为 `fwd.cj:327` 的 type alias（`public type Quat = detail.Quat<Float32, PackedHighp>`），再对该 alias 进行 generic-style 实例化——这是 Cangjie 类型别名对泛型目标的「透明再参数化」语义。但严格按 OOD 设计，`Quat` 应当通过 `public import glm.detail.{Quat, ...}` 在 `glm` 命名空间下作为类型公开，而非仅依赖 type alias 的副作用
- **建议**：在 `lib.cj:10` 补齐 `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}`，与 OOD §2 line 304 一致；测试已能通过编译并被设计预期

#### [一般] gtc/quaternion.cj 缺少 OOD §3.15 指定的两项 ext import

- **位置**：`cjglm/src/gtc/quaternion.cj:2-3`
- **描述**：OOD §3.15 line 1276-1277 明确要求 `import glm.ext.vector_relational.*`（引用 `equal`，用于 roll/pitch 的 `equal(vec2, vec2, 0)` 边界检测）和 `import glm.ext.scalar_constants.*`（引用 `epsilon<T>()`）。实际 `gtc/quaternion.cj` 仅 `import glm.detail.*` + `import std.math.FloatingPoint` + `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 三项
- **影响**：所有 7 个 stub 函数（`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`，line 22-47）函数体仅为 `{ throw Exception("stub") }`，未实际调用 `equal` 或 `epsilon<T>`，因此缺失这两项 import 不影响编译。但偏离 OOD 设计
- **建议**：按 OOD §3.15 line 1276-1277 在 `gtc/quaternion.cj` 头部补齐 `import glm.ext.vector_relational` 和 `import glm.ext.scalar_constants`（即使函数体仍为 stub，保持 import 列表与 OOD 设计一致）；阶段四 stub 实装后这两项 import 将成为必需

#### [轻微] test_lib.cj 未对 OOD §2 列出的全部 20 个 import 逐项验证

- **位置**：`cjglm/tests/glm/test_lib.cj`
- **描述**：OOD §2 列出 20 个新增 import。test_lib.cj 实际仅直接测试：Quat (1 个 test) + mat3Cast (1 个 test) + quatCast (1 个 test) + 三角函数 15 个 (testLibSin/Cos/Tan/Asin/Acos/Atan/Atan2/Sinh/Cosh/Tanh/Asinh/Acosh/Atanh/Radians/Degrees，共 15 个 test) = **17 个测试覆盖 5 个 import 组**（Quat、3 个 cast、trig）
- **遗漏 import 组**（OOD §2 line 306-323）：
  - `glm.ext.vector_relational`
  - `glm.ext.quaternion_common`
  - `glm.ext.quaternion_geometric`
  - `glm.ext.quaternion_trigonometric`
  - `glm.ext.quaternion_relational`
  - `glm.ext.quaternion_transform`
  - `glm.ext.quaternion_exponential`
  - `glm.ext.scalar_constants`
  - `glm.ext.quaternion_float` / `quaternion_double` / `quaternion_float_precision` / `quaternion_double_precision`（4 个别名文件）
  - `glm.ext.matrix_projection` / `matrix_clip_space` / `matrix_transform`
  - `glm.gtc.constants`
  - `glm.gtc.quaternion`
  - `glm.gtc.matrix_transform`
- **影响**：虽然有 `tests/glm/ext/test_*.cj` 和 `tests/glm/gtc/test_*.cj` 等子目录测试文件存在，但如前文「严重」发现所述——这些 tests/ 子目录文件均不被 cjpm test 发现执行；同时 test_lib.cj 作为 `lib.cj` 公共 API 的「统一可达性测试」文件，理论上应承担 1:1 对照全部 20 个 import 的职责
- **建议**：在 test_lib.cj 中追加对剩余 15 个 import 组的可达性测试（每个 import 至少 1 个 `@Expect` 烟雾测试调用相应符号），与 OOD §2 的 20 项清单形成 1:1 对照；或显式记录 test_lib.cj 仅负责验证「在 tests/glm/ 直通目录下的 lib 公共 API 子集」，其余 import 由 tests/glm/ext/、tests/glm/gtc/ 子目录测试负责——但需先解决上文「严重」发现的测试发现机制问题

#### [轻微] test_fwd.cj 中精度变体 Quat 别名测试覆盖较浅

- **位置**：`cjglm/tests/glm/test_fwd.cj:411-444`（`testFwdHighpQuatAlias`/`testFwdMediumpQuatAlias`/`testFwdLowpQuatAlias`/`testFwdHighpDQuatAlias`/`testFwdMediumpDQuatAlias`/`testFwdLowpDQuatAlias`）
- **描述**：6 个精度变体测试仅校验 `.w` 分量值（如 line 413 `@Expect(q.w, Float32(4.0))`），未校验 `.x`/`.y`/`.z` 也未校验精度字段 (`PackedHighp`/`PackedMediump`/`PackedLowp`) 差异
- **影响**：精度变体的差异在「Qualifier 类型参数」上（`PackedHighp`/`PackedMediump`/`PackedLowp`），不存在于运行时数据字段；仅校验 `.w` 已足够证明别名指向正确类型。这是测试覆盖度的「可读性/完整性」问题，而非正确性问题
- **建议**：可保留当前测试设计（简洁、明确指向别名验证），无需扩展。如要进一步增强，可补充 `q is Quat<Float32, PackedMediump>` 类型断言（若仓颉支持运行期 type assertion），但当前设计已满足 OOD §2 line 326-336 的 9 个别名覆盖要求

#### [轻微] lib.cj 通配符 import 触发「unused import」警告

- **位置**：`cjglm/src/lib.cj:14,16`
- **描述**：`import glm.ext.*` 和 `import glm.gtc.*` 被 cjpm 1.1.0 报告为 unused import（编译警告，非错误）。这表明 cjpm 对通配符的「public re-export」语义可能识别不足——lib.cj 本身未引用 ext/gtc 符号，工具链认为「import 进来的东西在 lib.cj 中未使用」。但实际上 `public import glm.ext.*` 应当将 ext/ 全部 `public` 符号重导出至 glm 命名空间，下游消费者可通过 `glm.<symbol>` 直接访问
- **影响**：编译产生警告但不影响功能（cjpm build 成功，下游 `test_lib.cj` 引用 `mat3Cast`/`quatCast` 等均能解析）。此问题与上文「一般」发现 2 相关——按 OOD 改为具名 import 后此警告将消失
- **建议**：与发现 2 联动——按 OOD §2 改为 20 个具名 import，消除 unused 警告的同时保持设计一致性

### 跨模块依赖方向校验（OOD §2「模块间依赖」）

| 校验项 | OOD §2 要求 | 实测结果 | 结论 |
|--------|------------|----------|------|
| `glm.detail` 不依赖任何上层包 | 不应有 `import glm.ext` 或 `import glm.gtc` | `src/detail/*.cj` 全部 import 仅 `std.math.*`/`std.deriving.*`/`std.unittest.*`，无 `glm.ext`/`glm.gtc` 引用 | ✅ 通过 |
| `glm.ext → glm.detail` 单向 | `src/ext/*.cj` 不应有 `import glm.gtc` | `src/ext/*.cj` 全部 import 仅 `glm.detail.*` 和 `std.math.*`，无 `glm.gtc` 引用 | ✅ 通过 |
| `glm.gtc → glm.detail` 单向 | `src/gtc/*.cj` 不应有 `import glm.ext.quaternion_*`，仅允许 `glm.ext.scalar_constants`/`glm.ext.vector_relational` | `src/gtc/*.cj` 全部 import 仅 `glm.detail.*` 和 `std.math.FloatingPoint`，**无任何 `glm.ext` import**（包括 §3.15 指定的 `glm.ext.vector_relational`/`glm.ext.scalar_constants`） | ⚠️ 严格通过（无禁止项），但偏离 §3.15 line 1276-1277（见上文「一般」发现 4） |
| 无循环依赖 | cjpm build 应成功 | `cjpm build` 成功（仅 21 个 unused import 警告，无错误） | ✅ 通过 |
| `src/gtc/` + `package glm.gtc` 被 cjpm 子包机制识别 | 阶段二已通过验证；阶段三需复用 | `target/release/glm/glm.gtc.cjo`（175808 bytes）成功生成；`cjpm test --no-run` 成功编译 `tests/glm/gtc/*.cj`（虽然不被发现执行） | ✅ 通过 |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 3 |
| 轻微 | 3 |

### 总评

本轮审查的核心目标是两个测试文件（test_fwd.cj、test_lib.cj）+ 跨模块依赖方向校验，得出三层结论：

**第一层：跨模块依赖方向完全合规**——`glm.detail` 不依赖任何上层包、`glm.ext → glm.detail` 单向、`glm.gtc → glm.detail` 单向、无循环依赖、cjpm 子包机制识别 `src/gtc/`，五项 OOD §2 校验全部通过。这印证了 OOD §1「gtc/quaternion.cj 与 type_quat_cast.cj 的协作设计」中包间单向依赖设计的正确性，cjpm build 与 test --no-run 均成功可证。

**第二层：test_fwd.cj 测试设计本身质量良好**——9 个 Quat 别名（Quat/FQuat/DQuat + 3×Float32 + 3×Float64）逐项覆盖，别名↔泛型兼容性测试（`testFwdAliasAndGenericCompatible`）、fwd.cj 头部注释检测（`testFwdHeaderComments`）、家族分组注释检测（`testFwdFamilyComments`）、FQuat 不变体回归保护（`testFwdNoRemovedQuatAliases`）覆盖完整。gen_fwd_aliases.py 与当前 fwd.cj 输出幂等，9 个 Quat 别名在脚本（line 53-63）和 fwd.cj（line 326-335）中完全对应。

**第三层：发现一个严重问题——tests/ 目录下的测试文件未被 cjpm test 发现执行**——这是本轮审查的最关键发现，直接影响 test_fwd.cj 和 test_lib.cj 的实际可验证性。cjpm 1.1.0 工具链的测试发现机制遵循「`src/**/*_test.cj` 下划线后缀」约定，而项目采用 `tests/**/test_*.cj` 前缀约定作为自定义扩展，导致 tests/glm/ 目录下 165+ 测试（含本轮审查目标 70+38=108 个）均不被执行，仅 src/detail/*_test.cj 的 422 个测试被运行。此问题在 `docs/03_ood_phase1.md:148` 已被声明「可正确发现」，但 cjpm 1.1.0 实际行为不符 OOD 声明，需要在阶段四前明确解决。

**lib.cj 与 OOD §2 的结构偏差**（通配符 import 替代具名 import）和 **gtc/quaternion.cj 缺失 §3.15 指定的 ext import** 是两处「设计-实现 1:1」偏差，非阻塞性问题但需要在阶段四 stub 实装前修正，否则阶段四实现时将引入连锁改动。test_lib.cj 覆盖范围未达 OOD §2 全部 20 个 import 是已知遗留（前轮 01_diag.md #21/#22/#23 已记录），且受本轮发现的「tests/ 不被 cjpm 发现」严重问题放大影响——sub-module 测试文件（tests/glm/ext/、tests/glm/gtc/）即使存在也无法作为兜底。

整体而言，跨模块集成设计正确且可编译运行，但**测试基础设施存在严重缺陷**——本轮审查的 test_fwd.cj 和 test_lib.cj 当前仅停留在「编译通过」状态，未实际执行，建议优先解决 cjpm 测试发现机制问题后再发布阶段三交付。