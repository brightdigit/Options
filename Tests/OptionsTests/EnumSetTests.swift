#if canImport(XCTest)
  @testable import Options
  import XCTest

  internal final class EnumSetTests: XCTestCase {
    private static let text = "[\"a\",\"b\",\"c\"]"

    internal func testDecoder() {
      // swiftlint:disable:next force_unwrapping
      let data = Self.text.data(using: .utf8)!
      let decoder = JSONDecoder()
      let actual: EnumSet<MockCollectionEnum>
      do {
        actual = try decoder.decode(EnumSet<MockCollectionEnum>.self, from: data)
      } catch {
        XCTAssertNil(error)
        return
      }
      XCTAssertEqual(actual.rawValue, 7)
    }

    internal func testEncoder() {
      let enumSet = EnumSet<MockCollectionEnum>(values: [.a, .b, .c])
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

    internal func testInitValue() {
      let set = EnumSet<MockCollectionEnum>(rawValue: 7)
      XCTAssertEqual(set.rawValue, 7)
    }

    internal func testInitValues() {
      let values: [MockCollectionEnum] = [.a, .b, .c]
      let set = EnumSet(values: values)
      XCTAssertEqual(set.rawValue, 7)
    }

    internal func testArray() {
      let expected: [MockCollectionEnum] = [.b, .d]
      let enumSet = EnumSet<MockCollectionEnum>(values: expected)
      let actual = enumSet.array()
      XCTAssertEqual(actual, expected)
    }
  }
#endif
