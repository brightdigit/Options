**PROTOCOL**

# `StringRepresentable`

```swift
public protocol StringRepresentable: RawRepresentable, CaseIterable
```

## Methods
### `rawValue(basedOn:)`

```swift
static func rawValue(basedOn string: String) throws -> RawValue
```

### `string(basedOn:)`

```swift
static func string(basedOn rawValue: RawValue) throws -> String
```
