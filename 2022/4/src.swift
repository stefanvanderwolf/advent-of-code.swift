import AdventOfCode
import Foundation

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        Input.Line.input(year: 2022, day: 4)
            .lazy
            .map {
                let scanner = Scanner(string: $0)
                let x = scanner.scanRange()
                scanner.eat()
                let y = scanner.scanRange()

                return (x, y)
            }
            .reduce(into: Solution(n1: 0, n2: 0)) {
                $0.n1! += ($1.0.includes($1.1) || $1.1.includes($1.0)).int
                $0.n2! += ($1.0.overlaps($1.1) || $1.1.overlaps($1.0)).int
            }
    }
}
