extension Collection where Element == Int {
    public var product: Int {
        reduce(1, *)
    }
}
