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
    // .package(url: /* package url */, from: "1.0.0")
//    .package(url: "https://github.com/shibapm/Komondor", from: "1.0.6"), // dev
//    .package(url: "https://github.com/eneko/SourceDocs", from: "1.2.1"), // dev
//    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.47.0"), // dev
//    .package(url: "https://github.com/realm/SwiftLint", from: "0.41.0"), // dev
//    .package(url: "https://github.com/shibapm/Rocket", .branch("master")), // dev
//    .package(url: "https://github.com/mattpolzin/swift-test-codecov", .branch("master")) // dev
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

#if canImport(PackageConfig)
  import PackageConfig

  let requiredCoverage: Int = 90

  let config = PackageConfiguration([
    "komondor": [
      "pre-push": [
        "swift test --enable-code-coverage --enable-test-discovery",
        "swift run swift-test-codecov .build/debug/codecov/Options.json -v \(requiredCoverage)"
      ],
      "pre-commit": [
        "swift test --generate-linuxmain",
        "swift test --enable-code-coverage --enable-test-discovery",
        "swift run swift-test-codecov .build/debug/codecov/Options.json -v \(requiredCoverage)",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "swift run sourcedocs generate build -cra",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint --strict"
      ]
    ]
  ]).write()
#endif
