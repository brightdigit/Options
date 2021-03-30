


public struct DescribedEnum<EnumType : StringRepresentable> : Codable {
  let value : EnumType
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let label = try container.decode(String.self)
    let rawValue = try EnumType.rawValue(basedOn: label)
    guard let value = EnumType(rawValue: rawValue) else {
      throw DecodingError.dataCorrupted(DecodingError.Context.init(codingPath: [], debugDescription: "Invalid String Value."))
    }
    self.value = value
  }
  
  public func encode(to encoder: Encoder) throws {
    let string = try EnumType.string(basedOn: value.rawValue)
    var container = encoder.singleValueContainer()
    try container.encode(string)
  }
}
