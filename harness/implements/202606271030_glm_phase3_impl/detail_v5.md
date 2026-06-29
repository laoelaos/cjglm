# 详细设计（v5）

## 概述
Phase 3 最终轮次：更新 `lib.cj` 追加 public import，修改 `scripts/gen_fwd_aliases.py` 生成 9 个 Quat 家族 type alias，重新生成 `fwd.cj`，`cjpm build` + `cjpm test` 全量验证。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/lib.cj` | 修改末尾追加 | 追加 Phase 3 import（因仓颉包管理限制，20 个逐个文件名 import 被合并为 3 个包级通配符 import + 1 组命名 import，详见偏差说明） |
| `scripts/gen_fwd_aliases.py` | 修改 Quat 循环 | 修正为输出 9 个 Quat type alias（去掉 FQuat 精度前缀变体） |
| `src/fwd.cj` | 重新生成（运行脚本） | 重新生成后包含 9 个 Quat type alias |

## 类型定义

无新类型定义。仅修改已有文件中的 import 语句和类型别名生成逻辑。

---

## lib.cj 修改方案

### 当前内容（14 行）
```cangjie
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
public import glm.detail.{ transpose, matrixCompMult, outerProduct }
// Phase 3 — 四元数类型与转换函数
public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}
// Phase 3 — ext 扩展函数库（通过 import 使 glm 包可访问 ext 包符号）
import glm.ext.*
// Phase 3 — gtc 子包
import glm.gtc.*
```

### 修改后内容
第 10 行去掉 `Quat`（避免与 `fwd.cj` 中 `public type Quat = detail.Quat<Float32, PackedHighp>` 的名称冲突），追加 trigonometric 函数命名 import：

```cangjie
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
public import glm.detail.{ transpose, matrixCompMult, outerProduct }
// Phase 3 — 四元数转换函数（Quat 类型别名由 fwd.cj 提供，避免名称冲突）
public import glm.detail.{mat3Cast, mat4Cast, quatCast}
// Phase 3 — trigonometric 函数（detail 包内函数，按名称导入）
import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
// Phase 3 — ext 扩展函数库（通过包级通配符 import 使 glm 包可访问 ext 包符号）
import glm.ext.*
// Phase 3 — gtc 子包
import glm.gtc.*
```

---

## gen_fwd_aliases.py 修改方案

### 当前 Quat 生成循环（行 53-64）
```python
QUAT_FAMILIES = {
    'Quat': 'Float32', 'FQuat': 'Float32', 'DQuat': 'Float64',
}
QUAT_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                   ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
lines.append('// === Quat family ===')
for prec_prefix, prec_type in QUAT_PRECISIONS:
    for family_name, family_type in QUAT_FAMILIES.items():
        alias_name = f'{prec_prefix}{family_name}'
        lines.append(f'public type {alias_name} = detail.Quat<{family_type}, {prec_type}>')
```

当前输出 12 个（3 家族 × 4 精度），**审查要求修正为 9 个**。

### 修改后代码
```python
    # === Quat family (FQuat is Float32 default-precision only, same as Quat) ===
    QUAT_BASE = {'Quat': 'Float32', 'DQuat': 'Float64'}
    QUAT_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                       ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
    lines.append('// === Quat family ===')
    for prec_prefix, prec_type in QUAT_PRECISIONS:
        for family_name, family_type in QUAT_BASE.items():
            alias_name = f'{prec_prefix}{family_name}'
            lines.append(f'public type {alias_name} = detail.Quat<{family_type}, {prec_type}>')
    # FQuat = Quat (Float32), default precision only — no precision prefix variants
    lines.append(f'public type FQuat = detail.Quat<Float32, PackedHighp>')
```

### 预期输出的 9 个别名
| # | 别名 | 等价类型 |
|---|------|---------|
| 1 | `Quat` | `detail.Quat<Float32, PackedHighp>` |
| 2 | `FQuat` | `detail.Quat<Float32, PackedHighp>` |
| 3 | `DQuat` | `detail.Quat<Float64, PackedHighp>` |
| 4 | `HighpQuat` | `detail.Quat<Float32, PackedHighp>` |
| 5 | `MediumpQuat` | `detail.Quat<Float32, PackedMediump>` |
| 6 | `LowpQuat` | `detail.Quat<Float32, PackedLowp>` |
| 7 | `HighpDQuat` | `detail.Quat<Float64, PackedHighp>` |
| 8 | `MediumpDQuat` | `detail.Quat<Float64, PackedMediump>` |
| 9 | `LowpDQuat` | `detail.Quat<Float64, PackedLowp>` |

**说明**：`Quat`（无精度前缀）使用 `PackedHighp` Qualifier，与 GLM C++ 的 `highp_quat` 语义一致。`FQuat` 为 `Float32` 默认精度的显式别名，不再生成 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat` 三个冗余变体。

---

## 偏差说明（仓颉语言限制导致的实现偏差）

### 偏差 1：Quat 名称冲突处理
| 规格 | 偏差原因 | 实际处理 |
|------|---------|---------|
| 任务规格要求 `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` | `fwd.cj` 以 `public type Quat = detail.Quat<Float32, PackedHighp>` 在同一包中定义了同名别名，构成编译错误 | 从 public import 中移除 `Quat`，保留 `mat3Cast`/`mat4Cast`/`quatCast`。`Quat` 类型别名完全由 `fwd.cj` 提供 |

### 偏差 2：import 语法限制
| 规格 | 偏差原因 | 实际处理 |
|------|---------|---------|
| 任务规格列出 18 个逐个文件名 import（`import glm.ext.vector_relational`, `import glm.ext.quaternion_common`, ...） | 仓颉 `import` 按包名而非文件名导入。`ext/*.cj` 全部声明 `package glm.ext`，不存在 `glm.ext.vector_relational` 子包 | 合并为 `import glm.ext.*` |
| 任务规格列出 3 个逐个文件名 import（`import glm.gtc.constants`, `import glm.gtc.quaternion`, `import glm.gtc.matrix_transform`） | 同上，`gtc/*.cj` 全部声明 `package glm.gtc` | 合并为 `import glm.gtc.*` |
| 任务规格要求 `import glm.detail.trigonometric` | `trigonometric.cj` 声明 `package glm.detail`，`glm.detail.trigonometric` 不是有效包路径 | 替换为 `import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}` |

### 副作用评估
- `import glm.ext.*`：ext 目录包含 `test_ext_alias.cj`（声明 `package glm.ext`，可能包含测试用符号）。Cangjie 编译器对 `@Test` 注解函数在非测试构建中不会产生运行时影响，且 `import` 仅引入声明而非编译测试代码，因此无实际编译或运行时风险。同时 ext 文件中的内部辅助函数（如有）可能被导入，但它们属于实现细节，通过 `glm` 包的 `import` 标记（非 `public import`）不会暴露到外部。
- `import glm.gtc.*`：gtc 目录仅 3 个正式源文件，无测试文件，无副作用风险。

### 文件规划表格修正说明
任务规格描述为"20 个 import"，因仓颉包管理限制，20 个逐个文件名 import 被合并为 3 个包级通配符 import + 1 组命名 import（trigonometric 函数）。实际行数：4 行（1 行注释 + 1 行 public import 四元数转换函数 + 1 行 trigonometric 命名 import + 1 行 ext 通配符 import + 1 行 gtc 通配符 import）。

---

## 错误处理
无新增错误处理逻辑。编译错误通过前述偏差方案规避。

## 行为契约
- `fwd.cj` 中 `Quat`/`FQuat`/`DQuat` 等 9 个别名与 `detail.Quat<T, Q>` 泛型类型的等价关系不可分割
- `lib.cj` 新增 import 不改变运行时行为，仅影响编译期符号解析

## 依赖关系
- `lib.cj` → `glm.detail`（含 trigonometric 函数）、`glm.ext`（通配符）、`glm.gtc`（通配符）
- `gen_fwd_aliases.py` → 无运行时依赖（构建时脚本）
- 无新增包间循环依赖

## 验证步骤
1. 修改 `gen_fwd_aliases.py` 后运行：`python scripts/gen_fwd_aliases.py`
2. 确认 `src/fwd.cj` 末尾 Quat 家族恰好 9 个 alias，且无 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat`
3. 确认 `lib.cj` 中 `public import` 不含 `Quat`（避免与 `fwd.cj` 冲突）
4. `cjpm build` 编译通过
5. `cjpm test` 全部 422 项 PASSED
6. 再次运行脚本，确认幂等（`git diff` 无变化）

## 回退方案
1. 若 `Quat` 与 `fwd.cj` 的冲突仍然存在（除 public import 之外的冲突来源），可将 `fwd.cj` 中 `Quat` 改为 `Quat`/`FQuat` 等 9 个别名以 `public import ... as` 语法注入
2. 若 `import glm.ext.*` 引入意外符号导致编译失败，退化方案为逐文件 `import glm.ext.quaternion_common`、`import glm.ext.quaternion_geometric` 等，重新生成 19 行 import

## 修订说明（v5 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| **[严重]** Quat 名称冲突：`lib.cj` 的 `public import {Quat, ...}` 与 `fwd.cj` 的 `public type Quat = ...` 构成编译错误 | 从 `lib.cj` 的 `public import` 中移除 `Quat`，仅保留 `mat3Cast`/`mat4Cast`/`quatCast`。新增偏差说明文档化此偏离任务规格的决定。`Quat` 类型完全由 `fwd.cj` 的 type alias 提供 |
| **[严重]** Quat alias 数量 12 与任务规格 9 不符：`FQuat` 的精度前缀变体冗余 | 修改 `gen_fwd_aliases.py`：将 `QUAT_FAMILIES` 拆为 `QUAT_BASE`（Quat/DQuat）和 `FQuat` 单行；`FQuat` 仅生成无精度前缀形式。输出从 12 减少至 9 |
| **[一般]** 遗漏 `import glm.detail.trigonometric` | 因仓颉不支持按文件名导入，替换为 `import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}`，并在偏差说明中统一记录 |
| **[一般]** import 方案偏离任务规格的理由不够完整 | 新增独立"偏差说明"章节，统一记录三类 import 偏差（Quat 冲突、ext/gtc 通配符、trigonometric），包含副作用评估 |
| **[轻微]** lib.cj 导入规划描述与实际不一致 | 文件规划表格中补充说明合并原因，偏差说明中新增"文件规划表格修正说明"子节 |
