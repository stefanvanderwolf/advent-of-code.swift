import AdventOfCode
import Algorithms
import Foundation

func cmp(_ lhs: Any, _ rhs: Any) -> Int {
    if let lhs = lhs as? Int, let rhs = rhs as? Int {
        return lhs.cmp(rhs)
    }

    guard let lhs = lhs as? [Any], let rhs = rhs as? [Any] else {
        if let lhs = lhs as? Int {
            return cmp([lhs], rhs)
        } else {
            return cmp(lhs, [rhs])
        }
    }

    for i in 0 ..< min(lhs.count, rhs.count) {
        let x = cmp(lhs[i], rhs[i])
        if x != 0 {
            return x
        }
    }

    return lhs.count.cmp(rhs.count)
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

        let n1 = input
            .chunks(ofCount: 2)
            .enumerated()
            .filter { cmp($0.element.first!, $0.element.last!) == -1 }
            .reduce(0) { $0 + $1.offset + 1}

        let dividers: [Any] = [
            [[2]],
            [[6]],
        ]

        let n2 = (input + dividers)
            .sorted { cmp($0, $1) < 0 }
            .enumerated()
            .filter { e -> Bool in
                dividers.contains {
                    cmp($0, e.element) == 0
                }
            }
            .map { $0.offset + 1 }
            .product

        return Solution(n1: n1, n2: n2)
    }
}
