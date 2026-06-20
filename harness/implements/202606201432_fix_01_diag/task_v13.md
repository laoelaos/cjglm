# 任务指令（v13）

## 动作
NEW

## 任务描述
在 `src/detail/scalar_vec_ops_test.cj` 末尾追加 8 个跨 Qualifier 测试函数，验证 `sub`/`mul`/`div`/`mod` 四个操作在 `PackedMediump` 和 `PackedLowp` Qualifier 上的泛型兼容性（使用 Vec2 Int64）。对应 01_diag.md #30。

### 追加函数清单

参照已有 `testScalarAddVec2PackedMediump` / `testScalarAddVec2PackedLowp` 模式（若不存在则参照 add 同名通用函数模式），各函数使用 `@Test` 标注，返回 `Unit`：

| 操作 | PackedMediump | PackedLowp |
|------|---------------|------------|
| sub | `testScalarSubVec2PackedMediump` | `testScalarSubVec2PackedLowp` |
| mul | `testScalarMulVec2PackedMediump` | `testScalarMulVec2PackedLowp` |
| div | `testScalarDivVec2PackedMediump` | `testScalarDivVec2PackedLowp` |
| mod | `testScalarModVec2PackedMediump` | `testScalarModVec2PackedLowp` |

### 函数体模板（以 sub 为例）
```cangjie
@Test
func testScalarSubVec2PackedMediump(): Unit {
    let v = Vec2<Int64, PackedMediump>(10, 20)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
}
```
使用 `PackedMediump` / `PackedLowp` 替换 `Defaultp`，数值与对应 `Defaultp` 版本的 `testScalarSubVec2` 等同（因 Qualifier 为空结构体，行为等价）。

### 签名/数值参照
- `sub(Int64(3), Vec2<Int64, Q>(10, 20))` → `(-7, -17)`
- `mul(Int64(5), Vec2<Int64, Q>(2, 3))` → `(10, 15)`
- `div(Int64(30), Vec2<Int64, Q>(10, 15))` → `(3, 2)`
- `mod(Int64(33), Vec2<Int64, Q>(10, 15))` → `(3, 3)`

## 选择理由
#30 是当前剩余任务中工作量最小的项（8 个测试函数），涉及单一文件，测试模式与已有代码一致，无新增依赖或风险。完成后剩余任务为 #8（~80 测试）和 #25/#26（fwd.cj 注释）。

## 任务上下文
- 文件：`src/detail/scalar_vec_ops_test.cj`（276 行，已有 sub/mul/div/mod Defaultp Vec2 测试 + 浮点 mod 测试）
- 测试框架：`@Test` + `@Expect` 宏
- Qualifier 类型：`PackedMediump`、`PackedLowp` 均为空结构体实现 `Qualifier` trait，行为与 `Defaultp` 等价
- 现有跨 Qualifier add 测试模式（`~219` 行附近）可作为直接参照
