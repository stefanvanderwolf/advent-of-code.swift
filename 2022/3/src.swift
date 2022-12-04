import AdventOfCode
import Algorithms

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static let priority: [Character] =
        [(97...122), (65...90)]
            .flatMap {
                $0.map { Character(UnicodeScalar($0)!) }
            }

    public static func solve() -> Solution<Int, Int> {
        let input = Input.Line.input(year: 2022, day: 3)
            .map { String($0) }

        let n1 = input
            .map { line -> (lowerbound: Set<Character>, upperbound: Set<Character>) in
                let half = line.index(line.startIndex, offsetBy: line.count / 2)

                return (Set(line[..<half]), Set(line[half...]))
            }
            .map {
                $0.0.intersection($0.1)
                    .map { priority.firstIndex(of: $0)! + 1 }
                    .reduce(0, +)
            }
            .reduce(0, +)

        let n2 = input
            .map { Set($0) }
            .chunks(ofCount: 3)
            .map {
                $0.reduce($0.first!) { $0.intersection($1) }
            }
            .map {
                $0
                    .map { priority.firstIndex(of: $0)! + 1 }
                    .reduce(0, +)
            }
            .reduce(0, +)

        return Solution(n1: n1, n2: n2)
    }
}
