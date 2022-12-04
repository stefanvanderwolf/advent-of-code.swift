extension ClosedRange {
    public func includes(_ other: Self) -> Bool {
        contains(other.lowerBound) && contains(other.upperBound)
    }
}
