public struct EnumSet<EnumType: RawRepresentable>: OptionSet
  where EnumType.RawValue == Int {
  public typealias RawValue = EnumType.RawValue

  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  public init(values: [EnumType]) {
    let set = Set(values.map { $0.rawValue })
    rawValue = Self.cumulativeValue(basedOnRawValues: set)
  }

  internal static func cumulativeValue(
    basedOnRawValues rawValues: Set<Int>) -> Int {
    rawValues.map { 1 << $0 }.reduce(0, |)
  }
}

extension EnumSet where EnumType: CaseIterable {
  public func array() -> [EnumType] {
    Self.enums(basedOnRawValue: rawValue)
  }

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
}

extension EnumSet: Codable
  where EnumType: MappedValueRepresentable, EnumType.MappedType: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let strings = try container.decode([String].self)
    let rawValues = try strings.map(EnumType.rawValue(basedOn:))
    let set = Set(rawValues)
    rawValue = Self.cumulativeValue(basedOnRawValues: set)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    let values = Self.enums(basedOnRawValue: rawValue)
    let strings = try values
      .map { $0.rawValue }
      .map(EnumType.mappedValue(basedOn:))
    try container.encode(strings)
  }
}
