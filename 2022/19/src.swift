import AdventOfCode
import Algorithms
import Collections
import RegexBuilder
import Foundation

typealias Current = UInt64

extension Current {
    var id: UInt64 {
        set { self = set(from: 58, till: 64, value: newValue) }
        get { val(from: 58, till: 64) }
    }

    var minute: UInt64 {
        set { self = set(from: 52, till: 59, value: newValue) }
        get { val(from: 52, till: 59) }
    }

    var geodeRobots: UInt64 {
        set { self = set(from: 46, till: 53, value: newValue) }
        get { val(from: 46, till: 53) }
    }

    var obsidianRobots: UInt64 {
        set { self = set(from: 40, till: 47, value: newValue) }
        get { val(from: 40, till: 47) }
    }

    var clayRobots: UInt64 {
        set { self = set(from: 34, till: 41, value: newValue) }
        get { val(from: 34, till: 41) }
    }

    var oreRobots: UInt64 {
        set { self = set(from: 28, till: 35, value: newValue) }
        get { val(from: 28, till: 35) }
    }

    var geode: UInt64 {
        set { self = set(from: 21, till: 29, value: newValue) }
        get { val(from: 21, till: 29) }
    }

    var obsidian: UInt64 {
        set { self = set(from: 14, till: 22, value: newValue) }
        get { val(from: 14, till: 22) }
    }

    var clay: UInt64 {
        set { self = set(from: 7, till: 15, value: newValue) }
        get { val(from: 7, till: 15) }
    }

    var ore: UInt64 {
        set { self = set(from: 0, till: 8, value: newValue) }
        get { val(from: 0, till: 8) }
    }

    func toggle(from: UInt8, till: UInt8) -> UInt64 {
        return self ^ ((((1 << from) - 1) ^ ((1 << (till - 1)) - 1)))
    }

    func unset(from: UInt8, till: UInt8) -> UInt64 {
        self & UInt64.max.toggle(from: from, till: till)
    }

    func set(from: UInt8, till: UInt8, value: UInt64) -> UInt64 {
        self.unset(from: from, till: till) | (value << from)
    }

    func val(from: UInt8, till: UInt8) -> UInt64 {
        return (self >> from) & ((1 << ((till - from) - 1)) - 1)
    }
}

enum Resource {
    case ore
    case clay
    case obsidian
}

struct Material {
    var resource: Resource
    var amount: Int
}

struct Blueprint {
    var id: Int
    var ore: Material
    var clay: Material
    var obsidian: [Material]
    var geode: [Material]
}


@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<UInt64, UInt64> {
        let blueprints = Input.Line.input(year: 2022, day: 19)
            .map {
                $0.matches(of: Regex {
                    Capture {
                        OneOrMore(.digit)
                    }
                })
            }
            .map {
                Blueprint(
                    id: Int($0[0].output.1)!,
                    ore: .init(resource: .ore, amount: Int($0[1].output.1)!),
                    clay: .init(resource: .ore, amount: Int($0[2].output.1)!),
                    obsidian: [.init(resource: .ore, amount: Int($0[3].output.1)!), .init(resource: .clay, amount: Int($0[4].output.1)!)],
                    geode: [.init(resource: .ore, amount: Int($0[5].output.1)!), .init(resource: .obsidian, amount: Int($0[6].output.1)!)]
                )
            }

        func execute(execute: (Current) -> UInt64, state: Current) -> UInt64 {
            guard state.minute != 0 else {
                return state.geode
            }

            func collect(into state: inout Current) {
                state.ore += state.oreRobots
                state.clay += state.clayRobots
                state.obsidian += state.obsidianRobots
                state.geode += state.geodeRobots
            }

            let blueprint = blueprints[Int(state.id)]

            var geode = state.geode

            if state.ore >= blueprint.geode[0].amount && state.obsidian >= blueprint.geode[1].amount {
                var state = state
                state.ore -= UInt64(blueprint.geode[0].amount)
                state.obsidian -= UInt64(blueprint.geode[1].amount)
                collect(into: &state)
                state.geodeRobots += 1
                state.minute -= 1
                geode = max(geode, execute(state))
            } else {
                if state.ore >= blueprint.obsidian[0].amount && state.clay >= blueprint.obsidian[1].amount {
                    var state = state
                    state.ore -= UInt64(blueprint.obsidian[0].amount)
                    state.clay -= UInt64(blueprint.obsidian[1].amount)
                    collect(into: &state)
                    state.obsidianRobots += 1
                    state.minute -= 1
                    geode = max(geode, execute(state))
                }

                if state.ore >= blueprint.clay.amount && (state.clayRobots < blueprint.obsidian[1].amount) {
                    var state = state
                    state.ore -= UInt64(blueprint.clay.amount)
                    collect(into: &state)
                    state.clayRobots += 1
                    state.minute -= 1
                    geode = max(geode, execute(state))
                }

                if state.ore >= blueprint.ore.amount &&
                    (state.oreRobots < blueprint.clay.amount || state.oreRobots < blueprint.obsidian[0].amount || state.oreRobots < blueprint.geode[0].amount) {
                    var state = state
                    state.ore -= UInt64(blueprint.ore.amount)
                    collect(into: &state)
                    state.oreRobots += 1
                    state.minute -= 1
                    geode = max(geode, execute(state))
                }

                var new = state
                collect(into: &new)
                new.minute -= 1

                geode = max(geode, execute(new))
            }

            return geode
        }

        let n1 = blueprints
            .map { blueprint -> UInt64 in
                let executor = memoize { (fn, state: Current) in
                    execute(execute: fn, state: state)
                }

                var state: Current = 0
                state.id = UInt64(blueprint.id) - UInt64(1)
                state.oreRobots = 1
                state.minute = 24

                return executor(state) * UInt64(blueprint.id)
            }
            .max()!

        let n2 = blueprints[0..<3]
            .map { blueprint -> UInt64 in
                let executor = memoize { (fn, state: Current) in
                    execute(execute: fn, state: state)
                }

                var state: Current = 0
                state.id = UInt64(blueprint.id) - UInt64(1)
                state.oreRobots = 1
                state.minute = 32

                return executor(state)
            }
            .reduce(1, *)

        return Solution(n1: n1, n2: n2)
    }
}
