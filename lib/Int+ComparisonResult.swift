import Foundation

extension Int {
    public func compare(_ other: Int) -> ComparisonResult {
        guard self != other else {
            return .orderedSame
        }

        return self < other ? .orderedAscending : .orderedDescending
    }
}
