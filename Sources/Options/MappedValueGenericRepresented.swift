public protocol MappedValues<Value> {
  associatedtype Value : Equatable
  func key(value: Value) throws -> Int
  func value(key: Int) throws -> Value
}

/// Protocol which simplifies mapped value by using an ordered Array of values.
public protocol MappedValueGenericRepresented: MappedValueRepresentable
  where RawValue == Int, MappedType: Equatable {
  
  associatedtype MappedValueType : MappedValues<MappedType>
  /// An array of the mapped values which lines up with each case.
  static var mappedValues: MappedValueType { get }
}

extension MappedValueGenericRepresented {
  /// Gets the raw value based on the MappedType by finding the index of the mapped value.
  /// - Parameter value: MappedType value.
  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  ///   If the value was not found in the array
  /// - Returns:
  ///   The raw value of the enumeration
  ///   based on the index the MappedType value was found at.
  public static func rawValue(basedOn value: MappedType) throws -> RawValue {
//    guard let index = mappedValues.firstIndex(of: value) else {
//      throw MappedValueRepresentableError.valueNotFound
//    }
//
//    return index
    return try Self.mappedValues.key(value: value)
  }

  /// Gets the mapped value based on the rawValue
  /// by access the array at the raw value subscript.
  /// - Parameter rawValue: The raw value of the enumeration
  ///   which pretains to its index in the `mappedValues` Array.
  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  ///   if the raw value (i.e. index) is outside the range of the `mappedValues` array.
  /// - Returns:
  ///   The Mapped Type value based on the value in the array at the raw value index.
  public static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType {
    return try Self.mappedValues.value(key: rawValue)
//    guard rawValue < mappedValues.count, rawValue >= 0 else {
//      throw MappedValueRepresentableError.valueNotFound
//    }
//    return mappedValues[rawValue]
  }
}
