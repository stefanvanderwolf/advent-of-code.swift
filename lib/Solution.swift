public struct Solution<N1: Answer, N2: Answer> {
    public var n1: N1?
    public var n2: N2?

    public init(n1: N1? = nil, n2: N2? = nil) {
        self.n1 = n1
        self.n2 = n2
    }
}

extension Solution: Equatable where N1: Equatable, N2: Equatable {}

extension Solution: CustomStringConvertible {
    public var description: String {
        return """
            n1 \(n1?.description ?? "???")
            n2 \(n2?.description ?? "???")
            """
    }
}
