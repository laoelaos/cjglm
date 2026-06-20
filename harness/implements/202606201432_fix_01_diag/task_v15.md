# 任务指令（v15）

## 动作
NEW

## 任务描述
在 `src/detail/scalar_vec_ops_test.cj` 追加测试覆盖，补齐 `scalar_vec_ops.cj` 已有函数的测试缺口。纯测试追加，不修改源文件。

具体缺口如下：

### 1. add/sub/mul/div 浮点类型
源函数签名：`public func add/sub/mul/div<T, Q>(s: T, v: VecN<T, Q>): VecN<T, Q> where T <: Number<T>, Q <: Qualifier`
- 当前测试：仅 Int64 类型
- 需要追加：Float32 × Vec1/2/3/4，每个 op 4 个测试函数，4 ops × 4 = 16 个

### 2. add/sub/mul/div 额外整数类型
- 当前测试：仅 Int64 类型
- 需要追加：Int32 × Vec1/2/3/4，每个 op 4 个，4 ops × 4 = 16 个

### 3. mod 额外整数类型
源函数签名：`public func mod<T, Q>(s: T, v: VecN<T, Q>): VecN<T, Q> where T <: Integer<T>, Q <: Qualifier`
- 当前测试：仅 Int64（已有）+ Float32/64/16（已有）
- 需要追加：Int32 × Vec1/2/3/4 = 4 个

### 4. 跨 Qualifier 测试补齐（Vec1/Vec3/Vec4）
当前 Vec2 已覆盖 sub/mul/div/mod × PackedMediump/PackedLowp（8 个测试，来自 R13）
- 需要追加 Vec1/Vec3/Vec4：sub/mul/div/mod × PackedMediump × 3 Vec + PackedLowp × 3 Vec = 4 ops × 6 = 24 个
- 每个 Vec 类型均覆盖 PackedMediump 和 PackedLowp 两种 qualifier，与 Vec2 已有模式一致

### 5. 边界/特殊值
- 零值 div（验证除零不 panic 的合理性，例如 `div(0, Vec1(1))`）
- 负值 scaler 作用于正分量（如 `add(-5, Vec1(3))`）
- 大数值跨类型一致性（如 `Vec1(Int64(9223372036854775807))` 溢出合理性验证）
- 每个 Vec 类型选 1-2 个典型边界场景，共约 4-6 个测试函数

## 选择理由
R14 完成后，#8 是唯一剩余可实施的项。当前 scalar_vec_ops.cj 提供 32 个函数，但测试仅覆盖：
- add/sub/mul/div：仅 Int64 × Vec1~4（16 个测试）
- mod integer：仅 Int64 × Vec1~4（4 个测试）
- mod float：Float32/64/16 × Vec1~4（12 个测试）
- 跨 Qualifier：仅 Vec2 × sub/mul/div/mod（8 个测试）

浮点 add/sub/mul/div 完全无测试，Int32 变体完全无测试，Vec1/Vec3/Vec4 跨 Qualifier 完全无测试。这些是 OOD §3.2 要求的包级函数的测试覆盖短板。

## 任务上下文
- **源文件**：`src/detail/scalar_vec_ops.cj`（151 行，32 个函数）
- **测试文件**：`src/detail/scalar_vec_ops_test.cj`（当前 340 行，40 个函数）
- **已有测试模式**：所有函数为包级 `@Test func testXxx(): Unit`，使用 `@Expect` 断言
- **命名约定**：`testScalar{Op}{VecN}[{Type}]`，例如 `testScalarAddVec1Float32`、`testScalarSubVec2PackedMediump`
- **数值验证**：每个测试初始化具体 VecN 值，调用标量操作，逐分量 `@Expect` 验证结果
- **Qualifier 类型**：`PackedHighp`、`PackedMediump`、`PackedLowp`、`Defaultp`
- **运行命令**：`cd cjglm && cjpm test`

## 工作量估算
约 50-80 个新测试函数，根据具体覆盖粒度确定。

## 修订说明（v15 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 1. [一般] 跨 Qualifier 测试数量自相矛盾（第27行24个 vs 第28行12个） | 删除第28行矛盾说明，明确采用 24 个测试方案（4 ops × 3 Vec × 2 qualifiers），与 Vec2 已有模式一致 |
| 2. [轻微] Float 类型选择未明确（`Float32（或 Float64）`） | 统一指定 `Float32`，与代码库中已有浮点测试的主要类型一致 |
| 3. [轻微] 边界测试未在计划中体现 | 将边界/特殊值从"可选"改为非可选部分，明确测试场景和数量（约4-6个函数） |
