extension Array {
  func ifNil<Wrapped, Failure: Error>(throw error: @autoclosure () -> Failure) throws -> [Wrapped] where Element == Wrapped? {
    try map { item in
      guard let value = item else {
        throw error()
      }
      return value
    }
  }
}
