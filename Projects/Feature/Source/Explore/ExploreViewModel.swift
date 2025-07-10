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
    @Published var ruinDetail: RuinsDetailResponse?
    
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
        } catch {
            print("Error occurred: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchRuinDeatil(_ id: Int) async {
        do {
            ruinDetail = try await exploreRepository.fetchRuinDeatil(
                id
            )
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func createBlock(_ location: CreateBlockRequest) async {
        do {
            try await exploreRepository.createBlock(
                .init(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
            )
        } catch {
            print(error)
        }
    }
}
