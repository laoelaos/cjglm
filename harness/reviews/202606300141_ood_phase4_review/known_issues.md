# 已知问题

---

- K1: slerp(k) 四参数版本公式需交叉验证 — 位置：`cjglm/src/ext/quaternion_common.cj:68-69`，原因：OOD 设计标注"参考 GLM 1.0.3 源码"，公式需补充单元测试覆盖 k 参数边界场景
- K2: noise.cj Float16 系统性溢出风险 — 位置：`cjglm/src/gtc/noise.cj:120`（及约 10+ 处类似位置），原因：`(exp as T).getOrThrow()` 在 Float16 中间值超出 ±65504 时抛出异常，但概率极低（fx 分量值 ≤ 1.0），Float16 场景几乎不用噪声函数
- K3: matrix_projection.cj 零 w 保护 — 位置：`cjglm/src/ext/matrix_projection.cj:8,46`，原因：project/unProject 在 w=0 时 Inf 传播，与 GLM 1.0.3 行为一致（OOD §5 不做输入验证）
