//
//  ContentView.swift
//  Feature
//
//  Created by dgsw30 on 5/5/25.
//


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
                    isZoomValid: $isZoomValid
                ) { location in
                    print("좌하단: \(location.southWest.latitude), \(location.southWest.longitude)")
                    print("우상단: \(location.northEast.latitude), \(location.northEast.longitude)")
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
                } onPolygonTap: { ruinsid in
                    Task {
                        await viewModel.fetchRuinDeatil(
                            ruinsid
                        )
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            showDetail = true
                        }
                    }
                }
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    VStack {
                        if let data = userData.userInfo {
                            LegacyTopBar(data: data)
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
                    ZStack(alignment: .bottom) {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showDetail = false
                                    viewModel.ruinDetail = nil
                                }
                            }
                        
                        RuinsDetailView(data: detail) {
                            withAnimation {
                                showDetail = false
                                viewModel.ruinDetail = nil
                            }
                        }
                        .padding(.horizontal, 6)
                        .padding(.bottom, 4)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: showDetail)
                    }
                }
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
                await userData.fetchMyinfo()
            }
        }
    }
}

#Preview {
    ExploreView()
}
