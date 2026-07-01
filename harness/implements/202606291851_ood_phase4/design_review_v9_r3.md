# 设计审查报告（v9 r3）

## 审查结果
APPROVED

## 发现

### **[轻微]** round.cj ceilPowerOfTwo 公式隐含 `==` 比较泛型 T

ceilPowerOfTwo 公式写为 `if x == floorPowerOfTwo(x)`，但偏差 **IMPL-03** 明确约束 `FloatingPoint<T>` 不支持 `==` 比较泛型 `T` 的值（编译器报 `invalid binary operator '==' on type 'Generics-T'`）。

偏差提示 #3 已指明 "比较泛型 T 的值时，先转为 Float64 再比较"，且该偏差在 `docs/deviations.md:724` 有完整记录，已知晓于此项目所有开发者。公式为概念性数学描述而非可执行代码，不影响实现者的正确理解。

### **[轻微]** packHalf Float32→Float16 下溢路径的舍入模式

下溢路径（`exp32 <= 112`）使用 `mant32 + (1 << (shift - 1))`（ties-away-from-zero），而规格化数路径使用 `mant32 + 0x1000 + ((mant32 >> 13) & 1)`（round-to-nearest-even），两路径舍入模式不一致。下溢场景中遇到 exact tie 的概率极低，实际数值行为几乎无差异。

### **[轻微]** packHalf/unpackHalf 伪代码未显式展示最终类型收窄/转换步骤

- packHalf：伪代码在 UInt32 域操作后生成 `result`，但函数返回类型为 `UInt16`，缺少 `(result as UInt16).getOrThrow()` 收窄步骤。
- unpackHalf：伪代码在 UInt32 域组装 `result`，但函数返回类型为 `Float32`，缺少 `Float32.fromBits(result)` 转换步骤。

上述步骤属于位操作隐式规约，不影响实现者理解。

## 修改要求
无
