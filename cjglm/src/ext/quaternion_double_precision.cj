package glm.ext
import glm.detail.{ Quat, PackedHighp, PackedMediump, PackedLowp }
public type highp_dquat = Quat<Float64, PackedHighp>
public type mediump_dquat = Quat<Float64, PackedMediump>
public type lowp_dquat = Quat<Float64, PackedLowp>
