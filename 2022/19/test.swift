import XCTest

@testable import day

final class DayInputTests: XCTestCase {
    @MainActor func testInput() throws {
        XCTAssertEqual(Day.solve(), .init(n1: 0, n2: 0))
    }
}

