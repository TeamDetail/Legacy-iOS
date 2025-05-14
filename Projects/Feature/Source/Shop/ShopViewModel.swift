import SwiftUI
import Combine

class ShopViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval = 0
    private let resetKey = "lastShopResetDate"
    private let resetInterval: TimeInterval = 24 * 60 * 60
    private var timer: AnyCancellable?
    
    init() {
        checkAndResetShop()
        startTimer()
    }
    
    func checkAndResetShop() {
        let now = Date()
        let lastReset = UserDefaults.standard.object(forKey: resetKey) as? Date ?? .distantPast
        let elapsed = now.timeIntervalSince(lastReset)
        
        if elapsed >= resetInterval {
            //MARK: 초기화 로직 추가
            UserDefaults.standard.set(now, forKey: resetKey)
            timeRemaining = resetInterval
        } else {
            //MARK: 로딩 로직 추가
            timeRemaining = resetInterval - elapsed
        }
    }
    
    private func startTimer() {
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    checkAndResetShop()
                }
            }
    }
}
