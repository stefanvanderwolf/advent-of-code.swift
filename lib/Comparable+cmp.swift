extension Comparable {
    public func cmp(_ rhs: Self) -> Int {
        if self < rhs { return -1 }
        if self > rhs { return 1 }
        return 0
    }
}
