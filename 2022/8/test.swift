import XCTest

@testable import day

final class DayInputTests: XCTestCase {
    @MainActor func testInput() throws {
        XCTAssertEqual(Day.solve(), .init(n1: 1538, n2: 496125))
    }
}

