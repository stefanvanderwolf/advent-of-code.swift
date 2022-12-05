import AdventOfCode
import Foundation

struct Move {
    var amount: Int
    var from: Int
    var to: Int
}

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<String, String> {
        let components = Input.Group.input(year: 2022, day: 5)
            .map { Array($0) }

        let stack = components[0]
            .dropLast(1)
            .reduce(into: [[Character]](repeating: [Character](), count: 10)) {
                let scanner = Scanner(string: $1)
                scanner.charactersToBeSkipped = nil

                for i in 1...9 {
                    scanner.eat()
                    let character = scanner.scanCharacter()
                    scanner.eat()
                    scanner.eat()

                    if let character, !character.isWhitespace {
                        $0[i].append(character)
                    }
                }
            }

        let moves = components[1]
            .map { Scanner(string: $0).scanMove() }

        let n1 = moves
            .reduce(into: stack) {
                for _ in 1...$1.amount {
                    var contents = $0[$1.from]
                    let character = contents.removeFirst()


                    $0[$1.from] = contents
                    $0[$1.to].insert(character, at: 0)
                }
            }
            .compactMap { $0.first }

        let n2 = moves
            .reduce(into: stack) {
                let range = 0..<$1.amount
                let characters = $0[$1.from][range]

                $0[$1.from].removeSubrange(range)
                $0[$1.to].insert(contentsOf: characters, at: 0)
            }
            .compactMap { $0.first }

        
        return Solution(n1: String(n1), n2: String(n2))
    }
}

extension Scanner {
    fileprivate func scanMove() -> Move {
        var move = Move(amount: 0, from: 0, to: 0)
        _ = scanString("move")
        scanInt(&move.amount)
        _ = scanString("from")
        scanInt(&move.from)
        _ = scanString("to")
        scanInt(&move.to)

        return move
    }
}
