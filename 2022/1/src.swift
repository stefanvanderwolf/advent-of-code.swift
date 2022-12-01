import AdventOfCode
import Algorithms

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        let calories = Input.Group.input(year: 2022, day: 1)
            .lazy
            .map { $0.compactMap { Int($0) }.reduce(0, +) }
            .max(count: 3, sortedBy: <)

        return Solution(n1: calories.last, n2: calories.reduce(0, +))
    }
}
