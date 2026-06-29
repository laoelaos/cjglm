# R3: GLM 阶段三顶层 fwd.cj / lib.cj / gen_fwd_aliases.py 审查

审查时间：2026-06-27

### 审查范围

| 文件 | 行数 | 状态 |
|------|------|------|
| `cjglm/src/fwd.cj` | 335 | 已修改 |
| `cjglm/src/fwd.cj.bak` | 338 | 不应入库的临时备份 |
| `cjglm/src/lib.cj` | 16 | 已修改 |
| `cjglm/scripts/gen_fwd_aliases.py` | 77 | 已修改 |

### 发现

#### [一般] `fwd.cj.bak` 备份文件包含 OOD 明确禁止的错误变体

- **位置**：`cjglm/src/fwd.cj.bak:330-332`
- **描述**：备份文件残留 OOD §2 明确禁止的 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat` 三个错误别名：
  ```
  public type HighpFQuat = detail.Quat<Float32, PackedHighp>
  public type MediumpFQuat = detail.Quat<Float32, PackedMediump>
  public type LowpFQuat = detail.Quat<Float32, PackedLowp>
  ```
  OOD §2 验证命令段已明确禁止：`FQuat 家族不应有 HighpFQuat/MediumpFQuat/LowpFQuat 精度变体——与 Vec 家族 FVec* 精度变体命名约定不一致，Quat 家族统一为 HighpQuat/MediumpQuat/LowpQuat`。该 `.bak` 是修复前的快照，被误纳入 git 暂存区（`git status` 显示 `new file: cjglm/src/fwd.cj.bak`）。
- **建议**：删除 `cjglm/src/fwd.cj.bak`，并将其加入 `.gitignore`（或至少在本次合并前 `git rm`）。当前 `fwd.cj`（335 行）已正确不含上述三个错误变体，备份文件不应继续存在于版本控制中。

#### [一般] `gen_fwd_aliases.py` 在 Windows 上破坏幂等性

- **位置**：`cjglm/scripts/gen_fwd_aliases.py:71`
- **描述**：脚本写入文件时显式指定 `newline='\n'`（LF 行尾）。当前已提交的 `fwd.cj` 使用 CRLF 行尾（Windows 仓库默认）。首次在已提交版本上执行脚本时，会将全部 335 行的行尾从 CRLF 改为 LF，触发 `git diff` 输出 670+ 行变更（实测 `diff` 返回 `1,335c1,335`）。OOD §2 幂等性验证段明确要求：
  ```
  再次执行后 git diff --stat 应无输出（幂等）
  ```
  实际测试：脚本对 LF 文件可幂等（`diff -q` 无输出），但对 CRLF 文件不幂等。`harness/implements/202606271030_glm_phase3_impl` 分支第一次执行即破坏了幂等性承诺。
- **建议**：修改 `gen_fwd_aliases.py:71` 的写入策略以保留原文件行尾，例如：
  - 检测原文件行尾（读取前 4KB 统计 `\r\n` vs `\n`），写入时使用对应的 `newline=''`（保留原样）或对应平台参数；
  - 或在仓库根 `.gitattributes` 中固化 `*.cj text eol=lf`，从源头统一行尾策略——与本仓库其他仓颉源文件保持一致。

#### [一般] `lib.cj` 行数偏离 OOD 预期（16 行 vs 28 行）

- **位置**：`cjglm/src/lib.cj:1-16`
- **描述**：OOD §2 明确声明「`cjglm/src/lib.cj` 当前**仅 8 行**」「**阶段三新增的 20 个 import 全部追加至 lib.cj 第 9 行起**」，并给出 20 个显式 import 清单。实际 `lib.cj` 仅 16 行（含 1 行 `package glm` + 8 行原有 `public import` + 4 行新增 import + 4 行 Phase 3 注释），原因是实现采用了 `import glm.ext.*` 和 `import glm.gtc.*` 两个通配符导入来合并原本 14 个 ext + 3 个 gtc 的显式 import 清单。
- **影响**：功能等价——通配符导入与显式导入覆盖同一组符号；但偏离 OOD 文本「20 个 import」的逐项描述，下游若按 OOD 文本逐行核对会察觉差异。
- **建议**：在 OOD §2 修订记录中追加偏差说明（参照 `docs/deviations.md` 格式），标注 `lib.cj` 采用通配符导入策略的事实与依据；或拆解为 17 个显式 import 以严格对齐 OOD 清单。当前实现本身无功能性问题。

#### [一般] `lib.cj` 触发 17 个 unused import 编译警告

- **位置**：`cjglm/src/lib.cj:12, 14, 16`
- **描述**：`cjpm build` 实际输出 17 条 `unused import` 警告（不含已存在的 Vec1/2/3/4 shadowed 警告）：
  - `glm.detail.sin` / `cos` / `tan` / `asin` / `acos` / `atan` / `atan2` / `sinh` / `cosh` / `tanh` / `asinh` / `acosh` / `atanh` / `radians` / `degrees`（15 个）
  - `glm.ext.*`（1 个）
  - `glm.gtc.*`（1 个）
  这些 `import`（非 `public`）仅服务于将 ext/gtc 符号引入 `glm` 包作用域以便 lib.cj 内部引用，但 lib.cj 自身并不调用这些符号，因此编译器判定为未使用。
- **影响**：构建成功（`cjpm build success`），但 17 条警告污染构建输出，不利于后续 warning 治理（O-06 流程关注点）。
- **建议**：评估两种修法——
  1. 改用 `public import` 重导出，使符号在 `glm` 包作用域可见的同时不再触发 unused 警告（参考现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式）；
  2. 保留非 `public` 导入，但在 lib.cj 顶部显式 `_ = sin; _ = cos; ...` 抑制（不推荐，污染源文件）；
  3. 通过 `cjpm build -Woff unused` 在构建脚本级别抑制（治标不治本）。

#### [轻微] `lib.cj` 实现与 OOD §2 显式 import 清单存在 4 处偏离

- **位置**：`cjglm/src/lib.cj:9-16`
- **描述**：与 OOD §2 「lib.cj 新增 import 清单」逐项对照，存在 4 处偏离：

  | # | OOD §2 描述 | 实际实现 | 偏离性质 |
  |---|-------------|---------|----------|
  | 1 | `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` | `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`（省略 `Quat`） | lib.cj:9 注释已说明原因——「Quat 类型别名由 fwd.cj 提供，避免名称冲突」。`fwd.cj:327` 已定义 `public type Quat = detail.Quat<Float32, PackedHighp>`，若 lib.cj 同时 `public import glm.detail.{Quat}` 会触发 shadowed 警告（参考 Vec1~Vec4 的现有 shadowed 警告模式）。设计取舍正确。 |
  | 2 | `import glm.detail.trigonometric` | `import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}` | `trigonometric.cj` 本身声明 `package glm.detail`（同包），并非子包；`glm.detail.trigonometric` 无法解析。实现改为按符号名导入，逻辑正确。 |
  | 3 | 14 个 `import glm.ext.*` 显式条目（`vector_relational`/`quaternion_common`/.../`matrix_transform`） | 单条 `import glm.ext.*` 通配符导入 | 通配符合并，语义等价。 |
  | 4 | 3 个 `import glm.gtc.*` 显式条目（`constants`/`quaternion`/`matrix_transform`） | 单条 `import glm.gtc.*` 通配符导入 | 同上。 |

  合计 20 条 OOD 显式条目被压缩为 5 条 import 语句（其中第 2 行涵盖 14 个 ext 子模块、第 3 行涵盖 3 个 gtc 子模块）。
- **影响**：lib.cj 注释明确标注了「Phase 3 — 四元数转换函数 / trigonometric 函数 / ext 扩展函数库 / gtc 子包」四个语义分组，代码意图清晰；偏离已在 lib.cj 行内注释中说明。
- **建议**：将上述 4 处偏离纳入 `docs/deviations.md` 三、内部区别 章节（例如新增 INT-07「lib.cj 通配符导入策略」），与现有 INT-03（fwd.cj 命名空间导入策略）形成统一的「导入策略偏差」说明集。

#### [轻微] OOD §2 别名描述与实际 qualifier 名称不一致

- **位置**：`docs/05_ood_phase3.md:330-335` 对比 `cjglm/src/fwd.cj:329-334`
- **描述**：OOD §2 描述的 Quat 精度别名形如 `type HighpQuat = Quat<Float32, Highp>`（无 `Packed` 前缀）。但 `glm.detail` 包内 `Qualifier` 层级仅声明了 `PackedHighp`/`PackedMediump`/`PackedLowp`（`cjglm/src/detail/qualifier.cj:5-7`），不存在 `Highp`/`Mediump`/`Lowp` 类型。实际 `fwd.cj:329-334` 全部使用 `PackedHighp`/`PackedMediump`/`PackedLowp`，与同文件内 Vec 家族的精度别名约定（如 `HighpVec2 = detail.Vec2<Float32, PackedHighp>` 见 `fwd.cj:110`）保持一致。
- **影响**：OOD 文档文本与代码实现存在命名差异；下游若按 OOD 文本逐字核对可能产生疑问。实现本身正确。
- **建议**：在 OOD §2 「fwd.cj 新增 type alias 清单」中将 `Highp`/`Mediump`/`Lowp` 全部修订为 `PackedHighp`/`PackedMediump`/`PackedLowp`，与 OOD 同段后续描述（`Vec2 = detail.Vec2<Float32, PackedHighp>`）保持一致。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 4 |
| 轻微 | 2 |

### 总评

本轮审查覆盖的 3 个文件整体质量良好：

- **fwd.cj** 9 个 Quat 别名生成完全符合 OOD §2 要求：`Quat`/`FQuat`/`DQuat` + 3×Float32 精度 + 3×Float64 精度 = 9 个；不包含禁止的 `Quat1`/`Quat2`/`Quat3` 变体；不包含禁止的 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat` 变体；命名空间导入策略正确沿用阶段二的 `import glm.detail` + `detail.VecN<...>` 限定访问模式（参考 deviations.md INT-03）。
- **lib.cj** 原有 7 个 import 全部完整保留（Vec1~Vec4/Qualifier/Defaultp/add~mod/fromBoolVec/Mat2x2~Mat4x4/transpose 等），新增 4 条 import 语句通过通配符策略实现了 OOD §2 所列 20 条 import 的功能等价覆盖。lib.cj 行内注释清晰说明了「Quat 类型别名由 fwd.cj 提供，避免名称冲突」的设计取舍，与 fwd.cj 的别名声明保持一致。
- **gen_fwd_aliases.py** 主体逻辑正确：独立 `QUAT_BASE`/`QUAT_PRECISIONS` 字典避免污染 Vec 家族循环；`family_name + prec_prefix` 拼接顺序与 OOD §2 「修改后完整 Python 代码」一致；FQuat 单独追加且不带精度前缀变体。

主要需清理/修复项（按优先级）：

1. **【必清】** 删除 `cjglm/src/fwd.cj.bak`（含 OOD 禁止的 `HighpFQuat` 等错误变体）；
2. **【必改】** 修复 `gen_fwd_aliases.py` 的 CRLF→LF 强制转换（`gen_fwd_aliases.py:71`），恢复幂等性以满足 OOD §2 验证要求；
3. **【建议】** 将 lib.cj 的 4 处偏离（Quat 省略/trigonometric 导入方式/ext/gtc 通配符）补登至 `docs/deviations.md`；
4. **【建议】** 修订 OOD §2 别名描述中的 `Highp`→`PackedHighp` 命名。