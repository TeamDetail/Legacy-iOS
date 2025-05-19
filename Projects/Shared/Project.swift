import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "Shared",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.detail.Shared",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.codeQuality],
            dependencies: [
//                .external(name: "Legacy-DesignSystem")
            ]
        )
    ]
)
