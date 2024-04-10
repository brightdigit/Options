
<p align="center">
    <img alt="Options" title="Options" src="logo.png" height="200">
</p>
<h1 align="center"> Options </h1>

Swift Package for more powerful `Enum` types.

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/Options)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/Options)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/brightdigit/Options/Options.yml?label=actions&logo=github&?branch=main)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FOptions%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brightdigit/Options)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FOptions%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brightdigit/Options)

[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/Options)](https://codecov.io/gh/brightdigit/Options)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/Options)](https://www.codefactor.io/repository/github/brightdigit/Options)
[![codebeat badge](https://codebeat.co/badges/c47b7e58-867c-410b-80c5-57e10140ba0f)](https://codebeat.co/projects/github-com-brightdigit-mistkit-main)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/Options)](https://codeclimate.com/github/brightdigit/Options)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/Options?label=debt)](https://codeclimate.com/github/brightdigit/Options)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/Options)](https://codeclimate.com/github/brightdigit/Options)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)


# Table of Contents

   * [**Introduction**](#introduction)
   * [**Features**](#features)
   * [**Installation**](#installation)
   * [**Usage**](#usage)
      * [Setting up a **`MappedValueRepresentable`** Enum](#setting-up-a-mappedvaluerepresentable-enum)
      * [Using **`MappedValueCollectionRepresented`**](#using-mappedvaluecollectionrepresented)
      * [Codable Enums using a **`MappedEnum`** Type](#codable-enums-using-a-mappedenum-type)
      * [Using Enums in OptionSets with **`EnumSet`**](#using-enums-in-optionsets-with-enumset)
      * [Converting **`EnumSet`** to Enum Array](#converting-enumset-to-enum-array)
      * [Codable **`EnumSet`** using a **`MappedValueRepresentable`** Enum](#codable-enumset-using-a-mappedvaluerepresentable-enum)
      * [Further Code Documentation](#further-code-documentation)
   * [**License**](#license)

# Introduction

**Options** provides a features to `Enum` and `OptionSet` types such as:

* Providing additional value types besides the `RawType rawValue` 
* Being able to interchange between `Enum` and `OptionSet` types
* Using an additional value type for a `Codable` `OptionSet`

## Example

Let's say you have `Enum` type:

```swift
enum ContinuousIntegrationSystem {
  case github
  case travisci
  case circleci
  case bitrise
}
```

We want two things:

* Use it as an `OptionSet` so we can store multiple CI sytems
* Store and parse it via a `String`

If `OptionSet` requires an `Int` `RawType`, how can we parse and store as `String`?

With **Options** we can enable `ContinuousIntegrationSystem` to do both:

```swift
@Options
enum ContinuousIntegrationSystem: Int, MappedValueCollectionRepresented {
  case github
  case travisci
  case circleci
  case bitrise
}

let systems = ContinuousIntegrationSystemSet([.travisci, .github])
```

# Installation

Swift Package Manager is Apple's decentralized dependency manager to integrate libraries to your Swift projects. It is now fully integrated with Xcode 11.

To integrate **Options** into your project using SPM, specify it in your Package.swift file:

```swift    
let package = Package(
  ...
  dependencies: [
    .package(url: "https://github.com/brightdigit/Options", from: "1.0.0")
  ],
  targets: [
      .target(
          name: "YourTarget",
          dependencies: ["Options", ...]),
      ...
  ]
)
```

# Usage 

## Setting up a [MappedValueRepresentable](/Documentation/Reference/Options/protocols/MappedValueRepresentable.md) Enum

So let's say we our `enum`:

```swift
enum ContinuousIntegrationSystem: Int {
  case github
  case travisci
  case circleci
  case bitrise
}
```

We want to be able to make it available as an `OptionSet` so it needs an `RawType` of `Int`. 
However we want to decode and encode it via `Codable` as a `String`. 

**Options** has a protocol `MappedValueRepresentable` which allows to do that by implementing it.

```swift
enum ContinuousIntegrationSystem: Int, MappedValueRepresentable {
  case github
  case travisci
  case circleci
  case bitrise
  
  static func rawValue(basedOn string: String) throws -> Int {
    if (string == "github") {
      return 0
    } else {
      ...
    } else {
      throw ...
    }
  }
  
  static func mappedValue(basedOn rawValue: Int) throws -> String {
    if (rawValue == 0) {
      return "github"
    } else {
      ...
    } else {
      throw ...
    }
  }
}
```

This can be simplified further by using [`MappedValueCollectionRepresented`](/Documentation/Reference/Options/protocols/MappedValueCollectionRepresented.md).

## Using [MappedValueCollectionRepresented](/Documentation/Reference/Options/protocols/MappedValueCollectionRepresented.md)

By using `MappedValueCollectionRepresented`, you can simplify implementing [`MappedValueRepresentable`](/Documentation/Reference/Options/protocols/MappedValueRepresentable.md):

```swift
enum ContinuousIntegrationSystem: Int, MappedValueCollectionRepresented {
  case github
  case travisci
  case circleci
  case bitrise
  
  static let mappedValues = [
    "github",
    "travisci",
    "circleci",
    "bitrise"
  ]
}
```

Now we we've made it simplifies implementing [`MappedValueRepresentable`](/Documentation/Reference/Options/protocols/MappedValueRepresentable.md) so let's look how to use it with `Codable`.

## Codable Enums using a [MappedEnum](/Documentation/Reference/Options/structs/MappedEnum.md) Type

So you've setup a `MappedValueRepresentable` `enum`, the next part is having the `MappedType` which in this case is `String` the part that's used in `Codable`.

This is where [`MappedEnum`](/Documentation/Reference/Options/structs/MappedEnum.md) is used:

```swift
struct BuildSetup : Codable {
  let ci: MappedEnum<ContinuousIntegrationSystem>
}
```

Now if the `String` can be used in encoding and decoding the value rather than the `RawType` `Int`:

```json
{
  "ci" : "github"
}
```

Next, let's take a look how we could use `ContinuousIntegrationSystem` in an `OptionSet`.

## Using Enums in OptionSets with [EnumSet](/Documentation/Reference/Options/structs/EnumSet.md)

[`EnumSet`](/Documentation/Reference/Options/structs/EnumSet.md) allows you to interchangeably use `Enum` with an `OptionSet`. [`EnumSet`](/Documentation/Reference/Options/structs/EnumSet.md) is a Generic `struct` while takes any `Enum` type with a `RawType`. So we can create an `OptionSet` instance which uses out `ContinuousIntegrationSystem`:

```swift
let systems = EnumSet<ContinuousIntegrationSystem>([.travisci, .github]) 
```

## Converting EnumSet to Enum Array

If your `Enum` implements `CaseIterable`, then you can extract the individual `ContinuousIntegrationSystem` enum values with `.array()`:

```swift
enum ContinuousIntegrationSystem: Int, CaseIterable {
  case github
  case travisci
  case circleci
  case bitrise
}

let systems = EnumSet<ContinuousIntegrationSystem>([.travisci, .github]) 

print(systems.array())
```

Lastly, let's put all this together.

## Codable EnumSet using a MappedValueRepresentable Enum

If your `enum` implements `MappedValueRepresentable` and you use it in an [`EnumSet`](/Documentation/Reference/Options/structs/EnumSet.md), then you can allow for your `OptionSet` to be `Codable` as an `Array` of values rather than the cumulative `rawValue`:

```swift
enum ContinuousIntegrationSystem: Int, MappedValueCollectionRepresented, CaseIterable {
case github
case travisci
case circleci
case bitrise

static let mappedValues = [
  "github",
  "travisci",
  "circleci",
  "bitrise"
]
}


struct BuildSetup : Codable {
  let systems: EnumSet<ContinuousIntegrationSystem>
}

let systems = BuildSetup(systems: EnumSet<ContinuousIntegrationSystem>(values: [.travisci, .github]))
```

For our `systems` variable, our `Codable` data would be:

```json
{
  "systems" : ["travisci", "github"]
}
```

This will make it easier for making our data human-readable instead of using the `rawValue` of `3`.

# Further Code Documentation

[Documentation Here](/Documentation/Reference/Options/README.md)

# License 

This code is distributed under the MIT license. See the [LICENSE](LICENSE) file for more info.
