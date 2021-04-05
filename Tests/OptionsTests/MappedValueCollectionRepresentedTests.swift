#if canImport(XCTest)
  @testable import Options
  import XCTest

  internal final class MappedValueCollectionRepresentedTests: XCTestCase {
    internal func testRawValue() {
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "a"), 0)
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "b"), 1)
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "c"), 2)
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "d"), 3)
    }

    internal func testString() {
      try XCTAssertEqual(MockEnum.mappedValue(basedOn: 0), "a")
      try XCTAssertEqual(MockEnum.mappedValue(basedOn: 1), "b")
      try XCTAssertEqual(MockEnum.mappedValue(basedOn: 2), "c")
      try XCTAssertEqual(MockEnum.mappedValue(basedOn: 3), "d")
    }

    internal func testRawValueFailure() {
      let caughtError: MappedValueCollectionRepresentedError?
      do {
        _ = try MockEnum.rawValue(basedOn: "e")
        caughtError = nil
      } catch let error as MappedValueCollectionRepresentedError {
        caughtError = error
      } catch {
        XCTAssertNil(error)
        caughtError = nil
      }

      XCTAssertEqual(caughtError, .valueNotFound)
    }

    internal func testStringFailure() {
      let caughtError: MappedValueCollectionRepresentedError?
      do {
        _ = try MockEnum.mappedValue(basedOn: .max)
        caughtError = nil
      } catch let error as MappedValueCollectionRepresentedError {
        caughtError = error
      } catch {
        XCTAssertNil(error)
        caughtError = nil
      }

      XCTAssertEqual(caughtError, .valueNotFound)
    }
  }

#endif
