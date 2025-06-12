//
//  ContentView.swift
//  Feature
//
//  Created by dgsw30 on 5/5/25.
//


import SwiftUI
import GoogleMaps
import CoreLocation

public struct ExploreView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isZoomValid = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            if locationManager.isLoading {
                ProgressView("위치를 가져오는 중입니다")
            } else {
                GMSMapViewRepresentable(userLocation: locationManager.location) { location, zoom in
                    print("좌하단: \(location.southWest.latitude), \(location.southWest.longitude)")
                    print("우상단: \(location.northEast.latitude), \(location.northEast.longitude)")
                    
//                    DispatchQueue.main.async {
//                        if zoom > 15 {
//                            isZoomValid = true
//                        } else {
//                            isZoomValid = false
//                        }
//                    }
                    //TODO: 줌 15 넘었을때 alert 띄워주기
                }
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    LegacyTopBar()
                }
            }
        }
        .task {
            locationManager.startUpdating()
        }
        .onDisappear {
            locationManager.stopUpdating()
        }
//        .alert("오류 발생", isPresented: $isZoomValid, actions: {
//            Button("확인", role: .cancel) {}
//        }, message: {
//            Text("줌을 많이 당기지 말아주세요")
//        })
    }
}

#Preview {
    ExploreView()
}
