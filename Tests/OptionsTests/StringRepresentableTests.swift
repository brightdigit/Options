@testable import Options
import XCTest

final class StringRepresentableTests: XCTestCase {
  func testStringValue() {
    try XCTAssertEqual(MockEnum.a.stringValue(), "a")
    try XCTAssertEqual(MockEnum.b.stringValue(), "b")
    try XCTAssertEqual(MockEnum.c.stringValue(), "c")
    try XCTAssertEqual(MockEnum.d.stringValue(), "d")
  }
}
