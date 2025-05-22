import SwiftUI
import Combine

class ShopViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval = 0
    private var timer: AnyCancellable?
    
    init() {
        checkAndResetShop()
        startTimer()
    }
    
    func checkAndResetShop() {
        let now = Date()
        let calendar = Calendar.current
        
        let todayMidnight = calendar.startOfDay(for: now)
        guard let nextMidnight = calendar.date(byAdding: .day, value: 1, to: todayMidnight) else { return }
        
        let timeUntilNextMidnight = nextMidnight.timeIntervalSince(now)
        timeRemaining = timeUntilNextMidnight
    }
    
    private func startTimer() {
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.checkAndResetShop()
                    //MARK: 초기화 로직
                }
            }
    }
}
