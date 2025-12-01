//
//  ExploreViewModel.swift
//  Feature
//
//  Created by 김은찬 on 6/19/25.
//

import Foundation
import DIContainer
import Alamofire
import Shared
import Domain
import Data

public class ExploreViewModel: ObservableObject {
    @Published var ruins: [RuinsPositionResponse]?
    @Published var ruinDetail: RuinsDetailResponse?
    @Published var myBlocks: [CreateBlockResponse]?
    @Published var isLoadingDetail = false
    
    @Published var searchResult: [RuinsDetailResponse]?
    @Published var isLoadingSearch = false
    
    @Inject var exploreRepository: any ExploreRepository
    @Inject var nameRepository: any AuthRepository
    
    @MainActor
    func fetchMap(_ location: MapBoundsRequest) async {
        do {
            ruins = try await exploreRepository.fetchMap(location)
        } catch {
            print("유적지 로딩 실패: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchRuinDeatil(_ id: Int) async {
        isLoadingDetail = true
        do {
            ruinDetail = try await exploreRepository.fetchRuinDeatil(id)
        } catch {
            print(error)
        }
        isLoadingDetail = false
    }
    
    @MainActor
    func createBlock(_ location: CreateBlockRequest) async {
        do {
            _ = try await exploreRepository.createBlock(location)
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
    
    @MainActor
    func pushAlarm(_ request: AlarmRequest) async {
        AF.request(
            serverUrl + "/alarm/location",
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .responseDecodable(of: BaseResponse<String>.self) { response in
            switch response.result {
            case .success(let alarmResponse):
                print("푸시 성공: \(alarmResponse)")
                print("status: \(alarmResponse.status), data: \(alarmResponse.data)")
            case .failure(let error):
                print("푸시 실패: \(error)")
            }
        }
    }
    
    @MainActor
    func searchRuins(_ ruinsName: String) async {
        isLoadingSearch = true
        do {
            searchResult = try await exploreRepository.searchRuins(ruinsName)
            isLoadingSearch = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func updateName(_ name: String) async {
        do {
            try await nameRepository.updateName(name)
        } catch {
            print(error.localizedDescription)
        }
    }
}
