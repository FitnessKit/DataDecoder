// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataDecoder",
    //platforms: [.iOS("8.0"), .macOS("10.10"), .tvOS("9.0"), .watchOS("2.0")],
    products: [
        .library(name: "DataDecoder", targets: ["DataDecoder"])
    ],
    targets: [
        .target(
            name: "DataDecoder"
        ),
        .testTarget(
            name: "DataDecoderTests",
            dependencies: [
                "DataDecoder"
            ]
        ),

	]
)
