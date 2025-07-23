import SwiftUI
import Component
import GoogleMaps
import CoreLocation
import Domain

public struct ExploreView: View {
    @StateObject private var quizViewModel = QuizViewModel()
    @StateObject private var quizStateViewModel = QuizStateViewModel()
    @StateObject private var userData = UserViewModel()
    @StateObject private var viewModel = ExploreViewModel()
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - 최소한의 State
    @State private var isZoomValid = false
    @State private var showDetail = false
    @State private var showMenu = false
    
    //MARK: 탭바 숨기는 바인딩
    @Binding var isTabBarHidden: Bool
    
    public init (
        _ isTabBarHidden: Binding<Bool>
    ) {
        self._isTabBarHidden = isTabBarHidden
    }
    
    public var body: some View {
        ZStack {
            if locationManager.isLoading {
                LegacyLoadingView(description: "위치를 가져오는 중이에요!")
            } else {
                GMSMapViewRepresentable(
                    userLocation: locationManager.location,
                    ruins: viewModel.ruins,
                    myBlocks: viewModel.myBlocks,
                    isZoomValid: $isZoomValid
                ) { location in
                    Task {
                        await viewModel.fetchMap(
                            .init(
                                minLat: location.southWest.latitude,
                                maxLat: location.northEast.latitude,
                                minLng: location.southWest.longitude,
                                maxLng: location.northEast.longitude
                            )
                        )
                    }
                } onPolygonTap: { ruinsId in
                    HapticManager.instance.impact(style: .light)
                    Task {
                        await viewModel.fetchRuinDeatil(ruinsId)
                        showDetail = true
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
                            LegacyTopBar(showMenu: $showMenu, data: data)
                        } else {
                            ErrorTopBar()
                        }
                        LegacyErrorAlert(
                            isPresented: $isZoomValid,
                            description: "줌을 많이 당기면 화면이\n멈출 수도 있어요!"
                        )
                    }
                }
                
                // 유적지 상세 로딩
                if viewModel.isLoadingDetail {
                    LoadingRuins()
                }
                
                // 상세 정보 오버레이
                if let detail = viewModel.ruinDetail, showDetail {
                    RuinsDetailOverlay(
                        detail: detail,
                        showDetail: $showDetail,
                        isTabBarHidden: $isTabBarHidden,
                        viewModel: viewModel
                    ) {
                        Task {
                            await quizViewModel.fetchQuiz(detail.ruinsId)
                            await quizViewModel.reset(userData.userInfo?.userId ?? 0) //MARK: 서버 고쳐지면 지울것
                            quizStateViewModel.startQuiz()
                            showDetail = false
                        }
                    }
                    
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isTabBarHidden = true
                        }
                    }
                }
            }
            
            // 퀴즈 플로우 전체
            QuizFlowOverlay(
                quizViewModel: quizViewModel,
                stateViewModel: quizStateViewModel,
                userData: userData, //MARK: 얘도 서버 고쳐지면 나중에 삭제
                ruinDetail: viewModel.ruinDetail
            )
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
        .onChange(of: quizStateViewModel.shouldHideTabBar) { shouldHide in
            withAnimation(.easeInOut(duration: 0.2)) {
                isTabBarHidden = shouldHide
            }
        }
        .task {
            locationManager.startUpdating()
        }
        .onDisappear {
            locationManager.stopUpdating()
        }
        .onAppear {
            //            locationManager.setTestLocation() //MARK: 테스트 할 때 사용
            Task {
                await viewModel.fetchMyBlock()
                await userData.fetchMyinfo()
            }
            SoundPlayer.shared.mainSound()
        }
    }
}
