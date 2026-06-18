# 再审议判定报告（v10）

## 判定结果

RETRY

## 判定理由

组件B诊断报告识别出 3 个严重（P1-P3）、2 个一般（P4-P5）质量问题，涉及 `Hashable` 实现缺失、与 C++ GLM 构造函数的签名对齐遗漏、`ComputeEqual` 公共 API 泄漏、`isIec559Of<T>()` 中非必要的 `Float16` 分支等。质询报告以 LOCATED 确认全部问题证据充分、逻辑完整、覆盖完备。因存在严重和一般等级问题，按判定标准判定为 RETRY。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：缺少 `Hashable` 实现，Vec 类型无法作为哈希键正常使用，且浮点 Epsilon 容差 `==` 与按位哈希存在契约不一致
- **所在位置**：§3.2（Vec 结构体系）、§4（关键行为契约）、§12（验收标准）
- **严重程度**：严重
- **改进建议**：明确 Vec 类型的 `Hashable` 实现策略，对整数/Bool Vec 使用 `@Derive[Hashable]`，对浮点 Vec 记录为已知限制；在 §4 补充 `hashCode()` 签名和行为约定；在 §12.2 新增哈希集合可用性验收项

- **问题描述**：Vec2 缺少 `Vec1+Vec1` 构造函数，与 C++ GLM `type_vec2.inl:73-78` 行为不一致
- **所在位置**：§4.1（向量构造 — Vec2 构造函数清单）
- **严重程度**：严重
- **改进建议**：补充 `public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier`

- **问题描述**：Vec3 缺少 4 个 `Vec1` 参与的组合构造函数，与 C++ GLM `type_vec3.inl` 行为不一致
- **所在位置**：§4.1（向量构造 — Vec3 构造函数清单）
- **严重程度**：严重
- **改进建议**：补充 `Vec1+Vec1+T`、`Vec1+T+Vec1`、`T+Vec1+Vec1`、`Vec1+Vec1+Vec1` 四个构造函数

- **问题描述**：`ComputeEqual` 被 `public import` 暴露为公共 API，泄漏实现细节
- **所在位置**：§2（公共 API 面设计），`lib.cj` 的 `public import` 列表
- **严重程度**：一般
- **改进建议**：从 `lib.cj` 的 `public import` 列表中移除 `ComputeEqual`，降级为 `internal` 包级可见类型

- **问题描述**：`isIec559Of<T>()` 实现中包含 `Float16` 类型增加不必要的验证风险
- **所在位置**：§10，`isIec559Of<T>()` 实现代码（第 893-896 行）
- **严重程度**：一般
- **改进建议**：简化实现为仅检查 `Float32`/`Float64`，将 `Float16` 分支推迟至后续轮次
