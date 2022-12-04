import Foundation

extension Scanner {
    public func scanRange() -> ClosedRange<Int> {
        var x: Int = 0
        var y: Int = 0
        scanInt(&x)
        _ = scanCharacter()
        scanInt(&y)

        return x...y
    }

    public func eat() {
        _ = scanCharacter()
    }
}
