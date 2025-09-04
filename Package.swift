// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GlimmerKit",
	platforms: [
		.iOS(.v16),
		.macOS(.v15),
		.watchOS(.v10)
	],
    products: [
        .library(name: "GlimmerKit",targets: ["GlimmerKit"]),
    ],
    targets: [
        .target(
            name: "GlimmerKit")
    ]
)
