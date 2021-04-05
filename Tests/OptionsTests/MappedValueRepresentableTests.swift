#if canImport(XCTest)
  @testable import Options
  import XCTest

  internal final class MappedValueRepresentableTests: XCTestCase {
    internal func testStringValue() {
      try XCTAssertEqual(MockCollectionEnum.a.mappedValue(), "a")
      try XCTAssertEqual(MockCollectionEnum.b.mappedValue(), "b")
      try XCTAssertEqual(MockCollectionEnum.c.mappedValue(), "c")
      try XCTAssertEqual(MockCollectionEnum.d.mappedValue(), "d")
    }
  }

#endif
