@testable import Options
import XCTest

public enum ContinuousIntegrationSystem: Int, CaseIterable, StringCollectionRepresented {
  case bitrise
  case travisci
  case github
  case circleci

  public static let strings = [
    "bitrise",
    "travisci",
    "github",
    "circleci"
  ]
}

final class OptionsTests: XCTestCase {
  func testExample() {
    let collection = [ContinuousIntegrationSystem.github, ContinuousIntegrationSystem.circleci, ContinuousIntegrationSystem.bitrise].map {
      try! $0.stringValue()
    }.joined(separator: "\", \"")
    XCTAssertEqual(collection, "github\", \"circleci\", \"bitrise")
    let json = "[\"\(collection)\"]"
    let bytes = json.data(using: .utf8)!
    let decoder = JSONDecoder()
    let set = try? decoder.decode(EnumSet<ContinuousIntegrationSystem>.self, from: bytes)
    XCTAssertEqual(set?.rawValue, 13)
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
