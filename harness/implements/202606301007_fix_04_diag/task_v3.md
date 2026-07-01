# 任务指令（v3）

## 动作
NEW

## 任务描述
在 `detail/vector_relational.cj` 补全 5 个缺失函数（G2），更新 `lib.cj` 导出新增符号，标记 `04_diag.md` G2 条目为已修复。

### 预期文件修改
| 文件 | 操作 | 说明 |
|------|------|------|
| `cjglm/src/detail/vector_relational.cj` | 修改 | 新增 5 个函数重载（Vec1~Vec4 × 5 = 20 个函数体） |
| `cjglm/src/lib.cj` | 修改 | 新增 `equal`/`notEqual`/`any`/`all`/`not_` 导出 |
| `docs/diag/impl/04_diag.md` | 修改 | G2 条目标记 ✅ 已修复 |

### 新增的 5 个函数（每函数 Vec1~Vec4 各一个重载）
1. `equal<T, Q>(x: VecN<T, Q>, y: VecN<T, Q>): VecN<Bool, Q>` — 逐分量 `==`，约束 `T <: Number<T>`（用 `x.x == y.x` 等）
2. `notEqual<T, Q>(x: VecN<T, Q>, y: VecN<T, Q>): VecN<Bool, Q>` — 逐分量 `!=`
3. `any<Q>(v: VecN<Bool, Q>): Bool` — 任一分量为 true 则返回 true（短路 `||`）
4. `all<Q>(v: VecN<Bool, Q>): Bool` — 所有分量为 true 才返回 true（短路 `&&`）
5. `not_<Q>(v: VecN<Bool, Q>): VecN<Bool, Q>` — 逐分量逻辑取反（`!`）

### lib.cj 变更
在第 45 行 `public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual}` 中新增：
```
public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
```

## 选择理由
P1 批次（实现错误修复）已全部完成并验证通过（435 测试通过，0 失败）。P2-1 是第二优先级（API 完整性）中最紧迫的任务——G2 为设计遗漏，OOD §3.1 已包含完整设计可直接编码实现。OOD 文档对 `detail/vector_relational.cj` 的职责描述（line 407-424）已明确补充了 5 个函数的签名和约束策略，编码阶段无需额外设计审议。

## 任务上下文

### G2 诊断摘要（来自 04_diag.md）
- **真实性**：真实问题
- **根因**：阶段三 OOD 设计遗漏
- **证据**：`detail/vector_relational.cj` 仅实现 4 个比较函数（lessThan/greaterThan/lessThanEqual/greaterThanEqual）。GLM 1.0.3 `vector_relational.hpp` 还包含 `equal`/`notEqual`/`any`/`all`/`not_` 五个函数
- **修改方向**：OOD §3.1 已包含设计，直接编码实现

### OOD 设计（06_ood_phase4.md §3.1, line 407-424）
- **职责**：提供 GLSL 8.7 节定义的逐分量比较函数
- **已有函数**：lessThan, greaterThan, lessThanEqual, greaterThanEqual（沿用阶段三）
- **补全函数**：
  - `equal(a, b)`：逐分量相等比较，返回 Bool 向量
  - `notEqual(a, b)`：逐分量不等比较，返回 Bool 向量
  - `any(v)`：向量任一分量为 true 则返回 true
  - `all(v)`：向量所有分量为 true 才返回 true
  - `not_(v)`：逐分量逻辑取反
- **约束策略**：
  - `equal`/`notEqual`：`T <: Number<T>`（支持任意可比较类型，但实际 == 需要 Equatable<T>，Number<T> 足够）
  - `any`/`all`/`not_`：仅对 Bool 向量定义
- **GLM 参考**：`references/glm-1.0.3/glm/glm/detail/func_vector_relational.inl`

### 已有代码（detail/vector_relational.cj）
当前文件（71 行）已有 4 个函数 × 4 维度 = 16 个重载，模式统一：
```cangjie
public func lessThan<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1<Bool, Q>(x.x < y.x)
}
```

新函数应遵循相同模式：
- `equal`/`notEqual`：使用 `==`/`!=` 运算符，约束 `T <: Number<T>`（Number 包含 Equatable）
- `any`：`v.x || v.y || v.z || v.w`（Vec1 仅 `v.x`，Vec2 为 `v.x || v.y` 等）
- `all`：`v.x && v.y && v.z && v.w`
- `not_`：`VecN(!v.x, !v.y, ...)`

### lib.cj 当前导出（第 45 行）
```cangjie
public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual}
```
需扩展为包含新 5 个函数名。

### 04_diag.md 标记位置
G2 条目在 `04_diag.md:97-107`，修改方向行（:107）追加 `✅ 已修复`。
