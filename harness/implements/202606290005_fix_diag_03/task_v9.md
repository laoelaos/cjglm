# 任务指令（v9）

## 动作
NEW

## 任务描述
修复 `cjglm/scripts/gen_fwd_aliases.py:71` 的 CRLF/LF 幂等性问题：检测已存在 `fwd.cj` 的行尾格式（CRLF/LF），在回写时保留原始行尾模式，使脚本对两种行尾格式均幂等。

具体操作：
1. 读取 `cjglm/scripts/gen_fwd_aliases.py:71` 附近代码，确认当前写入模式
2. 修改写入逻辑：以 `'rb'` 模式预读已存在 `fwd.cj` 文件，检测 `b'\r\n'` 是否出现
3. 若检测到 CRLF（`b'\r\n' in existing`），使用 `newline='\r\n'` 回写；否则使用 `newline='\n'`
4. 验证：在 CRLF 和 LF 环境下各执行一次脚本，确认幂等（`git diff` 无变更）

## 选择理由
G3.5（删除 fwd.cj.bak）完成后，G3.6 是下一个可独立完成的任务。操作简单（单文件 Python 脚本修改），无仓颉代码变更风险，可快速推进进度。

## 任务上下文
- 脚本文件：`cjglm/scripts/gen_fwd_aliases.py:71`
- 诊断报告：`docs/diag/impl/03_diag.md:474-497`（§G3.6）
- 当前问题：`open(fwd_path, 'w', encoding='utf-8', newline='\n')` 强制使用 LF 行尾，对 CRLF 文件执行时会触发全文件行尾变更，破坏幂等性
- 修复模式：
  ```
  with open(fwd_path, 'rb') as f:
      existing = f.read()
  newline_mode = '\r\n' if b'\r\n' in existing else '\n'
  with open(fwd_path, 'w', encoding='utf-8', newline=newline_mode) as f:
      f.write(content)
  ```

## 已有代码上下文
- 无仓颉代码需要修改
- 无测试文件需要修改
- 无文档需要更新
- 无需 deviations.md 登记（属构建工具兼容性问题，非 API/行为偏差）
