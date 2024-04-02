// swift-tools-version:5.2

// swiftlint:disable explicit_top_level_acl
// swiftlint:disable prefixed_toplevel_constant
// swiftlint:disable line_length
// swiftlint:disable explicit_acl

import PackageDescription

let package = Package(
  name: "Options",
  products: [
    .library(
      name: "Options",
      targets: ["Options"]
    )
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
  ],
  targets: [
    .target(
      name: "Options",
      dependencies: []
    ),
    .testTarget(
      name: "OptionsTests",
      dependencies: ["Options"]
    )
  ]
)
