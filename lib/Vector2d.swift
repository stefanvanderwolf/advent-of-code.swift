public struct Vector2d {
    public var x: Int
    public var y: Int

    public init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }
}

extension Vector2d: Hashable {}
extension Vector2d: Equatable {}

extension Vector2d {
    public static let zero = Vector2d(x: 0, y: 0)
}

extension Vector2d {
    public static let neighbours = [
        Vector2d(x: +1, y: 0),
        Vector2d(x: -1, y: 0),
        Vector2d(x: 0, y: +1),
        Vector2d(x: 0, y: -1)
    ]
}

extension Vector2d {
    public static func +=(lhs: inout Vector2d, rhs: Vector2d) {
        lhs = lhs + rhs
    }

    public static func +(lhs: Vector2d, rhs: Vector2d) -> Vector2d {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func -=(lhs: inout Vector2d, rhs: Vector2d) {
        lhs = lhs - rhs
    }

    public static func -(lhs: Vector2d, rhs: Vector2d) -> Vector2d {
        .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

extension Vector2d {
    public static func horizontal(from x1: Int, to x2: Int, on y: Int) -> [Vector2d] {
        (x1...x2).map { Vector2d(x: $0, y: y) }
    }

    public static func vertical(from y1: Int, to y2: Int, on x: Int) -> [Vector2d] {
        (y1...y2).map { Vector2d(x: x, y: $0) }
    }
}
