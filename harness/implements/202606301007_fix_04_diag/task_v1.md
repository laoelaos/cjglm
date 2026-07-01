# 任务指令（v1）

## 动作
NEW

## 任务描述
修正 `ext/matrix_transform.cj` 中 `rotate` 和 `shear` 函数的矩阵乘法顺序：

1. **rotate**（`:39`）：将 `Rot * m` 改为 `m * Rot` — GLM 1.0.3 `ext/matrix_transform.inl:40-45` 使用 `m[0]*Rot[0][0] + m[1]*Rot[0][1] + m[2]*Rot[0][2]` 等价于左乘 `m * Rot`
2. **shear**（`:63`）：将 `H * m` 改为 `m * H` — GLM 1.0.3 `ext/matrix_transform.inl:119-124` 同样为左乘模式

## 选择理由
S1是第一优先（功能正确性）问题，自包含在单文件中，无需修改其他生产代码。修复此问题后，依赖ext rotate/shear的gtc层可通过重导出获得正确行为。

## 任务上下文
- 问题来源：`docs/diag/impl/04_diag.md` S1条目
- OOD设计：`docs/06_ood_phase4.md` §3.2 ext/matrix_transform.cj 列明了rotate/shear签名，但未明确描述乘法顺序
- GLM参考：`references/glm-1.0.3/glm/ext/matrix_transform.inl:40-45`（rotate左乘）和`:119-124`（shear左乘）

## 已有代码上下文
当前代码 `cjglm/src/ext/matrix_transform.cj:39`：
```cangjie
Rot * m  // 错误：应为 m * Rot
```

当前代码 `cjglm/src/ext/matrix_transform.cj:63`：
```cangjie
H * m   // 错误：应为 m * H
```

修复后：
```cangjie
m * Rot
m * H
```
