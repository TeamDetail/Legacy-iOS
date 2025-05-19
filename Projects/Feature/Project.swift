import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Feature",
    targets: [
        .target(
            name: "Feature",
            destinations: [.iPhone],
            product: Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            bundleId: "com.detail.Feature",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.codeQuality],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .project(target: "DIContainer", path: .relativeToRoot("Projects/DIContainer")),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
                .project(target: "Component", path: .relativeToRoot("Projects/Component")),
                .external(name: "Moya"),
                .external(name: "GoogleMaps"),
                .external(name: "FlexibleKit"),
//                .external(name: "Legacy-DesignSystem"),
                .external(name: "FlowKit"),
                .external(name: "KakaoSDKAuth"),
                .external(name: "KakaoSDKCommon"),
                .external(name: "KakaoSDKUser")
            ],
            settings: .settings(
                base: [
                    "ENABLE_PREVIEWS": "YES"
                ]
            )
        )
    ]
)
