// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "day",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(path: "../../lib"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "day",
            dependencies: [
                .product(name: "AdventOfCode", package: "lib"),
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
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
