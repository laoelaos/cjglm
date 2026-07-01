# 设计审查报告（v10 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `lessThan` 函数在 `glm.detail` 中不存在，设计依赖列表中将其列为 noise.cj 的必需依赖（用于 Vec 类型的分量比较），但该函数仅在 `glm.gtc.quaternion.cj` 中为 `Quat` 类型实现。Vec1~Vec4 类型在 `glm.detail` 和 `glm.ext` 中均未定义 `lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual` 等分量比较函数。Simplex 噪声算法（GLM 参考实现）使用 `lessThan` 生成 bvec 掩码，缺失此函数会导致实现无法按设计编译。

- **[严重]** `getEngine()` 函数体内出现 `import` 语句（`import std.time.{DateTime}` 和 `import std.env`），违反仓颉语言规范：所有 `import` 必须在 `package` 之后、其他声明之前。这些导入必须移至文件顶部的包级作用域。

- **[一般]** 标量输入函数（`perlin1D`、`simplex1D`、`linearRand` 标量重载、`gaussRand`）声明了无法推导的类型参数 `Q <: Qualifier`。由于参数类型 `T` 是标量（非 `VecN`），`Q` 无法从调用处推导，调用方必须在每次调用时显式指定两个类型参数（如 `perlin1D<Float64, Defaultp>(0.5)`），存在严重可用性问题。现有 `gtc/round.cj` 和 `gtc/ulp.cj` 中标量函数均不使用 `Q`，应保持一致。

- **[轻微]** lib.cj 修改依赖行号引用（"修改第 23 行"），若前面批次修改过文件则行号可能失效。内容化的 before/after 已提供可缓解此问题，但行号参考存在脆弱性。

## 修改要求

1. **[严重] `lessThan` 不存在**：设计必须明确 noise.cj 如何处理 Vec 类型的分量比较——要么在 `glm.detail` 或 noise.cj 中实现 `lessThan` 函数族（`lessThan`、`greaterThan`、`lessThanEqual`、`greaterThanEqual`，返回 `VecN<Bool, Q>`），要么在设计中明确使用逐分量标量比较 + 手动构造 `Vec<Bool, Q>` 的替代方案。建议采用前一种方案，因后述方案会导致噪声算法代码膨胀且偏离 GLM 参考实现。

2. **[严重] 函数体内 `import`**：将 `std.time.{DateTime}` 和 `std.env` 的 `import` 移至 `random.cj` 文件顶部，放在 `package` 声明之后、其他声明之前。

3. **[一般] 标量函数多余 `Q`**：对标量输入函数移除 `Q` 类型参数：`perlin1D`（含 period 重载）、`simplex1D`、`linearRand` 标量重载、`gaussRand`。这些函数的 `Q` 无法推导且无实际用途，应与 `gtc/round.cj` 中标量函数的模式保持一致。
