package glm.gtc
import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
import glm.detail.{ Quat, Defaultp }

public type fvec1 = Vec1<Float32, Defaultp>
public type fvec2 = Vec2<Float32, Defaultp>
public type fvec3 = Vec3<Float32, Defaultp>
public type fvec4 = Vec4<Float32, Defaultp>

public type dvec1 = Vec1<Float64, Defaultp>
public type dvec2 = Vec2<Float64, Defaultp>
public type dvec3 = Vec3<Float64, Defaultp>
public type dvec4 = Vec4<Float64, Defaultp>

public type ivec2 = Vec2<Int32, Defaultp>
public type ivec3 = Vec3<Int32, Defaultp>
public type ivec4 = Vec4<Int32, Defaultp>
public type uvec2 = Vec2<UInt32, Defaultp>
public type uvec3 = Vec3<UInt32, Defaultp>
public type uvec4 = Vec4<UInt32, Defaultp>

public type i8vec2 = Vec2<Int8, Defaultp>
public type i8vec3 = Vec3<Int8, Defaultp>
public type i8vec4 = Vec4<Int8, Defaultp>
public type u8vec2 = Vec2<UInt8, Defaultp>
public type u8vec3 = Vec3<UInt8, Defaultp>
public type u8vec4 = Vec4<UInt8, Defaultp>

public type i16vec2 = Vec2<Int16, Defaultp>
public type i16vec3 = Vec3<Int16, Defaultp>
public type i16vec4 = Vec4<Int16, Defaultp>
public type u16vec2 = Vec2<UInt16, Defaultp>
public type u16vec3 = Vec3<UInt16, Defaultp>
public type u16vec4 = Vec4<UInt16, Defaultp>

public type i32vec2 = Vec2<Int32, Defaultp>
public type i32vec3 = Vec3<Int32, Defaultp>
public type i32vec4 = Vec4<Int32, Defaultp>
public type u32vec2 = Vec2<UInt32, Defaultp>
public type u32vec3 = Vec3<UInt32, Defaultp>
public type u32vec4 = Vec4<UInt32, Defaultp>

public type i64vec2 = Vec2<Int64, Defaultp>
public type i64vec3 = Vec3<Int64, Defaultp>
public type i64vec4 = Vec4<Int64, Defaultp>
public type u64vec2 = Vec2<UInt64, Defaultp>
public type u64vec3 = Vec3<UInt64, Defaultp>
public type u64vec4 = Vec4<UInt64, Defaultp>

public type hvec1 = Vec1<Float16, Defaultp>
public type hvec2 = Vec2<Float16, Defaultp>
public type hvec3 = Vec3<Float16, Defaultp>
public type hvec4 = Vec4<Float16, Defaultp>

public type fmat2x2 = Mat2x2<Float32, Defaultp>
public type fmat2x3 = Mat2x3<Float32, Defaultp>
public type fmat2x4 = Mat2x4<Float32, Defaultp>
public type fmat3x2 = Mat3x2<Float32, Defaultp>
public type fmat3x3 = Mat3x3<Float32, Defaultp>
public type fmat3x4 = Mat3x4<Float32, Defaultp>
public type fmat4x2 = Mat4x2<Float32, Defaultp>
public type fmat4x3 = Mat4x3<Float32, Defaultp>
public type fmat4x4 = Mat4x4<Float32, Defaultp>
public type fmat2 = fmat2x2
public type fmat3 = fmat3x3
public type fmat4 = fmat4x4

public type dmat2x2 = Mat2x2<Float64, Defaultp>
public type dmat2x3 = Mat2x3<Float64, Defaultp>
public type dmat2x4 = Mat2x4<Float64, Defaultp>
public type dmat3x2 = Mat3x2<Float64, Defaultp>
public type dmat3x3 = Mat3x3<Float64, Defaultp>
public type dmat3x4 = Mat3x4<Float64, Defaultp>
public type dmat4x2 = Mat4x2<Float64, Defaultp>
public type dmat4x3 = Mat4x3<Float64, Defaultp>
public type dmat4x4 = Mat4x4<Float64, Defaultp>
public type dmat2 = dmat2x2
public type dmat3 = dmat3x3
public type dmat4 = dmat4x4

public type fquat = Quat<Float32, Defaultp>
// dquat 与 glm.ext.quaternion_double.cj 已定义的 dquat 名称冲突（Defaultp == PackedHighp，类型实质相同）。
// 当前两文件分属不同包（glm.gtc vs glm.ext），不会触发编译错误。
// R10 更新 lib.cj 时，删除 ext/quaternion_double.cj 的 dquat 定义，统一由此处提供。
public type dquat = Quat<Float64, Defaultp>
public type hquat = Quat<Float16, Defaultp>
