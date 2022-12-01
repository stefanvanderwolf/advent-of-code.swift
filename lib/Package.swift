// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "lib",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(name: "AdventOfCode", targets: ["AdventOfCode"]),
    ],
    targets: [
        .target(name: "AdventOfCode", path: "."),
    ]
)
