import AdventOfCode
import Foundation

typealias Move = (amount: Int, from: Int, to: Int)

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

        return Solution(
            n1: moves
                .reduce(into: stack)
                .compactMap { $0.first }
                .asString(),
            n2: moves
                .reduce(into: stack, reverse: false)
                .compactMap { $0.first }
                .asString()
        )
    }
}

extension Array where Element == Move {
    func reduce(into stack: [[Character]], reverse: Bool = true) -> [[Character]] {
        reduce(into: stack) {
            let range = 0..<$1.amount
            var characters = $0[$1.from][range]
            if reverse {
                characters.reverse()
            }

            $0[$1.from].removeSubrange(range)
            $0[$1.to].insert(contentsOf: characters, at: 0)
        }
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
