//
//  MappedValueCollectionRepresentedTests.swift
//  SimulatorServices
//
//  Created by Leo Dion.
//  Copyright © 2024 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the “Software”), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

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

  internal func testCodable() throws {
    let encoder: JSONEncoder = .init()
    let decoder: JSONDecoder = .init()
    let enumValue = MockCollectionEnum.a
    let stringValue = try String(data: encoder.encode(enumValue), encoding: .utf8)
    let actualStringValue = try MockCollectionEnum.mappedValue(basedOn: enumValue.rawValue)
    XCTAssertEqual(stringValue, "\"\(actualStringValue)\"")
    XCTAssertEqual(stringValue, "\"a\"")
    let expectedStringValue = "a"
    let data = "\"\(expectedStringValue)\"".data(using: .utf8) ?? .init()
    let actualValue = try decoder.decode(MockCollectionEnum.self, from: data)
    XCTAssertEqual(actualValue, .a)
  }
}
