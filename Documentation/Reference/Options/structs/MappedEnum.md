**STRUCT**

# `MappedEnum`

```swift
public struct MappedEnum<EnumType: MappedValueRepresentable>: Codable
  where EnumType.MappedType: Codable
```

## Properties
### `value`

```swift
public let value: EnumType
```

## Methods
### `init(value:)`

```swift
public init(value: EnumType)
```

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | The encoder to write data to. |