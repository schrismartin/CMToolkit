import XCTest
@testable import CMToolKit

final class CMToolKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CMToolKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
