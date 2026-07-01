# 测试输出（v8 r2 fix）

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `tests/glm/detail/geometric_test.cj` | 新增 normalize Vec1、normalize Vec4 zero、faceforward Vec4 测试 |
| 修改 | `tests/glm/ext/matrix_transform_test.cj` | 新增 rotate、shear、lookAt 测试 |
| 修改 | `tests/glm/ext/matrix_clip_space_test.cj` | 替换弱断言为数值验证；新增 perspectiveFovRH_NO/LH_ZO 测试 |
| 修改 | `tests/glm/ext/vector_common_test.cj` | 新增 min3 Vec3、fmin Vec3 scalar、fclamp Vec3、mirrorRepeat Vec2、iround Vec3 测试 |
| 修改 | `tests/glm/ext/quaternion_trigonometric_test.cj` | 新增 angle(angleAxis) 互逆验证 |
| 修改 | `tests/glm/ext/matrix_projection_test.cj` | 新增 project/unProject 互逆验证（非单位矩阵）及泛型委托验证 |
| 修改 | `tests/glm/gtc/matrix_inverse_test.cj` | 新增 rotation+translation 仿射矩阵验证 |
| 修改 | `tests/glm/gtc/matrix_access_test.cj` | 新增 Mat3x3/Mat4x2/Mat2x4/Mat3x4 row/column 测试 |

## 测试覆盖矩阵

| 被测类型 | 文件 | 正向用例 | 边界条件 | 错误路径 | 状态交互 |
|---------|------|---------|---------|---------|---------|
| geometric dot | geometric_test | Vec1~Vec4 各 1 | — | — | — |
| geometric cross | geometric_test | Vec3 | — | — | — |
| geometric normalize | geometric_test | Vec1~Vec4 | Vec2/3/4 零向量 | — | — |
| geometric length | geometric_test | Vec2~Vec4 | — | — | — |
| geometric distance | geometric_test | Vec2~Vec4 | — | — | — |
| geometric reflect | geometric_test | Vec2~Vec4 | — | — | — |
| geometric refract | geometric_refract_test | Vec2~Vec4 | 全反射 | — | — |
| geometric faceforward | geometric_test | Vec2~Vec4 | — | — | — |
| ext matrix_transform | matrix_transform_test | translate/scale/rotate/shear/lookAt/RH/LH | rotate 零角 | — | — |
| ext matrix_clip_space | matrix_clip_space_test | frustum LH/RH ZO/NO、ortho、ortho LH/RH NO、perspective RH_NO/LH_ZO、perspectiveFov RH_NO/LH_ZO、infinitePerspective、tweakedInfinitePerspective | — | — | — |
| ext matrix_projection | matrix_projection_test | projectZO/NO、unProjectZO/NO、pickMatrix | — | — | — |
| ext quaternion_common | quaternion_common_test | conjugate/inverse/lerp/mix/slerp/slerp(k) | lerp 越界 | inverse 零四元数 | — |
| ext quaternion_trigonometric | quaternion_trigonometric_test | axis/angle/angleAxis、angle(angleAxis) roundtrip | 单位四元数、零四元数 | — | — |
| ext quaternion_transform | quaternion_transform_test | rotate 零角/90°/全周/非单位轴/零轴 | 零轴保护 | — | — |
| ext vector_common | vector_common_test | min(3/4 Vec2~Vec3)、fmin/fmax/fclamp、clamp/repeat/mirrorRepeat、iround/uround | — | — | — |
| gtc matrix_inverse | matrix_inverse_test | affineInverse（对角+旋转）、inverseTranspose Mat3/Mat4 | — | — | — |
| gtc matrix_access | matrix_access_test | row/column Mat4x4/Mat2x3/Mat3x3/Mat4x2/Mat2x4/Mat3x4 | — | index 越界 | — |
| gtc matrix_transform | matrix_transform_test | identity/shear/rotate_slow/scale_slow/shear_slow/translate/ortho | zero angle | — | — |

## 行为契约覆盖

| 行为契约 | 正向用例 | 特殊行为验证 |
|---------|---------|-------------|
| dot | dot(Vec1~4) | — |
| cross | cross(Vec3) | — |
| normalize Vec1 | normalize(Vec1(4)) == Vec1(1) | 零→NaN（因精度问题未断言 NaN） |
| normalize Vec2~4 | normalize 3-4-5 三角形 | 零→零向量 |
| length | length(3,4)=5 | — |
| distance | distance((0,0),(3,4))=5 | — |
| reflect | reflect((1,-1),(0,1))==(1,1) | — |
| refract | refract((1,-1),(0,1),0.5)==(0.5,-0.5) | k<0→零向量 |
| faceforward | dot(Nref,I)<0→N else -N | — |
| mix(quat) | mix 在 0/0.5/1 处正确 | clamp(越界 a) 静默 |
| slerp | slerp x→y 在 0/1 处正确 | sinOmega<epsilon→lerp |
| angle | angle(w=1)==0 | — |
| angleAxis | angleAxis(0,z)==(1,0,0,0) | — |
| angle(angleAxis) 互逆 | angle(angleAxis(θ, axis))≈θ | — |
| affineInverse | m*inv==I（对角+旋转） | — |
| inverseTranspose | Mat3/Mat4 | — |
| project/unProject 互逆 | unProject(project(obj))≈obj（非单位 MVP） | — |
