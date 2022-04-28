// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(

    name: "SLA",

    products: [
        .library(
            name: "SLA",
            targets: ["SLA"]),
    ],

    dependencies: [
        .package(
            name: "SimpleLogs",
            url: "https://github.com/javiersalcedopuyo/SimpleLogsSwift",
            .branch("main")
        )
    ],

    targets: [
        .target(
            name: "SLA",
            dependencies: ["SimpleLogs"]),
        .testTarget(
            name: "SLATests",
            dependencies: ["SLA"]),
    ]
)
