import AdventOfCode
import Collections
import Algorithms

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        var heightmap = Input.Line.input(year: 2022, day: 12)
            .map { Array($0.utf8) }

        let start: Vector2d = heightmap.enumerated().firstNonNil {
            guard let index = $0.element.firstIndex(of: UInt8(ascii:"S")) else {
                return nil
            }

            return Vector2d(x: index, y: $0.offset)
        }!

        let end: Vector2d = heightmap.enumerated().firstNonNil {
            guard let index = $0.element.firstIndex(of: UInt8(ascii:"E")) else {
                return nil
            }

            return Vector2d(x: index, y: $0.offset)
        }!

        heightmap[start.y][start.x] = ("a" as Character).asciiValue!

        let n1 = bfs(from: start, to: UInt8(ascii:"E"), map: heightmap) { $0 <= $1 + 1 }
        let n2 = bfs(from: end, to: UInt8(ascii:"a"), map: heightmap) { $0 >= $1 - 1 }

        return Solution(n1: n1, n2: n2)
    }

    private static func bfs(
        from source: Vector2d,
        to destination: UInt8,
        map: [[UInt8]],
        isAccessible: (UInt8, UInt8) -> Bool
    ) -> Int {
        var visited = Set<Vector2d>()
        var points = Deque([(dist: 0, point: source)])

        while let e = points.popFirst() {
            let value = map[e.point.y][e.point.x]

            if value == destination {
                return e.dist
            }

            if !visited.contains(e.point) {
                visited.insert(e.point)

                for around in Vector2d.neighbours {
                    let check = e.point + around

                    if let neighbour = map[safe: check.y]?[safe: check.x], isAccessible(neighbour, value) {
                        points.append((e.dist + 1, check))
                    }
                }
            }
        }

        return 0
    }
}
