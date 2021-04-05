#if canImport(XCTest)
  @testable import Options
  import XCTest

  internal final class MappedValueRepresentableTests: XCTestCase {
    internal func testStringValue() {
      try XCTAssertEqual(MockEnum.a.mappedValue(), "a")
      try XCTAssertEqual(MockEnum.b.mappedValue(), "b")
      try XCTAssertEqual(MockEnum.c.mappedValue(), "c")
      try XCTAssertEqual(MockEnum.d.mappedValue(), "d")
    }
  }

#endif
