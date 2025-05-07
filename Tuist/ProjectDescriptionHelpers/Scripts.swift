import ProjectDescription

public extension TargetScript {
    static let codeQuality = TargetScript.pre(
        path: .relativeToRoot("Tuist/Scripts/CodeQualityRunScript.sh"),
        name: "CodeQuality",
        basedOnDependencyAnalysis: false
    )
}
