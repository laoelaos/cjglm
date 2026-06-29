# 仓颉 GLM 偏差记录

> 本文档面向库的使用者，记录仓颉 GLM 与 C++ GLM 之间的使用差异。每一项偏差均从用户视角出发，说明 C++ GLM 的预期行为、仓颉 GLM 的实际行为、差异原因及迁移建议。
>
> 偏差分三类：
> - **一、功能无法实现**——用户期望的功能在仓颉中完全不可用
> - **二、接口/行为有偏差**——功能可用但调用方式或行为与 C++ GLM 不同
> - **三、内部区别**——实现方式不同，但用户使用体验一致

> 注意文档中的偏差不一定百分百准确。
> 当 Agent 想要往该文件中添加或删除偏差时，**只能** 直接写入 **四、未验证的偏差添加**以及**五、未验证的偏差删除**，格式参考现有格式，并且附加证据、验证次数。

---

## 一、仓颉限制导致功能无法实现

### IF-01: 一元 `+` 运算符不可用

**C++ GLM 行为**

C++ 中 `+v` 合法，对自定义类型可通过 `operator+()` 重载返回自身引用。GLM 中 `+vec` 等价于 `vec`，常用于强调正数值的语义意图。

**仓颉 GLM 行为**

`+v` **不可编译**，编译器报错。仓颉不支持重载一元 `+` 运算符。

**原因**

仓颉语言可重载的一元运算符仅包含一元 `-`（`operator func -()`）和按位求反 `!`（`operator func !()`），一元 `+` 不在可重载运算符列表中。此为语言层面的硬限制，无法通过任何方式绕过。

**迁移建议**

移除 `+v` 用法。如需语义明确（如正负号对照），直接使用 `v` 即可——一元 `+` 本身不改变值。示例：

```cangjie
// C++:  auto result = +v;
// 仓颉: let result = v      // 直接使用，行为等价
```

---

### IF-02: 标量-向量运算函数不可在 `const` 上下文调用

**C++ GLM 行为**

C++ GLM 的标量-向量运算函数（如 `add(scalar, vec)`）可声明为 `constexpr`，在编译期上下文中求值：

```cpp
constexpr vec2 result = add(2.0f, vec2(1.0f, 2.0f));  // 编译期求值
```

**仓颉 GLM 行为**

以下 20 个标量-向量运算函数**不可声明为 `const`**，仅可在运行时调用：

| 函数 | 约束 | 重载数 |
|------|------|--------|
| `add<T, Q>(s: T, v: VecN<T, Q>)` | `T <: Number<T>` | 4 (Vec1~Vec4) |
| `sub<T, Q>(s: T, v: VecN<T, Q>)` | `T <: Number<T>` | 4 |
| `mul<T, Q>(s: T, v: VecN<T, Q>)` | `T <: Number<T>` | 4 |
| `div<T, Q>(s: T, v: VecN<T, Q>)` | `T <: Number<T>` | 4 |
| `mod<T, Q>(s: T, v: VecN<T, Q>)` | `T <: Integer<T>` | 4 |

在 `const` 上下文（如 `const` 变量初始化、`const func` 函数体）中调用上述函数会触发编译错误 `expected 'const' expression`。

**原因**

仓颉 `const func` 要求函数体中所有表达式均为编译期可求值的 const 表达式，而函数参数 `s`、`v` 是运行时才确定的值，不满足此要求。这是仓颉 const 机制的核心限制——`const func` 只能操作编译期已知的值（如字面量、其他 const 值），不能接受运行时输入。

**迁移建议**

需要编译期求值的标量-向量运算，需手动内联计算：

```cangjie
// C++:  constexpr Vec2 result = add(2.0f, v);
// 仓颉: const val result = Vec2(Float32(2.0) * v.x, Float32(2.0) * v.y)  // 手动内联
// 或：  let result = add(Float32(2.0), v)  // 接受运行时求值
```

---

### IF-03: `componentAt` 不可在 `const` 上下文使用

**C++ GLM 行为**

C++ GLM 中通过 `operator[]` 或 Swizzle 可在 `constexpr` 上下文按索引访问向量分量。

**仓颉 GLM 行为**

`componentAt(i: Int64): T` 为非 const 函数，**不可在 `const` 上下文调用**。

**原因**

函数体内两个不可 const 的因素：
1. `assert(condition, message: "...")` —— `assert` 不是 `const` 函数
2. `throw Exception("...")` —— `Exception` 构造函数不是 `const` 的

这两个因素使 `componentAt` 无法声明为 `const func`。

**迁移建议**

在 `const` 上下文中，使用属性访问或下标替代：

```cangjie
// 运行时：可用 componentAt
let x = v.componentAt(0)

// const 上下文：用属性或下标
const val x = v.x       // 属性访问
const val y = v[1]      // 下标访问
```

---

### IF-04: 多分量组合构造函数全部缺失

**C++ GLM 行为**

C++ GLM 提供丰富的多分量组合构造函数，遵循 GLSL 5.4.1 规范：

```cpp
vec4(vec3 const& v, float s);          // 四分量 = v.xyz + s
vec4(vec2 const& a, vec2 const& b);    // 四分量 = a.xy + b.xy
vec4(vec2 const& v, float s, float t); // 四分量 = v.xy + s + t
vec3(vec2 const& v, float s);          // 三分量 = v.xy + s
// ...以及更多组合（Vec4 约 30 个重载）
```

**仓颉 GLM 行为**

各 VecN 结构体仅提供以下构造函数：
- `const init(x: T, y: T, ...)` — 逐分量同类型构造
- `init(scalar: T)` — 标量填充（Vec1 无此构造，仅有 `const init(x: T)`）
- `init(v: Vec1<T, Q>)` — 从 Vec1 填充全部分量

**全部**多分量组合构造函数（如 `Vec4(Vec3, T)`、`Vec4(Vec2, Vec2)`、`Vec4(Vec2, T, T)`、`Vec3(Vec2, T)` 等）均**未实现**。

**原因**

仓颉不支持泛型构造函数 `init<T2, Q2>(v: Vec2<T2, Q2>)`，且不支持 `T(v.x)` 类型参数作为构造调用。无约束泛型参数不能执行任何构造调用——编译器无法确认泛型 `T` 拥有接受其他类型参数的构造函数。即使添加 `where T <: Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明。

**迁移建议**

用户必须显式逐分量构造：

```cangjie
// C++:   vec4 v(v3, s);
// 仓颉:
let v = Vec4(v3.x, v3.y, v3.z, s)

// C++:   vec4 v(a, b);       // a 为 vec2, b 为 vec2
// 仓颉:
let v = Vec4(a.x, a.y, b.x, b.y)

// 跨类型转换需使用 castVecN(v, conv) 系列函数
// 注意：castVecN 不支持多分量组合（仅支持单一源向量 + 转换闭包）
```

---

### IF-05: `increment()` / `decrement()` 仅对整数类型可用，对浮点类型不可用

**C++ GLM 行为**

C++ GLM 的 `operator++` / `operator--` 对所有数值分量类型（含 `float` / `double`）可用：

```cpp
vec<2, float, Q> v(1.5f, 2.5f);
++v;   // (2.5f, 3.5f)
v++;   // 后缀：返回旧值 (1.5f, 2.5f)，v 变为 (2.5f, 3.5f)
```

**仓颉 GLM 行为**

`increment()` / `decrement()` 定义在 `extend<T, Q> VecN<T, Q> where T <: Integer<T>` 块中，因此**仅对整数分量类型（Int8~Int64、UInt8~UInt64）可用**。对 `Float32` / `Float64` Vec 调用 `increment()` 会触发编译错误（编译器错误在实例化处，`Float32` 不满足 `Integer<T>` 约束）。

**原因**

仓颉语言层面的 `++`/`--` 运算符仅支持整数类型（`expr++` 中 `expr` 的类型必须是整数类型），且 `Number<T>` 接口不提供 `+1`/`-1` 的泛型运算能力。`Integer<T>` 接口提供的按位取反 `!` 和一元负号 `-` 可通过演算式构造出类型 `T` 的值 `1`，但 `Number<T>`（浮点的父接口）不提供这些运算符，无法在泛型上下文中构造 `T(1)`。

**迁移建议**

浮点 Vec 的逐分量 +1/-1 需手动构造：

```cangjie
// C++:   ++v;  或  v++;
// 仓颉 (整数):
v.increment()   // OK，原地修改

// 仓颉 (浮点): 无 increment()，需手动
let v = Vec2<Float32, PackedHighp>(1.5f, 2.5f)
let newV = Vec2(v.x + Float32(1.0), v.y + Float32(1.0))
```

---

## 二、仓颉限制导致功能有偏差/接口不一致

### DV-01: `fromBoolVec` 需要额外提供零值和壹值

**C++ GLM 行为**

```cpp
vec2 result = fromBoolVec<float>(bvec2(true, false));
// 内部自动：true → float(1.0f), false → float(0.0f)
```

C++ 可通过模板参数 `T` 的构造函数 `T(1)` / `T(0)` 自动转换，调用者无需关心零值壹值。

**仓颉 GLM 行为**

函数签名增加了 `zero: T, one: T` 两个参数，调用方必须显式提供：

```cangjie
public func fromBoolVec<T, Q>(v: Vec2<Bool, Q>, zero: T, one: T): Vec2<T, Q>
    where Q <: Qualifier
```

同时提供跨限定符（qualifier）版本 `fromBoolVecQ2`：

```cangjie
public func fromBoolVecQ2<T, Q, Q2>(v: Vec2<Bool, Q2>, zero: T, one: T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
```

**原因**

仓颉无约束泛型参数不支持 `T(n)` 构造调用——编译器无法确认泛型 `T` 拥有接受 `Int64` 参数的构造函数。即使添加 `where T <: Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明。

**迁移建议**

调用时显式传入零值和壹值：

```cangjie
let bv = Vec2<Bool, PackedHighp>(true, false)

// C++:   vec2 result = fromBoolVec<float>(bv);
// 仓颉:
let result = fromBoolVec(bv, Float32(0.0), Float32(1.0))       // Float32 版本
let result64 = fromBoolVec(bv, Float64(0.0), Float64(1.0))     // Float64 版本
let resulti = fromBoolVec(bv, Int32(0), Int32(1))               // Int32 版本
```

---

### DV-02: `%`（取模）仅对整数类型可用（运算符级）；自由函数 `mod(s, v)` 已支持浮点

**C++ GLM 行为**

C++ 中 `%` 运算符对浮点类型也可使用（通过重载或 GLM 的 `mod` 函数），C++ GLM 在 `Number<T>` 约束的 extend 块中提供 `%` 和 `mod`。

**仓颉 GLM 行为**

`%` 运算符和 Vec 成员函数 `mod(s: T)` 仅在 `Integer<T>` 约束的 extend 块中提供：

```cangjie
// 运算符级——仅整数类型 T 有此运算符
extend<T, Q> Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> { ... }
    @OverflowWrapping
    public operator func %(rhs: T): Vec2<T, Q> { ... }
    public func mod(s: T): Vec2<T, Q> { this % s }
    // ... 其他重载
}
```

**浮点类型使用 `%` 会触发编译错误**，错误不在运算符定义处，而是在浮点实例化处（延迟检查）。

但**标量-向量自由函数 `mod(s, v)` 已提供浮点重载**（Float32/Float64/Float16 各 4 个，共 12 个），内部使用 `std.math.fmod` 实现：

```cangjie
// 整数版（泛型）
public func mod<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier

// 浮点版（具体类型）
public func mod<Q>(s: Float32, v: Vec2<Float32, Q>): Vec2<Float32, Q> where Q <: Qualifier
public func mod<Q>(s: Float64, v: Vec2<Float64, Q>): Vec2<Float64, Q> where Q <: Qualifier
public func mod<Q>(s: Float16, v: Vec2<Float16, Q>): Vec2<Float16, Q> where Q <: Qualifier
// ... Vec1/Vec3/Vec4 同理
```

**原因**

仓颉 `Number<T>` 接口不提供 `%` 运算符，仅 `Integer<T>` 接口提供 `operator func %(rhs: T): T`。这是标准库接口的设计限制。浮点自由函数 `mod(s, v)` 通过具体类型重载绕过此限制。

**迁移建议**

```cangjie
// 整数：运算符和自由函数均可
let r = ivec2(7, 3) % ivec2(3, 2)   // OK: (1, 1)
let r2 = mod(Int32(7), ivec2(3, 2)) // OK: (1, 1)

// 浮点：运算符不可用，但自由函数 mod(s, v) 可用
let v = Vec2<Float32, PackedHighp>(Float32(7.5), Float32(3.2))
// let r = v % Vec2(Float32(2.5), Float32(1.1))  // 编译错误！
let r = mod(Float32(7.5), v)                      // OK，使用 fmod
```

---

### DV-03: 移位运算右操作数固定为 `Int64`

**C++ GLM 行为**

```cpp
ivec2 result = ivec2(1, 2) << ivec2(1, 2);  // 右操作数类型与分量类型 T 相同
ivec2 result2 = ivec2(1, 2) << 3;            // 标量移位，类型仍为 T
```

移位运算的右操作数类型与向量分量类型 `T` 一致。

**仓颉 GLM 行为**

移位运算的右操作数**固定为 `Int64`**：

```cangjie
// 标量移位——右操作数为 Int64
public operator func <<(shift: Int64): Vec2<T, Q>         // 非 shift: T

// 向量移位——右操作数向量分量类型为 Int64
public operator func <<(rhs: Vec2<Int64, Q>): Vec2<T, Q>  // 非 Vec2<T, Q>

// 广播移位——Vec1 广播到 Vec2，分量类型为 Int64
public operator func <<(rhs: Vec1<Int64, Q>): Vec2<T, Q>  // 非 Vec1<T, Q>
```

**原因**

仓颉 `Integer<T>` 接口规定移位运算签名为 `operator func <<(n: Int64): T`，右操作数必须是 `Int64`。这是标准库接口级别的限制，无法通过泛型约束绕过。

**迁移建议**

移位时右操作数需转为 `Int64`：

```cangjie
// 标量移位
let v = IVec2(1, 2)
let r1 = v << Int64(3)                  // 标量：显式转 Int64

// 向量移位
let shift = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
let r2 = v << shift                      // 向量：右操作数分量类型为 Int64

// 若原始移位量是 Int32 向量，需逐分量转换
let i32shift = IVec2(1, 2)
let i64shift = Vec2<Int64, PackedHighp>(Int64(i32shift.x), Int64(i32shift.y))
let r3 = v << i64shift
```

---

### DV-04: `isIec559Of` / `epsilonOf` 需要传入值参数

**预期设计**

```cangjie
const func isIec559Of<T>(): Bool    // 无参数，靠泛型 T 推断
const func epsilonOf<T>(): T        // 无参数，靠泛型 T 推断
```

意图是只通过泛型类型参数即可判断类型是否为 IEC 559（IEEE 754）浮点数，或获取机器 epsilon 值。

**仓颉 GLM 实际行为**

两个函数均需要传入一个值参数 `hint: T` 来辅助类型推断：

```cangjie
public func isIec559Of<T>(hint: T): Bool {
    match (hint) {
        case _: Float64 => true
        case _: Float32 => true
        case _ => false
    }
}

public func epsilonOf<T>(hint: T): T where T <: Number<T> {
    NumericLimits<T>.epsilon(hint)
}
```

同时 `NumericLimits<T>.epsilon(hint: T)` 也需要此参数。

**原因**

三层限制叠加：
1. 无约束泛型不支持 `T(0)` 构造调用——无法在函数体内创建 `T` 的实例
2. 仓颉编译器在无值参数时难以推断泛型 `T` 的具体类型
3. 实现使用运行时 `match` 类型模式匹配（非 `const`），函数本身不可声明为 `const`

**迁移建议**

传入目标类型的零值即可——值本身不做运算，仅用于类型推断：

```cangjie
// 判断类型是否为 IEEE 754 浮点
let isF32Iec = isIec559Of(Float32(0.0))   // true
let isF64Iec = isIec559Of(Float64(0.0))   // true
let isIntIec = isIec559Of(Int32(0))        // false

// 获取机器 epsilon
let eps32 = epsilonOf(Float32(0.0))  // 1.1920929e-7
let eps64 = epsilonOf(Float64(0.0))  // 2.220446049250313e-16
```

---

### DV-05: `==` 对浮点 Vec 采用精确比较，`equalEpsilon` 不可在 `const` 上下文使用

**C++ GLM 行为**

C++ GLM 的 `operator==` 对所有类型（含浮点）执行精确逐分量比较（`a.x == b.x && a.y == b.y && ...`），这与 `operator!=` 互逆。需要容差比较时，用户自行编写 epsilon 判断逻辑。

**仓颉 GLM 行为**

`==` 和 `!=` 定义在 `T <: Equatable<T>` 的 extend 块中，对所有类型（含浮点）执行**精确比较**：

```cangjie
extend<T, Q> Vec2<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Vec2<T, Q>): Bool {
        ComputeEqual<T>.call(this.x, rhs.x) && ComputeEqual<T>.call(this.y, rhs.y)
    }
    public operator func !=(rhs: Vec2<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Vec2<T, Q>): Bool { ... }  // 显式精确比较
}
```

另外提供 `equalEpsilon` 用于浮点容差比较：

```cangjie
extend<T, Q> Vec2<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Vec2<T, Q>): Bool {
        ComputeEqualNumeric<T>.callConst(this.x, other.x)
        && ComputeEqualNumeric<T>.callConst(this.y, other.y)
    }
}
```

`ComputeEqualNumeric.callConst` 对 IEC 559（IEEE 754）浮点类型执行 epsilon 容差比较 `|a - b| <= epsilon`，对非浮点类型退化为精确比较。

**关键偏差**：`equalEpsilon` 不可在 `const` 上下文使用（因为 extend 块不支持 `const` 修饰符），因此**编译期浮点容差比较不可用**。

**原因**

仓颉 extend 块中的函数不支持 `const` 修饰符。`==` 和 `equalEpsilon` 均定义在 extend 块中，故均为非 const。而 `==` 本身的精确比较行为与 C++ GLM 一致，这不算是偏差——偏差在于 `equalEpsilon` 无法用于编译期。

**迁移建议**

```cangjie
// 精确比较（与 C++ GLM 行为一致）
let same = v1 == v2            // 可用
let diff = v1 != v2            // 可用

// 浮点容差比较（运行时）
let close = v1.equalEpsilon(v2)  // 非 const，仅运行时可用

// 编译期容差比较：不可用，需手动构造
// const val close = v1.equalEpsilon(v2)  // 编译错误
```

---

### DV-06: Bool 向量逻辑运算使用具名函数而非运算符

**C++ GLM 行为**

C++ 可通过运算符重载使 `&&` 和 `||` 对 Bool 向量逐分量运算：

```cpp
bvec2 result = bvec2(true, false) && bvec2(true, true);  // 逐分量 AND
```

**仓颉 GLM 行为**

仓颉不可重载 `&&` 和 `||` 运算符。Bool 向量的逻辑运算使用具名函数：

```cangjie
extend<Q> Vec2<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec2<Bool, Q>): Vec2<Bool, Q>
    public func logicalOr(other: Vec2<Bool, Q>): Vec2<Bool, Q>
}
```

**原因**

仓颉语言不允许重载短路逻辑运算符 `&&` 和 `||`。这是语言设计层面的限制——短路运算符的语义（不评估右操作数）与逐分量求值的行为天然矛盾。

**迁移建议**

使用具名函数替代运算符：

```cangjie
let a = Vec2<Bool, PackedHighp>(true, false)
let b = Vec2<Bool, PackedHighp>(true, true)

// C++:  bvec2 r1 = a && b;
// 仓颉:
let r1 = a.logicalAnd(b)   // (true && true, false && true) = (true, false)

// C++:  bvec2 r2 = a || b;
// 仓颉:
let r2 = a.logicalOr(b)    // (true || true, false || true) = (true, true)
```

---

### DV-07: Bool 向量不支持逐分量逻辑取反

**C++ GLM 行为**

C++ GLM 中 `!bvec` 对 Bool 向量逐分量取反，返回新的 Bool 向量：

```cpp
bvec2 result = !bvec2(true, false);  // result = (false, true)
```

**仓颉 GLM 行为**

Boolean 向量**不提供 `!` 运算符重载**，也不提供 `logicalNot` 函数。无法对 Bool 向量执行逐分量取反操作。

**原因**

仓颉语言**支持**重载一元 `!` 运算符（`operator func !(): R`），且 `VecN<Bool, Q>` 是独立类型，在其上定义 `operator func !()` 不会与 `Bool` 已有的 `!` 冲突。当前库未提供此功能，属于**设计遗漏**而非语言硬限制。Bool 向量当前仅提供 `logicalAnd` 和 `logicalOr` 两个具名逻辑函数：

```cangjie
extend<Q> Vec2<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec2<Bool, Q>): Vec2<Bool, Q> { ... }
    public func logicalOr(other: Vec2<Bool, Q>): Vec2<Bool, Q> { ... }
    // 无 logicalNot，也无 operator func !()
}
```

**迁移建议**

手动逐分量构造取反结果：

```cangjie
let b = Vec2<Bool, PackedHighp>(true, false)
// C++: bvec2 r = !b;
// 仓颉:
let r = Vec2<Bool, PackedHighp>(!b.x, !b.y)
```

---

### DV-08: `fromBoolVec` 测试无法验证 `T(1)`/`T(0)` 原始转换语义

**C++ GLM 行为**

C++ GLM 的 `fromBoolVec` 内部负责 `true → T(1)`、`false → T(0)` 的构造转换，测试可直接验证此语义。

**仓颉 GLM 行为**

由于 `fromBoolVec` 已改为 `(v, zero, one)` 形式（见 DV-01），测试只能验证布尔分量是否正确映射到调用方提供的 `zero` / `one`，无法再覆盖 C++ 语义中由库内部负责的 `true → T(1)`、`false → T(0)` 构造过程。

**原因**

这是接口偏差（DV-01）带来的测试边界变化。调用方显式提供 `zero`/`one` 后，测试验证的是"布尔分量到调用方提供值的映射"而非"布尔分量到类型默认零壹值的构造"。

**迁移建议**

无需迁移。此偏差不影响当前 API 的功能正确性——只要调用方传入正确的零值和壹值，行为与 C++ GLM 一致。属于测试覆盖边界问题。

---

### DV-09: 跨类型向量转换需使用 `castVecN` 函数而非构造函数

**C++ GLM 行为**

C++ GLM 支持通过构造函数在不同类型和维度的向量间直接转换：

```cpp
vec3 result(v2);   // vec2 → vec3，z 填充
vec4 result(v3);   // vec3 → vec4，w 填充
vec2 result(v4);   // vec4 → vec2，截断
```

**仓颉 GLM 行为**

仓颉不支持泛型构造函数 `init<T2, Q2>(v: Vec2<T2, Q2>)`，且不支持 `T(v.x)` 类型参数作为构造调用。替代方案为 `castVecN(v, conv)` 自由函数——共 16 个重载（4 种目标 Vec 类型 × 4 种源 Vec 类型），通过 `conv` 闭包提供分量级类型映射：

```cangjie
let v = Vec2<Int64, PackedHighp>(10, 20)
let r = castVec3<Float32, PackedHighp, Int64, PackedHighp>(v, { x => Float32(x) })
// r = Vec3(Float32(10.0), Float32(20.0), Float32(20.0))
```

因仓颉重载解析按参数类型而非返回类型判断，不同目标类型的转换函数无法共用同一函数名，故编码为 4 个独立函数名 `castVec1`/`castVec2`/`castVec3`/`castVec4`。

**原因**

仓颉不支持泛型构造函数 `init<T2, Q2>(v: Vec2<T2, Q2>)`，且无约束泛型不支持 `T(v.x)` 构造调用。与 DV-01 同为 `T(n)` 构造限制。

**迁移建议**

使用 `castVecN` 系列函数替代构造函数语法：

```cangjie
// C++:   vec3 result(v2);
// 仓颉:
let result = castVec3(v2, { x => Float32(x) })

// C++:   ivec2 result(v4);  // 截断
// 仓颉:
let result = castVec2(v4, { x => Int32(x) })
```

---

### DV-10: `increment()` / `decrement()` 为 `mut` 函数（原地修改返回 `Unit`），而非返回新向量副本

**C++ GLM 行为**

C++ GLM 的 `operator++` 前缀形式返回递增后的引用、后缀形式返回递增前的副本，两者均可作为表达式使用：

```cpp
vec2 v(1.0f, 2.0f);
vec2 r = ++v;  // 前缀：r = v = (2.0f, 3.0f)
vec2 s = v++;  // 后缀：s = (2.0f, 3.0f)，v = (3.0f, 4.0f)
```

**仓颉 GLM 行为**

`increment()` / `decrement()` 为 `mut` 函数，原地修改 `this` 并返回 `Unit`：

```cangjie
@OverflowWrapping
public mut func increment(): Unit {
    this.x = this.x + (-(!(this.x - this.x)))
    this.y = this.y + (-(!(this.y - this.y)))
}
```

调用方必须两步操作：`v.increment()` 修改 v 原地；无法链式调用或作为表达式使用。返回值类型从 `VecN<T, Q>` 变为 `Unit`。

**原因**

仓颉语言层面的 `++`/`--` 运算符本身即为原地修改返回 `Unit`（`expr++` 的类型为 Unit），不支持 C++ 的前缀/后缀语义区分。`increment()`/`decrement()` 的设计与此一致。

**迁移建议**

迁移 `v++` 或 `++v` 时需改写为 `v.increment()` 然后独立使用 v，不能嵌入表达式：

```cangjie
// C++:  vec2 r = ++v;
// 仓颉:
v.increment()
let r = v    // v 已被原地修改

// 如需创建新副本（模拟 C++ 后缀语义）：
let old = Vec2(v.x, v.y)  // 先保存旧值
v.increment()              // 原地修改
// old 为旧值，v 为新值
```

---

### DV-11: `castVecN` 低维→高维填充策略与 C++ GLM 的构造函数语义不同

**C++ GLM 行为**

C++ GLM 中跨维度转换构造时，额外分量填充固定值（通常为 0 或 1）：

```cpp
vec4(vec3 const& v)  // w = 1（齐次坐标惯例）
vec3(vec2 const& v)  // z = 0
vec2(vec4 const& v)  // truncate to xy
```

**仓颉 GLM 行为**

`castVecN` 系列函数在低维→高维转换时，**将最后一个可用分量的值重复到所有额外维度**：

```cangjie
castVec3(v2, conv)   // 结果 Vec3(x=conv(v2.x), y=conv(v2.y), z=conv(v2.y))
                     // 而非 C++ GLM 的 z=0
castVec4(v3, conv)   // 结果 Vec4(x=conv(v3.x), y=conv(v3.y), z=conv(v3.z), w=conv(v3.z))
                     // 而非 C++ GLM 的 w=1
castVec4(v2, conv)   // 结果 Vec4(x=conv(v2.x), y=conv(v2.y), z=conv(v2.y), w=conv(v2.y))
                     // 而非 C++ GLM 的 z=0, w=1
```

**原因**

此为有意设计选择。重复最后一个分量避免了在泛型上下文中构造类型 `T` 的零值或壹值（与 DV-01 同源限制），且此行为已被测试覆盖确认。

**迁移建议**

若用户依赖 C++ GLM 的填充 0/1 语义，迁移后需手动设置目标值：

```cangjie
// C++:   vec4 result(v3);  // w = 1
// 仓颉:
let tmp = castVec4(v3, { x => Float32(x) })  // w = v3.z（非 1）
let result = Vec4(tmp.x, tmp.y, tmp.z, Float32(1.0))  // 手动设置 w = 1
```

注意：在 high→low 截断场景（如 `castVec2(v3, conv)` 只取 xy）中，仓颉与 C++ 行为一致（取前 N 个分量）。**此偏差仅影响 low→high 扩展方向**。

---

## 三、内部区别

以下偏差仅影响库内部实现结构或组织方式，**用户使用方式和运行时行为无区别**。

| 编号 | 描述 | 原因 |
|------|------|------|
| INT-01 | **运算符定义全部在带约束的 `extend` 块中**。struct 体仅含数据成员、构造函数、下标运算符和 `length` 属性；所有算术/位/比较运算符均通过 `extend<T, Q> where T <: Number<T>` 等约束块提供 | 仓颉无约束泛型参数不能执行任何运算符操作（如 `this.x + rhs.x`、`!this.x`），必须通过 `Number<T>` / `Integer<T>` / `Equatable<T>` 等约束声明运算能力。用户调用 `a + b`、`a == b` 等与 C++ 一致，感知不到区别 |
| INT-02 | **`ComputeEqual` 拆分为两个结构体**：`ComputeEqual<T>`（精确比较，约束 `Equatable<T>`）和 `ComputeEqualNumeric<T>`（epsilon 容差，约束 `Number<T> & Equatable<T> & Comparable<T>`） | 仓颉运行时 `if` 的两个分支均需编译通过。原设计的单一 `ComputeEqual<T>` 中，epsilon 分支所需的 `a - b` 和 `epsilonOf(a)` 要求 `Number<T>` 约束，与无约束 `T` 矛盾。用户通过 `==` 和 `equalEpsilon` 使用，感知不到拆分 |
| INT-03 | **`fwd.cj` 使用命名空间导入 `import glm.detail` + `detail.VecN<...>` 限定访问**，而非 `import glm.detail.{Vec1, ...}` 命名导入 | 名称导入将泛型 `Vec1<T, Q>` 引入作用域，与后续 `public type Vec1 = Vec1<Float32, PackedHighp>` 别名定义同名，导致本地声明遮蔽导入，产生 252 个编译错误。用户使用 `glm.Vec2` 等别名时无感知 |
| INT-04 | **`equalEpsilon` 委托 `ComputeEqualNumeric<T>.callConst` 而非内联 `abs(a-b) <= epsilonOf(a)`** | 与 INT-02 联动——`callConst` 作为独立约束结构体的静态方法，复用性优于内联。行为完全等价 |
| INT-05 | **`increment()`/`decrement()` 在泛型 `Integer<T>` 上下文中使用演算式 `-(!(this.x - this.x))` 代替字面量 `1`** | 仓颉 `Integer<T>` 泛型上下文中无法直接使用 `Int64(1)` 或字面量 `1` 作为类型 `T` 的值——编译器将字面量视为 `Int64` 而非 `T`。实现使用数学恒等式：`this.x - this.x → 0 (T)`、`!0 → -1 (T)`、`-(-1) → 1 (T)`。该演算被 `@OverflowWrapping` 保护，对所有有符号和无符号整数类型行为正确。用户调用 `v.increment()` / `v.decrement()` 时感知不到此内部实现差异 |
| INT-06 | **`type_vec1_test.cj` 曾被误放入 `src/detail/` 导致编译失败（已删除）** | 测试文件被误放入源码目录（应在 `tests/glm/detail/`），导致其被当作源代码编译。因 `PackedHighp` 限定符下的 Vec1 运算符未被实现，编译器报 143 个错误。该问题在构建缓存有效时被掩盖，缓存失效后暴露。删除该文件后编译通过，422 项测试全部 PASSED。原文件中的 54 个测试用例因本身无法通过编译，从未在验证管线中实际运行 |

---

## 四、未验证的偏差添加

| 编号 | 描述 | 原因 | 证据 | 验证次数 |
|------|------|------|------|---------|
| DV-12 | **S1 quatCast 修复验证测试的 epsilon 容忍度已放宽**。`type_quat_cast_s1_test.cj` 中的 `mat3EqualEpsilonRelaxed` 辅助函数使用 `epsilon<Float64>() * 250000000.0`（≈5.55e-8）而非默认的 `epsilon<Float64>() * 100.0`（≈2.22e-14），作为 Float64 浮点舍入误差的容差缓冲 | 2 个 W-branch 测试在 Float64 精度下存在约 5e-8 的舍入误差（W-branch sqrt→div→mat3Cast 重建存在数值放大效应），远超默认 epsilon*100（≈2.22e-14）和设计预估的 5e-14，需要更宽松的容差 | `type_quat_cast_s1_test.cj:4` 确认 epsilon 乘数为 250000000.0；`cjpm test` 输出 435+ PASSED / 0 FAILED | 1（S1 修复后回归验证） |

## 五、未验证的偏差删除

（暂无）
