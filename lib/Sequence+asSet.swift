extension Sequence where Element: Hashable {
    public func asSet() -> Set<Element> {
        Set(self)
    }
}
