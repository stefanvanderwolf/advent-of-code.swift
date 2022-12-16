import AdventOfCode

public struct Quadrilateral {
    public var sensor: Point
    public var beacon: Point
    public var distance: Int

    init(sensor: Point, beacon: Point) {
        self.sensor = sensor
        self.beacon = beacon
        distance = sensor.distance(to: beacon)
    }

    func line(at y: Int) -> (lower: Int, upper: Int)? {
        let Δy = distance - abs(sensor.y - y);

        return Δy > 0
            ? (sensor.x - Δy, sensor.x + Δy + 1)
            : nil
    }
}

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    private static let regex = #/x\=(?<x>-?\d+), y\=(?<y>-?\d+)/#

    public static func solve() -> Solution<Int, Int> {
        let y = 2_000_000

        let quadrilaterals = Input.Line.input(year: 2022, day: 15)
            .map { $0.split(separator: ":") }
            .map {
                return (
                    sensor: try! regex.firstMatch(in: $0[0]).map { Point(x: $0.output.x, y: $0.output.y) }!,
                    beacon: try! regex.firstMatch(in: $0[1]).map { Point(x: $0.output.x, y: $0.output.y) }!
                )
            }
            .map { Quadrilateral(sensor: $0.sensor, beacon: $0.beacon) }

        // Find any sensors or beacons that are present on the y line. They
        // shouldn't be counted.
        let excluded = quadrilaterals
            .flatMap { [$0.sensor.y, $0.beacon.y] }
            .filter { $0 == y }
            .asSet()
            .count

        let n1 = quadrilaterals
            .compactMap { $0.line(at: y) }
            .sorted { ($0.lower, $1.upper) < ($1.lower, $1.upper) }
            .reduce(into: (count: -excluded, upper: Int.min)) {
                if $1.upper >= $0.upper {
                    $0.count += $1.upper - max($1.lower, $0.upper)
                    $0.upper = $1.upper
                }
            }
            .count

        let limit = 4_000_000

        var y2 = 0
        var x2 = 0

        for y in 0 ... limit {
            let count = quadrilaterals
                .compactMap { $0.line(at: y) }
                .map { (lower: max(0, $0.lower), upper: min($0.upper, limit)) }
                .sorted { ($0.lower, $1.upper) < ($1.lower, $1.upper) }
                .reduce(into: (count: 0, upper: Int.min)) {
                    if $1.upper >= $0.upper {
                        $0.count += $1.upper - max($1.lower, $0.upper)
                        $0.upper = $1.upper
                    }
                }
                .count

            if count < limit {
                var g = 0
                for x in 0 ... limit {
                    var found = false
                    for quadrilateral in quadrilaterals {
                        guard let range = quadrilateral.line(at: y) else { continue }
                        if x >= range.lower && x < range.upper {
                            found = true
                            break
                        }
                    }

                    if !found {
                        g = x
                        break
                    }
                }

                y2 = y
                x2 = g
            }
        }

        let n2 = x2 * 4_000_000 + y2

        return Solution(n1: n1, n2: n2)
    }
}
