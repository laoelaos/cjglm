# 设计审查报告（v2 r2）

## 审查结果
REJECTED

## 发现

### **[严重] P1-3 slerp cosOmega<0 分支未重新计算 omega**

**问题位置**：`detail_v2.md:100-115`（两参数 slerp）、`detail_v2.md:139-156`（四参数 slerp(k)）

**问题描述**：当 `cosOmega < 0` 时，设计代码仅对 y 取反（`let z = if (cosOmega < zero) { -y } else { y }`），但继续使用基于原始 `cosOmega`（负值）计算的 `omega = acos(cosOmega)`——此时 omega 为钝角（> π/2）。最短路径 slerp 的正确做法是在取反 y 后**重新计算 omega = acos(-cosOmega)**（使用绝对值），使 omega 成为 x 与 -y 之间的锐角（< π/2）。

**数学验证**：设原始 cosOmega = -0.5, ω = acos(-0.5) = 2π/3 (120°)。最短路径应使用 x 与 -y 之间的夹角 ω' = acos(0.5) = π/3 (60°)。当 a = 0.5：
  - 正确：sin((1-0.5) * π/3) = sin(π/6) = 0.5
  - 设计：sin((1-0.5) * 2π/3) = sin(π/3) ≈ 0.866
  - 结果不同，产生错误插值

**GLM 对照**：GLM 1.0.3 `ext/quaternion_common.inl:41-110` 在 `if (cosTheta < T(0)) { y = -y; cosTheta = -cosTheta; theta = acos(cosTheta); }` 中明确**重新计算 theta**。设计未遵循此模式。

**期望修正**：对标 GLM 实现，在取反 y 的同时，将 `cosOmega` 取绝对值（或重新 clamp 计算），然后基于新的 `cosOmega' = -cosOmega` 重新计算 `omega = acos(cosOmega')` 和 `sinOmega = sin(omega)`，再用更新后的 omega/sinOmega 计算 scale0/scale1。

---

### **[一般] P1-2 float_distance toUInt32()/toUInt64() 方法不可用**

**问题位置**：`detail_v2.md:51-52`、`detail_v2.md:60-61`

**问题描述**：设计代码使用 `a.toUInt32()` 和 `a.toUInt64()` 将 Int32/Int64 转为无符号类型。根据已有偏差记录 `deviations.md:725`（IMPL-04），Cangjie 标准库中 `Int32` 无 `toUInt32()` 方法，`Int64` 无 `toUInt64()` 方法。此前已验证此问题并统一采用 `(a as UInt32).getOrThrow()` 模式。

**证据**：代码库中所有 Int32→UInt32 转换（`common.cj:344,357-360`、`packing.cj:16-19,28-29`）均使用 `(val as UInt32).getOrThrow()`，不存在任何 `.toUInt32()` 调用。

**期望修正**：将 `a.toUInt32()` 替换为 `(a as UInt32).getOrThrow()`，`ua.toUInt64()` 替换为 `(ua as UInt64).getOrThrow()`。注意 `ua`/`ub` 已为 Int32/Int64 类型，转换模式统一为 `(a as UInt32).getOrThrow()`。

## 修改要求

1. **[严重]** P1-3 两参数和四参数 slerp 的 cosOmega<0 分支：取反 y 后，需重新计算 `omega = acos(-cosOmega)`（或等价地将 cosOmega 取绝对值后计算），确保最短路径插值使用正确的角度。
2. **[一般]** P1-2 float_distance：将 `Int32.toUInt32()` 调用替换为 `(Int32 as UInt32).getOrThrow()` 模式（Int64 同理），与代码库已有约定一致。
