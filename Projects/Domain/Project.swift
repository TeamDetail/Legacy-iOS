import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.detail.Domain",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.codeQuality],
            dependencies: [
                // 여기에 의존성 추가
            ]
        )
    ]
)
