import AdventOfCode
import Algorithms
import Collections

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        var max = Vector2d.zero
        let matrix = Input.Line.input(year: 2022, day: 8)
            .enumerated()
            .reduce(into: [Vector2d: Int]()) { matrix, tuple in
                max.y += 1
                max.x = 0

                tuple.element
                    .enumerated()
                    .forEach {
                        max.x += 1
                        matrix[Vector2d(x: $0.offset, y: tuple.offset)] = $0.element.wholeNumberValue!
                    }
            }

        var n1 = (max.y * 2) + (max.x * 2) - 4
        for y in 1..<(max.y - 1) {
            for x in 1..<(max.x - 1) {
                let current = Vector2d(x: x, y: y)

                func isVisible(_ vectors: [Vector2d]) -> Bool {
                    vectors.allSatisfy { matrix[$0]! < matrix[current]! }
                }

                if isVisible(Vector2d.horizontal(from: 0, to: current.x - 1, on: current.y))
                    || isVisible(Vector2d.horizontal(from: current.x + 1, to: max.x - 1, on: current.y))
                    || isVisible(Vector2d.vertical(from: 0, to: current.y - 1, on: current.x))
                    || isVisible(Vector2d.vertical(from: current.y + 1, to: max.y - 1, on: current.x)) {
                    n1 += 1
                }
            }
        }

        var n2 = 0
        for y in 1..<(max.y - 1) {
            for x in 1..<(max.x - 1) {
                let current = Vector2d(x: x, y: y)

                func score(_ vectors: [Vector2d]) -> Int {
                    var n = 0
                    for vector in vectors {
                        n += 1

                        if matrix[vector]! >= matrix[current]! {
                            break
                        }
                    }

                    return n
                }

                n2 = Swift.max(
                    score(Vector2d.horizontal(from: 0, to: current.x - 1, on: current.y).reversed())
                    * score(Vector2d.horizontal(from: current.x + 1, to: max.x - 1, on: current.y))
                    * score(Vector2d.vertical(from: 0, to: current.y - 1, on: current.x).reversed())
                    * score(Vector2d.vertical(from: current.y + 1, to: max.y - 1, on: current.x)),
                    n2
                )
            }
        }

        return Solution(n1: n1, n2: n2)
    }
}
