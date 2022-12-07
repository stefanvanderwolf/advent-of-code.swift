public class TreeNode<T> {
    public var value: T
    public var children = [TreeNode<T>]()
    public weak var parent: TreeNode<T>?

    public init(_ value: T, parent: TreeNode<T>? = nil) {
        self.value = value
        self.parent = parent
    }

    public func forEach(_ fn: (TreeNode<T>) -> Void) {
        fn(self)
        children
            .forEach {
                $0.forEach(fn)
            }
    }
}
