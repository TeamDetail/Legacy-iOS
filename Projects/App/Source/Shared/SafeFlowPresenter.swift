//
//  SafeFlowPresenter.swift
//  Legacy
//
//  Created by 김은찬 on 6/9/25.
//

import SwiftUI
import FlowKit
import Feature

public struct SafeFlowPresenter<Content: View>: View {
    @StateObject private var flow: FlowProvider
    @StateObject private var userViewModel = UserViewModel()
    
    public init(rootView: Content, customNavigationController: NavigationControllerSettings? = nil) {
        _flow = StateObject(wrappedValue: FlowProvider(rootView: rootView,
                                                       customNavigationController: customNavigationController))
    }
    
    public var body: some View {
        FlowPresenterProxy(flow: flow)
            .environmentObject(userViewModel)
    }
}

private struct FlowPresenterProxy: View {
    @ObservedObject var flow: FlowProvider
    
    var body: some View {
        flow.present()
            .environmentObject(flow)
    }
}
