# 详细设计（v11）

## 概述

修改 `cjglm/src/lib.cj`，完成两处变更以消除 unused import 编译警告并与 OOD §2 对齐：G3.8（通配符→显式 import + 第 12 行 public import）和 G3.9（添加 Quat public import）。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/lib.cj` | 修改 | 4 处变更见下文 |

## 修改说明

### G3.8a — Line 12: `import` → `public import`

**当前**（第 11-12 行）：
```cangjie
// Phase 3 — trigonometric 函数（detail 包内函数，按名称导入）
import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
```

**修改后**：
```cangjie
// Phase 3 — trigonometric 函数（detail 包内函数，按名称导入）
public import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
```

### G3.8b — Line 14: `import glm.ext.*` → 15 个显式模块 import

**当前**（第 13-14 行）：
```cangjie
// Phase 3 — ext 扩展函数库（通过包级通配符 import 使 glm 包可访问 ext 包符号）
import glm.ext.*
```

**修改后**：
```cangjie
// Phase 3 — ext 扩展函数库（显式模块导入）
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
```

### G3.8c — Line 16: `import glm.gtc.*` → 3 个显式模块 import

**当前**（第 15-16 行）：
```cangjie
// Phase 3 — gtc 子包
import glm.gtc.*
```

**修改后**：
```cangjie
// Phase 3 — gtc 子包（显式模块导入）
import glm.gtc.constants
import glm.gtc.quaternion
import glm.gtc.matrix_transform
```

### G3.9 — Line 10: 添加 `Quat`

**当前**（第 9-10 行）：
```cangjie
// Phase 3 — 四元数转换函数（Quat 类型别名由 fwd.cj 提供，避免名称冲突）
public import glm.detail.{mat3Cast, mat4Cast, quatCast}
```

**修改后**：
```cangjie
// Phase 3 — 四元数类型 + 转换函数
public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}
```

## 依赖关系

- 所有 18 个显式 import 目标模块均在 `cjglm/src/ext/` 和 `cjglm/src/gtc/` 中存在对应 `.cj` 文件，已验证
- `glm.detail.Quat` 泛型结构体定义于 `cjglm/src/detail/type_quat.cj:7`
- 修改后 `cjpm build` 需消除 17 个 unused import 警告（G3.8 的 `import glm.ext.*` 和 `import glm.gtc.*` 各展开为多个显式 import）
- 已有 `cjpm test` 结果不受影响（435 PASSED / 0 FAILED）
- 无需 `deviations.md` 登记（修复后与 OOD 对齐）
