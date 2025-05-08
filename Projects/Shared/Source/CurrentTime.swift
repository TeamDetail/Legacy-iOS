import SwiftUI

public func startTimer(currentTime: Binding<String>) {
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
        updateTime(currentTime: currentTime)
    }
}


public func updateTime(currentTime: Binding<String>) {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    currentTime.wrappedValue = dateFormatter.string(from: currentDate)
}
