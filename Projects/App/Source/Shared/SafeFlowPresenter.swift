//
//  SafeFlowPresenter.swift
//  Legacy
//
//  Created by 김은찬 on 6/9/25.
//

import SwiftUI
import FlowKit

public struct SafeFlowPresenter<Content: View>: View {
    @StateObject private var flow: FlowProvider
    
    public init(rootView: Content, customNavigationController: NavigationControllerSettings? = nil) {
        _flow = StateObject(wrappedValue: FlowProvider(rootView: rootView,
                                                       customNavigationController: customNavigationController))
    }
    
    public var body: some View {
        FlowPresenterProxy(flow: flow)
    }
}

private struct FlowPresenterProxy: View {
    @ObservedObject var flow: FlowProvider
    
    var body: some View {
        flow.present()
            .environmentObject(flow)
    }
}
