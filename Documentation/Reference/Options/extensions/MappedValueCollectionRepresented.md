**EXTENSION**

# `MappedValueCollectionRepresented`
```swift
public extension MappedValueCollectionRepresented
```

## Methods
### `rawValue(basedOn:)`

```swift
static func rawValue(basedOn value: MappedType) throws -> RawValue
```

Gets the raw value based on the MappedType by finding the index of the mapped value.
- Parameter value: MappedType value.
- Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  If the value was not found in the array
- Returns:
  The raw value of the enumeration
  based on the index the MappedType value was found at.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | MappedType value. |

### `mappedValue(basedOn:)`

```swift
static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType
```

Gets the mapped value based on the rawValue
by access the array at the raw value subscript.
- Parameter rawValue: The raw value of the enumeration
  which pretains to its index in the `mappedValues` Array.
- Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  if the raw value (i.e. index) is outside the range of the `mappedValues` array.
- Returns:
  The Mapped Type value based on the value in the array at the raw value index.

#### Parameters

| Name | Description |
| ---- | ----------- |
| rawValue | The raw value of the enumeration which pretains to its index in the `mappedValues` Array. |