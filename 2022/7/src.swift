import AdventOfCode

fileprivate extension TreeNode where T == Element {
    var isDirectory: Bool {
        switch value {
        case .dir:
            return true
        case .file:
            return false
        }
    }

    var size: Int {
        switch value {
        case .dir:
            return children.reduce(0) { $0 + $1.size }
        case .file(let file):
            return file.size
        }
    }
}

fileprivate enum Element: Equatable {
    struct File: Equatable {
        var name: String
        var size: Int
    }

    case dir(String)
    case file(File)
}

@main
public struct Day {
    public static func main() {
        solve().print()
    }

    public static func solve() -> Solution<Int, Int> {
        let root = TreeNode<Element>(.dir("/"))
        var current = root

        Input.Line.input(year: 2022, day: 7)
            .forEach {
                let components = $0.split(separator: " ")

                if $0.starts(with: "$") {
                    if $0 == "$ cd /" {
                        current = root
                    } else if $0.starts(with: "$ cd") {
                        current = components[2] == ".."
                            ? current.parent!
                            : current.children.first {
                                $0.isDirectory && $0.value == Element.dir(String(components[2]))
                            }!
                    }
                } else {
                    let child: TreeNode<Element> = components[0] == "dir"
                        ? .init(.dir(String(components[1])), parent: current)
                        : .init(.file(.init(name: String(components[1]), size: Int(components[0])!)), parent: current)
                    current.children.append(child)
                }
            }

        var sizes = [Int]()
        root.forEach {
            if $0.isDirectory {
                sizes.append($0.size)
            }
        }

        let n1 = sizes.filter { $0 < 100_000 }.reduce(0, +)

        let unused = 70_000_000 - root.size
        let needed = 30_000_000 - unused
        let n2 = sizes.filter { $0 > needed }.min()

        return Solution(n1: n1, n2: n2)
    }
}
