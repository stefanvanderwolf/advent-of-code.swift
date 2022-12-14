import AdventOfCode
import Algorithms

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        let cave = Input.Line.input(year: 2022, day: 14)
            .reduce(into: Set<Vector2d>()) { (cave, line) in
                line.split(separator: " -> ")
                    .map { Vector2d(String($0)) }
                    .windows(ofCount: 2)
                    .forEach {
                        if $0.first!.y == $0.last!.y {
                            for x in min($0.first!.x, $0.last!.x)...max($0.first!.x, $0.last!.x) {
                                cave.insert(.init(x: x, y: $0.first!.y))
                            }
                        } else {
                            for y in min($0.first!.y, $0.last!.y)...max($0.first!.y, $0.last!.y) {
                                cave.insert(.init(x: $0.first!.x, y: y))
                            }
                        }
                    }
            }

        let maxY = cave.max { $0.y < $1.y }!.y

        return Solution(
            n1: simulate(for: cave, abyss: maxY, cmp: <=),
            n2: simulate(for: cave, abyss: maxY + 2, cmp: <)
        )
    }

    private static func simulate(for cave: Set<Vector2d>, abyss: Int, cmp: (Int, Int) -> Bool) -> Int {
        var cave = cave

        for i in 0..<Int.max {
            var sand = Vector2d(x: 500, y: 0)

            guard !cave.contains(sand) else {
                return i
            }

            while !cave.contains(sand) {
                let below = sand + .init(x: 0, y: 1)
                let left = sand + .init(x: -1, y: 1)
                let right = sand + .init(x: 1, y: 1)

                guard below.y <= abyss else {
                    return i
                }

                if !cave.contains(below) && cmp(below.y, abyss) {
                    sand = below
                } else if !cave.contains(left) && cmp(below.y, abyss) {
                    sand = left
                } else if !cave.contains(right) && cmp(below.y, abyss) {
                    sand = right
                } else {
                    cave.insert(sand)
                }
            }
        }

        return -1
    }
}
