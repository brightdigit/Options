**STRUCT**

# `MappedEnum`

```swift
public struct MappedEnum<EnumType: MappedValueRepresentable>: Codable
  where EnumType.MappedType: Codable
```

A generic struct for enumerations which allow for additional values attached.

## Properties
### `value`

```swift
public let value: EnumType
```

Base Enumeraion value.

## Methods
### `init(value:)`

```swift
public init(value: EnumType)
```

Creates an instance based on the base enumeration value.
- Parameter value: Base Enumeration value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | Base Enumeration value. |

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

Decodes the value based on the mapped value.
- Parameter decoder: Decoder.

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | Decoder. |

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

Encodes the value based on the mapped value.
- Parameter encoder: Encoder.

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | Encoder. |