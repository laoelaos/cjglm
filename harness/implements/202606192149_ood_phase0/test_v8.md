# 测试报告（v8）

## 测试范围

验证 `src/fwd.cj` 修复后**别名语义不变**且**泛型与别名可同时访问不冲突**。

## 测试文件

| 文件 | 操作 | 说明 |
|------|------|------|
| `tests/glm/test_fwd.cj` | 追加测试 | 新增 34 个测试函数，覆盖多种别名类型及泛型访问 |

## 行为契约验证

### BC1：别名语义不变

| 测试函数 | 被测类型 | 结果 |
|---------|---------|------|
| `testFwdVec1Alias` | `Vec1` | PASS |
| `testFwdVec2Alias` | `Vec2` | PASS |
| `testFwdVec3Alias` | `Vec3` | PASS |
| `testFwdVec4Alias` | `Vec4`（已有） | PASS |
| `testFwdBVec1Alias` | `BVec1` | PASS |
| `testFwdBVec2Alias` | `BVec2`（已有） | PASS |
| `testFwdBVec3Alias` | `BVec3` | PASS |
| `testFwdBVec4Alias` | `BVec4` | PASS |
| `testFwdIVec1Alias` | `IVec1` | PASS |
| `testFwdIVec2Alias` | `IVec2` | PASS |
| `testFwdIVec4Alias` | `IVec4` | PASS |
| `testFwdUVec1Alias` | `UVec1` | PASS |
| `testFwdUVec3Alias` | `UVec3` | PASS |
| `testFwdDVec2Alias` | `DVec2` | PASS |
| `testFwdDVec4Alias` | `DVec4` | PASS |
| `testFwdMediumpVec2Alias` | `MediumpVec2` | PASS |
| `testFwdLowpVec4Alias` | `LowpVec4` | PASS |
| `testFwdHighpIVec2Alias` | `HighpIVec2` | PASS |
| `testFwdLowpIVec1Alias` | `LowpIVec1` | PASS |
| `testFwdI8Vec2Alias` | `I8Vec2` | PASS |
| `testFwdI16Vec3Alias` | `I16Vec3` | PASS |
| `testFwdI32Vec1Alias` | `I32Vec1` | PASS |
| `testFwdI64Vec4Alias` | `I64Vec4` | PASS |
| `testFwdU8Vec3Alias` | `U8Vec3` | PASS |
| `testFwdU16Vec2Alias` | `U16Vec2` | PASS |
| `testFwdU32Vec4Alias` | `U32Vec4` | PASS |
| `testFwdU64Vec1Alias` | `U64Vec1` | PASS |
| `testFwdFVec3Alias` | `FVec3` | PASS |
| `testFwdF64Vec2Alias` | `F64Vec2` | PASS |
| `testFwdF32Vec4Alias` | `F32Vec4` | PASS |

### BC2：泛型与别名可同时访问

| 测试函数 | 验证内容 | 结果 |
|---------|---------|------|
| `testFwdGenericVec1Accessible` | `detail.Vec1<Float32, PackedHighp>` 可构造 | PASS |
| `testFwdGenericVec2Accessible` | `detail.Vec2<Int32, PackedHighp>` 可构造 | PASS |
| `testFwdGenericVec3Accessible` | `detail.Vec3<Bool, PackedHighp>` 可构造 | PASS |
| `testFwdGenericVec4Accessible` | `detail.Vec4<Float64, PackedLowp>` 可构造 | PASS |
| `testFwdAliasAndGenericCompatible` | 别名赋值给泛型变量兼容 | PASS |
| `testFwdAliasAndGenericVec2Compatible` | 别名与泛型类型兼容 | PASS |

## 总计

- 新建测试函数：34 个
- 已有测试函数（未修改）：4 个（原本在 `test_fwd.cj` 中）
- 通过：38 / 38
- 失败：0（项目级 2 个失败源自 `glm.detail.type_vec1_test.cj` 的移位运算边界测试，与本修复无关）
