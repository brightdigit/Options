//public protocol StringCollectionRepresented: StringRepresentable where RawValue == Int {
//  static var strings: [String] { get }
//}
//
//public extension StringCollectionRepresented {
//  static func rawValue(basedOn string: String) throws -> RawValue {
//    guard let index = strings.firstIndex(of: string) else {
//      throw StringCollectionRepresentedError.stringNotFound
//    }
//
//    return index
//  }
//
//  static func string(basedOn rawValue: RawValue) throws -> String {
//    guard rawValue < strings.count, rawValue >= 0 else {
//      throw StringCollectionRepresentedError.stringNotFound
//    }
//    return Self.strings[rawValue]
//  }
//}

@testable import Options
import XCTest

final class StringCollectionRepresentedTests: XCTestCase {
  func testRawValue() {
    XCTFail()
  }
  
  func testString() {
    XCTFail()
  }
}
