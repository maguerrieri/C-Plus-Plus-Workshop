// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "C++Workshop",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "C++Workshop",
            targets: ["C++Workshop"]),
        .executable(name: "CardGameExe",
                    targets: ["CardGameExe"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CardGameExe",
            dependencies: ["CardGame"],
            publicHeadersPath: "."),
        .target(
            name: "CardGame",
            dependencies: ["C++Workshop"],
            publicHeadersPath: ".",
            cxxSettings: [ .unsafeFlags(["-fmodules", "-fcxx-modules"]) ]),
        .target(
            name: "C++Workshop",
            dependencies: [],
            publicHeadersPath: ".",
            cxxSettings: [ .unsafeFlags(["-fmodules", "-fcxx-modules"]) ]),
        .testTarget(
            name: "C++WorkshopTests",
            dependencies: ["C++Workshop"],
            cxxSettings: [ .unsafeFlags(["-fmodules", "-fcxx-modules"]) ]),
    ],
    cxxLanguageStandard: .cxx1z
)
