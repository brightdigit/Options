public protocol MappedValueCollectionRepresented: MappedValueRepresentable
  where RawValue == Int, MappedType: Equatable {
  static var mappedValues: [MappedType] { get }
}

public extension MappedValueCollectionRepresented {
  static func rawValue(basedOn value: MappedType) throws -> RawValue {
    guard let index = mappedValues.firstIndex(of: value) else {
      throw MappedValueCollectionRepresentedError.valueNotFound
    }

    return index
  }

  static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType {
    guard rawValue < mappedValues.count, rawValue >= 0 else {
      throw MappedValueCollectionRepresentedError.valueNotFound
    }
    return Self.mappedValues[rawValue]
  }
}
