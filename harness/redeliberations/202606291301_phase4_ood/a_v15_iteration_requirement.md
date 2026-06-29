根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

以下 4 个质量问题来自第 14 轮质量审查诊断报告（b_v14_diag_v1.md），经质询确认（LOCATED），需在本轮修复：

### P1（严重）— lib.cj 修改策略在 §8 和 §9.4 的描述自相矛盾

**所在位置**：
- §8 实施计划 → lib.cj 更新，第 931~933 行
- §9.4 lib.cj 导出，第 1028 行

**问题描述**：
§8 同一句内先声明"增量追加，**不修改已有行**"，随后立即要求"**但需修改现有 lib.cj 第 23 行**"。两者互斥，编码实施者无法同时遵守。
§9.4（第 1028 行）完整表述为："已有 import 行不做任何修改"，进一步强化"不修改"的预期。
然而 D30（第 883 行）已明确必须修改第 23 行以消除命名冲突（删除 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 的 gtc import），改由 ext 统一导入。

**改进建议**：① 删除 §8 第 931 行中的"不修改已有行"；② 将 §9.4 第 1026~1028 行的"增量追加策略"和"不做任何修改"修正为"增量追加策略，但需修改 lib.cj 第 23 行"并附简短理由；③ 在 §9.4 末尾引用 D30 作为详细依据。

### P2（一般）— lib.cj 导出遗漏 `hvec1`

**所在位置**：§8 lib.cj 更新代码块，第 980 行

**问题描述**：
§3.3 type_precision.cj 第 695 行的别名清单已包含 `hvec1`（在 v13→v14 修订 P2-2 中补充），但 §8 lib.cj 导出第 980 行仅有 `hvec2, hvec3, hvec4`，遗漏 `hvec1`。
按此导出实施后，`glm::hvec1` 将不可用，产生与 §3.3 设计不一致的行为。

**改进建议**：在第 980 行补充 `hvec1`，使导出与别名清单一致。

### P3（一般）— `stdmath_shim.cj` 未纳入实施批次规划

**所在位置**：§8 实施批次规划（第 887~930 行）

**问题描述**：
`stdmath_shim.cj`（第 99~102 行）是所有 core 函数库的底层依赖：
- exponential.cj 通过 shim 调用 pow/exp/log/sqrt
- trigonometric.cj 通过 shim 调用 sin/cos/tan/atan 等
- geometric.cj 通过 shim 调用 sqrt
- ext/scalar_common.cj 的 iround/uround 通过 shim 调用 roundT
但第 887~930 行的四批实施规划中，没有任何一个批次提及此文件。虽然它标为"非公共 API 文件"，但作为其他模块的编译期前置依赖，缺少显式安排可能导致编码阶段依赖顺序错误。

**改进建议**：在第一批（第 891~896 行）中增加 `stdmath_shim.cj` 条目，明确其作为`glm.detail`私有模块的创建时机和与 common.cj/exponential.cj 的先后依赖关系。

### P4（一般）— `gtc/matrix_access.cj` 和 `gtc/matrix_inverse.cj` 签名不足以直接编码

**所在位置**：
- §3.3 gtc/matrix_access.cj（第 572~575 行）
- §3.3 gtc/matrix_inverse.cj（第 564~566 行）

**问题描述**：
与同层次的 `packing.cj`（提供完整的 32 个函数签名）、`ulp.cj`（提供完整的具体类型重载签名）、`ext/matrix_projection.cj`（提供完整的 7 个函数签名）等形成对比，这两个模块的接口描述不足以直接指导编码：

1. **matrix_access.cj**：仅文字描述"对所有 9 个矩阵类型提供重载"，未给出 `row`/`column` 的任一完整签名。编码团队需自行推导每个矩阵类型的返回类型（Mat2x2→Vec2、Mat2x3→Vec3、Mat3x2→Vec2...），推演成本高且易出错。
2. **matrix_inverse.cj**：`affineInverse` 的描述暗示仅适用于 Mat4x4（"最后一行固定为 [0,0,0,1]"），但职责中未明确约束适用范围；`inverseTranspose` 完全未说明适用于哪些矩阵类型（GLM 中通常为 Mat3x3/Mat4x4）。

**改进建议**：
- matrix_access.cj：至少给出 2~3 个典例矩阵类型的完整函数签名，其余标注遵循 GLM 1.0.3 模式；
- matrix_inverse.cj：明确 `affineInverse` 仅适用于 Mat4x4（且有最后一行约束前提），`inverseTranspose` 的矩阵适用范围，在约束或注释中写明。

## 历史迭代回顾

### 已解决的问题
以下问题已在过去 14 轮迭代中得到解决，当前反馈中不再提及：
- 第 1 轮：stub 替换范围矛盾声明（§1 概述 vs. §5 错误表）、Common\<T\> 约束未定义、T(0)/T(1) 字面量约定、mod 约束策略等
- 第 2 轮：inversesqrt 零值边界、Vec1 normalize 语义、trigonometric.cj sqrt 依赖事实错误、lib.cj perspective/ortho/frustum 命名冲突等
- 第 3 轮：Vec1 normalize 零输入自相矛盾、IEEE 754 假设未验证、跨包同符号导入编译风险、packing/noise 签名缺失等
- 第 4 轮：modf/frexp/ldexp 签名缺失、奇异矩阵求逆行为不一致、mod 约束事实错误、ulp.cj 泛型不可编码等
- 第 5~6 轮：ext/scalar_common/vector_common 完整函数清单、命名冲突分析、slerp 退化阈值等
- 第 7~9 轮：lib.cj 跨包重复导入冲突、frexp 边缘场景、mirrorRepeat 公式、ldexp 描述自相矛盾等
- 第 10~13 轮：lib.cj noise/packing 导出、gtc 委托关系、frexp 指数公式错误、ulp 公式错误、simplex 返回类型错误等

### 持续存在的问题（本轮需重点解决）
以下 4 个问题在第 14 轮和第 15 轮连续出现，本轮必须彻底修复：

1. **lib.cj 修改策略矛盾**（P1）：v9→v10 修订（第 1121 行）已标记为 P1 并声称修正，但仅在 §8 追加"但需修改"措辞而未删除前文矛盾声明，也未更新 §9.4。属修复不完整。
2. **lib.cj 导出遗漏 hvec1**（P2）：v13→v14 修订（P2-2）补充了 §3.3 的 alias 清单但漏同歩更新 §8 导出。属修复遗漏。
3. **stdmath_shim.cj 未纳入实施批次**（P3）：v13→v14 首次识别，仅标注"需关注"，未实际修改实施规划表。属修复未执行。
4. **matrix_access/matrix_inverse 签名粒度不足**（P4）：v13→v14 首次识别并给出改进建议，但未实际补充签名。属修复未执行。

### 新发现的问题
本轮未发现新的质量问题。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v14_copy_from_v13.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
