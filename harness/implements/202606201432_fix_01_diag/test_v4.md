# 测试报告（v4）

## 概述

测试覆盖 `src/detail/type_cast.cj` 中 `castVec1`（4 个重载，R3 重命名）和 `castVec2`（4 个新增重载）的全部公开接口行为。

## 测试文件

| 文件路径 | 操作 | 说明 |
|---------|------|------|
| `src/detail/type_cast_test.cj` | 重命名 + 追加 | 13 处 `cast(` → `castVec1(`，新增 10 个 Vec2-target 测试函数 |

## 测试用例清单

### R3 测试（重命名，函数调用 `cast` → `castVec1`）

| 测试函数 | 场景 | 断言 |
|---------|------|------|
| `testCastVec1ToVec1IntToFloat` | Vec1<Int64>→Vec1<Float32> | `.x`=Float32(42.0) |
| `testCastVec2ToVec1TakesOnlyX` | Vec2<Int64>→Vec1<Int64> | `.x`=10（仅取 x） |
| `testCastVec3ToVec1TakesOnlyX` | Vec3<Int64>→Vec1<Int64> | `.x`=20（仅取 x） |
| `testCastVec4ToVec1TakesOnlyX` | Vec4<Int64>→Vec1<Int64> | `.x`=30（仅取 x） |
| `testCastSameTypeIdentity` | Vec1<Int64>→Vec1<Int64>, conv={x=>x} | `.x`=7 |
| `testCastInt32ToInt64` | Vec1<Int32>→Vec1<Int64> | `.x`=Int64(99) |
| `testCastFloatToIntTruncation` | Vec1<Float32>→Vec1<Int64> | `.x`=Int64(3) |
| `testCastCrossQualifierPackedHighpToDefaultp` | 跨 Q Vec1 | `.x`=5 |
| `testCastCrossQualifierDefaultpToPackedHighp` | 跨 Q Vec1（反向） | `.x`=8 |
| `testCastVec2CrossQualifierCrossType` | Vec2<Int32,PackedLowp>→Vec1<Float32,Defaultp> | `.x`=Float32(4.0) |
| `testCastVec3CrossQualifier` | Vec3<Int64,PackedMediump>→Vec1<Int64,Defaultp> | `.x`=15 |
| `testCastVec4CrossQualifier` | Vec4<Int64,PackedMediump>→Vec1<Int64,Defaultp> | `.x`=25 |
| `testCastVec1DoesNotModifySource` | 源 Vec 不可变性 | 源.x=42 |

### 新增 Vec2-target 测试

| 测试函数 | 场景 | 断言 |
|---------|------|------|
| `testCastVec2Vec1ToVec2IntToFloat` | Vec1<Int64>→Vec2<Float32> | `.x`=Float32(42.0), `.y`=Float32(42.0) |
| `testCastVec2Vec2ToVec2Identity` | Vec2<Int64>→Vec2<Int64> | `.x`=10, `.y`=20 |
| `testCastVec2Vec3ToVec2TakesOnlyXY` | Vec3<Int64>→Vec2<Int64> | `.x`=10, `.y`=20 |
| `testCastVec2Vec4ToVec2TakesOnlyXY` | Vec4<Int64>→Vec2<Int64> | `.x`=10, `.y`=20 |
| `testCastVec2SameTypeIdentity` | Vec2<Int64>→Vec2<Int64>, conv={x=>x} | `.x`=7, `.y`=8 |
| `testCastVec2Int32ToInt64` | Vec2<Int32>→Vec2<Int64> | `.x`=Int64(99), `.y`=Int64(88) |
| `testCastVec2FloatToIntTruncation` | Vec2<Float32>→Vec2<Int64> | `.x`=Int64(3), `.y`=Int64(5) |
| `testCastVec2CrossQualifierPackedHighpToDefaultp` | 跨 Q Vec2 | `.x`=5, `.y`=6 |
| `testCastVec2DoesNotModifySource` | 源 Vec 不可变性 | 源.x=42, 源.y=43 |
| `testCastVec2Vec1ToVec2SameValueBothComponents` | Vec1→Vec2 xy 相同 | `.x`=7, `.y`=7 |

## 覆盖维度的映射

| 维度 | 覆盖情况 |
|------|---------|
| 正常路径 | 所有 4 种源类型（Vec1/Vec2/Vec3/Vec4）→ Vec1 和 Vec2 |
| 跨类型转换 | Int32→Int64, Int64→Float32, Float32→Int64 |
| 跨 Qualifier | PackedHighp→Defaultp, Defaultp→PackedHighp, PackedLowp→Defaultp |
| 源不可变性 | 调用后源 Vec 分量值不变 |
| 身份转换 | 同类型同 Q，conv={x=>x} |
| Vec1→Vec2 分量填充 | xy 两分量值相同（单分量来源） |
| Vec3/Vec4→Vec2 截取 | 仅取前两分量，后序分量静默丢弃 |

## 缺失覆盖说明

- Bool 类型：当前测试组件未覆盖 Bool 分量的 cast 场景。`castVec1`/`castVec2` 泛型参数 T2 无约束，理论上支持 Bool。但因 R3 和当前轮次均未接到 Bool cast 的需求，暂不补充
- Float64 类型：当前使用 Float32，Float64 逻辑等价
- 边界值：未专门测试溢出/Inf/NaN 场景，因 cast 函数仅做闭包转换，不涉及算术运算，边界行为由 `conv` 闭包实现保证

## 执行结果

`cjpm test` —— 332/332 PASSED（R3 基线 322，新增 10 个 Vec2-target 测试全部通过）
