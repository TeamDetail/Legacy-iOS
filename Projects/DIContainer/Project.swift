import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DIContainer",
    targets: [
        .target(
            name: "DIContainer",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.detail.DIContainer",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.codeQuality],
            dependencies: [
                // 여기에 의존성 추가
                .external(name: "Swinject"),
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
            ]
        )
    ]
)
