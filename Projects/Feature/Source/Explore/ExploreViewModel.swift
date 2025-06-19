//
//  ExploreViewModel.swift
//  Feature
//
//  Created by 김은찬 on 6/19/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class ExploreViewModel: ObservableObject {
    @Published var ruins: [RuinsPositionResponse]?
    
    @Inject var exploreRepository: any ExploreRepository
    
    @MainActor
    func fetchMap(_ location: MapBoundsRequest) async {
        do {
            ruins = try await exploreRepository.fetchMap(
                .init(
                    minLat: location.minLat,
                    maxLat: location.maxLat,
                    minLng: location.minLng,
                    maxLng: location.maxLng
                )
            )
            guard let hello = ruins else { return }
            print(hello)
            
        } catch {
            print("Error occurred: \(error.localizedDescription)")
            dump(error)
        }
    }
}
