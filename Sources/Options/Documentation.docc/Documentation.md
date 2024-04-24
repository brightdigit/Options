# ``Options``

Swift Package for more powerful `Enum` types.

## Overview

**Options** provides a powerful set of features for `Enum` and `OptionSet` types:

* Providing additional representations for `Enum` types besides the `RawType rawValue` 
* Being able to interchange between `Enum` and `OptionSet` types
* Using an additional value type for a `Codable` `OptionSet`

### Requirements 

**Apple Platforms**

- Xcode 14.1 or later
- Swift 5.7.1 or later
- iOS 16 / watchOS 9 / tvOS 16 / macOS 12 or later deployment targets

**Linux**

- Ubuntu 20.04 or later
- Swift 5.7.1 or later

### Installation

Use the Swift Package Manager to install this library via the repository url:

```
https://github.com/brightdigit/Options.git
```

Use version up to `1.0`.

### Versatile Options with Enums and OptionSets

Let's say we are using an `Enum` for a list of popular social media networks:

```swift
enum SocialNetwork {
  case digg
  case aim
  case bebo
  case delicious
  case eworld
  case googleplus
  case itunesping
  case jaiku
  case miiverse
  case musically
  case orkut
  case posterous
  case stumbleupon
  case windowslive
  case yahoo
}
```

We'll be using this as a way to define a particular social handle:

```swift
struct SocialHandle {
  let name : String
  let network : SocialNetwork
}
```

However we also want to provide a way to have a unique set of social networks available:

```swift
struct SocialNetworks : OptionSet {
...
}

let user : User
let networks : SocialNetworks = user.availableNetworks()
```

Insert more text here.

## Topics

### Options conformance

- ``Options()``
- ``MappedValueRepresentable``
- ``MappedValueRepresented``
- ``EnumSet``

### Advanced customization

- ``MappedEnum``
- ``MappedValues``

### Errors

- ``MappedValueRepresentableError-2k4ki``

### Deprecated 

- ``MappedValueCollectionRepresented``
- ``MappedValueDictionaryRepresented``
