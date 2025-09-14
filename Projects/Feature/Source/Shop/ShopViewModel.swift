import Foundation
import DIContainer
import Combine
import Domain
import Data

class ShopViewModel: ObservableObject, APIMessageable {
    @Published var successMessage: String = ""
    @Published var errorMessage: String = ""
    
    @Published var storeData: StoreResponse?
    @Published var buyCount: Int?
    @Published var timeRemaining: TimeInterval = 0
    private var timer: AnyCancellable?
    @Inject var shopRepository: any StoreRepository
    
    init() {
        checkAndResetShop()
        startTimer()
    }
    
    var groupedCardPacks: [(StoreType, [CardPack])] {
        guard let storeData = storeData else { return [] }
        
        return StoreType.allCases
            .sorted(by: { $0.sortOrder < $1.sortOrder })
            .compactMap { storeType in
                let filteredPacks = storeData.cardpack.filter { $0.storeType == storeType }
                return filteredPacks.isEmpty ? nil : (storeType, filteredPacks)
            }
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
                    Task {
                        await self.fetchShop()
                    }
                    //MARK: 초기화 로직
                }
            }
    }
    
    @MainActor
    func fetchShop() async {
        do {
            let response = try await shopRepository.fetchStore()
            storeData = response
            buyCount = response.buyCount
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func buyCard(_ cardpackId: Int) async {
        do {
            try await shopRepository.buyCard(cardpackId)
            successMessage = "카드팩 구매 성공! 인벤토리를 확인하세요."
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
}
