import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Legacy",
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    ),
    settings: .settings(
        base: .init()
            .otherLinkerFlags(["$(inherited) -ObjC"]),
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ],
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "Legacy",
            destinations: [.iPhone],
            product: Environment.forPreview.getBoolean(default: false) ? .staticFramework : .app,
            bundleId: "com.detail.LegacyApp",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    //MARK: map
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                    ],
                    "UILaunchStoryboardName": "LaunchScreen",
                    "NSLocationWhenInUseUsageDescription": "이 앱은 지도에 현재 위치를 표시하기 위해 위치 정보를 사용합니다.",
                    "NSLocationAlwaysAndWhenInUseUsageDescription": "이 앱은 지도에 현재 위치를 표시하기 위해 위치 정보를 사용합니다.",
                    
                    //MARK: 가로모드 제한
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait"
                    ],
                    
                    //MARK: 다크모드만 지원
                    "UIUserInterfaceStyle": "Dark",
                    
                    //MARK: kakao
                    "LSApplicationQueriesSchemes": [
                        "kakaokompassauth",
                        "kakaolink"
                    ],
                    "CFBundleURLTypes": [
                        [
                            "CFBundleURLSchemes": [
                                "kakaob1cc10d264e3d7cb3022fab63c4632f3"
                            ]
                        ]
                    ],
                    "NSAppTransportSecurity": [
                        "NSAllowsArbitraryLoads": true
                    ]
                ]
            ),
            sources: ["Source/**"],
            resources: ["Resource/**"],
            scripts: [.codeQuality],
            dependencies: [
                .project(target: "Feature", path: .relativeToRoot("Projects/Feature")),
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .project(target: "Data", path: .relativeToRoot("Projects/Data")),
                .project(target: "DIContainer", path: .relativeToRoot("Projects/DIContainer")),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
                .project(target: "Component", path: .relativeToRoot("Projects/Component")),
                .external(name: "GoogleMaps"),
                .external(name: "KakaoSDKAuth"),
                .external(name: "KakaoSDKCommon"),
            ]
        )
    ]
)
