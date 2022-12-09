import XCTest

@testable import day

final class DayInputTests: XCTestCase {
    @MainActor func testInput() throws {
        XCTAssertEqual(Day.solve(), .init(n1: 6406, n2: 2643))
    }
}

