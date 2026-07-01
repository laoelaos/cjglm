# 任务指令（v13）

## 动作
NEW

## 任务描述
P4-3首批：quaternion测试补充（G28/G29/G30）+ G24/G27 ✅ 标记。

具体工作：
1. `tests/glm/ext/quaternion_common_test.cj` — 补充 G28（slerp中点验证+退化分支）+ G29（mix越界clamp）
2. `tests/glm/ext/quaternion_trigonometric_test.cj` — 补充 G30（axis round-trip）
3. `docs/diag/impl/04_diag.md` — 标记 G24/G27/G28/G29/G30 ✅ 已修复
4. `plan.md` 路线表 v13 列标记 P4-3 ✅

## 选择理由
v12 已完成 P4-2（G21-G23/G32-G33）。按 04_diag.md ext 测试分批顺序，首批为 quaternion 测试（G28/G29/G30）。G24 仅为标记（已通过 OOD D32 决策无需代码变更），G27 仅为标记（fmin/fmax 3/4 输入测试已随 G5 修复完成），两项零修改成本。G28/G29/G30 均位于 quaternion 测试文件（ext/ 包），修改范围集中、风险低、自包含。

## 任务上下文

### G28: quaternion_common_test.cj slerp 缺少中点验证和退化分支测试
- **位置**：`tests/glm/ext/quaternion_common_test.cj:175-205`
- **现有测试**：testSlerp（仅 a=0/a=1）、testSlerp4ArgsK（仅 a=0/a=1）、testSlerpShortestPath、testSlerp4ArgsKZero、testSlerp4ArgsShortestPath
- **需补充**：
  - slerp(a=0.5) 中点验证：使用两个正交单位四元数，验证 slerp 中点结果为 `(x+y)/|x+y|` 归一化
  - cosTheta→1 退化分支：使用近乎相同的两个四元数（如 q 和 q+极微扰），验证 slerp 退化为线性插值（结果接近 lerp）
  - cosTheta<0 取反分支：使用点积为负的两个四元数（角度差 >90°），验证 slerp 通过取反最近路径

### G29: quaternion_common_test.cj mix 越界 a<0 或 a>1 时 clamp 行为未测试
- **位置**：`tests/glm/ext/quaternion_common_test.cj:132-172`
- **现有测试**：testMix、testMixFloat32、testMixFloat16——均只测试 a=0/a=0.5/a=1
- **需补充**：
  - `testMixClampBelow(a=-0.5)`：验证 @Expect 结果等于 a=0 的值（clamp to 0）
  - `testMixClampAbove(a=1.5)`：验证 @Expect 结果等于 a=1 的值（clamp to 1）

### G30: quaternion_trigonometric_test.cj axis round-trip 未测试
- **位置**：`tests/glm/ext/quaternion_trigonometric_test.cj:68-74`
- **现有测试**：testAngleAngleAxisRoundtrip（仅 angle(angleAxis) round-trip）
- **需补充**：
  - `testAxisAngleAxisRoundtrip`：使用非单位轴向量（如 (0,1,0)），构造 angleAxis(theta, axis)，验证 axis(result) 与原始 axis 方向一致（点积 > 1-eps）

### G24: 仅标记 ✅ 已修复
- **位置**：`docs/diag/impl/04_diag.md:320-326`
- **说明**：OOD D32 已决定零轴返回单位四元数，无需修改代码

### G27: 仅标记 ✅ 已修复
- **位置**：`docs/diag/impl/04_diag.md:341-346`
- **说明**：fmin/fmax 3/4 输入 Vec1~Vec4 测试已全部存在（vector_common_test.cj:136-361），随 G5 修复完成时一并添加

## 已有代码上下文
- 测试文件均为 ext 包（`package glm.ext`），使用 `import glm.detail.{ Quat, Vec3, Defaultp }`
- 四元数类型：`Quat<Float64, Defaultp>`
- slerp 签名：`slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>`（三参数）；`slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: T): Quat<T, Q>`（四参数）
- mix 签名：`mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>`——实现内含 clamp(a, 0, 1)
- angleAxis 签名：`angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>`
- axis 签名：`axis<T, Q>(q: Quat<T, Q>): Vec3<T, Q>`
- 所有 slerp 测试使用 dot 为 0 的正交四元数（如 (1,0,0,0) 和 (0,1,0,0)），cosTheta=0 是最清晰的非退化测试条件
- 更完整的 slerp 测试需覆盖：cosTheta≈1（退化到 lerp）、cosTheta<0（取反最短路径）
