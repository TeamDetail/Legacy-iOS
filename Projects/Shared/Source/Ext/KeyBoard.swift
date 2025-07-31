//
//  KeyBoard.swift
//  Skool
//
//  Created by dgsw30 on 12/30/24.
//

import Foundation
import SwiftUI

public extension UIApplication {
    func hideKeyboard() {
        let scenes = UIApplication.shared.connectedScenes
        guard let windowScene = scenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: @retroactive UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

public extension View {
    func hideKeyBoard() -> some View {
        self.onAppear(perform : UIApplication.shared.hideKeyboard)
    }
}
