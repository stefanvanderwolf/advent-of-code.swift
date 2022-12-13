import AdventOfCode
import Algorithms
import Foundation

struct Comparator: SortComparator {
    var order: SortOrder = .forward

    func compare(_ lhs: Any, _ rhs: Any) -> ComparisonResult {
        if let lhs = lhs as? Int, let rhs = rhs as? Int {
            return lhs.compare(rhs)
        }

        guard let lhs = lhs as? [Any], let rhs = rhs as? [Any] else {
            if let lhs = lhs as? Int {
                return compare([lhs], rhs)
            } else {
                return compare(lhs, [rhs])
            }
        }

        for i in 0 ..< min(lhs.count, rhs.count) {
            let x = compare(lhs[i], rhs[i])
            if x != .orderedSame {
                return x
            }
        }

        return lhs.count.compare(rhs.count)
    }
}

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        let input = Input.Line.input(year: 2022, day: 13)
            .filter { !$0.isEmpty }
            .map {
                try! JSONSerialization.jsonObject(with: $0.data(using: .utf8)!)
            }

        let comparator = Comparator()

        let n1 = input
            .chunks(ofCount: 2)
            .enumerated()
            .filter { comparator.compare($0.element.first!, $0.element.last!) == .orderedAscending }
            .reduce(0) { $0 + $1.offset + 1}

        let dividers: [Any] = [
            [[2]],
            [[6]],
        ]

        let n2 = (input + dividers)
            .sorted(using: comparator)
            .enumerated()
            .filter { e -> Bool in
                dividers.contains {
                    comparator.compare($0, e.element) == .orderedSame
                }
            }
            .map { $0.offset + 1 }
            .product

        return Solution(
            n1: n1,
            n2: n2
        )
    }
}
