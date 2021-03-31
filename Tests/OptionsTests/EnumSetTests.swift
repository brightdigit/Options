@testable import Options
import XCTest

final class EnumSetTests: XCTestCase {
  static let text = "[\"a\",\"b\",\"c\"]"

  func testDecoder() {
    let data = Self.text.data(using: .utf8)!
    let decoder = JSONDecoder()
    let actual: EnumSet<MockEnum>
    do {
      actual = try decoder.decode(EnumSet<MockEnum>.self, from: data)
    } catch {
      XCTAssertNil(error)
      return
    }
    XCTAssertEqual(actual.rawValue, 7)
  }

  func testEncoder() {
    let enumSet = EnumSet<MockEnum>(values: [.a, .b, .c])
    let encoder = JSONEncoder()
    let data: Data
    do {
      data = try encoder.encode(enumSet)
    } catch {
      XCTAssertNil(error)
      return
    }

    let dataText = String(bytes: data, encoding: .utf8)

    guard let text = dataText else {
      XCTAssertNotNil(dataText)
      return
    }

    XCTAssertEqual(text, Self.text)
  }

  func testInitValue() {
    let set = EnumSet<MockEnum>(rawValue: 7)
    XCTAssertEqual(set.rawValue, 7)
  }

  func testInitValues() {
    let values: [MockEnum] = [.a, .b, .c]
    let set = EnumSet(values: values)
    XCTAssertEqual(set.rawValue, 7)
  }

  func testArray() {
    let expected: [MockEnum] = [.b, .d]
    let enumSet = EnumSet<MockEnum>(values: expected)
    let actual = enumSet.array()
    XCTAssertEqual(actual, expected)
  }
}
