# 任务指令（v14）

## 动作
NEW

## 任务描述
P4-3次批：vector_common_test.cj Vec1/Vec4 维度补全（G25）+ fclamp 边界值测试（G26）

具体工作：
1. `tests/glm/ext/vector_common_test.cj` — 补充 Vec1/Vec4 的 2-input fmin/fmax 测试（G25）+ 各维度 fclamp 边界值测试（G26）
2. `docs/diag/impl/04_diag.md` — 标记 G25 ✅ 已修复、G26 ✅ 已修复
3. `plan.md` 路线表 v14 列标记 P4-3 ✅

## 选择理由
v13 已完成 quaternion 首批测试（G28/G29/G30）。按 04_diag.md ext 测试分批顺序，次批为 vector_common_test.cj 维度补全（G25/G26）。G25 和 G26 均位于同一测试文件，修改范围集中、风险低、自包含。

## 任务上下文

### G25: vector_common_test.cj Vec1/Vec4 维度完全缺失
- **位置**：`tests/glm/ext/vector_common_test.cj`
- **说明**：当前已覆盖 Vec1/Vec4 的 3-input/4-input fmin/fmax 测试，但缺少以下 Vec1/Vec4 的 2-input 版本
- **需补充**：
  - `testFminVec1`：fmin(Vec1, Vec1)，参考 `testFminVec2`（L28-35）
  - `testFmaxVec1`：fmax(Vec1, Vec1)，参考 `testFmaxVec2`（L37-45）
  - `testFclampVec1`：fclamp(Vec1, min, max)，参考 `testFclampVec2`（L47-53）
  - `testFminVec4`：fmin(Vec4, Vec4)
  - `testFmaxVec4`：fmax(Vec4, Vec4)
  - `testFclampVec4`：fclamp(Vec4, min, max)

### G26: vector_common_test.cj fclamp 边界值未测试
- **位置**：`tests/glm/ext/vector_common_test.cj`
- **说明**：现有 fclamp 测试（Vec2/Vec3）仅覆盖常规值，缺少边界条件
- **需补充**（对 Vec2/Vec3/Vec4 维度）：
  - 全低于下限：x=(-1,-1), clamp(0,1) → (0,0)
  - 全高于上限：x=(2,2), clamp(0,1) → (1,1)
  - 零宽度区间：min==max（如 clamp(x, 0.5, 0.5)）
  - NaN 输入：fclamp 对 NaN 的行为

### G27（已随 G5 完成，仅标记）
- 已在 04_diag.md 标记 ✅ 已修复

## 已有代码上下文
- 测试文件：`tests/glm/ext/vector_common_test.cj`（package glm.ext，361 行）
- 已导入：`glm.detail.{ Vec1, Vec2, Vec3, Vec4, Defaultp }`
- 已使用测试宏：`@Test`, `@Expect`
- 现有 fmin/fmax 2-input 参考模式（Vec2）：
  ```
  func testFminVec2(): Unit {
      let a = Vec2<Float64, Defaultp>(1.0, 3.0)
      let b = Vec2<Float64, Defaultp>(2.0, 1.0)
      let r = fmin(a, b)
      @Expect(r.x, 1.0)
      @Expect(r.y, 1.0)
  }
  ```
- 现有 fclamp 参考模式（Vec2）：
  ```
  func testFclampVec2(): Unit {
      let x = Vec2<Float64, Defaultp>(0.5, 1.5)
      let r = fclamp(x, 0.0, 1.0)
      @Expect(r.x, 0.5)
      @Expect(r.y, 1.0)
  }
  ```
