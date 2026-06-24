# 任务指令（v1）

## 动作
NEW

## 任务描述
修复 `test_integration_matrix.cj:338-341` 中 `testIntegrationFromMatDeviation` 函数的 4 个 `@Expect` 断言预期值，使其与 OOD §3.3 声明的 DEVIATION 行为一致。

**变更文件**: `cjglm/tests/glm/test_integration_matrix.cj`

**具体修改**:
- `:338`：`@Expect(m44.c2.x, Float32(5.0))` → `@Expect(m44.c2.x, Float32(0.0))`
- `:339`：`@Expect(m44.c2.y, Float32(6.0))` → `@Expect(m44.c2.y, Float32(0.0))`
- `:340`：`@Expect(m44.c3.x, Float32(7.0))` → `@Expect(m44.c3.x, Float32(0.0))`
- `:341`：`@Expect(m44.c3.y, Float32(8.0))` → `@Expect(m44.c3.y, Float32(0.0))`

同时补充 `c2.z=1.0`、`c2.w=0.0`、`c3.z=0.0`、`c3.w=1.0` 的断言以与单元测试 `test_type_mat4x4.cj:645-652` 完全对齐。

## 选择理由
T5（CI 运行时失败）阻塞所有合并，是依赖图中的根节点。必须先解决此问题才能推进后续修复。

## 任务上下文
- Mat4x4.fromMat(Mat4x2, one) 的 DEVIATION 行为：列 2 为 `Vec4(zero, zero, one, zero)`、列 3 为 `Vec4(zero, zero, zero, one)`
- 诊断报告 §1 T5 已给出完整的根因分析和精确修复值
- 参考实现：`type_mat4x4.cj:235-239`（6a）和 `:287-291`（6b）
- 参考单元测试：`test_type_mat4x4.cj:633-653`（6a）和 `:837-857`（6b）

## 已有代码上下文
```cangjie
// test_integration_matrix.cj:330-344
@Test
func testIntegrationFromMatDeviation(): Unit {
    let src = Mat4x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let m44 = Mat4x4.fromMat(src, Float32(1.0))
    @Expect(m44.c0.x, Float32(1.0))
    @Expect(m44.c0.y, Float32(2.0))
    @Expect(m44.c1.x, Float32(3.0))
    @Expect(m44.c1.y, Float32(4.0))
    @Expect(m44.c2.x, Float32(5.0))  // ← 应改为 0.0
    @Expect(m44.c2.y, Float32(6.0))  // ← 应改为 0.0
    @Expect(m44.c3.x, Float32(7.0))  // ← 应改为 0.0
    @Expect(m44.c3.y, Float32(8.0))  // ← 应改为 0.0
    @Expect(m44.c0.z, Float32(0.0))
    @Expect(m44.c3.w, Float32(1.0))
}
```
