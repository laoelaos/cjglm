# 测试报告（v1）

## 概述

根据详细设计（detail_v1.md）的行为契约编写独立单元测试，位于 `tests/glm/` 目录下，与编码 agent 的 `src/` 测试文件互不干扰。

## 文件清单

| 文件路径 | 测试对象 | 用例数 |
|---------|---------|--------|
| `tests/glm/test_lib.cj` | `package glm` 占位 | 1 |
| `tests/glm/test_fwd.cj` | `package glm` 占位 | 1 |
| `tests/glm/detail/test_setup.cj` | 版本/配置常量 | 7 |
| `tests/glm/detail/test_qualifier.cj` | Qualifier 接口与实现 | 5 |
| `tests/glm/detail/test_shim_assert.cj` | assert 断言函数 | 3 |
| `tests/glm/detail/test_shim_limits.cj` | NumericLimits / isIec559Of / epsilonOf | 8 |
| **合计** | | **25** |

## 行为契约覆盖

### setup.cj 常量——7 个测试
- GLM_VERSION_MAJOR = 1, GLM_VERSION_MINOR = 0, GLM_VERSION_PATCH = 3
- GLM_VERSION = 103, GLM_CONFIG_SIMD = false
- GLM_CONFIG_ALIGNED_GENTYPES = false, GLM_CONFIG_CLIP_CONTROL = false

### Qualifier 契约——5 个测试
- PackedHighp/PackedMediump/PackedLowp 均可赋值给 Qualifier 接口
- Defaultp 可赋值给 PackedHighp
- 跨精度空结构体构造验证

### assert 契约——3 个测试
- 正常路径：assert(true) 无异常
- 错误路径：assert(false) 抛出 Exception
- 自定义消息：assert(false, message: "...") 抛出消息匹配的 Exception

### NumericLimits\<T\> 契约——2 个测试
- Float32 epsilon = 1.1920929e-7
- Float64 epsilon = 2.220446049250313e-16

### isIec559Of\<T\> 契约——4 个测试
- Float32 → true, Float64 → true
- Int64 → false, Bool → false（验证非浮点类型不产生编译错误）

### epsilonOf\<T\> 契约——2 个测试
- Float32 委托正确
- Float64 委托正确

## 设计偏差适配

| 偏差项 | 测试适配 |
|--------|---------|
| assert 使用命名参数 `message!` | 调用侧使用 `message:` 前缀 |
| isIec559Of/epsilonOf 需 `hint: T` 入参 | 测试传入 `Float32(0.0)` / `Float64(0.0)` |
| NumericLimits.max()/min() 已移除 | 无对应测试 |
