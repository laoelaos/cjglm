# 任务指令（v1）

## 动作
NEW

## 任务描述
实现 OOD Phase0 的首个任务——**项目基础设施层**，包含：

### 1. 项目初始化（$2）
- 在 `C:\Develop\Software\cjglm_wp\cjglm` 目录下执行 `cjpm init --type=static` 初始化静态库项目
- 创建完成后配置 `cjpm.toml`：

```toml
[package]
  cjc-version = "1.0.5"
  name = "glm"
  version = "0.1.0"
  output-type = "static"
  src-dir = "src"

[test]
  src-dir = "tests"
```

- 确保目录结构如下：
```
cjglm/
├── cjpm.toml
├── src/
│   └── glm/
│       ├── lib.cj         (最小内容：`package glm`)
│       ├── fwd.cj         (最小内容：`package glm`)
│       └── detail/
│           ├── setup.cj
│           ├── qualifier.cj
│           ├── shim_assert.cj
│           ├── shim_limits.cj
│           └── shim_cstddef.cj
└── tests/
    └── glm/
        ├── test_lib.cj    (最小内容：`package glm；import glm.*`)
        ├── test_fwd.cj    (最小内容：`package glm；import glm.*`)
        └── detail/
            └── (后续测试文件)
```

### 2. setup.cj（$3.6 依赖拓扑澄清）
配置常量文件，声明 `package glm.detail`。定义：

```cangjie
package glm.detail

// GLM 版本常量
const GLM_VERSION_MAJOR: Int64 = 1
const GLM_VERSION_MINOR: Int64 = 0
const GLM_VERSION_PATCH: Int64 = 3
const GLM_VERSION: Int64 = 103

// 配置开关
const GLM_CONFIG_SIMD: Bool = false
const GLM_CONFIG_ALIGNED_GENTYPES: Bool = false
const GLM_CONFIG_CLIP_CONTROL: Bool = false
```

### 3. shim_cstddef.cj（$3.6）
声明 `package glm.detail`。定义：

```cangjie
package glm.detail

public type SizeT = UInt64
public type LengthT = Int64
```

### 4. shim_assert.cj（$3.6）
声明 `package glm.detail`。提供断言函数：

```cangjie
package glm.detail

public func assert(condition: Bool, message: String = "Assertion failed"): Unit {
    if (!condition) {
        throw Exception(message)
    }
}
```

### 5. shim_limits.cj（$3.5/$3.6）
声明 `package glm.detail`。提供：

- `NumericLimits<T>` 结构体（where T <: Number<T>），包含：
  - `static func max(): T` —— 返回 `T.Max`（各数值类型自带 `Max` 静态属性，通过 `import std.math.{ Number }` 约束后即可使用；若编译器不支持泛型 `T.Max` 访问，回退为硬编码值）
  - `static func min(): T` —— 返回 `T.Min`（同上）
  - `static func epsilon(): T` —— 浮点机器 epsilon（对 `Float32` 返回 `1.1920929e-7`，对 `Float64` 返回 `2.220446049250313e-16`）
  - **注意**：`Number<T>` 接口仅声明算术运算符（`+`/`-`/`*`/`/`/`-`），**不包含** `Max`/`Min`。`T.Max`/`T.Min` 的访问依赖编译器对泛型参数的具体类型静态属性解析。若编译失败，移除 `max()`/`min()`（它们不是 phase0 消费项），或改用 `T(0)` 构造后通过语义推导。
- `const func isIec559Of<T>(): Bool` —— 判断 T 是否为 IEEE 754 浮点类型
  ```
  const func isIec559Of<T>(): Bool {
      if (T(0) is Float64 || T(0) is Float32) { true } else { false }
  }
  ```
- `const func epsilonOf<T>(): T where T <: Number<T>` —— 委托给 `NumericLimits<T>.epsilon()`

依赖：`import std.math.{ Number }`（用于 `Number<T>` 接口约束）

### 6. qualifier.cj（$3.1）
声明 `package glm.detail`。提供：

```cangjie
package glm.detail

// Qualifier 接口
public interface Qualifier {}

// Packed 系列（public）
public struct PackedHighp <: Qualifier {}
public struct PackedMediump <: Qualifier {}
public struct PackedLowp <: Qualifier {}

// Aligned 系列（internal，首轮不对外暴露）
internal struct AlignedHighp <: Qualifier {}
internal struct AlignedMediump <: Qualifier {}
internal struct AlignedLowp <: Qualifier {}

// 默认精度别名
public type Defaultp = PackedHighp
```

## 选择理由
基础依赖层：所有 Vec 类型（通过 `where Q <: Qualifier` 约束）和所有运算函数均依赖 Qualifier 体系。Shim 层提供断言、数值极限、类型别名等基础工具。这些模块均无项目内依赖（仅依赖仓颉标准库），是整个代码库的根基，按照"底层依赖优先"原则排为第一个任务。

## 任务上下文
摘录自 OOD 设计文档 $2（项目初始化）、$3.1（Qualifier 体系）、$3.6（Shim 层）、$3.5（ComputeEqual 中的 epsilonOf/isIec559Of）。

- 编译器版本 >= 1.0.5（当前：1.1.0 ✓）
- 项目类型为 static library
- Qualifier 是实现 `Qualifier` 接口的空结构体
- Aligned 系列使用 `internal` 可见性
- `isIec559Of<T>()` 使用 `T(0) is Float64 || T(0) is Float32` 模式
- `NumericLimits<T>` 使用 `where T <: Number<T>` 约束

## 已有代码上下文
- 项目根目录 `C:\Develop\Software\cjglm_wp\cjglm` 当前为空目录
- 编译器版本 1.1.0（满足 >= 1.0.5 要求）
- 参考实现位于 `C:\Develop\Software\cjglm_wp\references\glm-1.0.3\glm\glm\detail\`

### 编码规范
- 遵循仓颉编码规范，使用 PascalCase 类型命名、camelCase 函数/变量命名
- struct 体内部成员函数使用 `public` 修饰符
- 所有文件头部声明 `package glm.detail`
- 不添加多余的注释，代码应自文档化
- 使用 `cjpm build` 验证编译通过

### 文件路径清单
| 文件 | 包 | 最小内容说明 |
|------|-----|------------|
| `src/glm/detail/setup.cj` | `glm.detail` | 见 §2 配置常量 |
| `src/glm/detail/shim_cstddef.cj` | `glm.detail` | 见 §3 SizeT/LengthT |
| `src/glm/detail/shim_assert.cj` | `glm.detail` | 见 §4 assert 函数 |
| `src/glm/detail/shim_limits.cj` | `glm.detail` | 见 §5 NumericLimits |
| `src/glm/detail/qualifier.cj` | `glm.detail` | 见 §6 Qualifier 体系 |
| `src/glm/lib.cj` | `glm` | 至少包含 `package glm`，空占位文件后续填充 |
| `src/glm/fwd.cj` | `glm` | 至少包含 `package glm`，空占位文件后续填充 |

### 7. 基础设施层单元测试
声明 `package glm.detail`。在 R1 阶段为基础设施层编写以下测试文件：

**test_setup.cj** — 验证 `setup.cj` 配置常量的值正确性：
```cangjie
// tests/glm/detail/test_setup.cj
package glm.detail
import std.unittest.*

@Test
public func test_glm_version_constants() {
    @Assert(GLM_VERSION_MAJOR == 1)
    @Assert(GLM_VERSION_MINOR == 0)
    @Assert(GLM_VERSION == 103)
}
```

**test_qualifier.cj** — 验证 `Qualifier` 接口实现正确性：
```cangjie
// tests/glm/detail/test_qualifier.cj
package glm.detail
import std.unittest.*

@Test
public func test_qualifier_types() {
    let ph = PackedHighp()
    let pm = PackedMediump()
    let pl = PackedLowp()
    let dp: Defaultp = PackedHighp()
    @Assert(ph is Qualifier)
    @Assert(pm is Qualifier)
    @Assert(pl is Qualifier)
    @Assert(dp is Qualifier)
}
@Test
public func test_aligned_qualifier_same_package_access() {
    // Aligned 系列为 internal，同包可访问
    let ah = AlignedHighp()
    let am = AlignedMediump()
    let al = AlignedLowp()
    @Assert(ah is Qualifier)
    @Assert(am is Qualifier)
    @Assert(al is Qualifier)
}
```

**test_shim_assert.cj** — 验证 `assert(false)` 抛出异常：
```cangjie
// tests/glm/detail/test_shim_assert.cj
package glm.detail
import std.unittest.*

@Test
public func test_assert_passes() {
    assert(true)  // 不应抛出异常
}
@Test
public func test_assert_fails() {
    try {
        assert(false)
        @Assert(false)  // 不应执行到此处
    } catch (e: Exception) {
        @Assert(true)
    }
}
```

**test_shim_limits.cj** — 验证 `NumericLimits` 对 `Float32`/`Float64` 的 epsilon 值正确性：
```cangjie
// tests/glm/detail/test_shim_limits.cj
package glm.detail
import std.unittest.*

@Test
public func test_numeric_limits_epsilon_f32() {
    let eps = NumericLimits<Float32>.epsilon()
    @Assert(eps > Float32(0))
}
@Test
public func test_numeric_limits_epsilon_f64() {
    let eps = NumericLimits<Float64>.epsilon()
    @Assert(eps > Float64(0))
}
@Test
public func test_is_iec559_of() {
    @Assert(isIec559Of<Float32>())
    @Assert(isIec559Of<Float64>())
    @Assert(!isIec559Of<Int32>())
    @Assert(!isIec559Of<Bool>())
}
@Test
public func test_epsilon_of_f32() {
    let eps = epsilonOf<Float32>()
    @Assert(eps > Float32(0))
}
@Test
public func test_epsilon_of_f64() {
    let eps = epsilonOf<Float64>()
    @Assert(eps > Float64(0))
}
```

**测试目录结构更新**：
```
tests/glm/detail/
├── test_setup.cj
├── test_qualifier.cj
├── test_shim_assert.cj
└── test_shim_limits.cj
```

### 验证标准
1. 所有文件编写完成后，在项目根目录执行 `cjpm build` 编译通过
2. 目录结构符合设计要求
3. 执行 `cjpm test` 确认测试发现并运行通过

---

## 修订说明（v1 r2）
| 审查意见 | 修改措施 |
|---------|---------|
| **[严重]** 空占位文件缺少 package 声明将导致编译失败 | 将所有"空占位"说明替换为"最小内容"规格：`lib.cj`/`fwd.cj` 至少包含 `package glm`；`test_lib.cj`/`test_fwd.cj` 至少包含 `package glm`+`import glm.*`。更新文件路径清单表，为每个文件标注最小内容说明列 |
| **[一般]** 基础设施层缺少单元测试 | 新增 §7 基础设施层单元测试，包含 `test_setup.cj`（版本常量验证）、`test_qualifier.cj`（Qualifier 接口实现 + Aligned 同包访问验证）、`test_shim_assert.cj`（assert(true) 通过 + assert(false) 抛出异常）、`test_shim_limits.cj`（NumericLimits epsilon + isIec559Of + epsilonOf 验证）。更新测试目录结构。验证标准增加 `cjpm test` 通过条件 |
| **[一般]** plan.md 未枚举完整轮次规划 | 在 `plan.md` 末尾补充 R2~R4 的任务框架定义（核心抽象层、向量类型层、公共 API 与别名层），明确各轮次交付物边界和依赖关系 |
| **[一般]** 未验证 `NumericLimits<T>.max()`/`.min()` 在泛型约束下的可编译性 | 调研确认 `Number<T>` 接口（`std.math`）仅声明算术运算符，**不包含** `Max`/`Min`。在 §5 shim_limits.cj 中增加注意说明：`max()`/`min()` 依赖编译器对具体类型静态属性的泛型解析能力；若编译失败可移除这两个方法（phase0 无消费方）。`epsilonOf<T>()` 的 `where T <: Number<T>` 约束在编译期 `if` 分支抑制有效的假设下安全，保留不变 |
