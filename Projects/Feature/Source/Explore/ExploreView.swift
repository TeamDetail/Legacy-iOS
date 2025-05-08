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
    
    public init() {}
    
    public var body: some View {
        ZStack {
            if locationManager.isLoading {
                ProgressView("위치를 가져오는 중입니다")
            } else {
                GMSMapViewRepresentable(userLocation: locationManager.location)
                    .ignoresSafeArea()
                    .overlay(alignment: .top) {
                        LegacyTopBar()
                    }
            }
        }
        .task {
//            let location = await locationManager.requestAndWaitForLocation()
//            locationManager.updateLocation(location)
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
