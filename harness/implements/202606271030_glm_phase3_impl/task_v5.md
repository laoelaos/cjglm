# 任务指令（v5）

## 动作
NEW

## 任务描述
完成 GLM Phase 3 最终轮次：更新 `lib.cj` 追加 20 个 public import，修改 `scripts/gen_fwd_aliases.py` 生成 9 个 Quat 家族 type alias，重新生成 `fwd.cj`，`cjpm build` 全库编译验证并通过全部测试。

### 具体产出

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/lib.cj` | 末尾追加 20 行 public import |
| 修改 | `scripts/gen_fwd_aliases.py` | 新增 Quat 家族独立生成循环 |
| 重新生成 | `src/fwd.cj` | 运行脚本自动生成，新增 9 行 Quat type alias |
| 验证 | `cjpm build` + `cjpm test` | 编译通过、422 测试全部 PASSED |

## 选择理由
lib.cj 和 fwd.cj 是库的公共 API 面，必须在所有模块实现后统一更新。R5 为阶段三最终轮次，完成后计划全部实现。

## 任务上下文

### 1. lib.cj 当前状态
`src/lib.cj` 当前仅 8 行，包含 Phase 1/2 的 import。需在末尾追加以下 **20 个 import**（逐行追加，保持现有格式）：

```cangjie
// Phase 3 — 四元数类型与转换函数
public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}
import glm.detail.trigonometric
// Phase 3 — ext 扩展函数库（15 个）
import glm.ext.vector_relational
import glm.ext.quaternion_common
import glm.ext.quaternion_geometric
import glm.ext.quaternion_trigonometric
import glm.ext.quaternion_relational
import glm.ext.quaternion_transform
import glm.ext.quaternion_exponential
import glm.ext.scalar_constants
import glm.ext.quaternion_float
import glm.ext.quaternion_double
import glm.ext.quaternion_float_precision
import glm.ext.quaternion_double_precision
import glm.ext.matrix_projection
import glm.ext.matrix_clip_space
import glm.ext.matrix_transform
// Phase 3 — gtc 子包（3 个）
import glm.gtc.constants
import glm.gtc.quaternion
import glm.gtc.matrix_transform
```

**说明**：
- 第 1 个 `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` 将 detail 包的类型和转换函数通过 `public import` 重导出至顶层 `glm` 命名空间，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致
- 其余 19 个为 `import`（非 `public import`），使 `lib.cj` 所在包 `glm` 可访问这些模块，但无需将它们的符号再重导出至顶层（ext/gtc 的函数通过它们自己的 `public func` 已对外可见）

### 2. gen_fwd_aliases.py 修改

**现有脚本结构**（`scripts/gen_fwd_aliases.py`）：
- `VEC_FAMILIES` 字典（行 13-18）：定义 Vec 家族前缀 → 类型映射
- `VEC_PRECISIONS` 列表（行 19-20）：`[('', 'PackedHighp'), ('Highp', 'PackedHighp'), ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]`
- `DIMS = [1, 2, 3, 4]`（行 21）：Vec 维度
- 主循环（行 43-51）：遍历 `VEC_FAMILIES` × `VEC_PRECISIONS` × `DIMS` 生成别名

**修改方案**：

在现有 Vec/Mat 家族生成循环之后（行 51 之后）、`content = '\n'.join(lines)`（行 53）之前，插入以下独立循环：

```python
    # === Quat family (fixed 4-dim, no Vec1/Vec2/Vec3 variants) ===
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
    lines.append('')
```

**预期生成的 9 个别名**：
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

### 3. 验证步骤

1. 修改完 `gen_fwd_aliases.py` 后运行：`python scripts/gen_fwd_aliases.py`
2. 确认生成的 `src/fwd.cj` 包含全部 9 个 Quat type alias 且**不包含** `Quat1`/`Quat2`/`Quat3`
3. 运行 `cjpm build` 确认编译通过
4. 运行 `cjpm test` 确认 422 全部 PASSED
5. 运行脚本第二次，确认幂等（第二次执行后 git diff 无变化）

### 4. 回退方案
- 若 `gen_fwd_aliases.py` 修改成本过高，备选方案 B：将 9 个 type alias 手动写入 `lib.cj` 末尾（`lib.cj` 是手动维护文件）
- 若 `cjpm build` 因 import 顺序或循环依赖失败，记录偏差并逐一调整 import 顺序

## 已有代码上下文

### lib.cj（当前，8 行）
```cangjie
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
public import glm.detail.{ transpose, matrixCompMult, outerProduct }
```

### fwd.cj（当前，394 行，自动生成）
已包含 B / I / U / Vec / DVec / I8 / I16 / I32 / I64 / U8 / U16 / U32 / U64 / FVec / F32 / F64 / Mat / DMat / HighpMat / MediumpMat / LowpMat / HighpDMat / MediumpDMat / LowpDMat 家族别名。需新增 Quat 家族。

### gen_fwd_aliases.py（当前，64 行）
- `VEC_FAMILIES` 字典定义了 15 个 Vec 家族前缀
- `VEC_PRECISIONS` 列表定义了 4 种精度组合
- 主循环按家族 × 精度 × 维度生成别名
- 需要在 Vec 循环之后、写入文件之前插入 Quat 独立循环
