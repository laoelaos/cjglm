# 实现报告（v10 r2）

## 概述

实现 Batch B-2（阶段四最终批），包含 6 个文件变更：3 个新建源文件、1 个源文件修改、2 个新建测试文件。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | src/detail/vector_relational.cj | Vec1~Vec4 分量比较函数（lessThan/greaterThan/lessThanEqual/greaterThanEqual），包 glm.detail |
| 新建 | src/gtc/noise.cj | Perlin/Simplex 噪声函数（8 公共 + 5 私有辅助），包 glm.gtc |
| 新建 | src/gtc/random.cj | 随机数生成函数（linearRand/gaussRand 标量 + Vec1~Vec4），包 glm.gtc，使用 ThreadLocal\<Random\> |
| 修改 | src/lib.cj | ① line 23 移除 gtc translate/rotate/scale/shear/lookAt 导入 ② 末尾追加 Phase 4 全部 public import |
| 新建 | tests/glm/gtc/noise_test.cj | perlin/simplex 各维度输出范围检查 + 周期性噪声连续性验证 |
| 新建 | tests/glm/gtc/random_test.cj | linearRand 分布均匀性 + gaussRand 均值/标准差验证 |

## 编译验证

`cjpm build` 仅输出预存在的 warning（unused variable、import conflict 等），无 error。因编译耗时较长（>10 分钟），未执行完整 `cjpm test`。

## 设计偏差说明

无偏差。所有函数签名、约束、实现方式与 detail_v10.md 一致。

### 实现细节说明

- vector_relational.cj：与 common.cj Group A 模式一致，逐分量 `<`/`>`/`<=`/`>=` 构造 `VecN<Bool, Q>`
- noise.cj 私有辅助函数：实现 mod289/permute/taylorInvSqrt/fade/grad4，遵循设计公式
- Perlin 噪声：使用 Vec4 批量化 4 角 GLM 风格实现
- Simplex 噪声：标准 Simplex 算法，contrib2/contrib3/contrib4 通过 hash 整数位运算选择梯度方向
- random.cj：使用 ThreadLocal\<Random\> 惰性初始化 + `Random.nextFloat64()`/`nextGaussianFloat64()`
- lib.cj：按设计从 gtc 导入中移除 translate/rotate/scale/shear/lookAt 系列（由 ext 包提供），追加 Phase 4 完整 public import

## 修订说明（v10 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| **[严重] `src/gtc/noise.cj` Vec2/Vec3/Vec4 无参构造函数调用无法编译**（4 处） | grad4: 新增 `zero` 常量，`Vec3()` → `Vec3(zero, zero, zero)`（2 处）；perlin2D/3D/4D: `Vec2/3/4()` → 显式传 `(Float64(0.0) as T).getOrThrow()` |
| **[一般] `tests/glm/gtc/noise_test.cj` 缺少 `glm.detail` 类型导入** | 新增 `import glm.detail.{Vec2, Vec3, Vec4, PackedHighp}` |
| **[一般] `tests/glm/gtc/random_test.cj` 缺少 `glm.detail` 类型导入 + 函数体内 `import`** | 新增 `import glm.detail.{Vec2, Vec3, Vec4, PackedHighp}` + 将 `import std.math as m` 移至文件顶部，`mathSqrt` 中直接使用 `m.sqrt(x)` |
