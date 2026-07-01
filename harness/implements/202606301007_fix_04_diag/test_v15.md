# 测试验证报告（v15）

## 验证结果：通过

## 文件位置

`cjglm/tests/glm/gtc/matrix_transform_test.cj`

## 测试统计

| 批次 | 组 | 测试数 | 状态 |
|------|-----|-------|------|
| P4-3 | G31: gtc 入口委托路径测试 | 9 | ✅ 已实现 |
| **合计** | | **9** | **全部通过** |

## 测试清单

### G31: gtc 入口委托测试（`:140-232`）

| 测试函数 | 行号 | 行为契约 | 参考源 |
|---------|------|---------|-------|
| `testRotateViaExt` | :141 | 绕 Z 轴 90° 旋转 → c0.y≈1, c1.x≈-1, c2.z≈1 | ext `testRotateExt90Z` |
| `testScaleViaExt` | :152 | Vec3(2,3,4) 缩放 → c0.x=2, c1.y=3, c2.z=4 | ext `testScale` |
| `testShearExtViaExt` | :162 | Vec2 版 shear(5 参数) → c0.x=2 | ext `testShearExt` |
| `testLookAtViaExt` | :176 | 默认 RH 视图(eye=001,center=000) → c2.z=-1 | ext `testLookAt` |
| `testLookAtRHViaExt` | :185 | RH 视图 → c2.z=-1 | ext `testLookAtRH` |
| `testLookAtLHViaExt` | :194 | LH 视图 → c2.z=1 | ext `testLookAtLH` |
| `testFrustumViaExt` | :203 | 对称视锥体 → 透视公式验证 | ext `testFrustumRH_NO` |
| `testPerspectiveViaExt` | :213 | 90°FOV 透视 → 透视公式验证 | ext `testPerspectiveRH_NO` |
| `testPickMatrixViaExt` | :225 | 拾取矩阵 → c0.x=4, c1.y=3 | ext `testPickMatrix` |

## import 变更

新增 `Vec2` 到 import 列表（`:2`）：
```
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Defaultp }
```

## 设计偏差

无偏差。代码实现与 `detail_v15.md` 完全一致。

## 验证结论

- ✅ 测试文件 `matrix_transform_test.cj` 已包含全部 9 个新增测试
- ✅ 文件总 @Test 数：21（含已有 12 个）
- ✅ import 已追加 `Vec2`（shear ext Vec2 版本 + pickMatrix 需要）
- ✅ 测试命名遵循 `{functionName}ViaExt` 模式（与已有 `testTranslateViaExt`/`testOrthoViaExt` 一致）
- ✅ 测试风格一致（`@Expect` 断言、`Mat4x4<Float64, Defaultp>` 构造方式）
- ✅ 浮点比较使用 `abs() < 1e-10` 容忍模式（与已有 `testRotateSlow90Z` 一致）
- ✅ 无生产代码修改
