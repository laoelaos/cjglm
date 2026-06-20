package glm.detail

public func assert(condition: Bool, message!: String = "Assertion failed"): Unit {
    if (!condition) {
        throw Exception(message)
    }
}
