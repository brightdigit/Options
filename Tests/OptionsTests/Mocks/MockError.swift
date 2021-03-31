import Foundation

internal struct MockError<T>: Error {
  internal let value: T
}
