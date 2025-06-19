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
    @StateObject private var viewModel = ExploreViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var isZoomValid = false
    
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
                }
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    VStack {
                        LegacyTopBar()
                        LegacyErrorAlert(
                            isPresented: $isZoomValid,
                            description: "줌을 많이 당기면 타일이\n보이지 않을수 있어요!"
                        )
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
    }
}

#Preview {
    ExploreView()
}
