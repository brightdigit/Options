/// Generic struct for using Enums with RawValue type of Int as an Optionset
public struct EnumSet<EnumType: RawRepresentable>: OptionSet, Sendable
  where EnumType.RawValue == Int {
  public typealias RawValue = EnumType.RawValue

  /// Raw Value of the OptionSet
  public let rawValue: Int

  /// Creates the EnumSet based on the `rawValue`
  /// - Parameter rawValue: Integer raw value of the OptionSet
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  /// Creates the EnumSet based on the values in the array.
  /// - Parameter values: Array of enum values.
  public init(values: [EnumType]) {
    let set = Set(values.map(\.rawValue))
    rawValue = Self.cumulativeValue(basedOnRawValues: set)
  }

  internal static func cumulativeValue(
    basedOnRawValues rawValues: Set<Int>) -> Int {
    rawValues.map { 1 << $0 }.reduce(0, |)
  }
}

extension EnumSet where EnumType: CaseIterable {
  internal static func enums(basedOnRawValue rawValue: Int) -> [EnumType] {
    let cases = EnumType.allCases.sorted { $0.rawValue < $1.rawValue }
    var values = [EnumType]()
    var current = rawValue
    for item in cases {
      guard current > 0 else {
        break
      }
      let rawValue = 1 << item.rawValue
      if current & rawValue != 0 {
        values.append(item)
        current -= rawValue
      }
    }
    return values
  }

  /// Returns an array of the enum values based on the OptionSet
  /// - Returns: Array for each value represented by the enum.
  public func array() -> [EnumType] {
    Self.enums(basedOnRawValue: rawValue)
  }
}

extension EnumSet: Codable
  where EnumType: MappedValueRepresentable, EnumType.MappedType: Codable {
  /// Decodes the EnumSet based on an Array of MappedTypes.
  /// - Parameter decoder: Decoder which contains info as an array of MappedTypes.
  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let values = try container.decode([EnumType.MappedType].self)
    let rawValues = try values.map(EnumType.rawValue(basedOn:))
    let set = Set(rawValues)
    rawValue = Self.cumulativeValue(basedOnRawValues: set)
  }

  /// Encodes the EnumSet based on an Array of MappedTypes.
  /// - Parameter encoder: Encoder which will contain info as an array of MappedTypes.
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    let values = Self.enums(basedOnRawValue: rawValue)
    let mappedValues = try values
      .map(\.rawValue)
      .map(EnumType.mappedValue(basedOn:))
    try container.encode(mappedValues)
  }
}
