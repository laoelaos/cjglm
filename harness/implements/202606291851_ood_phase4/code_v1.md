# 实现报告（v1）

## 概述

实现 `detail/stdmath_shim.cj`：为 25 个 `std.math` 函数提供统一的泛型包装函数（`T <: FloatingPoint<T>`）。新增 1 个文件，修改 1 个现有文件以解决同包命名冲突。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | src/detail/stdmath_shim.cj | 25 个泛型包装函数（sqrtT/expT/logT/exp2T/log2T/powT/sinT/cosT/tanT/asinT/acosT/atanT/atan2T/sinhT/coshT/tanhT/asinhT/acoshT/atanhT/floorT/ceilT/roundT/truncT/absT/fmodT） |
| 修改 | src/detail/type_quat_cast.cj | 删除私有 `sqrtT` 定义（由 stdmath_shim.cj 的包级函数替代）；移除已不用的 `sqrt` import |

## 编译验证

`cjpm build` 成功，0 errors，仅存在已有 warnings（unused import / shadowed import / unused variable 等，均为阶段二~四已有代码遗留问题，与本变更无关）。

## 设计偏差说明

| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| 只需新建 stdmath_shim.cj，无需修改现有文件（detail_v1.md 第 9~11 行） | `detail/type_quat_cast.cj` 已有 `private func sqrtT<T>`（同包），仓颉编译器不将泛型约束纳入重载决议，两函数无法共存 | 删除 `type_quat_cast.cj` 的私有 `sqrtT`（第 129~132 行）及已不用的 `sqrt` 导入，改为使用 `stdmath_shim.cj` 的包级 `sqrtT`；已在 `docs/deviations.md` 中记录为 IMPL-01 |
