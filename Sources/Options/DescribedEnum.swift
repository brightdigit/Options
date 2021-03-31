public struct DescribedEnum<EnumType: StringRepresentable>: Codable {
  public let value: EnumType

  public init(value: EnumType) {
    self.value = value
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let label = try container.decode(String.self)
    let rawValue = try EnumType.rawValue(basedOn: label)
    guard let value = EnumType(rawValue: rawValue) else {
      preconditionFailure("Invalid Raw Value.")
    }
    self.value = value
  }

  public func encode(to encoder: Encoder) throws {
    let string = try EnumType.string(basedOn: value.rawValue)
    var container = encoder.singleValueContainer()
    try container.encode(string)
  }
}
