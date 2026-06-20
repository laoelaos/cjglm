# 任务指令（v7）

## 动作
NEW

## 任务描述
修改 `scripts/gen_fwd_aliases.py` 中两处代码生成逻辑，使其输出与 CL-11 手动修复后的 `fwd.cj` 一致。

### 变更清单

| 文件 | 操作 | 行号 | 说明 |
|------|------|------|------|
| `scripts/gen_fwd_aliases.py` | 修改 | 29 | 导入语句：`import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` → `import glm.detail` |
| `scripts/gen_fwd_aliases.py` | 修改 | 44 | 类型别名：`{vec_type}<{family_type}, {prec_type}>` → `detail.{vec_type}<{family_type}, {prec_type}>` |

### 验证步骤

1. 修改脚本
2. 运行 `python scripts/gen_fwd_aliases.py` 重新生成 `src/fwd.cj`
3. `cjpm build` 验证编译通过
4. `cjpm test` 验证测试全部通过

## 选择理由
#24 是脚本同步维护任务，修复工作量极小（2 行），但若不修复，任何人重新运行脚本将覆盖 CL-11 手动修复，导致 252 个编译错误。此编号属于脚本/工具维护范畴（区别于功能性编码缺失）。

## 任务上下文

### 当前 fwd.cj（CL-11 修复后）
```cangjie
package glm

import glm.detail  // 命名空间导入（非名称导入）

// ...256 个别名定义，均使用 detail.VecN<...> 前缀形式
public type Vec1 = detail.Vec1<Float32, PackedHighp>
```

### 当前 gen_fwd_aliases.py（需修改的行）
```python
# line 29 (current):
lines.append('import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }')
# line 29 (target):
lines.append('import glm.detail')

# line 44 (current):
lines.append(f'public type {alias_name} = {vec_type}<{family_type}, {prec_type}>')
# line 44 (target):
lines.append(f'public type {alias_name} = detail.{vec_type}<{family_type}, {prec_type}>')
```

## 偏差记录
本次修复属于脚本同步性质，与 CL-11 原本的偏差无关。无需新增偏差记录。
