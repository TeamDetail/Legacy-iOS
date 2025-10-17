//
//  StoryUploadView.swift
//  Component
//
//  Created by 김은찬 on 10/16/25.
//

import SwiftUI
import UIKit
import Domain
import Kingfisher

// MARK: - 공유용 상태 관리
class StoryPhotoStore: ObservableObject {
    static let shared = StoryPhotoStore()
    @Published var capturedImage: UIImage?
    @Published var isCapturing = false
    
    private init() {}
    
    func capture(view: UIView, size: CGSize? = nil, completion: @escaping () -> Void) {
        let targetSize = size ?? view.bounds.size
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            let image = renderer.image { _ in
                view.drawHierarchy(in: CGRect(origin: .zero, size: targetSize), afterScreenUpdates: true)
            }
            self.capturedImage = image
            completion()
        }
    }
    
    func shareToInstagram(appId: String) {
        guard let stickerData = capturedImage?.pngData() else { return }
        
        let pasteboardItems: [String: Any] = [
            "com.instagram.sharedSticker.backgroundImage": stickerData
        ]
        
        guard let urlScheme = URL(string: "instagram-stories://share?source_application=\(appId)"),
              UIApplication.shared.canOpenURL(urlScheme) else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/kr/app/instagram/id389801252")!)
            return
        }
        
        let options: [UIPasteboard.OptionsKey: Any] = [.expirationDate: Date().addingTimeInterval(60*5)]
        UIPasteboard.general.setItems([pasteboardItems], options: options)
        UIApplication.shared.open(urlScheme, options: [:])
    }
}

// MARK: - StoryUploadView
public struct StoryUploadView: View {
    let data: Card
    private var instagramAppId: String {
        Bundle.main.object(forInfoDictionaryKey: "META_APP_ID") as? String ?? ""
    }
    @ObservedObject private var photoStore = StoryPhotoStore.shared
    @State private var isImageLoaded = false
    
    // 자동 캡처 트리거
    let shouldAutoCapture: Bool
    let onComplete: (() -> Void)?
    
    public init(
        data: Card,
        shouldAutoCapture: Bool = false,
        onComplete: (() -> Void)? = nil
    ) {
        self.data = data
        self.shouldAutoCapture = shouldAutoCapture
        self.onComplete = onComplete
    }
    
    public var body: some View {
        ZStack {
            Image(icon: .cardBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("2025. 03. 09.")
                    .font(.body1(.medium))
                    .foreground(LegacyColor.Label.netural)
                
                Text("- 카드 획득 -")
                    .font(.bitFont(size: 48))
                    .foreground(LegacyColor.Common.white)
                
                VStack {
                    RuinCardViewForStory(data: data, isImageLoaded: $isImageLoaded)
                        .frame(width: 200, height: 260)
                }
                .frame(width: 245, height: 310)
                .background(LegacyColor.Background.normal)
                .clipShape(size: 30)
                
                Text("LEGACY")
                    .font(.bitFont(size: 40))
                    .foregroundColor(.white)
            }
            .padding()
            .onChange(of: isImageLoaded) { loaded in
                if loaded && shouldAutoCapture {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        captureAndShare()
                    }
                }
            }
            
            if photoStore.isCapturing {
                Color.clear
            }
        }
    }
    
    private func captureAndShare() {
        photoStore.isCapturing = true
        
        let controller = UIHostingController(rootView: self)
        controller.view.frame = UIScreen.main.bounds
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.addSubview(controller.view)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                photoStore.capture(view: controller.view, size: UIScreen.main.bounds.size) {
                    controller.view.removeFromSuperview()
                    photoStore.isCapturing = false
                    photoStore.shareToInstagram(appId: instagramAppId)
                    onComplete?()
                }
            }
        }
    }
}

// MARK: - RuinCardViewForStory
struct RuinCardViewForStory: View {
    let data: Card
    @Binding var isImageLoaded: Bool
    
    var body: some View {
        if let url = URL(string: data.cardImageUrl) {
            ZStack(alignment: .topLeading) {
                KFImage(url)
                    .onSuccess { _ in
                        isImageLoaded = true
                    }
                    .onFailure { _ in
                        isImageLoaded = false
                    }
                    .placeholder { _ in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: .infinity)
                            .aspectRatio(140/196, contentMode: .fit)
                    }
                    .resizable()
                    .aspectRatio(140/196, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipShape(size: 12)
                
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.black.opacity(0.0), location: 0.4),
                        .init(color: Color.black.opacity(0.8), location: 0.7),
                        .init(color: Color.black.opacity(1.0), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(size: 12)
                
                VStack(alignment: .leading, spacing: 4) {
                    CardCategory(category: data.nationAttributeName, backgroundColor: LegacyColor.Primary.normal)
                    CardCategory(category: data.lineAttributeName, backgroundColor: LegacyColor.Blue.netural)
                    CardCategory(category: data.regionAttributeName, backgroundColor: LegacyColor.Red.netural)
                    
                    Spacer()
                    
                    Text(data.cardName)
                        .font(.bitFont(size: 16))
                        .foreground(LegacyColor.Common.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .padding(12)
                
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .foreground(LegacyColor.Line.netural)
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(140/196, contentMode: .fit)
        }
    }
}
