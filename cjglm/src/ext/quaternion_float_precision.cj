package glm.ext
import glm.detail.{ Quat, PackedHighp, PackedMediump, PackedLowp }
public type highp_quat = Quat<Float32, PackedHighp>
public type mediump_quat = Quat<Float32, PackedMediump>
public type lowp_quat = Quat<Float32, PackedLowp>
