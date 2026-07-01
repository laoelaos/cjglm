# 任务指令（v10 r1）

## 动作
RETRY

## 任务描述
补充几何/矩阵测试覆盖：P4-2 第一批 G21+G22

### G21 — geometric_test.cj 补充边界测试
向 `tests/glm/detail/geometric_test.cj` 新增以下测试函数：

1. `testLengthZeroVec2/3/4` — `length(zero_vector) = 0`，验证 Vec2/Vec3/Vec4 零向量
2. `testDistanceSamePointVec2/3/4` — `distance(p, p) = 0`，验证 Vec2/Vec3/Vec4 同点距离
3. `testCrossParallel` — `cross(parallel vectors) = zero vector`，验证 Vec3 平行向量叉积为零
4. `testReflectPerpendicular` — `reflect(I, N) = -I` 当 I ∥ N（垂直入射反射），验证 Vec2/Vec3/Vec4

### G22 — geometric_refract_test.cj 补充边界测试
向 `tests/glm/detail/geometric_refract_test.cj` 新增以下测试函数：

1. `testRefractEtaOne` — `eta=1.0` 时光线直穿（无折射），`refract(I, N, 1.0) = I`，验证 Vec2/Vec3/Vec4
2. `testRefractTotalInternalReflection` — 大 eta 导致全内反射返回零向量，补充 Vec2/Vec4 全内反射测试（已有 Vec3 版本）

注意：不添加 Vec1 测试——`refract` 函数仅有 Vec2/Vec3/Vec4 重载（`geometric.cj:77,88,99`），不存在 Vec1 版本，且代码库中对几何函数（reflect/refract/length/distance）均未提供 Vec1 重载，保持一致性不新增 Vec1。

## 选择理由
P4-1（G13-G20 core 函数库测试）已在 v9 完成并验证通过。按 04_diag.md 中"几何/矩阵测试分批"顺序，第一批 G21+G22 为当前优先级最高的下一任务。两个问题均位于 `tests/glm/detail/` 目录，修改范围集中、风险低。

## 任务上下文
- 测试文件 `tests/glm/detail/geometric_test.cj` — 已有 dot/length/distance/cross/normalize/reflect/faceforward 常规测试，无边界情况
- 测试文件 `tests/glm/detail/geometric_refract_test.cj` — 已有 Vec2/Vec3/Vec4 折射测试 + 1 个全内反射测试（Vec3），无 eta=1 无折射边界，无 Vec2/Vec4 全内反射补充
- 函数签名参考（来自 detail 包）：
  - `length(v: Vec<T,Q>): T`
  - `distance(p0: Vec<T,Q>, p1: Vec<T,Q>): T`
  - `cross(x: Vec3<T,Q>, y: Vec3<T,Q>): Vec3<T,Q>`
  - `reflect(I: Vec<T,Q>, N: Vec<T,Q>): Vec<T,Q>`
  - `refract(I: Vec<T,Q>, N: Vec<T,Q>, eta: T): Vec<T,Q>`
  - `refract` 仅有 Vec2/Vec3/Vec4 重载，无 Vec1
- 04_diag.md G21/G22 条目末尾需添加 ✅ 已修复 标记
- plan.md 路线表需更新 v10 列 P4-2 标记

## RETRY 说明
v10 审查（plan_review_v10_r1.md）指出两个问题：
1. **[一般]** Vec1 `refract` 函数不存在，原计划的 `testRefractVec1` 不可实现。已选择方案A：放弃 Vec1 测试，改为补充 Vec2/Vec4 全内反射测试，保持与代码库现有模式一致（几何函数均无 Vec1 重载）。
2. **[轻微]** 原计划未提及 plan.md 路线表更新步骤。已在本任务上下文中补充。
