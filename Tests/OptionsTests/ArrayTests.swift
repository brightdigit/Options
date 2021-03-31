@testable import Options
import XCTest

internal final class ArrayTests: XCTestCase {
  internal func testIfNil() throws {
    let items: [Int?] = [
      1, nil, 2, nil, 4
    ]

    let errorValue = Int.random(in: 1 ... 1_000)

    let caughtError: Error?
    do {
      _ = try items.ifNil(throw: MockError(value: errorValue))
      caughtError = nil
    } catch {
      caughtError = error
    }

    let mockError = caughtError as? MockError<Int>

    XCTAssertEqual(mockError?.value, errorValue)
  }
}
