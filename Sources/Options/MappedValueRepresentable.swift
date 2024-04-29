//
//  MappedValueRepresentable.swift
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

public struct CodingOptions: OptionSet, Sendable {
  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  public static let allowMappedValueDecoding: CodingOptions = .init(rawValue: 1)
  public static let encodeAsMappedValue: CodingOptions = .init(rawValue: 2)

  public static let `default`: CodingOptions =
    [.allowMappedValueDecoding, encodeAsMappedValue]
}

public protocol MappedValueRepresentable: RawRepresentable, CaseIterable, Sendable {
  associatedtype MappedType = String
  /// Gets the raw value based on the MappedType.
  /// - Parameter value: MappedType value.
  /// - Returns: The raw value of the enumeration based on the `MappedType `value.
  static func rawValue(basedOn string: MappedType) throws -> RawValue

  /// Gets the `MappedType` value based on the `rawValue`.
  /// - Parameter rawValue: The raw value of the enumeration.
  /// - Returns: The Mapped Type value based on the `rawValue`.
  static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType

  static var codingOptions: CodingOptions {
    get
  }
}

extension MappedValueRepresentable {
  /// Gets the mapped value of the enumeration.
  /// - Parameter rawValue: The raw value of the enumeration
  ///   which pretains to its index in the `mappedValues` Array.
  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  ///   if the raw value (i.e. index) is outside the range of the `mappedValues` array.
  /// - Returns:
  ///   The Mapped Type value based on the value in the array at the raw value index.

  /// Gets the mapped value of the enumeration.

  /// - Returns: The `MappedType` value
  public func mappedValue() throws -> MappedType {
    try Self.mappedValue(basedOn: rawValue)
  }

  public static var codingOptions: CodingOptions {
    .default
  }
}

extension DecodingError {
  static func invalidRawValue(_ rawValue: some Any) -> DecodingError {
    .dataCorrupted(
      .init(codingPath: [], debugDescription: "Raw Value \(rawValue) is invalid.")
    )
  }
}

extension MappedValueRepresentable
  where Self: Decodable, MappedType: Decodable, RawValue: Decodable {
  private static func decodeAsRawValue(
    from container: any SingleValueDecodingContainer
  ) throws -> Self {
    let rawValue = try container.decode(RawValue.self)
    guard let value = Self(rawValue: rawValue) else {
      throw DecodingError.invalidRawValue(rawValue)
    }
    return value
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let mappedValues: MappedType

    if Self.codingOptions.contains(.allowMappedValueDecoding) {
      do {
        mappedValues = try container.decode(MappedType.self)
      } catch {
        self = try Self.decodeAsRawValue(from: container)
        return
      }

      let rawValue = try Self.rawValue(basedOn: mappedValues)

      guard let value = Self(rawValue: rawValue) else {
        throw DecodingError.dataCorrupted(
          .init(codingPath: [], debugDescription: "Invalid Raw Value.")
        )
      }

      self = value
    } else {
      self = try Self.decodeAsRawValue(from: container)
    }
  }
}

extension MappedValueRepresentable
  where Self: Encodable, MappedType: Encodable, RawValue: Encodable {
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    if Self.codingOptions.contains(.encodeAsMappedValue) {
      try container.encode(mappedValue())
    } else {
      try container.encode(rawValue)
    }
  }
}
