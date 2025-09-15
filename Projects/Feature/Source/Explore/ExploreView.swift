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
    
    // MARK: - 알람 관련 State
    @State private var lastAlarmLocation: CLLocation?
    @State private var alarmSentRuinIds: Set<Int> = []
    private let minAlarmDistance: CLLocationDistance = 100
    
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
                        
                        // 지도 데이터가 새로 로드된 후 근처 유적지 알람 체크
                        await checkNearbyRuinsAlarm()
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
            
            //MARK: 일정 거리 이상 이동했을 때만 알람 체크
            if shouldCheckAlarm(for: newLocation) {
                Task {
                    await checkNearbyRuinsAlarm()
                    lastAlarmLocation = newLocation
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
            Task {
                await viewModel.fetchMyBlock()
                await userData.fetchMyinfo()
                
                //MARK: 위치 테스트
                //                locationManager.stopUpdating()
                //                locationManager.setTestLocation()
                await checkNearbyRuinsAlarm()
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// 알람을 체크해야 하는지 판단
    private func shouldCheckAlarm(for newLocation: CLLocation) -> Bool {
        guard let lastLocation = lastAlarmLocation else {
            return true // 처음 위치면 체크
        }
        
        let distance = newLocation.distance(from: lastLocation)
        return distance >= minAlarmDistance
    }
    
    /// 근처 유적지 알람 체크 및 발송
    private func checkNearbyRuinsAlarm() async {
        guard let currentLocation = locationManager.location,
              let ruins = viewModel.ruins,
              let token = UserDefaults.standard.string(forKey: "FCMToken") else {
            return
        }
        
        // 50m 반경 내 유적지 찾기
        let nearbyRuins = ruins.filter { ruin in
            let ruinLocation = CLLocation(latitude: ruin.latitude, longitude: ruin.longitude)
            let distance = currentLocation.distance(from: ruinLocation)
            return distance < 50 && !alarmSentRuinIds.contains(ruin.ruinsId)
        }
        
        // 가장 가까운 유적지에만 알람 발송
        if let closestRuin = nearbyRuins.min(by: { ruin1, ruin2 in
            let distance1 = currentLocation.distance(from: CLLocation(latitude: ruin1.latitude, longitude: ruin1.longitude))
            let distance2 = currentLocation.distance(from: CLLocation(latitude: ruin2.latitude, longitude: ruin2.longitude))
            return distance1 < distance2
        }) {
            let request = AlarmRequest(
                lat: closestRuin.latitude,
                lng: closestRuin.longitude,
                title: "근처에 유적지가 있어요!",
                targetToken: token
            )
            
            await viewModel.pushAlarm(request)
            alarmSentRuinIds.insert(closestRuin.ruinsId)
        }
    }
}
