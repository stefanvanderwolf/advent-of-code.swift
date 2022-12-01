import Foundation

public enum Input {
    public enum Group {
        public static func input(
            year: Int,
            day: Int
        ) -> AnyIterator<[String]> {
            #if DEBUG
                return read(fopen(path(year, day), "r")!)
            #else
                return read(stdin)
            #endif
        }

        fileprivate static func read(
            _ ptr: UnsafeMutablePointer<FILE>
        ) -> AnyIterator<[String]> {
            .init {
                let lines = Line.read(ptr)
                    .prefix { !$0.isEmpty }

                return !lines.isEmpty
                    ? lines
                    : nil
            }
        }
    }

    public enum Line {
        public static func input(
            year: Int,
            day: Int
        ) -> AnyIterator<String> {
            #if DEBUG
                return read(fopen(path(year, day), "r")!)
            #else
                return read(stdin)
            #endif
        }

        fileprivate static func read(
            _ ptr: UnsafeMutablePointer<FILE>
        ) -> AnyIterator<String> {
            .init {
                let result = String(Char.read(ptr))
                return feof(ptr) == 0 ? result : nil
            }
        }
    }

    public enum Char {
        public static func input(
            year: Int,
            day: Int
        ) -> AnyIterator<Character> {
            #if DEBUG
                return read(fopen(path(year, day), "r")!)
            #else
                return read(stdin)
            #endif
        }

        fileprivate static func read(
            _ ptr: UnsafeMutablePointer<FILE>
        ) -> AnyIterator<Character> {
            .init {
                let ch = fgetc(ptr)
                guard ch != EOF, let unicode = UnicodeScalar(UInt32(ch)) else {
                    return nil
                }

                let character = Character(unicode)

                return !character.isNewline ? character : nil
            }
        }
    }

    private static func path(_ year: Int, _ day: Int) -> String {
        let home = ProcessInfo.processInfo.environment["HOME"]!
        return "\(home)/git/advent-of-code.swift/\(year)/\(day)/input.in"
    }
}
