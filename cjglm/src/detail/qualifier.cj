package glm.detail

public interface Qualifier {}

public struct PackedHighp <: Qualifier {}
public struct PackedMediump <: Qualifier {}
public struct PackedLowp <: Qualifier {}

internal struct AlignedHighp <: Qualifier {}
internal struct AlignedMediump <: Qualifier {}
internal struct AlignedLowp <: Qualifier {}

public type Defaultp = PackedHighp
