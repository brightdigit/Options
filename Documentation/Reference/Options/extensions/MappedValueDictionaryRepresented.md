**EXTENSION**

# `MappedValueDictionaryRepresented`
```swift
public extension MappedValueDictionaryRepresented
```

## Methods
### `rawValue(basedOn:)`

```swift
static func rawValue(basedOn value: MappedType) throws -> RawValue
```

Gets the raw value based on the MappedType by finding the key of the mapped value.
- Parameter value: MappedType value.
- Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  If the value was not found in the dictionary
- Returns:
  The raw value of the enumeration
  based on the key the MappedType value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | MappedType value. |

### `mappedValue(basedOn:)`

```swift
static func mappedValue(basedOn rawValue: RawValue) throws -> MappedType
```

Gets the mapped value based on the rawValue
by access the dictionary at the raw value key.
- Parameter rawValue: The raw value of the enumeration
  which pretains to its index in the `mappedValues` Array.
- Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  if the raw value (i.e. key) is not in the dictionary.
- Returns:
  The Mapped Type value based on the raw value key.

#### Parameters

| Name | Description |
| ---- | ----------- |
| rawValue | The raw value of the enumeration which pretains to its index in the `mappedValues` Array. |