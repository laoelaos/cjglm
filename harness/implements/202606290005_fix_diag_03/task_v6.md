# 任务指令（v6）

## 动作
NEW

## 任务描述
修复 G2.1：将 `quaternion_common.cj:40` 的 4 参数 `slerp` 签名第 4 参数从 `spin: Bool` 改为 `k: Int64`，与 OOD §3.11 / D22 决策一致。当前函数体为 `throw Exception("stub")`，保持 stub 状态不变。在 `quaternion_common_test.cj` 追加 3 个 `@Test` 用例验证新签名的 stub 异常路径。

## 选择理由
- G2.1 优先级 High（API 签名层面错误），将阻塞阶段四 slerp 完整实现
- S1 已闭环绕过（verify_v5 PASSED），S2 已完成（测试文件发现已修复）
- 当前最高优先级剩余任务
- 纯签名修复 + 测试追加，无运行时行为变更，风险低

## 任务上下文
### 需修改文件
| 文件 | 修改内容 |
|------|---------|
| `cjglm/src/ext/quaternion_common.cj:40` | `func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool)` → `func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64)` |
| `cjglm/tests/glm/ext/quaternion_common_test.cj` | 在 `testSlerpStub` 后追加 `testSlerp4ArgsK0`、`testSlerp4ArgsK1`、`testSlerp4ArgsKMinus1`，验证 `@ExpectThrows[Exception](slerp(x, y, a, k))` |

### 无需修改的文件
- 诊断文档 `03_diag.md`（修复后签名即与 OOD 一致，无偏差残留）
- 偏差记录 `deviations.md`（同前）
- OOD 设计文档（无需修改）

### 验证方式
- `cjpm build` 编译通过（0 errors）
- `cjpm test` 全部 438+ PASSED / 0 FAILED（新增 3 个测试通过）
- 读取 `quaternion_common.cj:40` 确认签名为 `k: Int64`

### 参考
- OOD §3.11 line 791、D22 决策、§11.5 line 2212 均声明 `k: Int64`
- 诊断报告 §G2.1（`docs/diag/impl/03_diag.md:299-322`）
- 无 4 参数 slerp 调用点（grep 扫描 `slerp(.*,.*,.*,` 结果为空）
