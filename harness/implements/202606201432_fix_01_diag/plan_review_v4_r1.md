# 计划审查报告（v4 r1）

## 审查结果
REJECTED

## 发现

### **[严重]** Vec2-target `cast` 重载与 Vec1-target 重载参数类型相同，导致重定义错误

根据仓颉语言函数重载规则（`function/README.md` §7.1）：
> "同名、不同参数数量或类型 → 有效重载"
> "泛型函数：对齐类型参数名后，若非泛型部分不同 → 重载；否则 → **重定义错误**。类型变量约束不参与判断"

task_v4.md 中定义的 Vec2-target 新增重载与 R3 已实现的 Vec1-target 重载在参数签名上完全相同：

```cangjie
// 已有 (Vec1-target, R3):
public func cast<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
// 新增 (Vec2-target, task_v4):
public func cast<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
```

对齐类型参数名后，非泛型部分均为 `(v: Vec1<T2, Q2>, conv: (T2) -> T)`，返回类型差异不参与重载判定 → **重定义错误**。此问题同样适用于 Vec2/Vec3/Vec4 为源类型的其余 3 对重载。

### 修正方向

将目标 Vec 类型编码到函数名中，消除重载歧义。具体方案：

1. **重命名**：将 R3 已有的 4 个 `cast` 函数（Vec1-target）重命名为 `castVec1`
2. **新增**：为 Vec2/Vec3/Vec4 目标类型分别定义 `castVec2`/`castVec3`/`castVec4`，各 4 个重载

变更清单：
- `type_cast.cj`：重命名 + 追加新函数组
- `type_cast_test.cj`：更新已有 `cast` → `castVec1` 调用 + 追加 Vec2-target 测试
- `plan.md`：更新 R3 记录（函数名改为 `castVec1`）
- `task_v4.md`：修订任务描述，使用 `castVec2` 命名方案

此方案函数名自描述目标 Vec 类型，对用户更清晰（无需依赖返回值类型推断），且避免了仓颉重载解析限制。
