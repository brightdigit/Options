#if canImport(XCTest)
  @testable import Options
  import XCTest

  internal final class MappedValueDictionaryRepresentedTests: XCTestCase {
    internal func testRawValue() {
      try XCTAssertEqual(MockDictionaryEnum.rawValue(basedOn: "a"), 2)
      try XCTAssertEqual(MockDictionaryEnum.rawValue(basedOn: "b"), 5)
      try XCTAssertEqual(MockDictionaryEnum.rawValue(basedOn: "c"), 6)
      try XCTAssertEqual(MockDictionaryEnum.rawValue(basedOn: "d"), 12)
    }

    internal func testString() {
      try XCTAssertEqual(MockDictionaryEnum.mappedValue(basedOn: 2), "a")
      try XCTAssertEqual(MockDictionaryEnum.mappedValue(basedOn: 5), "b")
      try XCTAssertEqual(MockDictionaryEnum.mappedValue(basedOn: 6), "c")
      try XCTAssertEqual(MockDictionaryEnum.mappedValue(basedOn: 12), "d")
    }

    internal func testRawValueFailure() {
      let caughtError: MappedValueRepresentableError?
      do {
        _ = try MockDictionaryEnum.rawValue(basedOn: "e")
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
        _ = try MockDictionaryEnum.mappedValue(basedOn: 0)
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
