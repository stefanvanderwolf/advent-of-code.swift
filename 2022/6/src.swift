import AdventOfCode
import Algorithms

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        let input = Input.Char.input(year: 2022, day: 6)
            .map { String($0) }

        func sequence(ofSize size: Int) -> Int {
            input
                .windows(ofCount: size)
                .enumerated()
                .first { Set($0.element).count == size }!
                .offset + size
        }

        return Solution<Int, Int>(
            n1: sequence(ofSize: 4),
            n2: sequence(ofSize: 14)
        )
    }
}
