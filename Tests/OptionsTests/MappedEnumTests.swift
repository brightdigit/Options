#if canImport(XCTest)
  @testable import Options
  import XCTest

  internal final class MappedEnumTests: XCTestCase {
    private static let text = "\"a\""
    internal func testDecoder() throws {
      // swiftlint:disable:next force_unwrapping
      let data = Self.text.data(using: .utf8)!
      let decoder = JSONDecoder()
      let actual: MappedEnum<MockEnum>
      do {
        actual = try decoder.decode(MappedEnum<MockEnum>.self, from: data)
      } catch {
        XCTAssertNil(error)
        return
      }
      XCTAssertEqual(actual.value, .a)
    }

    internal func testEncoder() throws {
      let encoder = JSONEncoder()
      let describedEnum: MappedEnum<MockEnum> = .init(value: .a)
      let data: Data
      do {
        data = try encoder.encode(describedEnum)
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
  }

#endif
