#if canImport(XCTest)
  @testable import Options
  import XCTest

  internal final class MappedValueCollectionRepresentedTests: XCTestCase {
    internal func testRawValue() {
      try XCTAssertEqual(MockCollectionEnum.rawValue(basedOn: "a"), 0)
      try XCTAssertEqual(MockCollectionEnum.rawValue(basedOn: "b"), 1)
      try XCTAssertEqual(MockCollectionEnum.rawValue(basedOn: "c"), 2)
      try XCTAssertEqual(MockCollectionEnum.rawValue(basedOn: "d"), 3)
    }

    internal func testString() {
      try XCTAssertEqual(MockCollectionEnum.mappedValue(basedOn: 0), "a")
      try XCTAssertEqual(MockCollectionEnum.mappedValue(basedOn: 1), "b")
      try XCTAssertEqual(MockCollectionEnum.mappedValue(basedOn: 2), "c")
      try XCTAssertEqual(MockCollectionEnum.mappedValue(basedOn: 3), "d")
    }

    internal func testRawValueFailure() {
      let caughtError: MappedValueRepresentableError?
      do {
        _ = try MockCollectionEnum.rawValue(basedOn: "e")
        caughtError = nil
      } catch let error as MappedValueRepresentableError {
        caughtError = error
      } catch {
        XCTAssertNil(error)
        caughtError = nil
      }

      XCTAssertEqual(caughtError, .valueNotFound)
    }

    internal func testStringFailure() {
      let caughtError: MappedValueRepresentableError?
      do {
        _ = try MockCollectionEnum.mappedValue(basedOn: .max)
        caughtError = nil
      } catch let error as MappedValueRepresentableError {
        caughtError = error
      } catch {
        XCTAssertNil(error)
        caughtError = nil
      }

      XCTAssertEqual(caughtError, .valueNotFound)
    }
  }

#endif
