import AdventOfCode

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve(_ input: some Sequence<(direction: Character, amount: Int)>, knots count: Int) -> Int {
        var knots = [Vector2d.zero] + [Vector2d](repeating: Vector2d.zero, count: count)

        return input
            .reduce(into: Set<Vector2d>()) {
                for _ in 0 ..< $1.amount {
                    switch $1.direction {
                    case "U": knots[0].y += 1
                    case "D": knots[0].y -= 1
                    case "L": knots[0].x -= 1
                    case "R": knots[0].x += 1
                    default: break
                    }

                    for i in (1 ..< knots.count) {
                        let head = knots[i - 1]
                        let tail = knots[i]

                        // Chebyshev distance:
                        let Δx = head.x - tail.x
                        let Δy = head.y - tail.y

                        guard max(abs(Δx), abs(Δy)) >= 2 else {
                            break
                        }

                        knots[i].x += Δx.cmp(0)
                        knots[i].y += Δy.cmp(0)
                    }

                    $0.insert(knots.last!)
                }
            }
            .count
    }

    public static func solve() -> Solution<Int, Int> {
        let input = Input.Line.input(year: 2022, day: 9)
            .map { ($0.first!, Int($0[$0.index($0.startIndex, offsetBy: 2)...])!) }

        return .init(
            n1: solve(input, knots: 1),
            n2: solve(input, knots: 9)
        )
    }
}
