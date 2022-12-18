import AdventOfCode

struct Valve: Hashable {
    let id: String
    let rate: Int
    let tunnels: [String]
}

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    private static let regex = #/Valve (?<id>\w+) has flow rate\=(?<rate>\d+); tunnel[s]? lead[s]? to valve[s]? (?<tunnels>((\w+)(?:,\s*|$))+)/#

    public static func solve() -> Solution<Int, Int> {
        let valves = Input.Line.input(year: 2022, day: 16)
            .map { try! regex.firstMatch(in: $0)!.output }
            .map {
                Valve(
                    id: String($0.id),
                    rate: Int($0.rate)!,
                    tunnels: $0.tunnels.split(separator: ", ").map { String($0) }
                )
            }
            .reduce(into: [String: Valve]()) { $0[$1.id] = $1 }

        struct State: Hashable {
            var from: String
            var opened: Set<String>
            var minute: Int
            var elephant: Bool
        }

        let walk = memoize { (walk, state: State) in
            guard state.minute != 0 else {
                return state.elephant
                    ? walk(.init(from: "AA", opened: state.opened, minute: 26, elephant: false))
                    : 0
            }

            let valve = valves[state.from]!

            var pressure = Int.min

            for tunnel in valve.tunnels {
                var new = state
                new.minute -= 1
                new.from = tunnel
                pressure = max(pressure, walk(new))
            }

            if !state.opened.contains(state.from) && valve.rate != 0 {
                var new = state
                new.minute -= 1
                new.opened = new.opened.union([state.from])

                pressure = max(pressure, (state.minute - 1) * valve.rate + walk(new))
            }

            return pressure
        }

        return Solution(
            n1: walk(State(from: "AA", opened: [], minute: 30, elephant: false)),
            n2: walk(State(from: "AA", opened: [], minute: 26, elephant: true))
        )
    }
}
