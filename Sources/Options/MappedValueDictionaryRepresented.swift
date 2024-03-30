/// Protocol which simplifies mapped value by using a dictionary.
public protocol MappedValueDictionaryRepresented: MappedValueRepresentable
  where RawValue == Int, MappedType: Equatable {
  /// An dictionary of the mapped values.
  static var mappedValues: [Int: MappedType] { get }
}

extension MappedValueDictionaryRepresented {
  /// Gets the raw value based on the MappedType by finding the key of the mapped value.
  /// - Parameter value: MappedType value.
  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  ///   If the value was not found in the dictionary
  /// - Returns:
  ///   The raw value of the enumeration
  ///   based on the key the MappedType value.
  public static func rawValue(basedOn value: MappedType) throws -> RawValue {
    let pair = mappedValues.first { $0.value == value }
    guard let key = pair?.key else {
      throw MappedValueRepresentableError.valueNotFound
    }

    return key
  }

  /// Gets the mapped value based on the rawValue
  /// by access the dictionary at the raw value key.
  /// - Parameter rawValue: The raw value of the enumeration
  ///   which pretains to its index in the `mappedValues` Array.
  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  ///   if the raw value (i.e. key) is not in the dictionary.
  /// - Returns:
  ///   The Mapped Type value based on the raw value key.
  public static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType {
    guard let value = mappedValues[rawValue] else {
      throw MappedValueRepresentableError.valueNotFound
    }
    return value
  }
}
