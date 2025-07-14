import SwiftUI

public func formatTime(_ time: TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = (Int(time) % 3600) / 60
    let seconds = Int(time) % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}
