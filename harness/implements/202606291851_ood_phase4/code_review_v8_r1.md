# 代码审查报告（v8 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `src/ext/quaternion_geometric.cj:5` — 偏差提示第 9 条明确要求移除私有 `sqrtT` 并改为 `import glm.detail.sqrtT`，但该文件第 5-8 行仍保留私有 `sqrtT` 函数。`ext/quaternion_trigonometric.cj` 已正确移除，但 `quaternion_geometric.cj` 遗漏修改。

- **[一般]** `src/ext/quaternion_common.cj:58` — `slerp(x, y, a, k)` 签名中 `k` 参数类型为 `Int64`，设计 A.5 节（第 599 行）明确指明 `k: T`。类型不符导致 API 契约偏离设计规格。

- **[一般]** `src/ext/vector_common.cj` — 多处缺失 Vec1 重载，与设计 B.1 节 "Vec1~Vec4" 的声明不符：
  - fmin/fmax/fclamp 系列：缺少 Vec1 版本（设计称 4 个重载 Vec1~Vec4，仅实现 Vec2~Vec4）
  - 纹理环绕函数（clamp/repeat/mirrorClamp/mirrorRepeat）：缺少 Vec1 版本（设计称 16 个函数，仅实现 12 个）
  - iround/uround：缺少 Vec1 版本（设计称 8 个函数，仅实现 6 个）

## 修改要求（仅 REJECTED 时）

1. **`src/ext/quaternion_geometric.cj:5`** — 私有 `sqrtT` 函数（第 5-8 行）必须删除，改为从 `glm.detail` 导入公开版 `sqrtT`。该文件当前 `import` 行未含 `sqrtT`，需追加到导入列表。这是偏差提示第 9 条明确要求的修改。

2. **`src/ext/quaternion_common.cj:58`** — 将 `slerp` 4 参数重载的第四个参数类型由 `Int64` 改为 `T`（与设计一致），内部转换逻辑相应调整。

3. **`src/ext/vector_common.cj`** — 补充所有缺失的 Vec1 重载：
   - 为 fmin/fmax/fclamp 各补充 Vec1 版本（标量-向量和向量-向量两个变体）
   - 为 clamp/repeat/mirrorClamp/mirrorRepeat 各补充 Vec1 版本
   - 为 iround/uround 各补充 Vec1 版本
   - 注意 Vec1 已是导入状态，可直接使用
