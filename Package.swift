// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TweakPane",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "TweakPane",
            targets: ["TweakPane"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TweakPane",
            dependencies: []
        ),
        .testTarget(
            name: "TweakPaneTests",
            dependencies: ["TweakPane"]
        ),
    ]
)
