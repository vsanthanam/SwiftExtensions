// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "SwiftUtilities",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "SwiftUtilities",
            targets: [
                "SwiftUtilities"
            ]
        ),
        .library(
            name: "MacroUtilities",
            targets: [
                "MacroUtilities"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "509.0.0"
        ),
        .package(
            url: "https://github.com/nicklockwood/SwiftFormat",
            exact: "0.52.11"
        )
    ],
    targets: [
        .target(
            name: "SwiftUtilities",
            dependencies: [
                "SwiftUtilitiesCompilerPlugin"
            ]
        ),
        .target(
            name: "MacroUtilities",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                )
            ]
        ),
        .macro(
            name: "SwiftUtilitiesCompilerPlugin",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                ),
                "MacroUtilities",
            ]
        ),
        .testTarget(
            name: "SwiftUtilitiesTests",
            dependencies: [
                "SwiftUtilities",
                "SwiftUtilitiesCompilerPlugin",
                "MacroUtilities",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        ),
        .testTarget(
            name: "MacroUtilitiesTests",
            dependencies: [
                "MacroUtilities",
                .product(
                    name: "SwiftDiagnostics",
                    package: "swift-syntax"
                )
            ]
        )
    ]
)
