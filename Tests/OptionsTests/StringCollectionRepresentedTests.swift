@testable import Options
import XCTest

final class StringCollectionRepresentedTests: XCTestCase {
  func testRawValue() {
    do {
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "a"), 0)
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "b"), 1)
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "c"), 2)
      try XCTAssertEqual(MockEnum.rawValue(basedOn: "d"), 3)
    } catch {
      XCTAssertNil(error)
    }
  }

  func testString() {
    do {
      try XCTAssertEqual(MockEnum.string(basedOn: 0), "a")
      try XCTAssertEqual(MockEnum.string(basedOn: 1), "b")
      try XCTAssertEqual(MockEnum.string(basedOn: 2), "c")
      try XCTAssertEqual(MockEnum.string(basedOn: 3), "d")
    } catch {
      XCTAssertNil(error)
    }
  }

  func testRawValueFailure() {
    let caughtError: StringCollectionRepresentedError?
    do {
      _ = try MockEnum.rawValue(basedOn: "e")
      caughtError = nil
    } catch let error as StringCollectionRepresentedError {
      caughtError = error
    } catch {
      XCTAssertNil(error)
      caughtError = nil
    }

    XCTAssertEqual(caughtError, .stringNotFound)
  }

  func testStringFailure() {
    let caughtError: StringCollectionRepresentedError?
    do {
      _ = try MockEnum.string(basedOn: .max)
      caughtError = nil
    } catch let error as StringCollectionRepresentedError {
      caughtError = error
    } catch {
      XCTAssertNil(error)
      caughtError = nil
    }

    XCTAssertEqual(caughtError, .stringNotFound)
  }
}
