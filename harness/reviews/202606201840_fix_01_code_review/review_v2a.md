# R2A: type_cast.cj 跨类型转换工具函数及测试审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/type_cast.cj` — 16 个 castVec1~castVec4 跨类型转换函数
- `cjglm/src/detail/type_cast_test.cj` — 43 个测试用例

### 发现

#### [轻微] 测试覆盖缺少 Bool 和 UInt 家族分量类型

- **位置**：`cjglm/src/detail/type_cast_test.cj`
- **描述**：全部 43 个测试仅使用 `Int64`、`Int32`、`Float32` 三种分量类型（T/T2），未覆盖 Bool 源/目标、UInt 家族（UInt8/16/32/64）等类型。castVec 函数签名中 T2 无约束，理论上支持任意类型（通过 conv 闭包转换），但 Bool 和 UInt 路径未经测试验证。
- **建议**：至少为每个 castVecN 家族补充一个 Bool→数值转换测试（如 `castVec1<Int64, Defaultp, Bool, Defaultp>(Vec1<Bool, Defaultp>(true), { x => if (x) { Int64(1) } else { Int64(0) } })`）和一个 UInt32 跨类型测试，覆盖数值类型全频谱的基本正确性。

#### [轻微] 低维→高维扩展时的分量填充行为与 GLM 构造函数语义有差异

- **位置**：`cjglm/src/detail/type_cast.cj:45` (castVec3 Vec2→Vec3)、`:64-65` (castVec4 Vec1→Vec4)、`:70` (castVec4 Vec2→Vec4)、`:75` (castVec4 Vec3→Vec4)
- **描述**：低维→高维扩展时，castVec 函数将最后一个可用分量的转换结果重复填充到剩余分量（如 `castVec4( Vec2(x,y) )` → `Vec4(conv(x), conv(y), conv(y), conv(y))`）。C++ GLM 的跨类型构造函数在 GLSL §5.4.1 规则下使用零填充（`vec4(vec2(x,y))` → `(x, y, 0, 0)`）。此差异未在 `docs/deviations.md` 中记录（已确认 DV-01~DV-06、IF-01~IF-04、INT-01~INT-04 均不覆盖此行为）。是否属于偏差需设计审议确认——若 castVec 函数定位为 "逐分量映射工具"（非构造语义），则重复填充是合理设计；若定位为 "构造函数替代"，则为行为偏差。
- **建议**：① 确定 castVec 的语义定位后，将组件填充策略以设计决策或偏差形式记录到 `docs/deviations.md` 或 `docs/02_ood_phase0.md` 的对应章节；② 若决定对齐 GLM 零填充语义，修改 `castVec3(v: Vec2)`、`castVec4(v: Vec1)`、`castVec4(v: Vec2)`、`castVec4(v: Vec3)` 的构造函数调用参数，在缺少分量的位置使用 `T(0)` 而非重复 conv 调用。

#### [轻微] 跨 Q 组合测试覆盖不完整

- **位置**：`cjglm/src/detail/type_cast_test.cj`
- **描述**：跨 Q 测试仅覆盖 `PackedHighp→Defaultp`、`Defaultp→PackedHighp`、`PackedLowp→Defaultp`、`PackedMediump→Defaultp` 等组合。`PackedHighp→PackedLowp`、`PackedLowp→PackedHighp`、`PackedMediump→PackedHighp` 等反向或跨两级 Q 组合未测试。虽然首轮所有 Q 行为等价（空结构体），类型层面的编译通过性仍应验证。
- **建议**：补充 2-3 个覆盖 `PackedHighp→PackedLowp`、`PackedLowp→PackedMediump` 等额外 Q 组合的测试。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 0 |
| 轻微 | 3 |

### 总评

`type_cast.cj` 实现正确、完整。16 个函数覆盖了 4 源×4 目标的全组合（castVec1~castVec4 各 4 个重载），签名、约束、参数、返回值均正确，分量映射模式在各自家族内一致。`type_cast_test.cj` 的 43 个测试覆盖了每个 castVecN 家族的主要场景（身份转换、跨类型、跨 Q、浮点截断、源不可变性），测试模式规范、断言完整。存在 3 处轻微改进项：分量类型多样性不足（缺 Bool/UInt）、低维→高维扩展填充行为与 GLM 语义的差异需确认并记录、跨 Q 组合测试可更全面。整体代码质量良好，无阻塞性问题。
