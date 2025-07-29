import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Data",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.detail.Data",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.codeQuality],
            dependencies: [
                // 여기에 의존성 추가
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
                .external(name: "Swinject"),
                .external(name: "Realm"),
                .external(name: "RealmSwift"),
            ]
        )
    ]
)
