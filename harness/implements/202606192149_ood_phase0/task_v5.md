# 任务指令（v5）

## 动作
NEW

## 任务描述
实现公共 API 面与别名层（04-公共 API 与别名层），包含：

1. **`src/lib.cj`** — 公共 API 重导出文件（`package glm`），通过 `public import` 将 `glm.detail` 核心类型暴露给下游
2. **`src/fwd.cj`** — 标量别名 44 个 + 向量别名 256 个（`package glm`），全量覆盖 16 家族 × 4 分量数 × 4 精度变体
3. **`scripts/gen_fwd_aliases.py`** — 别名自动生成脚本
4. **`tests/glm/test_lib.cj`** — lib.cj 的测试（验证 public import 正确工作）
5. **`tests/glm/test_fwd.cj`** — fwd.cj 的测试（验证别名可正常实例化）
6. **`src/lib_test.cj`** 和 **`src/fwd_test.cj`** — 可选保留或整合到 tests/ 下

依赖：R1~R3 全部 Vec 类型、Qualifier、scalar_vec_ops 均已实现

## 选择理由
R4 是 OOD Phase0 的最后一层——公共 API 面通过 `public import` 暴露核心类型给下游消费者，256 个别名是首轮强制交付标准。不依赖任何其他未完成任务，R1~R3 的实现文件已就绪。

## 任务上下文

### lib.cj 导出清单
来自设计文档 §2 公共 API 面设计：
```cangjie
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
```

注意：
- `add`/`sub`/`mul`/`div`/`mod` 来自 `scalar_vec_ops.cj`（声明 `package glm.detail`），路径使用包名而非文件名
- `fromBoolVec`/`fromBoolVecQ2` 来自 `type_fromBoolVec.cj`（声明 `package glm.detail`）
- `shim_*` 文件、`vectorize.cj`、`compute_vector_decl.cj`、`scalar_vec_ops.cj`、`type_fromBoolVec.cj` 为内部实现，不对下游导出
- 后续轮次扩展只需在 `lib.cj` 追加对应 `public import` 行

### fwd.cj 结构
代码生成脚本位置：`scripts/gen_fwd_aliases.py`
输出路径：`src/fwd.cj`

标量别名（44 个）：
- 10 个原生类型（Int8~Int64, UInt8~UInt64, Float32, Float64）+ `uint` = 11 个基础名
- 每个基础名有 4 个精度变体（无前缀、`highp_`、`mediump_`、`lowp_`）
- 基础名 `uint` 只有 1 个无精度版本
- 共 `10*4 + 1*4 + 1（uint无精度）` = 44 个

向量别名（256 个）：
- 16 个家族：B/Bool, I/Int32, U/UInt32, Vec/Float32, DVec/Float64, I8/Int8, I16/Int16, I32/Int32, I64/Int64, U8/UInt8, U16/UInt16, U32/UInt32, U64/UInt64, FVec/Float32, F32/Float32, F64/Float64
- 4 个分量数（Vec1~Vec4）：映射关系 Vec1/Vec2/Vec3/Vec4
- 4 个精度变体（无前缀→PackedHighp, Highp→PackedHighp, Mediump→PackedMediump, Lowp→PackedLowp）
- 命名约定：`[Precision]FamilyName[Dimension]`，PascalCase 风格
- 家族名映射规则：单字母大写（b→B, i→I, u→U），定长家族（vec→Vec, dvec→DVec, fvec→FVec），数字前缀（i8→I8 等）
- 注意 `Vec`/`DVec`/`FVec` 三家族的命名：末尾已带 `Vec`，别名不应重复（如 `Vec2` 而非 `VecVec2`）
- `public type` 确保对外可见

### gen_fwd_aliases.py 脚本
设计文档 §3.8 提供完整 Python 脚本模板，约 40 行。实施者可直接基于此模板定制。

输出文件结构：
```
// fwd.cj — GLM 兼容类型别名（自动生成）

package glm
import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }

// === Scalar aliases ===
public type int8 = Int8
public type highp_int8 = Int8
...

// === B family ===
public type BVec1 = Vec1<Bool, PackedHighp>
public type HighpBVec1 = Vec1<Bool, PackedHighp>
...
```

### 测试文件
- `tests/glm/test_lib.cj`（`package glm`）：
  - 验证 `lib.cj` 中的 public import 可正常访问被导出类型
  - 测试 `let v: Vec2<Float32, PackedHighp> = ...` 编译通过
  - 测试 `add`/`sub`/`mul`/`div`/`mod` 包级函数可通过 `glm.*` 导入访问
  
- `tests/glm/test_fwd.cj`（`package glm`）：
  - 验证别名可正常实例化，抽查 4 个家族（B/I/U/Vec）各 1 个精度变体
  - 验证 `let b: BVec2 = BVec2(Bool(true), Bool(true))` 编译通过
  - 验证 `let v: Vec4 = Vec4(...)` 编译通过
  - 验证 `let lv: LowpIVec3 = ...` 编译通过

## 已有代码上下文

### 现有文件
- `src/lib.cj`：仅包含 `package glm`，需覆写
- `src/fwd.cj`：仅包含 `package glm`，需覆写
- `src/lib_test.cj`：存在占位测试（`@Expect(true, true)`）
- `src/fwd_test.cj`：存在占位测试（`@Expect(true, true)`）
- `tests/glm/test_lib.cj`：存在占位测试
- `tests/glm/test_fwd.cj`：存在占位测试

### 核心依赖（已就绪）
- `src/detail/type_vec1.cj` ~ `src/detail/type_vec4.cj` — Vec1~Vec4 泛型结构体
- `src/detail/qualifier.cj` — Qualifier 接口及 PackedHighp/PackedMediump/PackedLowp/AlignedHighp 等实现
- `src/detail/scalar_vec_ops.cj` — add/sub/mul/div/mod 包级独立函数
- `src/detail/type_fromBoolVec.cj` — fromBoolVec/fromBoolVecQ2 工厂函数
- `src/detail/setup.cj`、`src/detail/shim_*.cj` — 已就绪

### 包结构
- `glm.detail` 包：所有 detail 文件声明 `package glm.detail`
- `glm` 包：lib.cj 和 fwd.cj 声明 `package glm`
- 核心类型（Vec1~Vec4、Qualifier 实现）定义在 `glm.detail`，通过 `public import` 暴露到 `glm`
- `fwd.cj` 中的 `public type` 别名自动属于 `package glm`，下游 `import glm.*` 即可访问

### 已知约束
- R3 的 type_vec1~4.cj 存在预存编译错误（`%`/`<<`/`>>` 运算符在无约束泛型 T 上的使用），但不影响 R4 的 fwd.cj 和 lib.cj 实现
- 生成脚本需独立运行（`python scripts/gen_fwd_aliases.py`），生成 `src/fwd.cj`
- `src/lib_test.cj` 和 `tests/glm/test_lib.cj` 功能重叠，可二选一或同时保留
