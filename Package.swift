// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "SwiftExtensions",
            targets: [
                "SwiftExtensions"
            ]
        ),
        .library(
            name: "CoreExtensions",
            targets: [
                "CoreExtensions"
            ]
        ),
        .library(
            name: "MacroExtensions",
            targets: [
                "MacroExtensions"
            ]
        ),
        .library(
            name: "UIExtensions",
            targets: [
                "UIExtensions"
            ]
        ),
        .library(
            name: "CollectionExtensions",
            targets: [
                "CollectionExtensions"
            ]
        ),
        .library(
            name: "FoundationExtensions",
            targets: [
                "FoundationExtensions"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "509.1.0"
        ),
        .package(
            url: "https://github.com/nicklockwood/SwiftFormat",
            exact: "0.53.1"
        )
    ],
    targets: [
        .target(
            name: "SwiftExtensions",
            dependencies: [
                "CoreExtensions",
                "UIExtensions",
                "FoundationExtensions",
                "CollectionExtensions"
            ]
        ),
        .target(
            name: "CoreExtensions"
        ),
        .target(
            name: "MacroExtensions",
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
        .target(
            name: "UIExtensions",
            dependencies: [
                "UIExtensionsCompilerPlugin"
            ]
        ),
        .target(
            name: "CollectionExtensions",
            dependencies: [
                "CoreExtensions"
            ]
        ),
        .target(
            name: "FoundationExtensions",
            dependencies: [
                "CoreExtensions",
                "FoundationExtensionsCompilerPlugin"
            ]
        ),
        .macro(
            name: "UIExtensionsCompilerPlugin",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                ),
                "MacroExtensions",
            ]
        ),
        .macro(
            name: "FoundationExtensionsCompilerPlugin",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                ),
                "MacroExtensions",
            ]
        ),
        .testTarget(
            name: "CoreExtensionsTests",
            dependencies: [
                "CoreExtensions"
            ]
        ),
        .testTarget(
            name: "UIExtensionsTests",
            dependencies: [
                "UIExtensions",
                "UIExtensionsCompilerPlugin",
                "MacroExtensions",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        ),
        .testTarget(
            name: "MacroExtensionsTests",
            dependencies: [
                "MacroExtensions",
                .product(
                    name: "SwiftDiagnostics",
                    package: "swift-syntax"
                )
            ]
        ),
        .testTarget(
            name: "CollectionExtensionsTests",
            dependencies: [
                "CollectionExtensions"
            ]
        ),
        .testTarget(
            name: "FoundationExtensionsTests",
            dependencies: [
                "FoundationExtensions",
                "FoundationExtensionsCompilerPlugin",
                "MacroExtensions",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        )
    ]
)
