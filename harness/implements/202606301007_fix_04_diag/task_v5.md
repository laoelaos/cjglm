# 任务指令（v5）

## 动作
NEW

## 任务描述
实现 P2-3（G6）：修改 `ext/scalar_common.cj` 中 `iround`/`uround` 函数，改用 `stdmath_shim.roundT` 委托路径。

具体变更：
1. `ext/scalar_common.cj:3` 的 import 增加 `roundT`（来自 `glm.detail`）
2. `ext/scalar_common.cj:104-108` `iround<T>(x: T): Int64` 改为委托 `roundT`：
   ```cangjie
   public func iround<T>(x: T): Int64 where T <: FloatingPoint<T> {
       (roundT(x) as Int64).getOrThrow()
   }
   ```
3. `ext/scalar_common.cj:110-114` `uround<T>(x: T): UInt64` 改为委托 `roundT`：
   ```cangjie
   public func uround<T>(x: T): UInt64 where T <: FloatingPoint<T> {
       (roundT(x) as UInt64).getOrThrow()
   }
   ```
4. 标记 `docs/diag/impl/04_diag.md` 中 G6 条目（`:143` 行附近）为已修复

## 选择理由
P2-3 是 P2 批次中优先级最高的待完成任务——同为实现与设计偏差修正（G6），且修改范围极小（仅两个函数体），风险低、自包含，快速完成后可继续 P2 批次后续任务（P2-4 删除 ext dquat、P2-5 round.cj ±0 保留符号）。

## 任务上下文
- **问题**：当前 `iround`/`uround` 直接用 `math.round(xF64)` 然后类型转换，未使用 OOD 设计的 `roundT` 统一委托路径
- **OOD 要求**：§3.2 `ext/scalar_common.cj` 明确指定 `iround/uround 实现为 Int64(stdmath_shim.roundT(x))`
- **roundT 签名**：`stdmath_shim.cj:90` — `public func roundT<T>(x: T): T where T <: FloatingPoint<T>`
- **04_diag.md 引用**：行 143-152 指出修改方向为"修改实现代码，改用 `stdmath_shim.roundT(x)` 统一委托路径"

## 已有代码上下文
- `ext/scalar_common.cj:3` 当前 import 为：`import std.math.{ FloatingPoint, Number }` + `import std.math as math` + `import glm.detail.{ min, max, abs, clamp, floor, fract, isnan, mix }`
- `iround`/`uround` 实现位于 `ext/scalar_common.cj:104-114`
- `stdmath_shim.roundT` 位于 `detail/stdmath_shim.cj:90-92`
- `detail/common.cj:166, 169, 246-249` 已在多处使用 `roundT`，证明该函数可用且工作正常
- 无需修改 `lib.cj`（iround/uround 已在 lib.cj 的 export 覆盖范围内）
