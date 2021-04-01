**EXTENSION**

# `EnumSet`
```swift
extension EnumSet where EnumType: CaseIterable
```

## Methods
### `array()`

```swift
public func array() -> [EnumType]
```

Returns an array of the enum values based on the OptionSet
- Returns: Array for each value represented by the enum.

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

Decodes the EnumSet based on an Array of MappedTypes.
- Parameter decoder: Decoder which contains info as an array of MappedTypes.

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | Decoder which contains info as an array of MappedTypes. |

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

Encodes the EnumSet based on an Array of MappedTypes.
- Parameter encoder: Encoder which will contain info as an array of MappedTypes.

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | Encoder which will contain info as an array of MappedTypes. |