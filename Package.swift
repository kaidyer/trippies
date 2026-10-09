// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Trippies",
    platforms: [
        .iOS("18.0"),
        .macOS(.v14)
    ],
    products: [
        .library(name: "TrippiesCore", targets: ["TrippiesCore"])
    ],
    targets: [
        .target(
            name: "TrippiesCore",
            path: "Trippies",
            exclude: ["Assets.xcassets", "TrippiesApp.swift", "Views"]
        ),
        .testTarget(
            name: "TrippiesCoreTests",
            dependencies: ["TrippiesCore"]
        )
    ]
)
