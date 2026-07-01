# 详细设计（v16）

## 概述

完成 P4-4 首批 G34：为 `tests/glm/gtc/packing_test.cj` 补充 12 组 pack/unpack 函数的 round-trip 测试（含常规值和边界值），覆盖当前缺失的全部函数对。全部变更限于测试文件、诊断文档和计划路线表，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/gtc/packing_test.cj` | 在 `:86` 后追加 | 新增 22 个测试函数覆盖 12 对缺失 pack/unpack |
| `docs/diag/impl/04_diag.md:391` | 修改 | G34 行末尾追加 `✅ 已修复` |
| `harness/implements/202606301007_fix_04_diag/plan.md:26` | 修改 | 路线表 v16 列 P4-4 标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数。

## 新增测试函数签名

所有函数位于 `package glm.gtc`，`@Test` 标记，返回 `Unit`。

### Unorm 标量（packUnorm1x8/unpackUnorm1x8）

```
@Test func testPackUnorm1x8Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(255.0)`
- 调用：`packUnorm1x8(v: Float32)` → `UInt8` → `unpackUnorm1x8(p: UInt8)` → `Float32`
- 值：`0.0`, `0.5`, `1.0`
- 断言：`@Expect(abs(unpacked - val) < eps, true)`

```
@Test func testPackUnorm1x8Boundary(): Unit
```
- `0.0` → `@Expect(unpacked, Float32(0.0))`
- `1.0` → `@Expect(unpacked, Float32(1.0))`

### Unorm Vec2（packUnorm2x8/unpackUnorm2x8）

```
@Test func testPackUnorm2x8Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(255.0)`
- 调用：`packUnorm2x8(v)` → `UInt16` → `unpackUnorm2x8<Defaultp>(packed)` → `Vec2<Float32, Defaultp>`
- 值：`Vec2<Float32, Defaultp>(Float32(0.0), Float32(0.5))`
- 断言：`@Expect(abs(unpacked.x - val.x) < eps, true)`（对 x/y 分别做）

```
@Test func testPackUnorm2x8Boundary(): Unit
```
- `Vec2(0.0, 0.0)` → `@Expect(unpacked.x, Float32(0.0))` / `@Expect(unpacked.y, Float32(0.0))`
- `Vec2(1.0, 1.0)` → `@Expect(unpacked.x, Float32(1.0))` / `@Expect(unpacked.y, Float32(1.0))`

### Unorm 标量 16-bit（packUnorm1x16/unpackUnorm1x16）

```
@Test func testPackUnorm1x16Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(65535.0)`
- 调用：`packUnorm1x16(v: Float32)` → `UInt16` → `unpackUnorm1x16(p: UInt16)` → `Float32`
- 值：`0.0`, `0.5`, `1.0`

```
@Test func testPackUnorm1x16Boundary(): Unit
```
- `0.0` → exact `0.0`
- `1.0` → exact `1.0`

### Unorm Vec2 16-bit（packUnorm2x16/unpackUnorm2x16）

```
@Test func testPackUnorm2x16Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(65535.0)`
- 调用：`packUnorm2x16(v)` → `UInt32` → `unpackUnorm2x16<Defaultp>(packed)` → `Vec2<Float32, Defaultp>`
- 值：`Vec2(0.0, 0.5)`

```
@Test func testPackUnorm2x16Boundary(): Unit
```
- `Vec2(0.0, 0.0)` exact
- `Vec2(1.0, 1.0)` exact

### Unorm Vec4 16-bit（packUnorm4x16/unpackUnorm4x16）

```
@Test func testPackUnorm4x16Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(65535.0)`
- 调用：`packUnorm4x16(v)` → `UInt64` → `unpackUnorm4x16<Defaultp>(packed)` → `Vec4<Float32, Defaultp>`
- 值：`Vec4(0.0, 0.5, 1.0, 0.3)`

```
@Test func testPackUnorm4x16Boundary(): Unit
```
- `Vec4(0.0, 0.0, 0.0, 0.0)` exact
- `Vec4(1.0, 1.0, 1.0, 1.0)` exact

### Snorm 标量 8-bit（packSnorm1x8/unpackSnorm1x8）

```
@Test func testPackSnorm1x8Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(127.0)`
- 调用：`packSnorm1x8(v: Float32)` → `UInt8` → `unpackSnorm1x8(p: UInt8)` → `Float32`
- 值：`-1.0`, `-0.5`, `0.0`, `0.7`

```
@Test func testPackSnorm1x8Boundary(): Unit
```
- `1.0` → `@Expect(unpacked, Float32(1.0))`
- `-1.0` → `@Expect(unpacked, Float32(-1.0))`

### Snorm Vec2 8-bit（packSnorm2x8/unpackSnorm2x8）

```
@Test func testPackSnorm2x8Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(127.0)`
- 调用：`packSnorm2x8(v)` → `UInt16` → `unpackSnorm2x8<Defaultp>(packed)` → `Vec2<Float32, Defaultp>`
- 值：`Vec2(-1.0, 0.5)`

```
@Test func testPackSnorm2x8Boundary(): Unit
```
- `Vec2(1.0, 1.0)` exact
- `Vec2(-1.0, -1.0)` exact

### Snorm 标量 16-bit（packSnorm1x16/unpackSnorm1x16）

```
@Test func testPackSnorm1x16Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(32767.0)`
- 调用：`packSnorm1x16(v: Float32)` → `UInt16` → `unpackSnorm1x16(p: UInt16)` → `Float32`
- 值：`-1.0`, `-0.5`, `0.0`, `0.7`

```
@Test func testPackSnorm1x16Boundary(): Unit
```
- `1.0` exact; `-1.0` exact

### Snorm Vec2 16-bit（packSnorm2x16/unpackSnorm2x16）

```
@Test func testPackSnorm2x16Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(32767.0)`
- 调用：`packSnorm2x16(v)` → `UInt32` → `unpackSnorm2x16<Defaultp>(packed)` → `Vec2<Float32, Defaultp>`
- 值：`Vec2(-1.0, 0.5)`

```
@Test func testPackSnorm2x16Boundary(): Unit
```
- `Vec2(1.0, 1.0)` exact
- `Vec2(-1.0, -1.0)` exact

### Snorm Vec4 16-bit（packSnorm4x16/unpackSnorm4x16）

```
@Test func testPackSnorm4x16Roundtrip(): Unit
```
- eps = `Float32(1.0) / Float32(32767.0)`
- 调用：`packSnorm4x16(v)` → `UInt64` → `unpackSnorm4x16<Defaultp>(packed)` → `Vec4<Float32, Defaultp>`
- 值：`Vec4(-1.0, -0.5, 0.0, 0.7)`

```
@Test func testPackSnorm4x16Boundary(): Unit
```
- `Vec4(1.0, 1.0, 1.0, 1.0)` exact
- `Vec4(-1.0, -1.0, -1.0, -1.0)` exact

### Half Vec2（packHalf2x16/unpackHalf2x16）

```
@Test func testPackHalf2x16Roundtrip(): Unit
```
- eps = `Float32(0.001)`
- 调用：`packHalf2x16(v)` → `UInt32` → `unpackHalf2x16<Defaultp>(packed)` → `Vec2<Float32, Defaultp>`
- 值：`Vec2(0.0, 1.0)` 和 `Vec2(-0.5, -1.0)`
- 使用循环遍历（类似已有 `testPackHalf1x16Roundtrip` 模式）：对每个值 `pack` → `unpack` → `@Expect(abs(unpacked.x - v.x) < eps, true)` / `abs(unpacked.y - v.y)`

### Half Vec4（packHalf4x16/unpackHalf4x16）

```
@Test func testPackHalf4x16Roundtrip(): Unit
```
- eps = `Float32(0.001)`
- 调用：`packHalf4x16(v)` → `UInt64` → `unpackHalf4x16<Defaultp>(packed)` → `Vec4<Float32, Defaultp>`
- 值：`Vec4(0.0, 1.0, -1.0, 0.5)`
- 断言：`@Expect(abs(unpacked.x - v.x) < eps, true)` 等

## 错误处理

不涉及错误处理逻辑变更。浮点 round-trip 使用 `@Expect(abs(unpacked - orig) < eps, true)` 容忍比较；边界值使用 `@Expect(unpacked, Float32(...))` 精确比较（整型转换无精度损失的边界值，如 0.0/1.0/-1.0）。

Epsilon 常量：
| 类别 | 精度 | eps 值 |
|------|------|--------|
| Unorm 8-bit | 1/255 | `Float32(1.0) / Float32(255.0)` |
| Unorm 16-bit | 1/65535 | `Float32(1.0) / Float32(65535.0)` |
| Snorm 8-bit | 1/127 | `Float32(1.0) / Float32(127.0)` |
| Snorm 16-bit | 1/32767 | `Float32(1.0) / Float32(32767.0)` |
| Half | half-float | `Float32(0.001)` |

## 行为契约

- 全部变更限于 `tests/glm/gtc/packing_test.cj`，不修改生产代码
- 现有 import 行保持不动（`Vec2`, `Vec3`, `Vec4`, `Defaultp` 已足够；UInt 标量类型为内置无需 import）
- 22 个测试函数追加到文件末尾（`:86` 之后）
- 测试命名：`testPack{Type}{Bits}Roundtrip` / `testPack{Type}{Bits}Boundary`，Half 仅 Roundtrip
- Half 测试通过 `for` 循环遍历多个 Vec 值（与已有 `testPackHalf1x16Roundtrip` 模式一致）
- 对无 Qualifier 参数的 unpack 函数（1x8/1x16 标量版），调用时不传类型参数
- 有 Qualifier 参数的 pack 函数由 Vec 参数的 `<Defaultp>` 自动推断
- `04_diag.md` 仅修改 G34 条目（`:391` 附近）末尾添加 `✅ 已修复`
- `plan.md` 路线表 v16 列标记 P4-4 ✅

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `packing_test.cj` | 无新增 import | UInt8/16/32/64 为内置类型；Vec2/4 + Defaultp 已导入 |
| `04_diag.md` | 无 | 纯文本标记 |
| `plan.md` | 无 | 纯文本标记 |

## 修订说明（v16 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 测试函数数量自相矛盾：文件规划表和行为契约声称 "21 个测试函数"，实际列举为 22 个 | 将文件规划表和行为契约中的 "21" 修正为 "22"（Unorm/Snorm 各 5 对 × 2（Roundtrip+Boundary）= 20，Half Vec2/4 各 1 个 Roundtrip = 2，合计 22） |
