# 任务指令（v13）

## 动作
NEW

## 任务描述
在 `src/detail/geometric.cj` 末尾追加 3 个 `refract` stub 函数（Vec2/Vec3/Vec4 各一），同步创建测试文件 `tests/glm/detail/test_geometric_refract.cj`。

预期文件变更：
- 修改 `src/detail/geometric.cj` — 在文件末尾（现有 all 21 stub 函数之后）追加以下 3 个函数：
  ```cangjie
  public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  ```
- 新建 `tests/glm/detail/test_geometric_refract.cj` — 每个 Vec 维度至少 1 个测试用例，验证函数存在且调用不抛异常（stub 状态仅验证签名正确性）

## 选择理由
T12（矩阵比较运算符）已完成并验证通过。T13 是 plan.md 中最后一个待办任务——refract 是设计文档 §3.7 要求但前序实现遗漏的 3 个 geometric stub 函数。geometric.cj 中已有 6 组共 21 个 stub 函数（dot/cross/normalize/length/distance/reflect），追加 3 个 refract 函数完全机械。不依赖任何其他未完成任务。

## 任务上下文
- 设计文档 §3.7 geometric.cj 清单包含 refract 函数，格式：`func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier`，Vec3/Vec4 同理
- geometric.cj 现有代码模式：所有函数体均为 `throw Exception("stub")`，函数体使用 `{ }` 而非分号结尾
- `Vec2<T, Q>` / `Vec3<T, Q>` / `Vec4<T, Q>` 类型在 `glm.detail` 包中同包直接可见
- 不依赖任何其他未完成任务

## 已有代码上下文
`src/detail/geometric.cj` 已有 21 个 stub 函数（每函数均为 `public func name<T, Q>(args): RetType where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }` 模式），分布在 Vec1~Vec4 四种维度。现有函数清单：dot(1~4)、cross(3)、normalize(2~4)、length(2~4)、distance(2~4)、reflect(2~4)。追加的 3 个 refract 函数遵循完全相同的签名和实现模式。

测试文件模式参考 `tests/glm/detail/test_geometric.cj`（使用 `@Test` 标注测试函数，`@Expect` 断言，确保函数可调用）。
