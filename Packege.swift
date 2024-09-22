// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "YourProject",
    products: [
        .executable(name: "hazy", targets: ["h"])
    ],
    dependencies: [
        // Add any Swift dependencies if needed
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: [],
            path: "./",
            exclude: ["src/"],   // Exclude C files from the Swift target
            sources: ["main.swift", "Widgets/"],  // Include Swift files here
            cSettings: [
                .headerSearchPath("src"),  // For C headers
            ]
        ),
        .target(
            name: "WaylandC",
            dependencies: [],
            path: "src/",
            publicHeadersPath: ".",
            cSettings: [
                .define("USE_WLROOTS"),
            ]
        ),
        .testTarget(
            name: "YourProjectTests",
            dependencies: ["YourProject"]),
    ]
)
