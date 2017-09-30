// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataDecoder",
    products: [
        .library(name: "DataDecoder", targets: ["DataDecoder"])
    ],
    targets: [
        .target(
            name: "DataDecoder"
        )
	],
    swiftLanguageVersions: [3, 4]
)
