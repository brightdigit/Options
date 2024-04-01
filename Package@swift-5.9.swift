// swift-tools-version:5.9

// swiftlint:disable explicit_top_level_acl
// swiftlint:disable prefixed_toplevel_constant
// swiftlint:disable line_length
// swiftlint:disable explicit_acl

import PackageDescription
import CompilerPluginSupport

let swiftSettings = [
  SwiftSetting.enableUpcomingFeature("BareSlashRegexLiterals"),
  SwiftSetting.enableUpcomingFeature("ConciseMagicFile"),
  SwiftSetting.enableUpcomingFeature("ExistentialAny"),
  SwiftSetting.enableUpcomingFeature("ForwardTrailingClosures"),
  SwiftSetting.enableUpcomingFeature("ImplicitOpenExistentials"),
  SwiftSetting.enableUpcomingFeature("StrictConcurrency"),
  SwiftSetting.enableUpcomingFeature("DisableOutwardActorInference"),
  SwiftSetting.enableExperimentalFeature("StrictConcurrency"),
  SwiftSetting.unsafeFlags(["-warn-concurrency", "-enable-actor-data-race-checks"])
]

let package = Package(
  name: "Options",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(
      name: "Options",
      targets: ["Options"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax", from: "510.0.0")
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0")
  ],
  targets: [
    .target(
      name: "Options",
      dependencies: ["OptionsMacros"],
      swiftSettings: swiftSettings
    ),
    .macro(
        name: "OptionsMacros",
        dependencies: [
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
        ]
    ),
    .testTarget(
      name: "OptionsTests",
      dependencies: ["Options"]
    )
  ]
)
