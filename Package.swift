// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "perso-interactive-ondevice-sdk-swift",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .visionOS(.v2)
    ],
    products: [
        .library(
            name: "PersoInteractiveOnDeviceSDK",
            targets: [
                "PersoInteractiveOnDeviceSDK"
            ]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "PersoInteractiveOnDeviceSDK",
            url: "https://github.com/perso-ai/perso-interactive-ondevice-sdk-swift/releases/download/1.0.0/PersoInteractiveOnDeviceSDK.xcframework.zip",
            checksum: "24b182b758d99979ecad38dad69e004ce2fd299fdf7de0f7b6cd46d6e082f9ca"
        )
    ]
)
