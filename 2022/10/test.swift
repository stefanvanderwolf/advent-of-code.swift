import XCTest

@testable import day

final class DayInputTests: XCTestCase {
    @MainActor func testInput() throws {
        let n2 = """

        ███  ████ ███   ██  ████ ████   ██ ███  
        █  █    █ █  █ █  █    █ █       █ █  █ 
        █  █   █  ███  █      █  ███     █ ███  
        ███   █   █  █ █ ██  █   █       █ █  █ 
        █    █    █  █ █  █ █    █    █  █ █  █ 
        █    ████ ███   ███ ████ ████  ██  ███  
        """
        XCTAssertEqual(Day.solve(), .init(n1: 14520, n2: n2))
    }
}

