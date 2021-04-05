import Options

// swiftlint:disable identifier_name

internal enum MockDictionaryEnum: Int, MappedValueDictionaryRepresented {
  case a = 2
  case b = 5
  case c = 6
  case d = 12
  internal typealias MappedType = String
  internal static var mappedValues = [
    2: "a",
    5: "b",
    6: "c",
    12: "d"
  ]
}
