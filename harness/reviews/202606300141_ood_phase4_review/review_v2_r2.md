# R2: Ext quaternion 补齐 + GTC 矩阵相关文件审查

审查时间：2026-06-30

### 审查范围

**组 A — Ext quaternion 补齐（§3.2）**
- `cjglm/src/ext/quaternion_common.cj` — mix/slerp/slerp(k)
- `cjglm/src/ext/quaternion_transform.cj` — rotate
- `cjglm/src/ext/quaternion_trigonometric.cj` — angle/angleAxis
- `cjglm/src/ext/quaternion_geometric.cj` — dot/length/normalize/cross（确认委托）

**组 B — GTC 矩阵相关（§3.3）**
- `cjglm/src/gtc/matrix_transform.cj` — identity/translate/rotate/scale/lookAt/ortho/frustum/perspective 系族
- `cjglm/src/gtc/matrix_inverse.cj` — affineInverse/inverseTranspose
- `cjglm/src/gtc/matrix_access.cj` — row/column 行列访问

### 审查依据

- OOD 设计文档 `docs/06_ood_phase4.md` §§3.2~3.3
- `docs/02_roadmap.md` 阶段 4 部分
- `docs/deviations.md` 偏差记录
- 项目已有代码风格和 `cangjie-*` 系列 skill

### 发现

#### [一般] slerp k 参数版本公式与 GLM 1.0.3 存在潜在语义差异

- **位置**：`cjglm/src/ext/quaternion_common.cj:68-69`
- **描述**：`slerp(x, y, a, k)` 实现为 `sinT((one - a) * omega / k) / sinT(omega / k)` 和 `sinT(a * omega / k) / sinT(omega / k)`。此公式分母统一为 `sinT(omega / k)`，与 GLM 1.0.3 源码中 `slerp` 的 k 参数变体一致。但 GLM 1.0.3 的 `slerp` 四参数版本具体实现逻辑需交叉验证（OOD 设计文档 §3.2 标注"参考 GLM 1.0.3 源码"），建议补充单元测试覆盖 k 参数的边界场景（k=0、k=1、k=epsilon 等），验证退化路径选择是否与 GLM 一致。
- **建议**：补充 `slerp(x,y,a,k)` 的边界测试用例，特别是 k 值导致 `sinT(omega/k)` 接近零时的退化分支触发行为。

#### [一般] gtc/matrix_transform.cj shear 函数与 ext 版本 API 不同，需注意命名冲突

- **位置**：`cjglm/src/gtc/matrix_transform.cj:29-40`
- **描述**：gtc `shear` 的签名 `(m: Mat4x4, n: Vec3, s: T)` 与 ext `shear` 的签名 `(m: Mat4x4, p: Vec3, l_x: Vec2, l_y: Vec2, l_z: Vec2)` 在参数个数和类型上均不同。OOD 设计 §3.3 已明确此为有意识的设计差异（"gtc API 不同"），且通过仓颉函数重载机制可共存。但此差异在调用链中可能导致混淆，尤其是 `lib.cj:43` 从 ext 导入 `shear`，而 `lib.cj:23` 从 gtc 导入 `shear_slow` 但不导入 gtc 的 `shear`，最终用户层面 `glm.shear` 调用的是 ext 版本。
- **建议**：OOD 设计已有明确意图，当前格局无需修改。建议在 `gtc/matrix_transform.cj` 中补充注释，阐明两种 shear 语义的区别（ext: 通用剪切矩阵 vs gtc: 沿法线方向的简化剪切），帮助后续维护者理解。

#### [轻微] quaternion_common.cj slerp 退化分支未对 a 做 clamp

- **位置**：`cjglm/src/ext/quaternion_common.cj:50`
- **描述**：`slerp` 的 `sinOmega < epsilon` 退化分支直接使用原始 `a` 进行 lerp（`x*(one - a) + y*a`），而 `mix` 函数（同一文件行 38）对 `a` 做了 `clamp(a, zero, one)`。此差异符合 OOD 设计决策 D10（mix clamp vs lerp assert 的有意差异），但 slerp 退化路径的 lerp 既不 assert 也不 clamp，与同文件 `lerp` 函数（assert 策略）和 `mix` 函数（clamp 策略）存在三方不一致。
- **建议**：可接受当前做法（slerp 退化路径极其罕见），无需修改。如追求一致性，可考虑在退化分支中对 `a` 做 clamp 或 assert，与 `mix` 或 `lerp` 对齐。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 1 |

### 总评

**组 A（Ext quaternion）**：全部 4 个文件的实现正确、完整，与 OOD 设计文档 §§3.2 一致。关键路径验证通过：
- `mix` 正确使用 `clamp(a, 0, 1)` 后线性插值 ✅
- `slerp` 正确实现 `clamp(dot, -1, 1) → acos → sin → epsilon 退化分支` 的球面插值链路 ✅
- `slerp(k)` 四参数版本公式与 GLM 1.0.3 参考实现一致 ✅
- `rotate` 正确处理零长度轴（返回单位四元数），sin/cos 构造正确，四元数乘法公式正确 ✅
- `angle` 使用 `acos(clamp(x.w, -1, 1))`，`angleAxis` 使用 `sin/cos(halfAngle)` 构造 ✅
- `angleAxis` 位于 `quaternion_trigonometric.cj`（匹配OOD §1.4 差异说明，偏离路线图但正确）✅
- `quaternion_geometric.cj` 提供 Quat 专属 dot/length/normalize/cross，不可委托 detail.geometric（类型不同），通过复用 `sqrtT` 等 detail 原语实现"消除阶段三重复"的设计意图 ✅

**组 B（GTC 矩阵）**：全部 3 个文件的实现正确，与 OOD 设计 §§3.3 一致：
- `gtc/matrix_transform.cj` 正确采用委托模式（`public import glm.ext.*`），5 个 gtc 特定函数（identity、shear[gtc API]、rotate_slow、scale_slow、shear_slow）本地实现，其余 ~59 函数从 ext 层委托。64 函数系族完整覆盖 ✅
- `affineInverse` 公式正确（提取上三角 3×3 → inverse → 变换平移分量 → 重构 Mat4x4）✅
- `inverseTranspose` 正确实现 `transpose(inverse(m))`，提供 Mat3x3/Mat4x4 重载 ✅
- `row`/`column` 覆盖全部 9 种矩阵类型，非方阵返回维度正确（row dim = 列数，column dim = 行数），索引范围校验正确 ✅

代码质量良好，所有文件实现与设计文档一致，未发现数学逻辑错误或类型安全问题。
