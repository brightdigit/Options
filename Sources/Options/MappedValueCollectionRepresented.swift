
///// Protocol which simplifies mapped value by using an ordered Array of values.
public protocol MappedValueCollectionRepresented: MappedValueGenericRepresented where MappedValueType : Sequence {
  /// An array of the mapped values which lines up with each case.
  
}

extension Array : MappedValues where Element : Equatable {
  
  
  public func key(value: Element) throws -> Int {
        guard let index = self.firstIndex(of: value) else {
          throw MappedValueRepresentableError.valueNotFound
        }
    
    return index
  }
  
  public func value(key: Int) throws -> Element {
        guard key < count, key >= 0 else {
          throw MappedValueRepresentableError.valueNotFound
        }
    return self[key]
  }
}
//
//extension MappedValueCollectionRepresented {
//  /// Gets the raw value based on the MappedType by finding the index of the mapped value.
//  /// - Parameter value: MappedType value.
//  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
//  ///   If the value was not found in the array
//  /// - Returns:
//  ///   The raw value of the enumeration
//  ///   based on the index the MappedType value was found at.
//  public static func rawValue(basedOn value: MappedType) throws -> RawValue {
//    guard let index = mappedValues.firstIndex(of: value) else {
//      throw MappedValueRepresentableError.valueNotFound
//    }
//
//    return index
//  }
//
//  /// Gets the mapped value based on the rawValue
//  /// by access the array at the raw value subscript.
//  /// - Parameter rawValue: The raw value of the enumeration
//  ///   which pretains to its index in the `mappedValues` Array.
//  /// - Throws: `MappedValueCollectionRepresentedError.valueNotFound`
//  ///   if the raw value (i.e. index) is outside the range of the `mappedValues` array.
//  /// - Returns:
//  ///   The Mapped Type value based on the value in the array at the raw value index.
//  public static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType {
//    guard rawValue < mappedValues.count, rawValue >= 0 else {
//      throw MappedValueRepresentableError.valueNotFound
//    }
//    return mappedValues[rawValue]
//  }
//}
