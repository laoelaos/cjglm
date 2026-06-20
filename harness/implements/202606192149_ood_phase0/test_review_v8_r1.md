# 测试审查报告（v8 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/test_fwd.cj:238-241` — `testFwdGenericFromLibAccessible` 使用 `Vec1<Float32, PackedHighp>`，但 `Vec1` 在 `glm` 包内是 `src/fwd.cj:99` 定义的具名别名 `detail.Vec1<Float32, PackedHighp>`（非泛型），`lib.cj` 的泛型 `Vec1` 重导出已被此别名遮蔽（设计文档已确认 4 个 shadow warning）。对具名别名施加类型参数 `<Float32, PackedHighp>` 在语义上不成立。期望修正：使用 `detail.Vec1<Float32, PackedHighp>` 明确访问泛型，与 `testFwdGenericVec1Accessible`（第 201 行）一致。

- **[轻微]** `test_v8.md:64` — 报告声明"新建测试函数：30 个"，但测试文件中实际包含 35 个新测试函数。计数有误。

## 修改要求（仅 REJECTED 时）

### 问题 1：`testFwdGenericFromLibAccessible` 泛型访问方式有误

**文件位置**：`tests/glm/test_fwd.cj` 第 238-241 行

**问题**：测试函数 `testFwdGenericFromLibAccessible` 的完整内容为：
```
@Test
func testFwdGenericFromLibAccessible(): Unit {
    let v: Vec1<Float32, PackedHighp> = Vec1<Float32, PackedHighp>(Float32(3.0))
    @Expect(v.x, Float32(3.0))
}
```
该测试试图验证"通过 `lib.cj` 的 public import 访问泛型"，但 `Vec1` 在 `glm` 包作用域内已被 `src/fwd.cj:99` 的 `public type Vec1 = detail.Vec1<Float32, PackedHighp>` 遮蔽为一个具名别名（单形类型），而非泛型类 `Vec1<T, Q>`。对具名别名 `Vec1` 施加类型参数 `<Float32, PackedHighp>` 语义不成立。

**为什么是问题**：测试报告称该测试 PASS，但 Cangjie 中具名别名不应接受类型参数。该测试要么编译失败（与通过报告矛盾），要么测试行为未正确验证"泛型可通过 lib.cj 访问"这一契约。这降低了测试的可信度。

**期望修正方向**：将该测试改为使用 `detail.Vec1<Float32, PackedHighp>` 访问泛型，与第 201 行的 `testFwdGenericVec1Accessible` 一致。例如：
```
@Test
func testFwdGenericFromLibAccessible(): Unit {
    let v: detail.Vec1<Float32, PackedHighp> = detail.Vec1<Float32, PackedHighp>(Float32(3.0))
    @Expect(v.x, Float32(3.0))
}
```
如果该测试的意图是验证通过 lib.cj 的 public import 名称 `Vec1` 访问泛型（而非 `detail.` 限定），则应移至包外集成测试，或改为测试 `testFwdGenericVec1Accessible` 已在验证的等价行为并直接删除。

### 问题 2：测试计数有误

**文件位置**：`test_v8.md` 第 64 行

**问题**：报告称"新建测试函数：30 个"，实际测试文件中有 35 个新测试函数。

**期望修正方向**：将计数修正为 35。
