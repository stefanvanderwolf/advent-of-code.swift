import AdventOfCode

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<String, Int> {
        Solution(
            n1: Input.Line.input(year: 2022, day: 25)
                .map(\.asInt)
                .reduce(0, +)
                .asSnafu,
            n2: 2022
        )
    }
}

extension String {
    var asInt: Int {
        enumerated()
            .reduce(into: 0) {
                let index = count - $1.offset - 1
                switch $1.element {
                case "=":
                    $0 += -2 * pow(5, index)
                case "-":
                    $0 += -1 * pow(5, index)
                default:
                    $0 += Int($1.element.wholeNumberValue!) * pow(5, index)
                }
            }
    }
}

extension Int {
    var asSnafu: String {
        var result = [String]()
        var n = self
        while n != 0 {
            let remainder = n % 5

            if remainder < 3 {
                result.insert(String(remainder), at: 0)
                n = (n - remainder) / 5
            } else {
                if remainder == 3 {
                    result.insert("=", at: 0)
                } else if remainder == 4 {
                    result.insert("-", at: 0)
                }

                n = (n + (5 - remainder)) / 5
            }
        }
        return result.joined()
    }
}
