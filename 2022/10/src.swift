import AdventOfCode

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, String> {
        let instructions = Input.Line.input(year: 2022, day: 10).map { String($0) }

        var n1 = 0

        let measurements = [20, 60, 100, 140, 180, 220]
        var screen = [[Character]](repeating: [Character](repeating: " ", count: 40), count: 6)

        var register = 1
        var cycle = 0
        var i = 0
    outer:
        while cycle != measurements.last! {
            defer { i  += 1 }

            let index = (i + instructions.count) % instructions.count
            let instruction = instructions[index]
            let components = instruction.split(separator: " ")

            let addition = components[0] == "addx" ? Int(components[1...].joined())! : 0
            let time = components[0] == "addx" ? 2 : 1

            for _ in 0 ..< time {
                cycle += 1

                if measurements.contains(cycle) {
                    n1 += cycle * register
                }

                let x1 = max(0, (cycle % 40) - 1)
                let y1 = cycle / 40

                if ((register - 1) ... (register + 1)).contains(x1) {
                    screen[y1][x1] = "█"
                }

                if cycle == 240 {
                    break outer
                }
            }

            register += addition
        }

        return Solution(
            n1: n1,
            n2: "\n" + screen.map { String($0) }.joined(separator: "\n")
        )
    }
}
