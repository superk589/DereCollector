// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DereCollector",
    dependencies: [
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Repeater.git", from: "1.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-SQLite.git", from: "3.0.0"),
        .package(url: "https://github.com/naoty/Timepiece.git", from: "1.0.0"),
        .package(url: "https://github.com/superk589/MessagePack.swift.git", .branch("master")),
        .package(url: "https://github.com/superk589/RijndaelSwift.git", .branch("master")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
        .package(url: "https://github.com/kareman/SwiftShell", from: "4.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "DereCollector",
            dependencies: [
                "PerfectHTTPServer",
                "PerfectRepeater",
                "PerfectSQLite",
                "Timepiece",
                "MessagePack",
                "RijndaelSwift",
                "SwiftyJSON",
                "SwiftShell",
                "CryptoSwift"
            ]
        ),
    ]
)
