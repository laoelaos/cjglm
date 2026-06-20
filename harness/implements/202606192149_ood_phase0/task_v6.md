# 任务指令（v6）

## 动作
NEW

## 任务描述
修复 type_vec1~4.cj 中三类预存的泛型约束编译错误，同步修正测试文件中的无效测试用例。

涉及文件：
- `src/detail/type_vec1.cj` — Vec1 泛型结构体
- `src/detail/type_vec2.cj` — Vec2 泛型结构体
- `src/detail/type_vec3.cj` — Vec3 泛型结构体
- `src/detail/type_vec4.cj` — Vec4 泛型结构体
- `src/detail/type_vec1_test.cj` — Vec1 单元测试
- `src/detail/type_vec2_test.cj` — Vec2 单元测试
- `src/detail/type_vec3_test.cj` — Vec3 单元测试
- `src/detail/type_vec4_test.cj` — Vec4 单元测试

## 选择理由
R4（公共 API 与别名层）验证时 `cjpm test` 因 R3 预存编译错误失败（96 errors 全部来自 type_vec1.cj），R4 代码本身是正确的。必须先行修复 R3 遗留的编译错误后，R4 才能通过验证。

## 任务上下文

### 背景
验证报告 v5 显示 96 个编译错误，打印了前 8 个（均来自 type_vec1.cj）。错误分为三类：

### 修复 1：`%` 运算符移入 `Integer<T>` extend 块
- **当前状态**：`%` 定义在 `extend<T, Q> VecN<T, Q> where T <: Number<T>` 块中
- **原因**：`Number<T>` 接口仅提供 `+`、`-`、`*`、`/` 和一元 `-`，**不提供 `%`**
- **`Integer<T>` 接口** 提供 `operator func %(rhs: T): T`
- **修复**：将 `public operator func %(...)` 的所有重载（VecN op VecN、VecN op T、以及 Vec1 对 Vec2/3/4 广播）从 `Number<T>` 块移到 `Integer<T>` 块。伴随 `%` 的 `public func mod(s: T): VecN<T, Q>` 具名函数也一同移动。保留 `@OverflowWrapping` 标注

### 修复 2：`<<`/`>>` 右操作数改为 `Int64`
- **当前状态**：`<<(rhs: VecN<T, Q>)` 和 `<<(shift: T)` 等，右操作数为 `T`
- **原因**：`Integer<T>` 接口中 `<<`/`>>` 定义签名是 `operator func <<(n: Int64): T`，右操作数必须是 `Int64`，不能是 `T`
- **修复**：将所有 `<<`/`>>` 的右操作数类型从 `T` 改为 `Int64`：
  - `operator func <<(rhs: Vec1<T, Q>)` → `operator func <<(rhs: Vec1<Int64, Q>)`
  - `operator func <<(shift: T)` → `operator func <<(shift: Int64)`
  - `operator func <<(rhs: Vec2<T, Q>)` → `operator func <<(rhs: Vec2<Int64, Q>)`（Vec1 对 Vec2 广播）
  - 以及 Vec2/3/4 中的 Vec1 广播版本同理
  - `>>` 同理

### 修复 3：删除一元 `+` 运算符
- **当前状态**：`public operator func +(): Vec1<T, Q> { this }`
- **原因**：仓颉可重载运算符列表中 **不包含** 一元 `+`（仅一元 `-` 合法）
- **修复**：从所有 Vec 类型的 `Number<T>` extend 块中删除 `public operator func +()` 行
- 一元 `-` 不受影响，保持原样

### Vec1 修复清单（以 type_vec1.cj 为模板，其他 Vec 文件同理）

**Number\<T\> 块中需要移动的 `%` 相关行**（移到 Integer\<T\> 块中与 `&`/`|`/`^` 等并列）：
```
@OverflowWrapping
public operator func %(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x % rhs.x) }
@OverflowWrapping
public operator func %(rhs: T): Vec1<T, Q> { Vec1(this.x % rhs) }
public func mod(s: T): Vec1<T, Q> { this % s }
@OverflowWrapping
public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x % rhs.x, this.x % rhs.y) }
@OverflowWrapping
public operator func %(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z) }
@OverflowWrapping
public operator func %(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z, this.x % rhs.w) }
```

**Number\<T\> 块中需要删除的行**（一元 +）：
```
public operator func +(): Vec1<T, Q> { this }
```

**Integer\<T\> 块中需要修改的 `<<`/`>>` 行**：
- `<<(rhs: Vec1<T, Q>)` → `<<(rhs: Vec1<Int64, Q>)`
- `<<(shift: T)` → `<<(shift: Int64)`
- `<<(rhs: Vec2<T, Q>)` → `<<(rhs: Vec2<Int64, Q>)`
- `<<(rhs: Vec3<T, Q>)` → `<<(rhs: Vec3<Int64, Q>)`
- `<<(rhs: Vec4<T, Q>)` → `<<(rhs: Vec4<Int64, Q>)`
- 同理 `>>` 所有重载

**Integer\<T\> 块中需要插入的 `%` 相关行**（在上述修改后，紧接 `bitwiseNot` 之前或之后）：
```
@OverflowWrapping
public operator func %(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x % rhs.x) }
@OverflowWrapping
public operator func %(rhs: T): Vec1<T, Q> { Vec1(this.x % rhs) }
public func mod(s: T): Vec1<T, Q> { this % s }
@OverflowWrapping
public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x % rhs.x, this.x % rhs.y) }
@OverflowWrapping
public operator func %(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z) }
@OverflowWrapping
public operator func %(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z, this.x % rhs.w) }
```

### Vec2/3/4 特有说明
Vec2/3/4 的 `Number<T>` 块中也有 `%` 运算符（含 Vec* op Vec* 和 Vec* op T），以及 `mod` 具名函数，均需移入各自的 `Integer<T>` 块。

Vec2/3/4 的 `Integer<T>` 块中也有 `<<`/`>>` 对 Vec1 的广播（`<<(rhs: Vec1<T, Q>)`），需改为 `<<(rhs: Vec1<Int64, Q>)`。

### 测试文件修改

类型_vec1_test.cj 需要：
1. **删除** `testVec1UnaryPlus` 测试函数（`+v` 不再合法）
2. **无需修改** `testVec1ShiftVec` / `testVec1ShiftRightVec` / 广播移位测试，因为这些测试中 `T = Int64`，修改后的签名 `<<(rhs: Vec1<Int64, Q>)` 仍然匹配 `Vec1<Int64, Defaultp>`
3. **无需修改** `%` 运算符测试，因为 `Int64 <: Integer<Int64>`，移入 `Integer<T>` 块后继续可用

其他 vec 测试文件同理。

### 编译验证方式
```powershell
cjpm build
# 应无 error 输出，96 errors 全部消除
```

### 依赖
- 不依赖其他未完成任务
- 修复后即可重新验证 R4

## 已有代码上下文

### 已知可用的接口约束
来自仓颉标准库 `std.math`：

**Number\<T\>**：
```
operator func +(rhs: T): T
operator func -(rhs: T): T
operator func *(rhs: T): T
operator func /(rhs: T): T
operator func -(): T     // 一元负号
```

**Integer\<T\>** （继承 Number\<T\>）：
```
static func isSigned(): Bool
operator func %(rhs: T): T   // 余数
operator func &(rhs: T): T   // 按位与
operator func |(rhs: T): T   // 按位或
operator func ^(rhs: T): T   // 按位异或
operator func !(): T          // 按位取反
operator func >>(n: Int64): T // 右移（右操作数为 Int64）
operator func <<(n: Int64): T // 左移（右操作数为 Int64）
```

### 可重载运算符列表（仓颉）
`()`、`[]`、`!`、`-`（一元）、`**`、`*`、`/`、`%`、`+`、`-`（二元）、`<<`、`>>`、`<`、`<=`、`>`、`>=`、`==`、`!=`、`&`、`^`、`|`

注意：一元 `+` **不在列表中**，不可重载。
