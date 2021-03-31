import Options

// swiftlint:disable identifier_name

internal enum MockEnum: Int, MappedValueCollectionRepresented {
  case a
  case b
  case c
  case d
  internal typealias MappedType = String
  internal static let mappedValues = [
    "a",
    "b",
    "c",
    "d"
  ]
}
