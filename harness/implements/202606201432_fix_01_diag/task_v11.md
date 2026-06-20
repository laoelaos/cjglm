# 任务指令（v11）

## 动作
NEW

## 任务描述
在 `tests/glm/test_lib.cj` 中追加测试函数以覆盖 #21（Vec1/Vec3/Vec4 重导出验证）和 #22（sub/mul/div/mod 包级函数可达性验证）：

1. Vec1/Vec3/Vec4 构造测试（参照 `testLibVec2Construct`）：每个 Vec 类型各 1 个函数，验证通过 `package glm` 命名空间可正确构造并访问分量
2. Vec1/Vec3/Vec4 分量访问测试（参照 `testLibVec2Construct`，验证 .x/.y/.z/.w 访问）：每个 Vec 类型各 1 个函数
3. sub/mul/div/mod 包级函数可达性测试（参照 `testLibAddScalarVec`）：每个函数各 1 个，使用 `Int64` Vec2 验证可通过 `package glm` 命名空间调用

共约 10 个新测试函数。

## 选择理由
R10 完成 #28（测试重命名）后，#12/#17（componentAt const）已确认为 **BLOCKED**（deviations.md IF-03，仓颉语言限制，`assert` 非 const、`Exception` 无 const init、`match case _` 对无约束泛型无法构造返回值）。#21/#22 是剩余任务中最高优先级（测试改进），且涉及同一文件 `test_lib.cj`，修改量小无风险。

## 任务上下文
- 原文 #21：`test_lib.cj` 仅覆盖 Vec2，未覆盖 Vec1/Vec3/Vec4 的重导出验证
- 原文 #22：`test_lib.cj` 未覆盖 sub/mul/div/mod 包级函数可达性

## 已有代码上下文
`tests/glm/test_lib.cj`（31 行，4 个已有测试函数）：

```cangjie
@Test
func testLibVec2Construct(): Unit {
    let v = Vec2<Float32, PackedHighp>(Float32(1.0), Float32(2.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibAddScalarVec(): Unit {
    let v = Vec2<Float32, PackedHighp>(Float32(1.0), Float32(2.0))
    let r = add(Float32(10.0), v)
    @Expect(r.x, Float32(11.0))
}

@Test
func testLibFromBoolVec(): Unit {
    let bv = Vec2<Bool, PackedHighp>(Bool(true), Bool(false))
    let r = fromBoolVec(bv, Float32(0.0), Float32(1.0))
    @Expect(r.x, Float32(1.0))
}

@Test
func testLibQualifierType(): Unit {
    let _q: Qualifier = PackedHighp()
    let _d: Defaultp = Defaultp()
    @Expect(true, true)
}
```

`package glm` 命名空间下 `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4, add, sub, mul, div, mod }` 已在 `lib.cj` 中定义，所有 Vec 类型和包级函数均通过 `test_lib.cj` 的 `package glm` 作用域直接可见。

### 模式参照
- Vec 构造测试：`let v = Vec{N}<Float32, PackedHighp>(...)` + `@Expect(v.x, ...)`
- 标量-向量函数测试：`let r = sub(Float32(10.0), v)` 或 `sub(Int64(10), v)` + `@Expect(r.x, ...)`
