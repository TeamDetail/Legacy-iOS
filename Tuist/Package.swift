// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        baseSettings: .settings(
            base: .init(),
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        ),
        projectOptions: [
            "LocalSwiftPackage": .options(disableSynthesizedResourceAccessors: false)
        ]
    )
#endif

let package = Package(
    name: "Legacy-iOS",
    dependencies: [
        .package(url: "https://github.com/Moya/Moya", from: "15.0.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/Mercen-Lee/FlowKit", branch: "main"),
        .package(url: "https://github.com/googlemaps/ios-maps-sdk", from: "9.4.0"),
        .package(url: "https://github.com/eunchan2815/FlexibleKit", from: "1.0.1"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.24.2")
    ]
)
