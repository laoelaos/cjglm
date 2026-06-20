# 任务指令（v2）

## 动作
NEW

## 任务描述
在 `type_vec1.cj` 的 struct `Vec1<T, Q>` 体内（`public const init(x: T)` 之后）追加 4 个跨类型转换构造函数：

```cangjie
public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier {
    this.x = T(v.x)
}

public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier {
    this.x = T(v.x)
}

public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier {
    this.x = T(v.x)
}

public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier {
    this.x = T(v.x)
}
```

预期文件路径：`cjglm/src/detail/type_vec1.cj`

## 选择理由
- 第一优先级——构造函数体系缺失（#9, #10, #14, #15, #19）直接影响类型系统完备性
- Vec1 是最简单的 Vec 类型（单分量），作为跨类型构造模式的验证起点，降低后续 Vec2~Vec4 的实施风险
- 不依赖其他 Vec 类型的跨类型构造函数，可独立编译验证
- R1（setup.cj let→const）已 PASSED，309/309 测试通过

## 任务上下文
### 需求来源
诊断报告 `01_diag.md` 第 #9 项：OOD §4.1 要求 Vec1 提供 4 个跨类型转换构造函数，当前仅定义了 `public const init(x: T)`，4 个跨类型构造函数全部缺失。

### 设计约束
1. **非 const 声明**：跨类型构造函数不得标注 `const`，因为函数体内的 `T(v.x)` 类型转换表达式在 const 上下文中不合法（多数 T2→T 组合如 `Int32(Float32(1.5))` 不是 const 表达式）
2. **独立泛型参数 T2**：使用独立的泛型参数 `T2` 以避免与 struct 的 `T` 参数产生类型推导冲突
3. **Bool→Numeric 兼容**：`T2` 在签名层面无约束（可为任意类型，包括 `Bool`），但构造函数体内的 `T(v.x)` 在 `T2=Bool`、`T`=数值类型时产生编译错误（仓颉不支持 `Int32(Bool)`）。此为 D5 延迟检查语义的预期行为，不在此任务范围内（由 `fromBoolVec` 工厂函数处理）
4. **跨 Q 转换**：`Q2 <: Qualifier` 约束允许任意 Qualifier 之间的跨 Q 转换，首轮所有 Qualifier 均为空结构体，跨 Q 赋值在数据语义上等价
5. **fill-from-Vec1（同类型）已存在**：注意 `Vec2~Vec4` 已有 `public init(v: Vec1<T, Q>)` 同类型 fill-from-Vec1 构造函数。Vec1 本身因 D31 限制不提供 fill-from-Vec1 跨类型版本（与 `const init(x: T)` 重载冲突）。但本任务新增的 `public init<T2, Q2>(v: Vec1<T2, Q2>)` 与 `const init(x: T)` 参数类型不同（`Vec1<T2, Q2>` vs `T`），不构成重载冲突

### 跨类型取分量规则
- `Vec1<T2, Q2>` → 取 `.x` 分量
- `Vec2<T2, Q2>` → 取 `.x` 分量（Vec1 仅有一个分量，取第一分量）
- `Vec3<T2, Q2>` → 取 `.x` 分量（同前）
- `Vec4<T2, Q2>` → 取 `.x` 分量（同前）

### Vec1 构造函数不对称性说明
Vec1 仅提供 `const init(x: T)` 而无 `public init(scalar: T)`。原因：两者参数列表均为单 `T` 参数，仓颉重载规则中 `const` 不构成区分依据，视为重复定义。`const init(x: T)` 在非 const 上下文中也可用于运行时构造（const README §3.2 规则 5），等效于标量填充构造的功能。

### 跨类型构造函数与 const init 的共存性
- `const init(x: T)` — 接收单个 `T` 参数
- `init<T2, Q2>(v: VecN<T2, Q2>)` — 接收单个 `VecN<T2, Q2>` 参数
- 参数类型不同（`T` vs `VecN<T2, Q2>`），不构成重载歧义

## 已有代码上下文

### type_vec1.cj 当前结构
```cangjie
@Derive[Hashable]
public struct Vec1<T, Q> where Q <: Qualifier {
    public var x: T

    public const init(x: T) {
        this.x = x
    }
    // ↑ 在此处之后追加 4 个跨类型构造函数

    public static func length(): Int64 { 1 }
    // ... 运算符和成员函数
}
```

### 已完成的 R1 修改
- `setup.cj` 中 7 个 `public let` → `public const`
- 编译通过，测试 309/309 PASSED

### 测试模式参考（现有 testVec1ConstInit）
```cangjie
@Test
func testVec1ConstInit(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    @Expect(v.x, 42)
}
```
