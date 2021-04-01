public protocol MappedValueRepresentable: RawRepresentable, CaseIterable {
  associatedtype MappedType
  /// Gets the raw value based on the MappedType.
  /// - Parameter value: MappedType value.
  /// - Returns: The raw value of the enumeration based on the `MappedType `value.
  static func rawValue(basedOn string: MappedType) throws -> RawValue

  /// Gets the `MappedType` value based on the `rawValue`.
  /// - Parameter rawValue: The raw value of the enumeration.
  /// - Returns: The Mapped Type value based on the `rawValue`.
  static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType
}

public extension MappedValueRepresentable {
  /// Gets the mapped value of the enumeration.
  /// - Parameter rawValue: The raw value of the enumeration
  ///   which pretains to its index in the `mappedValues` Array.
  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  ///   if the raw value (i.e. index) is outside the range of the `mappedValues` array.
  /// - Returns:
  ///   The Mapped Type value based on the value in the array at the raw value index.

  /// Gets the mapped value of the enumeration.

  /// - Returns: The `MappedType` value
  func mappedValue() throws -> MappedType {
    try Self.mappedValue(basedOn: rawValue)
  }
}
