import SwiftUI
import Component
import GoogleMaps
import CoreLocation
import Domain

public struct ExploreView: View {
    @StateObject private var quizViewModel = QuizViewModel()
    @StateObject private var quizStateViewModel = QuizStateViewModel()
    @EnvironmentObject private var userData: UserViewModel
    @StateObject private var viewModel = ExploreViewModel()
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - 최소한의 State
    @State private var isZoomValid = false
    @State private var showDetail = false
    @State private var showMenu = false
    
    //MARK: 탭바 숨기는 바인딩
    @Binding var isTabBarHidden: Bool
    
    @State private var showSearchModal = false
    
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
                        withAnimation(.appSpring) {
                            showMenu = false
                        }
                    }
                } onLocationButtonTap: {
                    
                }
                .ignoresSafeArea()
                
                VStack {
                    if let data = userData.userInfo {
                        LegacyTopBar(showMenu: $showMenu, data: data)
                    } else {
                        ErrorTopBar()
                    }
                    Spacer()
                }
                
                VStack {
                    MapUtilityView(isPresented: $isZoomValid) {
                        guard let location = locationManager.location else { return }
                        NotificationCenter.default.post(
                            name: NSNotification.Name("MoveToUserLocation"),
                            object: location
                        )
                    } searchAction: {
                        showSearchModal = true
                    }
                    .padding(.top, 80)
                    Spacer()
                }
                
                // 유적지 상세 로딩
                if viewModel.isLoadingDetail {
                    LoadingRuins()
                }
                
                // 상세 정보 오버레이
                if let detail = viewModel.ruinDetail, showDetail {
                    RuinsDetailModal(
                        showDetail: $showDetail,
                        isTabBarHidden: $isTabBarHidden,
                        detail: detail,
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
                        isTabBarHidden = true
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
            
            if showSearchModal {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.appSpring) {
                            showSearchModal = false
                        }
                    }
                
                RuinsSearchModal(
                    viewModel: viewModel,
                    close: {
                        withAnimation(.appSpring) {
                            showSearchModal = false
                        }
                    },
                    clickEvent: { selectedRuin in
                        let targetLocation = CLLocation(
                            latitude: selectedRuin.latitude,
                            longitude: selectedRuin.longitude
                        )
                        
                        // 지도 카메라 이동 알림
                        NotificationCenter.default.post(
                            name: NSNotification.Name("MoveToSelectedRuin"),
                            object: targetLocation
                        )
                        
                        withAnimation(.appSpring) {
                            showSearchModal = false
                        }
                    }
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .onChange(of: locationManager.location) { newLocation in
            guard let newLocation, newLocation.horizontalAccuracy < 100 else { return }
            
            // 1. 근처 유적지 필터
            if let nearbyRuin = viewModel.ruins?.first(where: { ruin in
                let distance = newLocation.distance(from: CLLocation(latitude: ruin.latitude, longitude: ruin.longitude))
                return distance < 50 // 50m 안쪽이면 알람
            }) {
                // 2. FCM 토큰 가져오기
                if let token = UserDefaults.standard.string(forKey: "FCMToken") {
                    let request = AlarmRequest(
                        lat: nearbyRuin.latitude,
                        lng: nearbyRuin.longitude,
                        title: "근처에 유적지가 있어요!",
                        targetToken: token
                    )
                    Task {
                        await viewModel.pushAlarm(request)
                    }
                }
            }
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
            isTabBarHidden = shouldHide
        }
        .task {
            locationManager.startUpdating()
        }
        .onDisappear {
            locationManager.stopUpdating()
        }
        .onAppear {
            //MARK: 테스트 할 때 사용
            //            locationManager.stopUpdating()
            //            locationManager.setTestLocation()
            Task {
                await viewModel.fetchMyBlock()
                await userData.fetchMyinfo()
            }
            //            if let token = UserDefaults.standard.string(forKey: "FCMToken") {
            //                let request = AlarmRequest(
            //                    lat: 35.6657913817,
            //                    lng: 128.4219071616,
            //                    title: "테스트용 알람!",
            //                    targetToken: token
            //                )
            //                Task {
            //                    await viewModel.pushAlarm(request)
            //                    print("알람 요청 보냄")
            //                }
            //            } else {
            //                print("FCMToken 없음, 먼저 토큰 확인 필요")
            //            }
            //            SoundPlayer.shared.mainSound()
        }
    }
}
