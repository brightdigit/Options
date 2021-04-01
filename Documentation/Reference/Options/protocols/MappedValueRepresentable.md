**PROTOCOL**

# `MappedValueRepresentable`

```swift
public protocol MappedValueRepresentable: RawRepresentable, CaseIterable
```

## Methods
### `rawValue(basedOn:)`

```swift
static func rawValue(basedOn string: MappedType) throws -> RawValue
```

Gets the raw value based on the MappedType.
- Parameter value: MappedType value.
- Returns: The raw value of the enumeration based on the `MappedType `value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | MappedType value. |

### `mappedValue(basedOn:)`

```swift
static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType
```

Gets the `MappedType` value based on the `rawValue`.
- Parameter rawValue: The raw value of the enumeration.
- Returns: The Mapped Type value based on the `rawValue`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| rawValue | The raw value of the enumeration. |