// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iHacker",
    platforms: [.iOS(.v15),
                .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Landmarks",
//            type: .static, // 当时static时，无法预览swiftUI
            targets: ["Landmarks"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Quick", path: "/Users/boyer/hsg/Quick"),
        .package(name: "Nimble", path: "/Users/boyer/hsg/Nimble"),
    ],
    targets: [
        .target(
            name: "Landmarks",
            dependencies: [],
            resources: [
                    // .process("Resources"),
                       .copy("Resources/landmarkData.json")
            ]
        ),
        .testTarget(
            name: "LandmarksTests",
            dependencies: ["Landmarks","Quick","Nimble"]),
    ]
)

// SPM demo
let myLibrary = Target.target(name: "MyLibrary")
let myLibraryLib = Product.library(name: "MyLibrary", targets: ["MyLibrary"]) // type: .static,
package.targets.append(myLibrary)
package.products.append(myLibraryLib)

//添加项目
addLib(name: "Wesplit")
addLib(name: "Pen")

func addLib(name:String) {
    let target = Target.target(name: name)
    let library = Product.library(name: name, targets: [name]) //type: .static,
    package.targets.append(target)
    package.products.append(library)
}
