public protocol StringRepresentable: RawRepresentable, CaseIterable {
  static func rawValue(basedOn string: String) throws -> RawValue
  static func string(basedOn rawValue: RawValue) throws -> String
}

extension StringRepresentable {
  func stringValue() throws -> String {
    try Self.string(basedOn: rawValue)
  }
}
