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
    @Published var myBlocks: [CreateBlockResponse]?
    @Published var isLoadingDetail = false
    
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
        isLoadingDetail = true
        do {
            ruinDetail = try await exploreRepository.fetchRuinDeatil(
                id
            )
            isLoadingDetail = false
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func createBlock(_ location: CreateBlockRequest) async {
        do {
            _ = try await exploreRepository.createBlock(
                .init(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
            )
            await fetchMyBlock()
        } catch {
            print("블록 생성 에러\(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchMyBlock() async {
        do {
            myBlocks = try await exploreRepository.fetchMyBlock()
        } catch {
            print("블록 에러\(error.localizedDescription)")
        }
    }
}
