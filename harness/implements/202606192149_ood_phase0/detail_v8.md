# 详细设计（v8）

## 概述
修复 `src/fwd.cj` 中 `Vec1`~`Vec4` 类型导入被本地别名遮蔽导致的 252 个编译错误。根因是 `import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 将泛型 `Vec1<T, Q>` 等导入作用域，而第 99-102 行的 `public type Vec1 = Vec1<Float32, PackedHighp>` 等别名声明与导入同名，本地声明遮蔽导入，导致后续所有泛型引用被解析为单形别名（0 类型参数），触发 `type argument's number does not match type parameter's number`。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/fwd.cj` | 修改 | 移除 Vec1~Vec4 名称导入，改用命名空间导入；所有泛型引用加 `detail.` 前缀 |

## import 语句修改

### 当前（第 3-4 行）
```
import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }
```

### 目标
```
import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }
import glm.detail
```

## 替换规格

### 替换模式
对 `src/fwd.cj` 第 51-306 行中所有 RHS 的 `Vec1<`、`Vec2<`、`Vec3<`、`Vec4<` 标识符引用，添加 `detail.` 命名空间前缀。

| 匹配模式 | 替换为 | 匹配次数 | 涉及行号 |
|---------|--------|---------|---------|
| `Vec1<` (在类型上下文中) | `detail.Vec1<` | ~52 | 第 51 行及所有 Vec1 引用 |
| `Vec2<` (在类型上下文中) | `detail.Vec2<` | ~52 | 第 52 行及所有 Vec2 引用 |
| `Vec3<` (在类型上下文中) | `detail.Vec3<` | ~52 | 第 53 行及所有 Vec3 引用 |
| `Vec4<` (在类型上下文中) | `detail.Vec4<` | ~52 | 第 54 行及所有 Vec4 引用 |

### 注意事项
- 仅替换 RHS（等号右侧）的类型引用，LHS 别名名称 `Vec1`~`Vec4`、`BVec1`~`BVec4` 等保持不变
- 第 99-102 行也是如此：`public type Vec1 = Vec1<Float32, PackedHighp>` → `public type Vec1 = detail.Vec1<Float32, PackedHighp>`
- `<` 标记确保不会误匹配非泛型引用场景（本文件中不存在此类场景，但仍作为安全边界）
- 约 208 个带 Qualifier 的别名 + 48 个无 Qualifier 别名，共 ~256 处替换

## 错误处理
无运行时错误处理变更。修复后消除所有 252 个编译错误。

## 行为契约
- 别名语义不变：所有 `public type XxxVecN = ...` 仍暴露相同类型
- 编译后 `Vec1`（单形别名，即 `Vec1<Float32, PackedHighp>`）和 `detail.Vec1<T, Q>`（泛型）均可访问，不冲突
- 仅 `src/fwd.cj` 文件受影响，其他文件无需修改

## 依赖关系
| 文件 | 依赖 | 说明 |
|------|------|------|
| `src/fwd.cj` | `glm.detail` 包中的泛型 `Vec1~4<T, Q>` 类型 | 所有 RHS 引用通过 `detail.VecN<...>` 访问 |
| `src/lib.cj` | `src/fwd.cj` 中定义的别名 | `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 产生 shadow 警告但不影响编译正确性，无需修改 |
