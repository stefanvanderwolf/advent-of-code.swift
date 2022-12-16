public typealias Point = SIMD2<Int>

extension Point {
    public init(x: some StringProtocol, y: some StringProtocol) {
        self.init(x: Int(x)!, y: Int(y)!)
    }
}

extension Point {
    public func distance(to point: Point) -> Int {
        return abs(x - point.x) + abs(y - point.y)
    }
}
