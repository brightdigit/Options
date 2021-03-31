**EXTENSION**

# `MappedValueRepresentable`
```swift
public extension MappedValueRepresentable
```

## Methods
### `mappedValue()`

```swift
func mappedValue() throws -> MappedType
```

Gets the mapped value of the enumeration.
- Parameter rawValue: The raw value of the enumeration
  which pretains to its index in the `mappedValues` Array.
- Throws: `MappedValueCollectionRepresentedError.valueNotFound`
  if the raw value (i.e. index) is outside the range of the `mappedValues` array.
- Returns:
  The Mapped Type value based on the value in the array at the raw value index.
Gets the mapped value of the enumeration.
- Returns: The `MappedType` value

#### Parameters

| Name | Description |
| ---- | ----------- |
| rawValue | The raw value of the enumeration which pretains to its index in the `mappedValues` Array. |