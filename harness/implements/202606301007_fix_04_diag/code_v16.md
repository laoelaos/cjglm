# 实现报告（v16）

## 概述

为 `tests/glm/gtc/packing_test.cj` 补充了 22 个测试函数，覆盖 12 组 pack/unpack 函数对的 round-trip 测试（含常规值和边界值）。同步更新了诊断文档中的 G34 状态标记。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `cjglm/tests/glm/gtc/packing_test.cj` | 追加 22 个测试函数，覆盖 Unorm/Snorm 1x8/2x8/1x16/2x16/4x16 及 Half 2x16/4x16 |
| 修改 | `docs/diag/impl/04_diag.md:410` | G34 行末尾追加 `✅ 已修复` |
| 修改 | `harness/implements/202606301007_fix_04_diag/plan.md:26` | P4-4 v16 列已标记 ✅（无需变更，已存在） |

## 新增测试函数（22 个）

| 函数名 | 覆盖函数对 | 类型 |
|--------|-----------|------|
| `testPackUnorm1x8Roundtrip` | packUnorm1x8 / unpackUnorm1x8 | round-trip ε=1/255 |
| `testPackUnorm1x8Boundary` | packUnorm1x8 / unpackUnorm1x8 | 边界 0.0/1.0 exact |
| `testPackUnorm2x8Roundtrip` | packUnorm2x8 / unpackUnorm2x8 | round-trip ε=1/255 |
| `testPackUnorm2x8Boundary` | packUnorm2x8 / unpackUnorm2x8 | 边界 exact |
| `testPackUnorm1x16Roundtrip` | packUnorm1x16 / unpackUnorm1x16 | round-trip ε=1/65535 |
| `testPackUnorm1x16Boundary` | packUnorm1x16 / unpackUnorm1x16 | 边界 0.0/1.0 exact |
| `testPackUnorm2x16Roundtrip` | packUnorm2x16 / unpackUnorm2x16 | round-trip ε=1/65535 |
| `testPackUnorm2x16Boundary` | packUnorm2x16 / unpackUnorm2x16 | 边界 exact |
| `testPackUnorm4x16Roundtrip` | packUnorm4x16 / unpackUnorm4x16 | round-trip ε=1/65535 |
| `testPackUnorm4x16Boundary` | packUnorm4x16 / unpackUnorm4x16 | 边界 exact |
| `testPackSnorm1x8Roundtrip` | packSnorm1x8 / unpackSnorm1x8 | round-trip ε=1/127 |
| `testPackSnorm1x8Boundary` | packSnorm1x8 / unpackSnorm1x8 | 边界 ±1.0 exact |
| `testPackSnorm2x8Roundtrip` | packSnorm2x8 / unpackSnorm2x8 | round-trip ε=1/127 |
| `testPackSnorm2x8Boundary` | packSnorm2x8 / unpackSnorm2x8 | 边界 exact |
| `testPackSnorm1x16Roundtrip` | packSnorm1x16 / unpackSnorm1x16 | round-trip ε=1/32767 |
| `testPackSnorm1x16Boundary` | packSnorm1x16 / unpackSnorm1x16 | 边界 ±1.0 exact |
| `testPackSnorm2x16Roundtrip` | packSnorm2x16 / unpackSnorm2x16 | round-trip ε=1/32767 |
| `testPackSnorm2x16Boundary` | packSnorm2x16 / unpackSnorm2x16 | 边界 exact |
| `testPackSnorm4x16Roundtrip` | packSnorm4x16 / unpackSnorm4x16 | round-trip ε=1/32767 |
| `testPackSnorm4x16Boundary` | packSnorm4x16 / unpackSnorm4x16 | 边界 exact |
| `testPackHalf2x16Roundtrip` | packHalf2x16 / unpackHalf2x16 | round-trip ε=0.001，for 循环 2 个 Vec2 值 |
| `testPackHalf4x16Roundtrip` | packHalf4x16 / unpackHalf4x16 | round-trip ε=0.001 |

## 编译验证

`cjpm build` 成功，仅预存 warnings，无 errors。

## 设计偏差说明

无偏差。所有实现与设计规格一致：
- 标量 unpack 函数（1x8/1x16）调用时不传类型参数
- Vec 版本 unpack 函数使用 `<Defaultp>` 类型参数
- epsilon 常量与设计表中一致
- 边界值使用 `@Expect(unpacked, Float32(...))` 精确比较
- round-trip 使用 `@Expect(abs(unpacked - orig) < eps, true)` 容忍比较
- Half2x16 使用 for 循环模式与已有 `testPackHalf1x16Roundtrip` 一致
