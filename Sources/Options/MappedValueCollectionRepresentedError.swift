import Foundation

/// An Error thrown when the `MappedType` value or `RawType` value
/// are invalid for an `Enum`.
public enum MappedValueCollectionRepresentedError: Error {
  case valueNotFound
}
