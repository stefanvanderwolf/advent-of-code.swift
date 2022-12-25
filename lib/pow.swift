import Darwin

public func pow(_ z: Int, _ n: Int) -> Int {
    Int(pow(Double(z), Double(n)))
}
