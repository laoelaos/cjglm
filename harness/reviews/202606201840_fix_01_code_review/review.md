# 审查进度

## R1: 修复质量验证 — 已完成

### R1A 基础设施层修复 — 轻微 1
- ✅ setup.cj: let→const 已修复
- ⚠️ shim_limits/compute_vector_relational: 未修复但已覆盖偏差(DV-04/INT-02), 按 scope 排除
- 新: callConst 内联 abs 替代 std.math.abs(轻微)

### R1B Vec1/Vec2+scalar_vec_ops+fromBoolVec — 一般 3
- ✅ mod 浮点路径已修复(新增 12 重载)
- ⚠️ increment/decrement 已添加但签名不符(mut Unit vs VecN)
- ❌ Vec1/Vec2 跨类型构造函数全部缺失
- 新: increment/decrement 签名偏差(一般)

### R1C Vec3/Vec4+公共API+测试 — 一般 8 / 轻微 3
- ✅ fwd.cj 注释, test_lib.cj 覆盖扩展, testPackedHighpCrossAssign 重命名
- ⚠️ Vec3/Vec4 increment/decrement 已添加但签名不符
- ❌ Vec3/Vec4 构造函数/componentAt/测试 import/test_fwd import 未修复
- 新: test_fwd.cj 硬编码路径(轻微)

## R2: 新增代码审查 — 已完成

### R2A type_cast.cj + test — 轻微 3
- 实现完整: 16 函数覆盖 4源×4目标全组合
- 新: 低维→高维填充与 GLM 语义差异待确认(轻微)
- 新: 缺 Bool/UInt 类型/跨 Q 组合测试(轻微)

### R2B compute_vector_decl.cj + vectorize.cj — 一般 1 / 轻微 2
- 生产代码与 OOD 设计完全一致
- 新: compute_vector_decl 测试维度覆盖不均衡(一般)
- 新: 类型/Q 覆盖单一(仅 Int64/Float32/Defaultp)(轻微)

### R2C 测试覆盖完整性 — 严重 1 / 一般 5 / 轻微 1
- ❌ tests/glm/detail/ 6 文件仍缺 unittest import(严重, 前序未修复)
- 新: float mod 缺 qualifier/负数边界(一般)
- 新: fromBoolVec 仅测 Int64(一般), Vec2/3/4 缺越界测试(一般)

## R3: 设计一致性审查 — 已完成

### R3A 基础设施+标量向量运算设计一致性 — 轻微 2
- 总体一致性良好: qualifier/shim_cstddef/lib.cj 完全一致
- 新: cjpm.toml version (1.0.3 vs 0.1.0)(轻微)
- 新: shim_assert 参数标签 message!: vs message?:(轻微)

### R3B Vec 类型体系设计一致性 — 严重 1 / 一般 1 / 轻微 1
- ❌ [严重] Vec1~Vec4 全部缺失 §4.1 跨类型构造函数体系(27个构造函数缺失)
- ⚠️ increment/decrement 签名不一致(一般)
- 新: static length() 缺 const(轻微)

### R3C 公共API+别名+项目配置 — 一般 5 / 轻微 1
- ✅ lib.cj 完全符合 OOD §2
- 新: uint 额外精度变体 vs OOD 表(一般)
- 新: gen_fwd_aliases.py 与输出同步风险(一般)
- 新: cjpm.toml version/cjc-version 验证记录缺失(一般)
- 新: type_cast.cj 在 OOD 设计框架中缺位(一般)

# 审查总结

## 问题汇总

| 轮次 | 严重 | 一般 | 轻微 | 总计 |
|------|------|------|------|------|
| R1A 基础设施层 | 0 | 0 | 1 | 1 |
| R1B Vec1/Vec2+ops | 0 | 3 | 0 | 3 |
| R1C Vec3/Vec4+API | 0 | 8 | 3 | 11 |
| R2A type_cast | 0 | 0 | 3 | 3 |
| R2B compute+vectorize | 0 | 1 | 2 | 3 |
| R2C 测试覆盖 | 1 | 5 | 1 | 7 |
| R3A 基础设施一致性 | 0 | 0 | 2 | 2 |
| R3B Vec体系一致性 | 1 | 1 | 1 | 3 |
| R3C 公共API+项目 | 0 | 5 | 1 | 6 |
| **合计** | **2** | **23** | **14** | **39** |

## 关键发现

1. **[严重] Vec1~Vec4 跨类型构造函数体系全部缺失** — OOD §4.1 规定的 49 个构造函数仅实现约 10 个基础版本，跨类型/多元组合/截断版本全部缺失。这影响类型转换链路完整性（R3C, 前序 R1B/R1C 已验证未修复）

2. **[严重] tests/glm/detail/ 下 6 文件仍缺 unittest import** — 前序审查 R3C 待办完全未修复，使用 `@Test`/`@Expect` 宏但未导入 `std.unittest`（R2C）

3. **[一般] increment/decrement 签名与设计不符** — 4 个 Vec 的 increment/decrement 使用 `mut func(): Unit`（原地修改）而非设计的 `func(): VecN<T,Q>`（返回新向量），调用契约不兼容（R1B/R1C）

4. **[一般] 构造函数体系缺口** — Vec1/Vec2 跨类型构造函数全部缺失、Vec1~Vec4 componentAt 缺 const、== 非 const（已知偏差 DV-05）

5. **[一般] 生成脚本与输出不同步** — gen_fwd_aliases.py 仍可能覆盖手动修复的 CL-11 修复（前序未修复）

6. **[一般] type_cast.cj 设计框架缺位** — 16 个 castVec 函数在 OOD 设计文档中无对应章节

## 待办建议

→ 详细见 `todo.md`

## 后续工作

建议在后续轮次中优先处理：
1. 补充 Vec 跨类型构造函数（影响面最大）
2. 修正 increment/decrement 签名
3. 补充 tests/glm/detail/ import
4. 同步 gen_fwd_aliases.py 与 fwd.cj
5. 将 type_cast.cj 纳入设计文档
