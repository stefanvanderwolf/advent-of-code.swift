import XCTest

@testable import day

final class DayInputTests: XCTestCase {
    @MainActor func testInput() throws {
        XCTAssertEqual(Day.solve(), .init(n1: 72664227897438, n2: 3916491093817))
    }
}

