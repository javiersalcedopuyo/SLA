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

    dependencies: [],

    targets: [
        .target(
            name: "SLA",
            dependencies: []),
        .testTarget(
            name: "SLATests",
            dependencies: ["SLA"]),
    ]
)
