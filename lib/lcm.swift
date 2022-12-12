extension Collection where Element == Int {
    public var lcm: Int {
        reduce(first!) { AdventOfCode.lcm($0, $1) }
    }
}

public func lcm(_ x: Int, _ y: Int) -> Int {
    return x / gcd(x, y) * y
}
