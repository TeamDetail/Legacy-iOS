//
//  ExploreView.swift
//  Feature
//
//  Created by 김은찬 on 7/19/25.
//

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
    
    //MARK: 탭바 숨김 상태
    @Binding var isTabBarHidden: Bool
    @State private var showSearchModal = false
    
    // MARK: - NickName Modal State
    @State private var showNickModal = false
    @State private var nickName: String = ""
    @FocusState private var isNickFocused: Bool
    
    // MARK: - 알람 관련
    @State private var lastAlarmLocation: CLLocation?
    @State private var alarmSentRuinIds: Set<Int> = []
    private let minAlarmDistance: CLLocationDistance = 100
    
    // MARK: 키보드 높이
    @State private var keyboardHeight: CGFloat = 0
    @State private var isNickKeyboardFocused = false
    
    public init(_ isTabBarHidden: Binding<Bool>) {
        self._isTabBarHidden = isTabBarHidden
    }
    
    public var body: some View {
        ZStack {
            if locationManager.isLoading {
                LegacyLoadingView("위치를 가져오는 중이에요!")
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
                } onLocationButtonTap: {}
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
                
                // 유적지 상세 모달
                if let detail = viewModel.ruinDetail, showDetail {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            
                            let locationBinding = Binding<CLLocation?>(
                                get: { locationManager.location },
                                set: { newValue in
                                    locationManager.location = newValue
                                }
                            )
                            
                            RuinsDetailModal(
                                showDetail: $showDetail,
                                detail: detail,
                                viewModel: viewModel,
                                userLocation: locationBinding,
                                onShowDetail: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isTabBarHidden = true
                                    }
                                },
                                onDismissDetail: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isTabBarHidden = false
                                    }
                                }
                            ) {
                                Task {
                                    await quizViewModel.fetchQuiz(detail.ruinsId)
                                    await quizViewModel.reset(userData.userInfo?.userId ?? 0)
                                    quizStateViewModel.startQuiz()
                                    showDetail = false
                                }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .id(detail.ruinsId)
                    .ignoresSafeArea()
                }
            }
            
            // MARK: 퀴즈 플로우 전체
            QuizFlowOverlay(
                quizViewModel: quizViewModel,
                stateViewModel: quizStateViewModel,
                userData: userData, //MARK: 임시 — 서버 수정 후 제거
                ruinDetail: viewModel.ruinDetail
            )
            
            // MARK: 검색 모달
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
            
            if showNickModal {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    NickNameModal(
                        nickName: $nickName,
                        isTextFieldFocused: $isNickFocused
                    ) {
                        Task {
                            await viewModel.updateName(nickName)
                            withAnimation(.spring) {
                                showNickModal = false
                            }
                            userData.userInfo = nil
                            await userData.fetchMyinfo()
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, isNickKeyboardFocused ? 140 : 20)
                    .animation(.spring(response: 0.55, dampingFraction: 0.85), value: isNickKeyboardFocused)
                    Spacer()
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .onAppear { isNickFocused = true }
            }
        }
        
        // MARK: 위치 변경
        .onChange(of: locationManager.location) { newLocation in
            guard let newLocation, newLocation.horizontalAccuracy < 100 else { return }
            
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
        // MARK: 탭바 숨김 동기화
        .onChange(of: quizStateViewModel.shouldHideTabBar) { shouldHide in
            isTabBarHidden = shouldHide
        }
        .onChange(of: quizStateViewModel.didCompleteQuiz) { didComplete in
            guard didComplete, let ruin = viewModel.ruinDetail else { return }
            Task {
                await viewModel.createBlock(
                    .init(
                        latitude: ruin.latitude,
                        longitude: ruin.longitude
                    )
                )
                quizStateViewModel.didCompleteQuiz = false
            }
        }
        .task {
            locationManager.startUpdating()
        }
        .onAppear {
            SoundPlayer.shared.mainSound()
        }
        .onDisappear {
            locationManager.stopUpdating()
        }
        .task {
            await viewModel.fetchMyBlock()
            await userData.fetchMyinfo()
            await checkNearbyRuinsAlarm()
            if let data = userData.userInfo, data.nickname.isEmpty {
                await MainActor.run {
                    withAnimation(.appSpring) {
                        showNickModal = true
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notif in
            if let rect = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                keyboardHeight = rect.cgRectValue.height
                withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                    isNickKeyboardFocused = true
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                keyboardHeight = 0
                isNickKeyboardFocused = false
            }
        }
        
    }
}

// MARK: - Private Methods
extension ExploreView {
    /// 알람 체크 여부
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
