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
                    "CFBundleShortVersionString": "1.0.0",
                    "CFBundleVersion": "1",
                    
                    // MARK: Map
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                    ],
                    "UILaunchStoryboardName": "LaunchScreen",
                    "NSLocationWhenInUseUsageDescription": "사용자의 현재 위치를 기반으로 주변 역사 유적지를 탐색하고, 해당 지역을 점령하는 게임 기능을 제공하기 위해 위치 정보를 사용합니다.",
                    "NSLocationAlwaysAndWhenInUseUsageDescription": "앱이 백그라운드에서도 사용자의 위치를 기반으로 점령 현황을 갱신하고, 인근 유적지 이벤트 알림을 제공하기 위해 위치 정보를 사용합니다.",
                    
                    //MARK: 가로모드 제한
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait"
                    ],
                    
                    //MARK: 다크모드만 지원
                    "UIUserInterfaceStyle": "Dark",
                    
                    // MARK: Instagram App ID
                    "META_APP_ID": "826905676417975",
                    
                    // MARK: Kakao & Instagram
                    "LSApplicationQueriesSchemes": [
                        "kakaokompassauth",
                        "kakaolink",
                        "instagram-stories",
                        "instagram"
                    ],
                    "CFBundleURLTypes": [
                        [
                            "CFBundleURLSchemes": [
                                "kakaob1cc10d264e3d7cb3022fab63c4632f3"
                            ]
                        ],
                        [
                            "CFBundleURLSchemes": [
                                "com.googleusercontent.apps.919022966133-jivjj8g1sir5u49j9h5fcfk5qh9lum9v"
                            ]
                        ]
                    ],
                    "NSAppTransportSecurity": [
                        "NSAllowsArbitraryLoads": true
                    ],
                    
                    //MARK: 푸시 알림 설정
                    "FirebaseAppDelegateProxyEnabled": true,
                    "UIBackgroundModes": [
                        "remote-notification"
                    ]
                ]
            ),
            sources: ["Source/**"],
            resources: ["Resource/**"],
            entitlements: .file(path: "Resource/Legacy.entitlements"),
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
                .external(name: "FirebaseMessaging"),
                .external(name: "GoogleSignIn"),
                .external(name: "GoogleSignInSwift")
            ]
        )
    ]
)
