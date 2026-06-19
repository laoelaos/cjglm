# 再审议判定报告（v9）

## 判定结果

RETRY

## 判定理由

组件B诊断报告定位到 6 个问题，包含 2 个严重（P1 `public import` 路径错误导致编译失败、P2 参考实现验证声明虚构）、2 个中等（P3 `equalExact` 测试缺口、P4 包可见性假设未验证）和 2 个一般（P5 树形图结构错误、P6 `countof` 偏离理由不准确）。质询报告结论为 LOCATED，确认了所有问题的有效性。由于存在严重和一般等级的问题，不符合 PASS 条件，需重新运行组件A进行修正。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：`lib.cj` 的 `public import` 语句使用了错误的包路径 `glm.detail.scalar_vec_ops`，应改为 `glm.detail`
- **所在位置**：§2 公共 API 面设计，`lib.cj` 代码块第4行
- **严重程度**：严重
- **改进建议**：将 `public import glm.detail.scalar_vec_ops.{ add, sub, mul, div, mod }` 改为 `public import glm.detail.{ add, sub, mul, div, mod }`，同步检查其他引用

- **问题描述**：`§7 D6` 声称 `GLM_CONFIG_CLIP_CONTROL` 默认值通过 `GLM_CLIP_CONTROL_DISABLE` 验证，但 `references/glm-1.0.3/glm/glm/detail/setup.hpp` 中不存在该宏定义
- **所在位置**：§7 D6，`GLM_CONFIG_CLIP_CONTROL` 配置行
- **严重程度**：严重
- **改进建议**：删除错误描述，替换为准确的条件编译逻辑说明（依赖 `GLM_FORCE_DEPTH_ZERO_TO_ONE`/`GLM_FORCE_LEFT_HANDED` 平台检测宏）

- **问题描述**：`equalExact` 在验证计划中未覆盖 NaN 返回 `false`、整数/Bool Vec 边界组合及回退路径下行为等价断言
- **所在位置**：§4.5 `equalExact` 段落、§9.3、§12.1 层次三测试列表
- **严重程度**：中等
- **改进建议**：补充 NaN 测试项；显式声明 `equalExact` 在 `==` 容差路径下行为不同（精确比较 vs 容差比较）；将 NaN 测试加入层次四

- **问题描述**：测试文件通过声明 `package glm.detail` 访问 `internal` 类型的假设未经验证，依赖编译器包解析策略
- **所在位置**：§12.3 测试工具小节
- **严重程度**：中等
- **改进建议**：在 §10 新增验证项确认测试文件能否声明同包访问 `internal` 类型；定义备选方案（提升可见性或提供测试 helper）

- **问题描述**：初始目录树形图仍显示两个同级的 `src/glm/` 条目，文件系统中不可能实现
- **所在位置**：§2 项目初始化与构建基础设施，初始目录结构树形图
- **严重程度**：一般
- **改进建议**：修正为正确的嵌套结构（`src/glm/` 同时包含 `lib.cj`、`fwd.cj` 和 `detail/` 子目录）

- **问题描述**：`countof` 偏离理由解释为"VArray 的 `$N` 必须为固定字面量"，与其实际功能（计算 C 数组长度）无关
- **所在位置**：§8.2 范围可追溯性对照表 S3 行、§3.6 shim_cstddef.cj 描述
- **严重程度**：一般
- **改进建议**：修正偏离理由为 Cangjie 无 `sizeof` 等效设施且无原生数组类型，`VArray<T, $N>.size` 可覆盖 `countof` 的角色
