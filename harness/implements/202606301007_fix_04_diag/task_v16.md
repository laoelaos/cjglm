# 任务指令（v16）

## 动作
NEW

## 任务描述
在 `tests/glm/gtc/packing_test.cj` 中补充 12 组 pack/unpack 函数的 round-trip 测试（含常规值和边界值），覆盖当前缺失的全部函数对。标记 `04_diag.md` G34 为 ✅ 已修复。更新 `plan.md` 路线表 v16 列 P4-4 标记 ✅。

## 选择理由
v15 完成 P4-3 末批（G31），P4-4 是最后一批待完成的任务。G34（packing 函数覆盖）是 gtc 测试补充中最大的批次（12 对函数，24 个函数），自包含于单个测试文件，风险低。后续剩余 G35（noise_test 边界）、G36+G37（ulp_test 边界）可在后续轮次完成。

## 任务上下文
### 需要补充的函数对（12 对，当前缺失）

| 函数对 | 输入类型 | 返回类型 | Round-trip 验证模式 |
|--------|---------|---------|-------------------|
| packUnorm1x8/unpackUnorm1x8 | Float32 / UInt8 | UInt8 / Float32 | 常规值 0.0/0.5/1.0 + 边界 0.0/1.0 |
| packUnorm2x8/unpackUnorm2x8 | Vec2<Float32> / UInt16 | UInt16 / Vec2<Float32> | 常规值 Vec2(0.0, 0.5) + 边界 |
| packUnorm1x16/unpackUnorm1x16 | Float32 / UInt16 | UInt16 / Float32 | 常规值 0.0/0.5/1.0 + 边界 |
| packUnorm2x16/unpackUnorm2x16 | Vec2<Float32> / UInt32 | UInt32 / Vec2<Float32> | 常规值 Vec2(0.0, 0.5) + 边界 |
| packUnorm4x16/unpackUnorm4x16 | Vec4<Float32> / UInt64 | UInt64 / Vec4<Float32> | 常规值 Vec4(0.0, 0.5, 1.0, 0.3) + 边界 |
| packSnorm1x8/unpackSnorm1x8 | Float32 / UInt8 | UInt8 / Float32 | 常规值 -1.0/-0.5/0.0/0.7 + 边界 ±1.0 |
| packSnorm2x8/unpackSnorm2x8 | Vec2<Float32> / UInt16 | UInt16 / Vec2<Float32> | 常规值 Vec2(-1.0, 0.5) + 边界 |
| packSnorm1x16/unpackSnorm1x16 | Float32 / UInt16 | UInt16 / Float32 | 常规值 -1.0/-0.5/0.0/0.7 + 边界 ±1.0 |
| packSnorm2x16/unpackSnorm2x16 | Vec2<Float32> / UInt32 | UInt32 / Vec2<Float32> | 常规值 Vec2(-1.0, 0.5) + 边界 |
| packSnorm4x16/unpackSnorm4x16 | Vec4<Float32> / UInt64 | UInt64 / Vec4<Float32> | 常规值 Vec4(-1.0, -0.5, 0.0, 0.7) + 边界 |
| packHalf2x16/unpackHalf2x16 | Vec2<Float32> / UInt32 | UInt32 / Vec2<Float32> | 常规值 Vec2(0.0, 1.0) + 负值 Vec2(-0.5, -1.0) |
| packHalf4x16/unpackHalf4x16 | Vec4<Float32> / UInt64 | UInt64 / Vec4<Float32> | 常规值 Vec4(0.0, 1.0, -1.0, 0.5) |

### 已有测试模式参考

**Unorm 已有测试（packUnorm4x8/unpackUnorm4x8）：**
```cangjie
let eps = Float32(1.0) / Float32(255.0)
@Expect(abs(unpacked.x - Float32(0.0)) < eps, true)
```
- 8-bit Unorm eps = `Float32(1.0) / Float32(255.0)`
- 16-bit Unorm eps = `Float32(1.0) / Float32(65535.0)`

**Snorm 已有测试（packSnorm4x8/unpackSnorm4x8）：**
```cangjie
let eps = Float32(1.0) / Float32(127.0)
@Expect(abs(unpacked.x - Float32(-1.0)) < eps, true)
```
- 8-bit Snorm eps = `Float32(1.0) / Float32(127.0)`
- 16-bit Snorm eps = `Float32(1.0) / Float32(32767.0)`

**Half 已有测试（packHalf1x16/unpackHalf1x16）：**
```cangjie
let eps = Float32(0.001)
@Expect(abs(unpacked - v) < eps, true)
```

### 文件位置
`cjglm/tests/glm/gtc/packing_test.cj` —— 当前 86 行，4 组已有测试（testPackUnorm4x8Roundtrip, testPackUnorm4x8Boundary, testPackSnorm4x8Roundtrip, testPackSnorm4x8Boundary, testPackHalf1x16Roundtrip, testPackDouble2x32Roundtrip）

## 04_diag.md 标记
- 文件：`docs/diag/impl/04_diag.md` L391-410
- G34 条目末尾追加 `✅ 已修复`
