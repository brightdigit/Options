**PROTOCOL**

# `MappedValueRepresentable`

```swift
public protocol MappedValueRepresentable: RawRepresentable, CaseIterable
```

## Methods
### `rawValue(basedOn:)`

```swift
static func rawValue(basedOn string: String) throws -> RawValue
```

### `mappedValue(basedOn:)`

```swift
static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType
```
