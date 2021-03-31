**EXTENSION**

# `Array`
```swift
public extension Array
```

## Methods
### `ifNil(throw:)`

```swift
func ifNil<Wrapped, Failure: Error>(
  throw error: @autoclosure () -> Failure
) throws -> [Wrapped] where Element == Wrapped?
```
