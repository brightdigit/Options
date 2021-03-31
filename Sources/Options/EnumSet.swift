public struct EnumSet<EnumType: RawRepresentable>: OptionSet
  where EnumType.RawValue == Int {
  public typealias RawValue = EnumType.RawValue

  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  public init(values: [EnumType]) {
    rawValue = Self.cumulativeValue(basedOnRawValues: values.map { $0.rawValue })
  }

  internal static func cumulativeValue(basedOnRawValues rawValues: [Int]) -> Int {
    rawValues.map { 1 << $0 }.reduce(0, |)
  }
}

extension EnumSet: Codable where EnumType: StringRepresentable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let strings = try container.decode([String].self)
    let rawValues = try strings.map(EnumType.rawValue(basedOn:))
    rawValue = Self.cumulativeValue(basedOnRawValues: rawValues)
  }

  internal static func enums(basedOnRawValue rawValue: Int) -> [EnumType] {
    let cases = EnumType.allCases.sorted { $0.rawValue < $1.rawValue }
    var values = [EnumType]()
    var current = rawValue
    for item in cases {
      guard current > 0 else {
        break
      }
      if current | item.rawValue == item.rawValue {
        values.append(item)
        current -= item.rawValue
      }
    }
    return values
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    let values = Self.enums(basedOnRawValue: rawValue)
    let strings = try values
      .map { $0.rawValue }
      .map(EnumType.string(basedOn:))
    try container.encode(strings)
  }
}
