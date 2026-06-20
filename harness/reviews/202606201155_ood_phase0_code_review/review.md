# 审查进度

## R1: 基础设施层 + 计算基础设施层审查 — 已完成

### R1A 基础设施层 (setup/qualifier/shim) — 严重 0 / 一般 2 / 轻微 3
- 一般: setup.cj 使用 `let` 而非 `const`；shim_limits.cj 函数签名与设计不一致
- 轻微: 未使用的 import；Aligned 系列缺测试；shim_cstddef_test.cj 缺失

### R1B 计算基础设施层 (compute_vector_relational/decl/vectorize) — 严重 0 / 一般 1 / 轻微 4
- 一般: ComputeEqual.callConst 被拆分到独立结构体 ComputeEqualNumeric
- 轻微: callConst 缺 const；手动 abs；未委托 ComputeEqual；位移测试缺类型覆盖

### R1C 标量-向量运算层 (scalar_vec_ops) — 严重 0 / 一般 3 / 轻微 1
- 一般: 所有 20 个函数缺 const；mod 仅整数路径无浮点路径；测试覆盖窄(仅 Int64)
- 轻微: 缺 std.math.trunc 导入

## R2: Vec 类型体系审查 — 已完成

### R2A Vec1/Vec2 类型体系 (type_vec1/2) — 严重 0 / 一般 6 / 轻微 4
- 一般: Vec1/Vec2 缺跨类型转换构造函数；缺 increment/decrement；componentAt 缺 const；== 在 extend 块中丢失 const
- 轻微: == 使用 ComputeEqual.call 而非 callConst；equalEpsilon 委托未定义结构体；缺越界测试

### R2B Vec3/Vec4 类型体系 (type_vec3/4) — 严重 0 / 一般 6 / 轻微 2
- 一般: 缺跨类型转换和多元组合构造函数；缺 increment/decrement；componentAt 缺 const；== 用 call 精确比较
- 轻微: 浮点 == 未测试；componentAt 未测 const 上下文

### R2C fromBoolVec (type_fromBoolVec) — 严重 1 / 一般 1 / 轻微 1
- 严重: 函数签名多出 zero/one 参数，与设计 §4.8 不符
- 一般: 测试因签名偏差未验证核心 T(1)/T(0) 语义

## R3: 公共 API + 别名 + 项目配置审查 — 已完成

### R3A lib.cj 公共 API (lib.cj/test_lib.cj) — 严重 0 / 一般 3 / 轻微 2
- 一般: test_lib 仅测 Vec2 缺 Vec1/3/4；缺 sub/mul/div/mod 重导出测试；同包无法验证下游 `import glm.*`
- 轻微: fromBoolVecQ2 未测；PackedMediump/Lowp 未测

### R3B fwd.cj 别名 (fwd.cj/test_fwd.cj/gen_fwd_aliases.py) — 严重 0 / 一般 4 / 轻微 1
- 一般: 生成脚本未同步 CL-11 修复(重新运行将破坏)；缺头部注释和分组注释；test_fwd.cj 缺 import glm.detail
- 轻微: 脚本输出格式与设计模板顺序不一致

### R3C 集成测试 (tests/glm/detail/) — 严重 1 / 一般 3 / 轻微 2
- 严重: tests/glm/detail/ 下测试文件缺 std.unittest.testmacro 导入
- 一般: testPackedHighpCrossAssign 名不符实；缺整数 epsilon 降级测试；缺多 Qualifier 覆盖

## 审查总结

### 问题汇总

| 轮次 | 严重 | 一般 | 轻微 | 总计 |
|------|------|------|------|------|
| R1A 基础设施层 | 0 | 2 | 3 | 5 |
| R1B 计算基础设施层 | 0 | 1 | 4 | 5 |
| R1C 标量-向量运算 | 0 | 3 | 1 | 4 |
| R2A Vec1/Vec2 类型 | 0 | 6 | 4 | 10 |
| R2B Vec3/Vec4 类型 | 0 | 6 | 2 | 8 |
| R2C fromBoolVec | 1 | 1 | 1 | 3 |
| R3A lib.cj 公共 API | 0 | 3 | 2 | 5 |
| R3B fwd.cj 别名 | 0 | 4 | 1 | 5 |
| R3C 集成测试 | 1 | 3 | 2 | 6 |
| **合计** | **2** | **29** | **20** | **51** |

### 关键发现

1.  **[严重] fromBoolVec 函数签名偏离设计** (§4.8): 多出了 `zero: T, one: T` 参数，改变了 API 契约
2.  **[严重] tests/glm/detail/ 下测试文件缺 unittest 导入**: 可能导致编译失败
3.  **[一般] 构造函数体系不完整**: 所有 Vec 均缺失跨类型转换和多元组合构造函数
4.  **[一般] const 正确性**: setup.cj 用 let 而非 const；shim_limits/scalar_vec_ops/componentAt 缺 const
5.  **[一般] 生成脚本与输出不同步**: CL-11 修复后脚本未更新，重新运行将破坏修复
6.  **[一般] 测试覆盖偏窄**: 多文件仅测 Int64，缺浮点/边界/溢出测试

→ 详细待办见 `todo.md`
