import SwiftUI
import Component
import GoogleMaps
import CoreLocation
import Domain

public struct ExploreView: View {
    @StateObject private var quizData = QuizViewModel()
    @StateObject private var userData = UserViewModel()
    @StateObject private var viewModel = ExploreViewModel()
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - State
    @State private var wrongNumbers: [Int] = []
    @State private var isZoomValid = false
    @State private var showDetail = false
    @State private var showMenu = false
    @State private var showQuiz = false
    @State private var showFinishView = false
    @State private var showClap = false
    @State private var showCrying = false
    
    public init() {}
    
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
                    Task {
                        await viewModel.fetchRuinDeatil(ruinsId)
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
                
                if let detail = viewModel.ruinDetail, showDetail {
                    RuinsDetailOverlay(
                        detail: detail,
                        showDetail: $showDetail,
                        viewModel: viewModel
                    ) {
                        Task {
                            await quizData.fetchQuiz(detail.ruinsId)
                            withAnimation {
                                showQuiz = true
                                showDetail = false
                            }
                        }
                    }
                }
            }
            
            if showQuiz, let detail = viewModel.ruinDetail {
                QuizView(
                    userId: userData.userInfo?.userId ?? 0,
                    quizId: detail.ruinsId,
                    name: detail.name,
                    onDismiss: {
                        withAnimation {
                            showQuiz = false
                        }
                    },
                    onComplete: {
                        withAnimation {
                            showQuiz = false
                            showClap = true
                        }
                    },
                    onFailure: { wrongs in
                        withAnimation {
                            wrongNumbers = wrongs
                            showQuiz = false
                            showCrying = true
                        }
                    }
                )
                .zIndex(1000)
                .transition(.opacity.combined(with: .scale))
            }
            
            if showClap {
                ClapView {
                    withAnimation {
                        showClap = false
                        showFinishView = true
                    }
                }
                .zIndex(1500)
                .transition(.opacity.combined(with: .scale))
            }
        }
        .overlay {
            Group {
                if showFinishView, let reward = viewModel.ruinDetail {
                    FinishQuizView(data: reward) {
                        withAnimation {
                            showFinishView = false
                        }
                    }
                    .zIndex(2000)
                    .transition(.opacity.combined(with: .scale))
                }
                
                if showCrying, let detail = viewModel.ruinDetail {
                    CryingView(wrongNumbers: wrongNumbers) {
                        withAnimation {
                            showCrying = false
                            showQuiz = true
                        }
                    }
                    .zIndex(2000)
                    .transition(.opacity.combined(with: .scale))
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
            SoundPlayer.shared.mainSound()
        }
    }
}
