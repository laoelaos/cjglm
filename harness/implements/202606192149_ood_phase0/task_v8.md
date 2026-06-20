# 任务指令（v8）

## 动作
NEW

## 任务描述
修复 `src/fwd.cj` 中 Vec1~Vec4 类型导入被本地别名遮蔽导致的编译错误。

**根因**：第 3 行 `import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 将泛型 `Vec1<T, Q>` 等导入当前作用域，但第 99-102 行 `public type Vec1 = Vec1<Float32, PackedHighp>` 等别名声明与导入同名，根据仓颉语言规则（§4.3 遮蔽与重载），本地声明遮蔽导入。导致第 51 行及之后所有 `Vec1<Bool, PackedHighp>` 等泛型引用被解析为单形别名（0 类型参数），触发 `type argument's number does not match type parameter's number`，共 252 个错误。

**修复方案**：
1. 删除第 3 行 `Vec1, Vec2, Vec3, Vec4` 名称导入。保留其他导入不变。
2. 新增 `import glm.detail` 命名空间导入（用于 `detail.Vec1` 限定访问）。
3. 将所有泛型引用（第 51-306 行的 `Vec1<`、`Vec2<`、`Vec3<`、`Vec4<`）替换为 `detail.Vec1<`、`detail.Vec2<`、`detail.Vec3<`、`detail.Vec4<`。
4. 第 99-102 行 RHS 的 `Vec1<Float32, PackedHighp>` 等也需改为 `detail.Vec1<Float32, PackedHighp>` 等（LHS 别名名称不变）。

**影响范围**：仅 `src/fwd.cj` 一个文件，约 256 行机械替换。

**无需修改**：
- `src/lib.cj` — 其 `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 导入被遮蔽仅产生警告，编译正确性不受影响
- `src/detail/*.cj` — 所有逻辑不受影响
- 测试文件 — fwd.cj 仅为类型别名层，不涉及测试逻辑

## 选择理由
R6（scalar_vec_ops.cj const 修复）已验证通过——目标 50 个编译错误全部消除。但修复后暴露出 fwd.cj 中 252 个预存编译错误（此前被 scalar_vec_ops 错误遮蔽）。本任务是代码库当前唯一编译错误源。

## 任务上下文
- fwd.cj 属于 `package glm`，通过 type alias 暴露常用具现化向量类型
- 当前共 256 行类型别名，覆盖 B/I/U/D/I8/I16/I32/I64/U8/U16/U32/U64/F/F32/F64 各 ×4 分量 ×4 精度 = ~208 个带 Qualifier 参数的别名 + 48 个无 Qualifier 别名
- 所有别名 RHS 使用 `VecN<T, Q>` 泛型引用形式

## 已有代码上下文
当前 `src/fwd.cj:1-4`:
```
package glm
import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }
```

改为：
```
package glm
import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }
import glm.detail
```

后续所有 `Vec1<...>` → `detail.Vec1<...>`，`Vec2<...>` → `detail.Vec2<...>`，`Vec3<...>` → `detail.Vec3<...>`，`Vec4<...>` → `detail.Vec4<...>`。

## 验证标准
1. `cjpm build -i` 编译通过，0 errors
2. `cjpm test` 运行通过，全部测试用例通过
