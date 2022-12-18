public func memoize<Input: Hashable, Output>(_ fn: @escaping ((Input) -> Output, Input) -> Output) -> (Input) -> Output {
    var memo = [Input: Output]()

    func wrap(input: Input) -> Output {
        if let value = memo[input] {
            return value
        }

        let value = fn(wrap, input)
        memo[input] = value
        return value
    }

    return wrap
}
