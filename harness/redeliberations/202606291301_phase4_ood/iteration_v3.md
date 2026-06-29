# 再审议判定报告（v3）

## 判定结果

RETRY

## 判定理由

组件B诊断报告识别出6项质量问题（P1-P6），其中3项严重（P1：Vec1 normalize 零输入行为自相矛盾；P2：inversesqrt(0)返回+Inf依赖CangJie浮点除零行为未经验证；P3：lib.cj跨包同符号导入存在编译风险）、3项一般（P4：gtc/packing.cj设计粒度不足；P5：gtc/random.cj线程本地存储方案缺少可行性验证；P6：ext/matrix_transform.cj与ext/matrix_clip_space.cj实际函数范围未明确）。质询报告结论为LOCATED，全部6项问题均经审查确认。实际内部循环轮次（1轮）未达到最大轮次（12轮），提前终止原因系问题已全部定位且被确认。根据判定标准，审查报告包含严重或一般等级的问题，应判定为RETRY。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：Vec1 normalize 零输入行为自相矛盾——第275行描述为"0 * Inf = NaN"，第278行general描述及§5错误表描述为"返回零向量"
- **所在位置**：§3.1 geometric.cj 第275行 vs. 第278行、§5 错误处理策略表 第601–603行
- **严重程度**：严重
- **改进建议**：选择方案A（统一零向量保护）或方案B（Vec1例外并加脚注），全局同步

- **问题描述**：inversesqrt(0)返回+Inf依赖CangJie浮点除零符合IEEE 754规范，该假设未经验证且现有代码库存在反向证据
- **所在位置**：§3.1 exponential.cj 第248行、D20
- **严重程度**：严重
- **改进建议**：新增验证项确认Float64(1)/Float64(0)是否返回+Inf，并在§1.7补充为H4确定性声明或增加零值保护分支

- **问题描述**：lib.cj更新方案中mix和exp/log/pow/sqrt跨包同符号导入存在编译风险，CangJie同名函数跨public import重载解析行为未经验证，且exp/log/pow/sqrt的冲突被完全忽视
- **所在位置**：§8 lib.cj更新代码块，§8 "关于mix命名冲突的处理"段落
- **严重程度**：严重
- **改进建议**：编写最小测试用例验证CangJie跨public import同名函数重载解析行为，将exp/log/pow/sqrt纳入冲突分析，验证失败则设计替代方案

- **问题描述**：gtc/packing.cj仅列出函数名称，未给出任何一个函数的完整签名和实现路径
- **所在位置**：§3.3 gtc/packing.cj 第419–427行
- **严重程度**：一般
- **改进建议**：为每个packing函数补充完整签名，至少包含2–3个典例函数的完整签名作为格式示范

- **问题描述**：gtc/random.cj ThreadLocal<Random>方案未验证CangJie中ThreadLocal是否可用、Random是否满足Send/Sync约束、种子初始化竞态问题
- **所在位置**：§3.3 gtc/random.cj 第445–447行、D19、§6
- **严重程度**：一般
- **改进建议**：新增验证项确认ThreadLocal<Random>可编译运行，补充初始化与竞态保护策略，提供备选方案

- **问题描述**：ext/matrix_transform.cj和ext/matrix_clip_space.cj实际函数范围未明确，缺少完整函数清单
- **所在位置**：§1 核心抽象表、§3.2 ext/matrix_transform.cj 第317–326行、§3.2 ext/matrix_clip_space.cj 第337–344行
- **严重程度**：一般
- **改进建议**：列出每个ext/矩阵文件的完整函数签名清单，或明确标注与GLM 1.0.3对应头文件一致并给出参考行号
