# 详细设计（v5）

## 概述
实现公共 API 面与别名层（R4）：`src/lib.cj` 通过 `public import` 将 `glm.detail` 核心类型重导出到 `glm` 包；`src/fwd.cj` 定义 44 个标量别名 + 256 个向量别名；`scripts/gen_fwd_aliases.py` 自动生成 `fwd.cj`；`tests/glm/test_lib.cj` 和 `tests/glm/test_fwd.cj` 验证导入和别名的可用性。更新 `cjpm.toml` 增加 `[test]` 配置以支持独立测试目录。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/lib.cj` | 覆写 | 通过 `public import` 将 `glm.detail` 核心类型/函数重导出到 `glm` 包 |
| `src/fwd.cj` | 覆写 | 44 个标量别名 + 256 个向量别名（自动生成产物） |
| `scripts/gen_fwd_aliases.py` | 新建 | Python 脚本，全量生成 `src/fwd.cj` |
| `tests/glm/test_lib.cj` | 覆写 | 验证 `public import` 导出的类型/函数可正常访问 |
| `tests/glm/test_fwd.cj` | 覆写 | 验证标量和向量别名可正常实例化 |
| `cjpm.toml` | 修改 | 增加 `[test] src-dir = "tests"` 配置 |

## 类型定义

### lib.cj — 公共 API 重导出
**形态**：包级文件
**包路径**：`glm`
**职责**：将 `glm.detail` 核心类型通过 `public import` 暴露给下游

```cangjie
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
```

**公开接口**：共 13 个导出符号：Vec1/2/3/4, Qualifier, PackedHighp/Mediump/Lowp, Defaultp, add/sub/mul/div/mod, fromBoolVec/fromBoolVecQ2
**构造方式**：无需构造，纯声明文件
**类型关系**：`lib.cj` 属于 `glm` 包，通过 `public import` 引用 `glm.detail` 包

### fwd.cj — 类型别名（自动生成）
**形态**：包级文件（自动生成）
**包路径**：`glm`
**职责**：提供 GLM 兼容的标量和向量类型别名

**标量别名（44 个）**：
- 11 个基础名 × 4 精度变体 = 44 个
- 基础名：int8, int16, int32, int64, uint8, uint16, uint32, uint64, float, double, uint
- 精度前缀：`""` (PackedHighp), `highp_` (PackedHighp), `mediump_` (PackedMediump), `lowp_` (PackedLowp)
- 示例：`public type int8 = Int8`, `public type highp_float = Float32`

**向量别名（256 个）**：
- 16 个家族 × 4 分量数 × 4 精度变体 = 256 个
- 家族映射：B→Bool, I→Int32, U→UInt32, Vec→Float32, DVec→Float64, I8→Int8, I16→Int16, I32→Int32, I64→Int64, U8→UInt8, U16→UInt16, U32→UInt32, U64→UInt64, FVec→Float32, F32→Float32, F64→Float64
- 命名约定：`[Precision]FamilyName[Suffix][Dimension]`，Suffix 为空当家族名以 `Vec` 结尾，否则为 `Vec`
- 示例：`public type BVec2 = Vec2<Bool, PackedHighp>`, `public type LowpDVec4 = Vec4<Float64, PackedLowp>`, `public type Vec3 = Vec3<Float32, PackedHighp>`

**公开接口**：300 个 `public type` 别名
**构造方式**：类型别名，无需构造

### gen_fwd_aliases.py — 生成脚本
**形态**：独立 Python 脚本
**职责**：生成 `src/fwd.cj`

**核心逻辑**：
```python
SCALAR_MAP = {
    'int8': 'Int8', 'int16': 'Int16', 'int32': 'Int32', 'int64': 'Int64',
    'uint8': 'UInt8', 'uint16': 'UInt16', 'uint32': 'UInt32', 'uint64': 'UInt64',
    'float': 'Float32', 'double': 'Float64',
    'uint': 'UInt32',
}
SCALAR_PRECISIONS = [('', ''), ('highp_', ''), ('mediump_', ''), ('lowp_', '')]

VEC_FAMILIES = {
    'B': 'Bool', 'I': 'Int32', 'U': 'UInt32', 'Vec': 'Float32',
    'DVec': 'Float64', 'I8': 'Int8', 'I16': 'Int16', 'I32': 'Int32',
    'I64': 'Int64', 'U8': 'UInt8', 'U16': 'UInt16', 'U32': 'UInt32',
    'U64': 'UInt64', 'FVec': 'Float32', 'F32': 'Float32', 'F64': 'Float64',
}
VEC_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                  ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
DIMS = [1, 2, 3, 4]
VEC_TYPES = {1: 'Vec1', 2: 'Vec2', 3: 'Vec3', 4: 'Vec4'}

# 输出到 src/fwd.cj（项目实际路径）
OUTPUT = 'src/fwd.cj'
```

**脚本关键差异**：输出路径为 `src/fwd.cj`（而非设计文档模板中的 `src/glm/fwd.cj`），因为当前项目的 `cjpm.toml` 中 `src-dir = "src"`。

### tests/glm/test_lib.cj
**形态**：测试文件
**包路径**：`glm`
**职责**：验证 `public import` 可正常访问被导出类型和函数

**测试用例**：
1. 验证 `Vec2<Float32, PackedHighp>` 可通过 `glm.*` 导入后构造
2. 验证 `add(s, v)` 包级函数可通过 `glm.*` 导入后调用
3. 验证 `fromBoolVec` 可通过 `glm.*` 导入后调用
4. 验证 `Qualifier` 和 `Defaultp` 类型可正常引用

### tests/glm/test_fwd.cj
**形态**：测试文件
**包路径**：`glm`
**职责**：验证别名可正常实例化

**测试用例**：
1. BVec2 实例化：`let b: BVec2 = BVec2(Bool(true), Bool(true))`
2. Vec4 实例化：`let v: Vec4 = Vec4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))`
3. LowpIVec3 实例化：`let lv: LowpIVec3 = LowpIVec3(Int32(1), Int32(2), Int32(3))`
4. 标量别名验证：`public type` 可正常访问

## 错误处理
无运行时错误处理。编译期错误由仓颉编译器捕获：类型别名定义错误在编译时报告；`public import` 路径错误导致编译失败。

## 行为契约
- `lib.cj` 的 `public import` 必须精确匹配 `glm.detail` 中的公开符号名
- `fwd.cj` 的别名必须与 GLM C++ 头文件 `fwd.hpp` 中的命名约定一致
- `gen_fwd_aliases.py` 生成的 `fwd.cj` 必须在 `src/` 目录下（与 `src-dir = "src"` 一致）
- 脚本运行时覆盖 `src/fwd.cj`，需确保目录结构存在
- 测试文件 `tests/glm/test_lib.cj` 和 `tests/glm/test_fwd.cj` 声明 `package glm`，通过 `import glm.*` 可直接访问 lib.cj 和 fwd.cj 中定义的 public 符号
- `cjpm.toml` 的 `[test] src-dir = "tests"` 配置使得 `cjpm test` 可自动发现 `tests/` 下的 `@Test` 标注

## 依赖关系
| 文件 | 依赖 | 说明 |
|------|------|------|
| `src/lib.cj` | `glm.detail`（Vec1~Vec4, Qualifier 系列, scalar_vec_ops 函数, fromBoolVec 函数） | 通过 `public import` 引用 |
| `src/fwd.cj` | `glm.detail.{ Vec1~Vec4, PackedHighp, PackedMediump, PackedLowp }` | 别名定义依赖 Vec 和 Qualifier 类型 |
| `tests/glm/test_lib.cj` | `glm` 包（lib.cj 的导出） | 验证 public import |
| `tests/glm/test_fwd.cj` | `glm` 包（fwd.cj 的别名） | 验证别名可用性 |
| `gen_fwd_aliases.py` | Python 3 | 独立脚本，无仓颉依赖 |
