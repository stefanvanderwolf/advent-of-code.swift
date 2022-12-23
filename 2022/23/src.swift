import AdventOfCode
import Algorithms

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    private static let N = Vector2d(x: +0, y: -1)
    private static let NW = Vector2d(x: -1, y: -1)
    private static let NE = Vector2d(x: +1, y: -1)
    private static let W = Vector2d(x: -1, y: +0)
    private static let E = Vector2d(x: +1, y: +0)
    private static let SW = Vector2d(x: -1, y: +1)
    private static let S = Vector2d(x: +0, y: +1)
    private static let SE = Vector2d(x: +1, y: +1)
    private static let all = [
        N, NW, NE, W, E, SW, S, SE,
    ]

    private static let directions = [
        [N, NE, NW, N],
        [S, SE, SW, S],
        [W, NW, SW, W],
        [E, NE, SE, E],
    ]

    public static func rounds(_ count: Int, elfs: Set<Vector2d>) -> (elfs: Set<Vector2d>, round: Int) {
        var elfs = elfs

        for round in 0 ... count {
            let propositions = elfs
                .filter { elf in
                    all
                        .map { elf + $0 }
                        .contains {
                            elfs.contains($0)
                        }
                }
                .reduce(into: [Vector2d: [Vector2d]]()) { propositions, elf in
                    for i in 0 ..< directions.count {
                        let index = (round + i + directions.count) % directions.count
                        let positions = directions[index].dropLast(1)
                        let proposes = directions[index].last!

                        let available = positions
                            .map { elf + $0 }
                            .allSatisfy {
                                !elfs.contains($0)
                            }

                        if available {
                            propositions[elf + proposes, default: []].append(elf)
                            break
                        }
                    }
                }

            if propositions.isEmpty {
                return (elfs, round + 1)
            }

            propositions
                .filter { $0.value.count == 1 }
                .forEach {
                    elfs.remove($0.value[0])
                    elfs.insert($0.key)
                }
        }

        return (elfs, -1)
    }

    public static func solve() -> Solution<Int, Int> {
        let elfs = Input.Line.input(year: 2022, day: 23)
            .enumerated()
            .reduce(into: Set<Vector2d>()) { (positions, element) in
                element
                    .element
                    .enumerated()
                    .filter { $0.element == "#" }
                    .forEach {
                        positions.insert(.init(x: $0.offset, y: element.offset))
                    }
            }

        return Solution(
            n1: rounds(10, elfs: elfs).elfs.tiles,
            n2: rounds(Int.max, elfs: elfs).round
        )
    }
}

extension Set where Element == Vector2d {
    var tiles: Int {
        let (minX, maxX) = map { $0.x }.minAndMax(by: <)!
        let (minY, maxY) = map { $0.y }.minAndMax(by: <)!

        return (maxY - minY + 1) * (maxX - minX + 1) - count
    }
}
