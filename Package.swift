// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwiftUiMVVMTemplate",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftUiMVVMTemplate",
            targets: ["SwiftUiMVVMTemplate"]),
    ],
    dependencies: [
        // Add your dependencies here
    ],
    targets: [
        .target(
            name: "SwiftUiMVVMTemplate",
            dependencies: [],
            path: "SwiftUi MVVM Template",
            exclude: ["Assets.xcassets"],
            sources: [
                ".",
                "App",
                "Core",
                "Modules",
                "Shared"
            ])
    ]
)
