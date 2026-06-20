# 详细设计（v7）

## 概述
修改 `scripts/gen_fwd_aliases.py` 中两处字符串模板，使其生成与 CL-11 手动修复后的 `fwd.cj` 一致的输出。

## 文件规划
| 文件 | 操作 | 行 | 说明 |
|------|------|----|------|
| `scripts/gen_fwd_aliases.py` | 修改 | 29 | 导入语句格式 |
| `scripts/gen_fwd_aliases.py` | 修改 | 44 | 别名定义格式 |

## 变更定义

### 第 29 行
- 当前：`lines.append('import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }')`
- 目标：`lines.append('import glm.detail')`

### 第 44 行
- 当前：`lines.append(f'public type {alias_name} = {vec_type}<{family_type}, {prec_type}>')`
- 目标：`lines.append(f'public type {alias_name} = detail.{vec_type}<{family_type}, {prec_type}>')`

## 验证方案
1. 修改后运行脚本
2. `cjpm build` 确认编译通过
3. `cjpm test` 确认测试通过
