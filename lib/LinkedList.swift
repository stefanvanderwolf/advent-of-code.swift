public class LinkedList<Element> {
    public class Node {
        public var value: Element
        public var next: Node?
        public weak var previous: Node?

        public init(_ value: Element) {
            self.value = value
        }
    }

    public var head: Node?
    public var tail: Node?
    public var count = 0

    public init() {}

    public convenience init(_ array: [Element]) {
        self.init()

        array.forEach(append)
    }

    public func append(_ value: Element) {
        append(.init(value))
    }

    public func append(_ node: Node) {
        defer { count += 1 }
        if let tail {
            tail.next = node
            node.previous = tail
            self.tail = node
        } else {
            head = node
            tail = node
        }
    }

    public func insert(_ node: Node, after destination: Node) {
        if tail === destination {
            destination.next = node
            node.previous = destination

            self.tail = node
        } else {
            let next = destination.next

            destination.next = node
            next?.previous = node

            node.previous = destination
            node.next = next

            assert(node.previous != nil)
        }

        count += 1
    }

    public func remove(_ node: Node) {
        if node === tail {
            tail = node.previous
            tail?.next = nil
        } else if node === head {
            head = node.next
            head?.previous = nil
        } else {
            let previous = node.previous
            let next = node.next

            node.previous?.next = next
            node.next?.previous = previous
        }

        node.previous = nil
        node.next = nil

        count -= 1
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var nodes = [Element]()
        var current = head
        while let node = current {
            nodes.append(node.value)
            current = node.next
        }
        return nodes.description
    }
}

extension LinkedList {
    public func first(where fn: (Element) -> Bool) -> Node? {
        var current = head
        while let node = current {
            if fn(node.value) {
                break
            }
            current = node.next
        }

        return current
    }
}
