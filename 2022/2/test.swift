import XCTest

@testable import day

final class DayInputTests: XCTestCase {
    @MainActor func testInput() throws {
        XCTAssertEqual(Day.solve(), .init(n1: 14297, n2: 10498))
    }

    let rock: UInt8 = 65
    let paper: UInt8 = 66
    let scissor: UInt8 = 67

    func testPlay() {
        // Draw
        XCTAssertEqual(Day.play(rock, against: rock), 4)
        XCTAssertEqual(Day.play(paper, against: paper), 5)
        XCTAssertEqual(Day.play(scissor, against: scissor), 6)

        // Lost
        XCTAssertEqual(Day.play(rock, against: paper), 1)
        XCTAssertEqual(Day.play(paper, against: scissor), 2)
        XCTAssertEqual(Day.play(scissor, against: rock), 3)

        // Win
        XCTAssertEqual(Day.play(rock, against: scissor), 7)
        XCTAssertEqual(Day.play(paper, against: rock), 8)
        XCTAssertEqual(Day.play(scissor, against: paper), 9)
    }
}

