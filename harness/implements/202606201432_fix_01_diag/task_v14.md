# 任务指令（v14）

## 动作
NEW

## 任务描述
修改 `src/fwd.cj`，追加两处文档/风格改进（对应 01_diag.md #25/#26）：

### #25 — 文件头部注释
在第 1 行 `package glm` 前插入 2 行注释：
```
// fwd.cj — GLM 兼容类型别名（自动生成）
// 注意：此文件由脚本自动生成，手动修改请谨慎
```

### #26 — 家族分组注释
在以下 16 个家族第一个别名定义前各插入一行 `// === {FamilyName} family ===` 注释：

| 行号 | 前一行为 | 插入位置（前一个家族最后一行→新家族第一行之间） | 注释内容 |
|------|---------|----------------------------------------------|---------|
| 51 | `public type lowp_uint = UInt32`（第 49 行）后空行（第 50 行） | 第 51 行 `public type BVec1` 前 | `// === B family ===` |
| 67 | B 家族最后一行 `LowpBVec4`（第 66 行） | 第 67 行 `public type IVec1` 前 | `// === I family ===` |
| 83 | I 家族最后一行 `LowpIVec4`（第 82 行） | 第 83 行 `public type UVec1` 前 | `// === U family ===` |
| 99 | U 家族最后一行 `LowpUVec4`（第 98 行） | 第 99 行 `public type Vec1` 前 | `// === Vec family ===` |
| 115 | Vec 家族最后一行 `LowpVec4`（第 114 行） | 第 115 行 `public type DVec1` 前 | `// === DVec family ===` |
| 131 | DVec 家族最后一行 `LowpDVec4`（第 130 行） | 第 131 行 `public type I8Vec1` 前 | `// === I8 family ===` |
| 147 | I8 家族最后一行 `LowpI8Vec4`（第 146 行） | 第 147 行 `public type I16Vec1` 前 | `// === I16 family ===` |
| 163 | I16 家族最后一行 `LowpI16Vec4`（第 162 行） | 第 163 行 `public type I32Vec1` 前 | `// === I32 family ===` |
| 179 | I32 家族最后一行 `LowpI32Vec4`（第 178 行） | 第 179 行 `public type I64Vec1` 前 | `// === I64 family ===` |
| 195 | I64 家族最后一行 `LowpI64Vec4`（第 194 行） | 第 195 行 `public type U8Vec1` 前 | `// === U8 family ===` |
| 211 | U8 家族最后一行 `LowpU8Vec4`（第 210 行） | 第 211 行 `public type U16Vec1` 前 | `// === U16 family ===` |
| 227 | U16 家族最后一行 `LowpU16Vec4`（第 226 行） | 第 227 行 `public type U32Vec1` 前 | `// === U32 family ===` |
| 243 | U32 家族最后一行 `LowpU32Vec4`（第 242 行） | 第 243 行 `public type U64Vec1` 前 | `// === U64 family ===` |
| 259 | U64 家族最后一行 `LowpU64Vec4`（第 258 行） | 第 259 行 `public type FVec1` 前 | `// === FVec family ===` |
| 275 | FVec 家族最后一行 `LowpFVec4`（第 274 行） | 第 275 行 `public type F32Vec1` 前 | `// === F32 family ===` |
| 291 | F32 家族最后一行 `LowpF32Vec4`（第 290 行） | 第 291 行 `public type F64Vec1` 前 | `// === F64 family ===` |

## 选择理由
#25/#26 是剩余最小工作量任务，约 18 行纯注释修改，不涉及代码逻辑变更，无编译或运行时影响。完成此任务后 #8（scalar_vec_ops 测试覆盖改进）将是唯一剩余可实施任务。低优先级文档/风格改进的快速完成符合用户"所有任务必须完成"的要求。

## 任务上下文
OOD §3.8 明确要求：
- 头部注释：`// fwd.cj — GLM 兼容类型别名（自动生成）` + 自动生成警示
- 分组注释：以 `// === {FamilyName} family ===` 注释头分隔不同家族

## 已有代码上下文
`src/fwd.cj`（306 行，自动生成）当前结构：
- 第 1-4 行：`package glm` + `import` 语句
- 第 6-49 行：基本类型别名（int8~lowp_uint）— 无家族标记
- 第 51-66 行：B 家族（Bool Vec 别名，BVec1~LowpBVec4，16 行）
- 第 67-82 行：I 家族（Int32 Vec 别名，IVec1~LowpIVec4）
- 第 83-98 行：U 家族（UInt32 Vec 别名，UVec1~LowpUVec4）
- 第 99-114 行：Vec 家族（Float32 Vec 别名，Vec1~LowpVec4）
- 第 115-130 行：DVec 家族（Float64 Vec 别名，DVec1~LowpDVec4）
- 第 131-146 行：I8 家族（Int8 Vec 别名，I8Vec1~LowpI8Vec4）
- 第 147-162 行：I16 家族（Int16 Vec 别名，I16Vec1~LowpI16Vec4）
- 第 163-178 行：I32 家族（Int32 Vec 别名，I32Vec1~LowpI32Vec4）
- 第 179-194 行：I64 家族（Int64 Vec 别名，I64Vec1~LowpI64Vec4）
- 第 195-210 行：U8 家族（UInt8 Vec 别名，U8Vec1~LowpU8Vec4）
- 第 211-226 行：U16 家族（UInt16 Vec 别名，U16Vec1~LowpU16Vec4）
- 第 227-242 行：U32 家族（UInt32 Vec 别名，U32Vec1~LowpU32Vec4）
- 第 243-258 行：U64 家族（UInt64 Vec 别名，U64Vec1~LowpU64Vec4）
- 第 259-274 行：FVec 家族（Float32 Vec 别名，FVec1~LowpFVec4）
- 第 275-290 行：F32 家族（Float32 Vec 别名，F32Vec1~LowpF32Vec4）
- 第 291-306 行：F64 家族（Float64 Vec 别名，F64Vec1~LowpF64Vec4）

每家族 4 个具体类型（裸类型 + Highp + Mediump + Lowp）× 4 个 Vec 维度 = 16 行/家族，共 16 家族 × 16 行 = 256 个类型别名。

## 验证标准
- `cjpm build` 编译通过（注释不影响编译）
- `cjpm test` 384/384 全部 PASSED（无回归）
- 文件开头可见正确的头部注释
- 各家族第一个别名前可见正确的分组注释
