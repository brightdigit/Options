public protocol MappedValueRepresentable: RawRepresentable, CaseIterable {
  associatedtype MappedType
  static func rawValue(basedOn string: String) throws -> RawValue
  static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType
}

public extension MappedValueRepresentable {
  func mappedValue() throws -> MappedType {
    try Self.mappedValue(basedOn: rawValue)
  }
}
