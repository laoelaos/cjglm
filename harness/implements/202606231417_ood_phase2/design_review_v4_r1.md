# 设计审查报告（v4 r1）

## 审查结果
REJECTED

## 发现

### [一般] Extend 3（fromMat 6a）Mat3x4 表中 Mat4x2 源方向实现错误（detail_v4.md:217）

`Mat3x4 from Mat4x2` 列 2 写为 `Vec4(m.c2.x,m.c2.y,zero,zero)`，应改为 `Vec4(m.c2.x,m.c2.y,one,zero)`。

原因：R_src=2→R_dst=4 做 rowExt，列 2 (j=2) 的新增行 i=2 恰为对角线位置 (2,2)，应填 `one`。

### [一般] Extend 3（fromMat 6a）Mat4x3 表中 Mat3x2 源方向有两处错误（detail_v4.md:241）

`Mat4x3 from Mat3x2`：
- 列 2 写为 `Vec3(m.c2.x,m.c2.y,zero)`，应为 `Vec3(m.c2.x,m.c2.y,one)` — rowExt 对角线 (2,2)
- 列 3 写为 `Vec3(zero,zero,one)`，应为 `Vec3(zero,zero,zero)` — colExt 新列 j=3≥R_src=2，全 T(0)；rowExt i=2≠j=3

### [一般] Extend 3（fromMat 6a）Mat4x3 表中 Mat4x2 源方向实现错误（detail_v4.md:244）

`Mat4x3 from Mat4x2` 列 2 写为 `Vec3(m.c2.x,m.c2.y,zero)`，应为 `Vec3(m.c2.x,m.c2.y,one)` — rowExt 对角线 (2,2)。

### [一般] Extend 3（fromMat 6a）Mat4x3 表中 Mat3x3 源方向实现错误（detail_v4.md:243）

`Mat4x3 from Mat3x3` 列 3 写为 `Vec3(zero,zero,one)`，应为 `Vec3(zero,zero,zero)` — colExt 新列 j=3≥R_src=3，全 T(0)。

### [一般] Extend 3（fromMat 6a）Mat3x4 表中 Mat2x3 源方向实现错误（detail_v4.md:213）

`Mat3x4 from Mat2x3` 列 2 写为 `Vec4(zero,zero,zero,one)`，应为 `Vec4(zero,zero,one,zero)` — colExt 新列 j=2 的对角线在行 2（第三个分量），`one` 应位于 Vec4 索引 2 而非索引 3。

### [一般] Extend 3（fromMat 6a）Mat3x4 表中 Mat3x2 源方向实现错误（detail_v4.md:215）

`Mat3x4 from Mat3x2` 列 2 写为 `Vec4(m.c2.x,m.c2.y,zero,zero)`，应为 `Vec4(m.c2.x,m.c2.y,one,zero)` — rowExt 对角线 (2,2)。

### [一般] Extend 3（fromMat 6a）Mat4x3 表中 Mat3x4 源方向实现错误（detail_v4.md:242）

`Mat4x3 from Mat3x4` 列 3 写为 `Vec3(zero,zero,one)`，应为 `Vec3(zero,zero,zero)` — colExt 新增列 j=3 在 Vec4 中填 `one` 于位置 3，但随后 rowSh 为 Vec3 时该 `one` 被截断。

## 修改要求

上列所有 fromMat 6a 方向的实现表达式均需按 **对角线优先** 规则修正：rowExt 新增分量中仅当 `i==j`（对角线）时填 `one`，其余填 T(0)；colExt 新增列 j 中仅当 `j<R_src` 时位置 j 填 `one`，否则全 T(0)。修正方向见各发现中的期望值。
