import XCTest

@testable import day

final class DayInputTests: XCTestCase {
    @MainActor func testInput() throws {
        XCTAssertEqual(Day.solve(), .init(n1: "2-2=12=1-=-1=000=222", n2: 2022))
    }
}

