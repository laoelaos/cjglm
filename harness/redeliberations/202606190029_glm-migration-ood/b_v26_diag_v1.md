# OOD 设计文档质量审查报告（v26）

## 审查范围与视角

- **审查对象**：`a_v26_copy_from_v25.md`（GLM 1.0.3 仓颉迁移首轮 OOD 设计方案）
- **审查维度**：需求响应充分度、事实/逻辑正确性、深度与完整性（从实际落地和下游消费者视角）
- **审查策略**：侧重内部审议（设计-验证循环）**未充分覆盖**的维度，避免重复

---

## 审查发现

### F1. [中等] `fromBoolVec` 实例方法模式导致非自然调用路径

**问题描述**：

`fromBoolVec` 工厂函数（§4.8）被定义为扩展成员函数（`extend` 块中的实例方法），但其函数体完全不使用 `self`——仅从参数 `v: VecN<Bool, Q>` 中读取数据并构造新 Vec 返回。这导致调用方必须持有一个同类型的 Vec 实例才能完成 Bool→Numeric 转换：

```cangjie
// 调用方需要构造一个"哑"实例作为 receiver
let dummy = Vec2<Float32, PackedHighp>(Float32(0), Float32(0));
let result = dummy.fromBoolVec(boolVec);
```

这与本设计中其他工厂函数的设计风格不一致：
- `add(s, v)` / `sub(s, v)` 等 scalar-op-vec 方向函数定义为包级独立函数，可直接通过 `import` 调用
- 调用方无需持有任何 Vec 实例即可使用

**所在位置**：§4.8 `fromBoolVec` 签名清单（第 867~901 行）

**可替代方案**：
- **方案 A**：改为包级独立函数（如 `func fromBoolVec<T, Q>(v: VecN<Bool, Q>): VecN<T, Q> where Q <: Qualifier`），调用方直接 `let v = fromBoolVec<Float32, PackedHighp>(boolVec)`
- **方案 B**：利用仓颉 `extend` 块支持 `static` 修饰符（见 extend README §4.2，`static` 在允许的修饰符列表中），定义为 `public static func fromBoolVec(v: VecN<Bool, Q>): VecN<T, Q>`，调用方通过 `Vec2<Float32, PackedHighp>.fromBoolVec(boolVec)` 语法调用

**理由**：方案 A 或 B 消除了 receiver 必须存在的前置条件，与用户的直接直觉（"我想把一个 Bool Vec 转成数值 Vec，不需要先有一个数值 Vec"）更一致。方案 B 利用 extend 块中已允许的 `static` 修饰符，保持 Vec 类型的关联性。

**严重程度**：中等。非正确性问题，但影响编码阶段的 API 使用体验，且调用方发现此缺陷后需要额外的重构成本（约 0.5 人天调整接口定义 + 更新调用方代码）。

---

### F2. [提示] `fromBoolVec` 的 Q 参数绑定限制了跨 Q Bool→Numeric 转换

**问题描述**：

当前 `fromBoolVec` 签名中参数类型为 `VecN<Bool, Q>`，其中 `Q` 与 `self` 的 `Q` 绑定：

```
extend<T, Q> VecN<T, Q> where Q <: Qualifier {
    public func fromBoolVec(v: VecN<Bool, Q>): VecN<T, Q> { ... }
}
```

这意味着 `fromBoolVec` 仅支持同 Q 转换（如 `PackedHighp`→`PackedHighp`），不支持跨 Q 转换（如 `PackedLowp`→`PackedHighp`）。而同一设计中的跨类型构造函数 `init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier` 天然支持 Q2→Q 的转换——此缺口未在文档中显式标注。

**所在位置**：§4.8 `fromBoolVec` 签名清单（第 867~901 行），§9.4 类型转换边界

**影响评估**：
- 实践中 Bool Vec 的 Qualifier 参数通常无实际意义（Bool 不参与精度/对齐策略），因此跨 Q 的 Bool→Numeric 转换场景极少出现
- 若确有此需求，可通过将 `fromBoolVec` 改为 F1 建议的独立函数模式并增加独立 Q2 类型参数来消除此限制

**改进建议**：
- 在 §4.8 末尾或 §8.4 中标注 `fromBoolVec` 的跨 Q 转换限制
- 若采用 F1 的独立函数方案，可在签名中增加独立 Q2 参数（`func fromBoolVec<T, Q, Q2>(v: VecN<Bool, Q2>): VecN<T, Q>`）

---

### F3. [提示] const 上下文中 `equalEpsilon` 容差比较路径真空

**问题描述**：

§4.5 声明：若 `==` 因 D29 回退到精确比较路径，`equalEpsilon` 成为"浮点 Vec 上唯一可用的容差比较路径"。但 `equalEpsilon` 定义于 `extend` 块中（非 `const`），无法在 `const` 表达式中调用。这意味着在回退路径下，const 上下文中的浮点容器比较既不能用 `==`（已回退为精确比较），也不能用 `equalEpsilon`（非 const），形成功能真空。

**所在位置**：§4.5 `equalEpsilon` 定义段落（第 801~816 行），§7 D29 回退触发条件

**影响评估**：
- 仅在 D29 回退触发时才成为问题（乐观/最可能路径下不触发）
- 若编码阶段确实需要在 const 上下文中进行浮点容差比较，可按 §4.5 注释中提到的备选方案将 `equalEpsilon` 移至 struct 体内声明为 `const` 成员函数

**改进建议**：
- 在 §4.5 回退路径描述末尾补充一条标注：说明在回退路径下 const 上下文的容差比较真空及备选方案（移至 struct 体内 / 使用包级独立函数）
- 此真空已在同一节中隐含提及（"若编码阶段需要在 const 上下文中调用 equalEpsilon，可将其定义移至 struct 体内"），但建议在回退路径描述处显式交叉引用

---

## 整体评价

### 需求响应充分度

设计文档完整映射了 roadmap §3E/§3G 定义的首轮范围（基础设施层 + 向量类型系统 + 256 个别名体系），无遗漏项。§2 模块划分、§8 范围追溯表、§11 迁移成本评估三个维度相互印证，需求追溯链闭合。**响应充分**。

### 事实/逻辑正确性

历经 25 轮审查迭代，之前发现的事实错误（mod 的 const 声明、extend 块 const 限制、`@OverflowWrapping` 继承性、const if 术语等）均已修正。当前版本在事实层面已无显著错误。文档中涉及编译器行为假设的部分均以"待验证"状态标识，并配有完整的回退方案，风险处置透明。

### 深度与完整性

文档深度充足（2222 行），覆盖架构设计、行为契约、设计决策、迁移文件清单、迁移成本评估、验证策略六个维度。编码阶段可直接参考 §4.1 的完整构造函数清单、§4.3~§4.6 的运算定义、§8.3 的迁移顺序逐步实现。测试策略（§12）覆盖四层验证层次，与验证计划（§10）形成闭环。

**主要短板**：`fromBoolVec` 的 API 模式（F1）是少数影响编码启动体验的设计质量问题——实施者首次使用时将发现需要 "dummy instance" 才能调用工厂函数。此问题的修复成本低（修改定义处 4 处 + 重新编译验证），建议在编码阶段开始前完成。
