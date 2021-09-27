// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "FMIKit",
    platforms: [
        .iOS(.v14),
        .watchOS(.v4)],
    ],
    products: [
        .library(
            name: "FMIKit",
            targets: ["FMIKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FMIKit",
            dependencies: []),
        .testTarget(
            name: "FMIKitTests",
            dependencies: ["FMIKit"]),
    ],
    swiftLanguageVersions: [.v5]
)
