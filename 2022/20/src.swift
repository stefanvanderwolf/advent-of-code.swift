import AdventOfCode

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func mixing(_ list: LinkedList<(offset: Int, element: Int)>, count: Int = 1) -> Int {
        let map = {
            var map = [Int: LinkedList<(offset: Int, element: Int)>.Node]()
            var current = list.head
            while let node = current {
                map[node.value.offset] = node
                current = node.next
            }
            return map
        }()

        func cycle(from node: LinkedList<(offset: Int, element: Int)>.Node, count: Int) -> LinkedList<(offset: Int, element: Int)>.Node? {
            var current: LinkedList<(offset: Int, element: Int)>.Node? = node
            for i in 0 ..< Int.max {
                if abs(count) == i {
                    break
                }

                current = count > 0
                    ? (node.next ?? list.head!)
                    : (node.previous ?? list.tail!)
            }

            return current
        }

        for _ in 0 ..< count {
            for i in 0 ..< list.count {
                let node = map[i]!
                let previous = node.previous ?? list.tail!

                list.remove(node)
                let after = cycle(from: previous, count: node.value.element % list.count)!
                list.insert(node, after: after)
            }
        }

        return [Int](repeating: 1000, count: 3)
            .reduce(into: (n: 0, node: list.first(where: { $0.element == 0 })!)) {
                $0.node = cycle(from: $0.node, count: $1)!
                $0.n += $0.node.value.element
            }
            .n
    }

    public static func solve() -> Solution<Int, Int> {
        let numbers = Input.Line.input(year: 2022, day: 20)
            .map { Int($0)! }

        return Solution(
            n1: mixing(LinkedList(numbers
                .map { $0 }
                .enumerated()
                .map { $0 })),
            n2: mixing(LinkedList(numbers
                .map { $0  * 811589153 }
                .enumerated()
                .map { $0 }), count: 10)
        )
    }
}
