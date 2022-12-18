// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "day",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(path: "../../lib"),
    ],
    targets: [
        .executableTarget(
            name: "day",
            dependencies: [
                .product(name: "AdventOfCode", package: "lib"),
            ],
            path: ".",
            exclude: [ "test.swift", "input.in" ],
            sources: [ "src.swift" ]
        ),

        .testTarget(
            name: "test",
            dependencies: ["day"],
            path: ".",
            exclude: [ "src.swift", "input.in" ],
            sources: [ "test.swift" ]
        ),
    ]
)
