# 详细设计（v9）

## 概述

修复 `cjglm/scripts/gen_fwd_aliases.py:71` 的 CRLF/LF 幂等性问题：检测已存在 `fwd.cj` 的行尾格式（CRLF/LF），在回写时保留原始行尾模式，使脚本对两种行尾格式均幂等。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/scripts/gen_fwd_aliases.py` | 修改 | 在第 71 行附近添加 CRLF/LF 检测逻辑，保留原始行尾模式 |

## 修改说明

### 目标函数：`main()`

**函数签名**：`main() -> Unit`

**修改位置**：`scripts/gen_fwd_aliases.py:66-72`

### 当前代码（第 66-72 行）
```python
content = '\n'.join(lines)
script_dir = os.path.dirname(os.path.abspath(__file__))
output_path = os.path.join(script_dir, '..', OUTPUT)
output_path = os.path.normpath(output_path)
os.makedirs(os.path.dirname(output_path), exist_ok=True)
with open(output_path, 'w', encoding='utf-8', newline='\n') as f:
    f.write(content)
```

### 修改后逻辑

1. 在 `content = '\n'.join(lines)` 之后、`open(...)` 写入之前，插入行尾检测步骤：
   - 检查 `output_path` 是否已存在（使用 `os.path.exists()`）
   - 若存在，以 `'rb'` 模式打开并读取全部内容
   - 检测 `b'\r\n'` 是否出现在已存在内容中
2. 根据检测结果决定 `newline` 参数：
   - 文件存在且包含 `b'\r\n'` → `newline='\r\n'`（保留 CRLF）
   - 文件不存在或不存在 `\r\n` → `newline='\n'`（默认 LF）
3. 其余逻辑保持不变（`os.makedirs`、写入、打印）

### 错误处理

- 使用 `try/except` 包裹文件读取操作，避免因权限或路径问题导致脚本异常终止
- 若读取失败，回退到 LF 模式（默认行为）

## 行为契约

### 前置条件
- `gen_fwd_aliases.py` 可从项目根目录正常执行
- `src/` 目录可写

### 后置条件
- 生成的 `fwd.cj` 行尾格式与已存在文件保持一致
- 首次生成（文件不存在）时使用 LF 行尾（`newline='\n'`）
- 对已有 CRLF 文件执行后，`git diff` 无变更（幂等）
- 对已有 LF 文件执行后，`git diff` 无变更（幂等）

## 依赖关系

- 无外部依赖，仅使用 Python 标准库 `os`
- 无仓颉代码变更
- 无测试文件变更
- 无文档更新
- 无需 `deviations.md` 登记（见任务说明）

## 验证方式

1. 在 CRLF 环境下执行脚本，确认 `git diff` 无变更
2. 在 LF 环境下执行脚本，确认 `git diff` 无变更
