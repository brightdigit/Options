**STRUCT**

# `EnumSet`

```swift
public struct EnumSet<EnumType: RawRepresentable>: OptionSet
  where EnumType.RawValue == Int
```

Generic struct for using Enums with RawValue type of Int as an Optionset

## Properties
### `rawValue`

```swift
public let rawValue: Int
```

Raw Value of the OptionSet

## Methods
### `init(rawValue:)`

```swift
public init(rawValue: Int)
```

Creates the EnumSet based on the `rawValue`
- Parameter rawValue: Integer raw value of the OptionSet

#### Parameters

| Name | Description |
| ---- | ----------- |
| rawValue | Integer raw value of the OptionSet |

### `init(values:)`

```swift
public init(values: [EnumType])
```

Creates the EnumSet based on the values in the array.
- Parameter values: Array of enum values.

#### Parameters

| Name | Description |
| ---- | ----------- |
| values | Array of enum values. |