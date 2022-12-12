extension Collection where Element == Int {
    public var gcd: Int {
        reduce(first!) { AdventOfCode.gcd($0, $1) }
    }
}

public func gcd(_ m: Int, _ n: Int) -> Int {
    var t: Int = 0
    var b: Int = max(m, n)
    var r: Int = min(m, n)

    while r != 0 {
        t = b
        b = r
        r = t % b
    }
    return b
}

