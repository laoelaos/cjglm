# 设计审查报告（v9 r2）

## 审查结果
REJECTED

## 发现

### **[严重]** packSnorm 函数族缺少 signed→unsigned 位重解释步骤

**问题**：packSnorm1x8/2x8/4x8 的公式 `(round(clamp(v, -1, 1) * 127.0) as UInt8).getOrThrow()` 在输入为负值时会运行时失败。当 `v = -1.0`，中间值 `round(-127.0)` = -127.0，`(Float32(-127.0) as UInt8)` 返回 `None`（因 UInt8 范围为 0-255），`.getOrThrow()` 抛出异常。同理 packSnorm1x16 族也存在此问题。

**参考实现**（`references/glm-1.0.3/glm/glm/gtc/packing.inl:396-401`）：GLM 先转换为 `int8` 中间值，再通过 `memcpy` 进行位重解释为 `uint8`：
```cpp
int8 const Topack(static_cast<int8>(round(clamp(v, -1.0f, 1.0f) * 127.0f)));
uint8 Packed = 0;
memcpy(&Packed, &Topack, sizeof(Packed));
return Packed;
```

**修正方向**：公式应为 `round(clamp(...) * 127.0)` → 先 `as Int8`（值域 [-127, 127]，在 Int8 范围内）→ `Int8.fromBits(...)` → 再用 `UInt8.fromBits(int8Val.toBits())` 进行位重解释。

---

### **[严重]** unpackSnorm 函数族缺少 unsigned→signed 位重解释步骤

**问题**：`unpackSnorm1x8` 的公式 `clamp(Float32(p) / Float32(127.0), -1.0, 1.0)` 将 `p` 直接解释为正数。当 `packSnorm1x8(-1.0)` 返回的 `p = 129`（-127 的补码表示），`Float32(129)/127.0 ≈ 1.0157`，经 clamp 得到 1.0，而不是预期的 -1.0。pack→unpack 互逆性被破坏。

**参考实现**（`packing.inl:404-411`）：先通过 `memcpy` 将 `uint8` 位模式重解释为 `int8`，再转为 float：
```cpp
int8 Unpack = 0;
memcpy(&Unpack, &p, sizeof(Unpack));
return clamp(static_cast<float>(Unpack) * (1.0f/127.0f), -1.0f, 1.0f);
```

**修正方向**：公式应为 `Float32(Int8.fromBits(p.toBits())) / Float32(127.0)` 先位重解释再类型转换。

---

### **[严重]** Float16→Float32 (unpackHalf) 次规格数/零值转换公式错误

**问题**：公式 `if exp16 == 0: return sign | ((mant16 + 0x400) >> 1)` 有两点错误：
1. **零值**：mant16=0 时结果为 `sign | 0x200 ≠ 0`，应返回 0.0（符号位保留）。
2. **次规格数**：该公式产生错误的位模式。例如 mant16=1（最小次规格数，值 2^-24），该公式产生 Float32 次规格数 2^-140，实际应为 Float32 规格化数 2^-24（exponent=103）。

**参考实现**（`references/glm-1.0.3/glm/glm/detail/type_half.inl:31-103`）：GLM 的 `toFloat32` 对零值特殊处理（返回 `sign << 31`），对次规格数先通过 while 循环标准化，再走规格化数路径组装指数和尾数：
```cpp
if (e == 0) {
    if (m == 0) { /* zero */ }
    else {
        while (!(m & 0x00000400)) { m <<= 1; e -= 1; }
        e += 1; m &= ~0x00000400;
        // fall through to normal path
    }
}
// Normal path: e = e + (127 - 15); m = m << 13;
```

**修正方向**：直接采用 GLM 参考实现的标准化算法，而非简单位运算公式。

---

### **[一般]** Float32→Float16 (packHalf) 缺少舍入步骤

**问题**：GLM 参考的 `toFloat16`（`type_half.inl:105-237`）在规格化数路径中包含舍入逻辑：
```cpp
if (m & 0x00001000) { m += 0x00002000; if (m & 0x00800000) { m = 0; e += 1; } }
``` 
设计文档中的位操作公式仅做截断（`mant32 >> 13`），忽略舍入，导致精度损失和不对称行为。

**修正方向**：在 mantissa 右移前添加舍入判断，参照 GLM 实现。

---

### **[一般]** packDouble2x32 / unpackDouble2x32 类型不一致

**问题**：GLM 参考（`detail/func_packing.inl:129-154`）签名是 `uvec2 → double` / `double → uvec2`（两个 UInt32 ↔ Float64），而设计文档的签名是 `Vec2<Float64, Q> → UInt64` / `UInt64 → Vec2<Float64, Q>`。两个 Float64（各 64 位）无法无损装入一个 UInt64（64 位）；公式中的位运算含义不明确。即使意图是对 `Float64.toBits()` 的低 32 位做提取，设计也未明确说明。

**修正方向**：明确函数签名为 `Vec2<UInt32, Q> → Float64`（匹配 GLSL/GLM 语义），并相应调整位运算公式。

---

### **[轻微]** type_precision.cj 别名数量声明不一致

**问题**：设计文档声称"~100 个 type 别名"，但实际列出的别名仅为 69 个。虽不影响功能，但数量偏差可能误导后续规划或测试覆盖判断。

**修正方向**：将"~100 个"改为精确数量 69，或补齐缺失的别名。
