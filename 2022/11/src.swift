import AdventOfCode
import Foundation

class Monkey {
    enum Value {
        case old
        case value(Int)

        init(s: String) {
            if s == "old" {
                self = .old
            } else {
                self = .value(Int(s)!)
            }
        }
    }

    struct Test {
        let divisble: Int
        let yes: Int
        let no: Int
    }

    var items: [Int]
    var lhs: Value
    var rhs: Value
    var operation: String
    var test: Test

    init(items: [Int], lhs: Value, rhs: Value, operation: String, test: Test) {
        self.items = items
        self.lhs = lhs
        self.rhs = rhs
        self.operation = operation
        self.test = test
    }
}

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        let input = Input.Group.input(year: 2022, day: 11)
            .map { $0.map { String($0) } }

        let n = [(p: 1, r: 20), (p: 2, r: 10_000)]
            .map {
                play(parse(input), $0.r, $0.p)
            }

        return Solution(n1: n[0], n2: n[1])
    }

    private static func parse(_ input: [[String]]) -> [Monkey] {
        input
            .map {
                let scanner = Scanner(string: $0.joined(separator: "\n"))
                _ = scanner.scanString("Monkey")
                var id: Int = 0
                scanner.scanInt(&id)
                scanner.eat()

                _ = scanner.scanString("Starting items:")
                var items = [Int]()
                var item: Int = 0
                while scanner.scanInt(&item) {
                    items.append(item)
                    _ = scanner.scanString(",")
                }

                _ = scanner.scanString("Operation: new =")

                let components = scanner.scanUpToString("\n")!.split(separator: " ")
                let lhs = Monkey.Value(s: String(components[0]))
                let operation = String(components[1])
                let rhs = Monkey.Value(s: String(components[2]))

                _ = scanner.scanString("Test: divisible by ")
                var divisble: Int = 0
                scanner.scanInt(&divisble)

                _ = scanner.scanString("if true: throw to monkey ")
                var yes = 0
                scanner.scanInt(&yes)

                _ = scanner.scanString("if false: throw to monkey ")
                var no = 0
                scanner.scanInt(&no)

                return Monkey(
                    items: items,
                    lhs: lhs,
                    rhs: rhs,
                    operation: operation,
                    test: .init(divisble: divisble, yes: yes, no: no)
                )
            }
    }

    private static func play(_ monkeys: [Monkey], _ rounds: Int, _ part: Int) -> Int {
        let lcm = monkeys.map { $0.test.divisble }.lcm
        var inspectations = [Int](repeating: 0, count: monkeys.count)

        for _ in 1...rounds {
            for (id, monkey) in monkeys.enumerated() {
                for item in monkey.items {
                    inspectations[id] += 1

                    func value(_ value: Monkey.Value) -> Int {
                        switch value {
                        case .old:
                            return item
                        case .value(let i):
                            return i
                        }
                    }

                    var worry: Int
                    switch monkey.operation {
                    case "*":
                        worry = value(monkey.lhs) * value(monkey.rhs)
                    case "+":
                        worry = value(monkey.lhs) + value(monkey.rhs)
                    default: fatalError()
                    }

                    if part == 1 {
                        worry = worry / 3
                    }

                    let toss = worry % monkey.test.divisble == 0
                        ? monkey.test.yes
                        : monkey.test.no

                    monkeys[toss].items.append(worry % lcm)
                }

                monkeys[id].items = []
            }
        }

        return inspectations.sorted(by: >)[0 ..< 2].product
    }
}
