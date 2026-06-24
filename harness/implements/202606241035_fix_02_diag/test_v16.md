# 测试报告（v16）— T13 cjpm 子包构建验证

## 验证结果

| 项目 | 结果 |
|------|------|
| 验证文件 `src/ext/test_ext_alias.cj` | 已存在，内容符合规格 |
| `cjpm build` 退出码 | 0 ✅ |
| 模式 | **模式 A（零侵入）— 通过** |
| 编译错误 | 无 |
| 编译警告 | 若干（均为预存 stub/unused/import 冲突警告，非本次引入） |

## 结论

模式 A 验证通过。cjpm 正确发现 `src/ext/` 子包并编译 `package glm.ext`。无需回退到模式 B。

## 文件产物

- `src/ext/test_ext_alias.cj` — 最小验证文件（保留作为验证产物）
