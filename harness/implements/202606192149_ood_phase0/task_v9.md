# 任务指令（v9）

## 动作
NEW

## 任务描述
修复 `src/detail/type_vec1_test.cj` 中 Vec1 广播移位测试的测试数据错误：
1. **testVec1BroadcastShiftLeftVec2**（line 348-354）：`b = Vec2(8, 16)` 应改为 `Vec2(4, 6)`，使 shift 量与期望值（32=2<<4, 64=2<<6）一致
2. **testVec1BroadcastShiftRightVec2**（line 356-363）：`a = Vec1(2)` 应改为 `Vec1(128)`，`b = Vec2(32, 64)` 应改为 `Vec2(4, 3)`，使 `r.x = 128>>4 = 8`，`r.y = 128>>3 = 16`

## 选择理由
验证报告 v8 显示 301/303 测试通过，唯一 1 个 FAILED 和 1 个 ERROR 均源自 Vec1 广播移位测试的输入数据与期望值不匹配。Vec1 广播移位运算符（`<<` / `>>` for Vec2<T,Q>）实现正确，验证已通过的其他同类广播测试（BroadcastAdd/BitAnd/BitOr/BitXor/Mod）可佐证。

## 任务上下文
- 文件：`C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1_test.cj`
- 问题一（line 348-353）：`a=Vec1(2) << b=Vec2(8,16)` 实际计算 `2<<8=512` / `2<<16=131072`，但 `@Expect` 断言 `32`(=2<<4) / `64`(=2<<6)。b 的 shift 量应为 `(4,6)` 而非 `(8,16)`
- 问题二（line 356-362）：`a=Vec1(2) >> b=Vec2(32,64)` 中 `2>>64` 在 Int64 上触发 Overshift 异常（64 >= 64）。期望值 `r.x=8` / `r.y=16` 对应 `128>>4=8` / `128>>3=16`。a 应改为 128，b 应改为 (4,3)

## 已有代码上下文
type_vec1.cj 中 Vec1 广播移位运算符定义（Integer<T> extend 块）：
```
public operator func <<(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x << rhs.x, this.x << rhs.y) }
public operator func >>(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x >> rhs.x, this.x >> rhs.y) }
```
实现正确，仅测试数据有误。
