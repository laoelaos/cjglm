# cjglm — GLM 1.0.3 仓颉迁移

[GLM](https://github.com/g-truc/glm) 1.0.3 的仓颉（CangJie）语言移植。提供 GLSL 风格的向量/矩阵/四元数数学运算库，适用于图形学、游戏开发和数值计算场景。

## 项目状态

| 阶段 | 内容 | 状态 |
|------|------|------|
| 1 | 基础设施 + Vec1~Vec4 向量类型 + 类型别名 | ✅ 完成 |
| 2 | 9 个矩阵类型 (Mat2x2~Mat4x4) + ext/ 别名 | ✅ 完成 |
| 3 | 四元数 + ext/gtc 函数库 | 📋 待启动 |
| 4 | 函数库 (core/ext/gtc) 完整实现 | 📋 待启动 |
| 5 | SIMD 优化 + 平台检测 | 📋 待启动 |
| 6 | gtx/ 实验性扩展（按需） | 📋 待启动 |

## 快速开始

### 构建

```bash
cjpm build
```

### 运行测试

```bash
cjpm test
```

## 使用示例

```cangjie
import glm.*

// 向量构造与运算
let v1 = Vec2<Float32, PackedHighp>(1.0f, 2.0f)
let v2 = Vec2<Float32, PackedHighp>(3.0f, 4.0f)
let v3 = v1 + v2

// 使用类型别名（定义在 fwd.cj 中）
let a = FVec2(1.0f, 2.0f)
let b = FVec2(3.0f, 4.0f)
let c = a + b

// 矩阵构造与乘法
let m = Mat4x4<Float32, PackedHighp>(1.0f)
let result = m * a
```

## 类型别名

项目通过 `fwd.cj`（由 `scripts/gen_fwd_aliases.py` 自动生成）提供 GLM 兼容的类型别名，涵盖 16 个家族 × 4 分量数 × 4 精度变体：

| 家族 | 分量类型 | 示例 |
|------|---------|------|
| B | `Bool` | `BVec2`, `HighpBVec2` |
| I | `Int32` | `IVec3`, `MediumpIVec3` |
| U | `UInt32` | `UVec4`, `LowpUVec4` |
| Vec | `Float32` | `FVec2`, `HighpFVec2` |
| DVec | `Float64` | `DVec3`, `HighpDVec3` |
| 标量 | — | `int32`, `float`, `double`, `uint` |

## 项目结构

```
cjglm/
├── cjpm.toml             # 项目配置
├── scripts/
│   └── gen_fwd_aliases.py  # 别名自动生成脚本
├── src/
│   ├── lib.cj              # 公共 API 重导出
│   ├── fwd.cj              # 类型别名（自动生成）
│   ├── detail/              # 核心实现
│   │   ├── setup.cj             # 配置常量
│   │   ├── qualifier.cj         # Qualifier 接口与实现
│   │   ├── shim_*.cj            # 基础设施替代层
│   │   ├── type_vec{1,2,3,4}.cj # Vec1~Vec4 向量类型
│   │   ├── type_mat{2,3,4}x{2,3,4}.cj # 9 个矩阵类型
│   │   ├── scalar_vec_ops.cj    # 标量-向量运算
│   │   ├── scalar_mat_ops.cj    # 标量-矩阵运算
│   │   ├── vectorize.cj         # Functor 工具集
│   │   ├── compute_vector_*.cj  # 运算策略
│   │   ├── type_fromBoolVec.cj  # 布尔向量转换
│   │   ├── type_cast.cj         # 跨类型向量转换
│   │   ├── common.cj            # 基础数学函数 (stub)
│   │   ├── matrix.cj            # 矩阵运算函数（27 个实现 + 6 个 stub）
│   │   └── geometric.cj         # 几何函数 (stub)
│   └── ext/                    # 具现化别名文件
│       ├── vector_float{1,2,3,4}.cj
│       ├── vector_double{1,2,3,4}.cj
│       ├── matrix_float{2,3,4}x{2,3,4}.cj
│       └── matrix_double{2,3,4}x{2,3,4}.cj
└── tests/
    └── glm/
        └── detail/              # 对应模块的测试文件
```

## 与 C++ GLM 的偏差

详见 [docs/deviations.md](docs/deviations.md)。主要差异包括：

- **Qualifier 类型化**：C++ 的枚举值模板参数映射为接口+空结构体模式
- **Vec 按分量数拆分**：`vec<N,T,Q>` 拆分为 `Vec1`~`Vec4` 四个独立泛型结构体
- **`fromBoolVec` 需显式传递零值和壹值**：仓颉泛型不支持 `T(n)` 构造
- **`%` 仅对整数类型可用**：浮点取模需使用 `std.math.fmod`
- **移位右操作数固定为 `Int64`**：遵循 `Integer<T>` 接口规范
- **逻辑运算使用具名函数**：`&&`/`||`/`!` 不可重载，替换为 `logicalAnd`/`logicalOr`

## 设计文档

- [技术决策依据](docs/01_tech_decision.md) — 语言适配分析与迁移约束
- [阶段化路线图](docs/02_roadmap.md) — 6 阶段迁移规划
- [阶段一 OOD](docs/03_ood_phase1.md) — 基础设施 + 向量类型设计
- [阶段二 OOD](docs/04_ood_phase2.md) — 矩阵类型设计
- [偏差记录](docs/deviations.md) — 与 C++ GLM 的使用差异

## 许可证

Apache License 2.0。详见 [LICENSE](LICENSE) 文件。
