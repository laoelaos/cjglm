# 代码审查报告（v10 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `src/gtc/noise.cj:103,171,227,313` — Vec2/Vec3/Vec4 无参构造函数调用无法编译
  - 使用了 `Vec2()`(line:171)、`Vec3()`(line:103,227)、`Vec4()`(line:313)，但 Vec 结构体（type_vec2/3/4.cj）均未定义无参 `init()`。
  - 仓颉结构体规则：自动生成的无参构造函数仅在「无自定义构造函数且所有实例成员变量有初始值」时生成（struct/README.md:47-48）。Vec 类型有自定义构造函数且成员无初始值，故不生成无参 init。
  - 整个代码库中无其他 `Vec2()/Vec3()/Vec4()` 无参调用。
  - 修正：替换为 `VecN(zero)`，其中 `zero = (Float64(0.0) as T).getOrThrow()`。例如：`perlin2Imp(v, Vec2(zero), false)`。

- **[一般]** `tests/glm/gtc/noise_test.cj` — 缺少对 `glm.detail` 类型的导入
  - 使用 `Vec2`/`Vec3`/`Vec4`/`PackedHighp`（lines:13,20,27,40,47,54,69,79,89）但未导入。
  - 现有所有 `tests/glm/gtc/` 中用到 Vec 类型的测试文件均显式导入 `glm.detail.{Vec2,Vec3,Vec4,...}`。
  - 修正：添加 `import glm.detail.{Vec2, Vec3, Vec4, PackedHighp}`。

- **[一般]** `tests/glm/gtc/random_test.cj` — 缺少对 `glm.detail` 类型的导入
  - 使用 `Vec2`/`Vec3`/`Vec4`/`PackedHighp`（lines:20,29,39）但未导入。
  - 修正：添加 `import glm.detail.{Vec2, Vec3, Vec4, PackedHighp}`。

- **[一般]** `tests/glm/gtc/random_test.cj:67` — 在函数体内使用 `import`
  - `private func mathSqrt(x: Float64): Float64 { import std.math as m; m.sqrt(x) }` 中，`import` 出现在函数体内部。
  - 仓颉规则：import 须在 `package` 之后、其他声明之前（package/README.md:95-96）。
  - 修正：将 `import std.math as m` 移动到文件顶部（`package glm.gtc` 之后），并使用 `m.sqrt(x)` 或直接导入 `import std.math.sqrt`。

## 修改要求（仅 REJECTED 时）

1. **`src/gtc/noise.cj:103`** — line 103 `step(Vec3(px, py, pz), Vec3())` 改为 `step(Vec3(px, py, pz), Vec3(zero))`。grad4 函数体内已有 `one`/`two`/`f7` 等常量，需补充 `zero` 定义。

2. **`src/gtc/noise.cj:171`** — `perlin2D` 函数中 `perlin2Imp(v, Vec2(), false)` 改为 `perlin2Imp(v, Vec2((Float64(0.0) as T).getOrThrow()), false)`。

3. **`src/gtc/noise.cj:227`** — `perlin3D` 函数中 `perlin3Imp(v, Vec3(), false)` 改为 `perlin3Imp(v, Vec3((Float64(0.0) as T).getOrThrow()), false)`。

4. **`src/gtc/noise.cj:313`** — `perlin4D` 函数中 `perlin4Imp(v, Vec4(), false)` 改为 `perlin4Imp(v, Vec4((Float64(0.0) as T).getOrThrow()), false)`。

5. **`tests/glm/gtc/noise_test.cj`** — 在 `package glm.gtc` 之后添加 `import glm.detail.{Vec2, Vec3, Vec4, PackedHighp}`。

6. **`tests/glm/gtc/random_test.cj`** — 在 `package glm.gtc` 之后添加 `import glm.detail.{Vec2, Vec3, Vec4, PackedHighp}`，并将 `mathSqrt` 函数体中的 `import std.math as m` 移到文件顶部。
