import AdventOfCode

@main
public struct Day {
    private static let game: [UInt8] = [65, 67, 66]

    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        Input.Line.input(year: 2022, day: 2)
            .lazy
            .map { (other: $0.first!.asciiValue!, me: $0.last!.asciiValue!) }
            .reduce(into: Solution<Int, Int>(n1: 0, n2: 0)) {
                $0.n1! += play($1.me - 23, against: $1.other)
                $0.n2! += play(game.circular($1.other, direction: 89 - Int($1.me)), against: $1.other)
            }
    }

    public static func play(_ me: UInt8, against opponent: UInt8) -> Int {
        return {
            if opponent == game.circular(me, direction: +1) {
                return 6
            } else if opponent == me {
                return 3
            } else {
                return 0
            }
        }() + (Int(me) - 64)
    }
}

extension Array where Element: Equatable {
    fileprivate func circular(_ element: Element, direction: Int) -> Element {
        let index = firstIndex(of: element)!
        let i = distance(from: startIndex, to: index)

        return self[(i + direction + count) % count]
    }
}
