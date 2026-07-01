# 任务指令（v2）

## 动作
RETRY

## 任务描述
P1批次的全部5个子任务：

1. **P1-1（RETRY）S1靶向验证** — 验证 `ext/matrix_transform.cj` 的 `rotate`/`shear` 乘法顺序修正（v1已应用代码变更），靶向编译并运行 `tests/glm/ext/matrix_transform_test.cj`，确认测试通过。然后更新 `docs/diag/impl/04_diag.md` 中 S1 条目标注为"已修复"。

2. **P1-2 S2+G7: gtc/ulp.cj float_distance** — 修复 `cjglm/src/gtc/ulp.cj:51` 的 Int32 减法溢出（S2）+ 增加 NaN/Inf 前置检查（G7）。参考 GLM 1.0.3 `gtc/ulp.inl:85-99`，使用位重解释替代数值转型，加 `abs()` 返回无符号绝对值。

3. **P1-3 G10: ext/quaternion_common.cj slerp** — 修正四参数 slerp(k) 公式为 `phi = omega + k * pi<T>(); scale0 = sin(omega - a * phi) / sin(omega); scale1 = sin(a * phi) / sin(omega)`；在两参数和四参数 slerp 中补充 cosTheta<0 最短路径分支。

4. **P1-4 G1: detail/common.cj roundEven** — 交换 `cjglm/src/detail/common.cj:176-179` 的 if/else 分支：`if (rInt % 2 == 0) { r } else { r - one }`。

5. **P1-5 S3+S4: 测试期望值修正** — 修正 `tests/glm/ext/quaternion_transform_test.cj:63-70`（S3）和 `tests/glm/gtc/matrix_transform_test.cj:107-109`（S4）的错误期望值。

每完成一个子任务，更新 `04_diag.md` 中对应的条目状态为"已修复"。

## 选择理由
v1已成功修正S1代码，但全量 `cjpm test` 超时导致验证失败。v2采用靶向验证策略避免超时，同时推进P1剩余高优问题。P1-2~P1-5均为第一优先（功能正确性），参照 `04_diag.md` 第453~474行的优先级分组。

## 任务上下文
- 参考 `04_diag.md`：
  - S1（第18~34行）：rotate/shear乘法顺序
  - S2（第38~52行）+ G7（第156~170行）：float_distance溢出+NaN/Inf检查
  - G10（第208~225行）：slerp公式+最短路径
  - G1（第83~94行）：roundEven分支反转
  - S3（第55~66行）+ S4（第68~79行）：测试期望值
- 每完成一个子任务，更新 `04_diag.md` 在对应条目末尾追加 "✅ 已修复" 标记
- 偏差记录：如需添加新的偏差，依据 `docs/deviations.md` 头部指示写入"四、未验证的偏差添加"

## 已有代码上下文

### 已验证的S1代码变更
- `ext/matrix_transform.cj:39`：已改为 `m * Rot`
- `ext/matrix_transform.cj:63`：已改为 `m * H`
- `tests/glm/ext/matrix_transform_test.cj`：已包含4个S1验证测试（含左乘语义验证）

### P1-2~P1-5 当前状态
- `gtc/ulp.cj:51`：当前为 signed 减法，NaN/Inf 前置检查缺失
- `ext/quaternion_common.cj:42-71`：slerp 两参数和四参数缺失 cosTheta<0 分支，四参数公式与GLM不一致
- `detail/common.cj:176-179`：roundEven 分支反转
- `tests/glm/ext/quaternion_transform_test.cj:63-70`：期望值错误
- `tests/glm/gtc/matrix_transform_test.cj:107-109`：`c0.y` 和 `c1.x` 期望值错误

## RETRY 说明
v1验证失败原因：`cjpm test` 超时（全量测试套件执行时间超过时间限制），未产生测试结果。v1的代码变更本身正确（编译通过，仅预存warnings）。

v2策略变更：
1. 使用靶向编译/运行测试（`cjpm test --file=...` 或等效的单文件执行方式）代替全量测试
2. 每完成1个子任务即验证该子任务，不等到全部完成后再验证
3. 若靶向验证仍超时，尝试简化测试输入（减少矩阵维数或浮点类型变体）
