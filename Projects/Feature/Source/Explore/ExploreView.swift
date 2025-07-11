import SwiftUI
import Component
import GoogleMaps
import CoreLocation
import Domain

public struct ExploreView: View {
    @StateObject private var userData = UserViewModel()
    @StateObject private var viewModel = ExploreViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var isZoomValid = false
    @State private var showDetail = false
    @State private var showMenu = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            if locationManager.isLoading {
                LegacyLoadingView(
                    description: "위치를 가져오는 중이에요!"
                )
            } else {
                GMSMapViewRepresentable(
                    userLocation: locationManager.location,
                    ruins: viewModel.ruins,
                    myBlocks: viewModel.myBlocks,
                    isZoomValid: $isZoomValid
                ) { location in
                    Task {
                        //MARK: 유적지 정보 불러오기
                        await viewModel.fetchMap(
                            .init(
                                minLat: location.southWest.latitude,
                                maxLat: location.northEast.latitude,
                                minLng: location.southWest.longitude,
                                maxLng: location.northEast.longitude
                            )
                        )
                    }
                    //MARK: 유적지 Tab
                } onPolygonTap: { ruinsid in
                    Task {
                        await viewModel.fetchRuinDeatil(
                            ruinsid
                        )
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            showDetail = true
                        }
                    }
                } onMapTap: {
                    if showMenu {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            showMenu = false
                        }
                    }
                }
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    VStack {
                        if let data = userData.userInfo {
                            LegacyTopBar(
                                showMenu: $showMenu,
                                data: data
                            )
                        } else {
                            ErrorTopBar()
                        }
                        LegacyErrorAlert(
                            isPresented: $isZoomValid,
                            description: "줌을 많이 당기면 화면이\n멈출 수도 있어요!"
                        )
                    }
                }
                if let detail = viewModel.ruinDetail, showDetail {
                    RuinsDetailOverlay(
                        detail: detail,
                        showDetail: $showDetail,
                        viewModel: viewModel
                    )
                }
            }
        }
        .onChange(of: locationManager.location) { newLocation in
            guard let newLocation, newLocation.horizontalAccuracy < 100 else { return }
            
            Task {
                await viewModel.createBlock(
                    .init(
                        latitude: newLocation.coordinate.latitude,
                        longitude: newLocation.coordinate.longitude
                    )
                )
            }
        }
        .task {
            locationManager.startUpdating()
        }
        .onDisappear {
            locationManager.stopUpdating()
        }
        .onAppear {
            Task {
                await viewModel.fetchMyBlock()
                await userData.fetchMyinfo()
            }
        }
    }
}
