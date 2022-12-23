import AdventOfCode

typealias Name = String

enum Job {
    case number(Int)
    case operation(Name, String, Name)
}

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    private static func part1(_ name: Name, _ monkeys: [Name: Job]) -> Int {
        switch monkeys[name]! {
        case .number(let n):
            return n
        case .operation(let lhs, let operation, let rhs):
            let i = part1(lhs, monkeys)
            let j = part1(rhs, monkeys)

            switch operation {
            case "+": return i + j
            case "-": return i - j
            case "*": return i * j
            case "/": return i / j
            default: fatalError("Invalid operation")
            }
        }
    }

    private static func part2(_ monkeys: [Name: Job], me: String = "humn") -> Int {
        func find(_ name: String) -> Bool {
            if name == me {
                return true
            }

            switch monkeys[name]! {
            case .number: break
            case .operation(let lhs, _, let rhs):
                if find(lhs) || find(rhs) {
                    return true
                }
            }

            return false
        }

        func resolve(_ name: Name, _ result: Int) -> Int {
            switch monkeys[name]! {
            case .number:
                return result
            case .operation(let lhs, let operation, let rhs):
                if find(lhs) {
                    let value = part1(rhs, monkeys)
                    let new: Int = {
                        switch operation {
                        case "+": return result - value
                        case "-": return result + value
                        case "*": return result / value
                        case "/": return result * value
                        default: fatalError("Invalid operation")
                        }
                    }()

                    return resolve(lhs, new)
                } else {
                    let value = part1(lhs, monkeys)
                    let new: Int = {
                        switch operation {
                        case "+": return result - value
                        case "-": return value - result
                        case "*": return result / value
                        case "/": return value / result
                        default: fatalError("Invalid operation")
                        }
                    }()

                    return resolve(rhs, new)
                }
            }

        }

        switch monkeys["root"]! {
        case .number(let i):
            return i
        case .operation(let lhs, _, let rhs):
            let value: Int
            let other: Name
            if find(lhs) {
                value = part1(rhs, monkeys)
                other = lhs
            } else {
                value = part1(lhs, monkeys)
                other = rhs
            }

            return resolve(other, value)
        }
    }

    public static func solve() -> Solution<Int, Int> {
        let monkeys = Input.Line.input(year: 2022, day: 21)
            .reduce(into: [Name: Job]()) {
                let components = $1.split(separator: ":")
                let name = String(components[0])
                let other = components[1].split(separator: " ")
                if other.count == 1 {
                    $0[name] = .number(Int(other.first!)!)
                } else {
                    $0[name] = .operation(String(other[0]), String(other[1]), String(other[2]))
                }
            }

        return Solution(
            n1: part1("root", monkeys),
            n2: part2(monkeys)
        )
    }
}
