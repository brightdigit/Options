import Options

// swiftlint:disable identifier_name

internal enum MockEnum: Int, StringCollectionRepresented {
  internal static let strings = [
    "a",
    "b",
    "c",
    "d"
  ]

  case a
  case b
  case c
  case d
}
