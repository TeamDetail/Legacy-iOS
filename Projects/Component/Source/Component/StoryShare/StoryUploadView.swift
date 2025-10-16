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
    private init() {}
    
    // 뷰 전체를 UIImage로 캡처
    func capture(view: UIView, size: CGSize? = nil) {
        let targetSize = size ?? view.bounds.size
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let image = renderer.image { _ in
            view.drawHierarchy(in: CGRect(origin: .zero, size: targetSize), afterScreenUpdates: true)
        }
        self.capturedImage = image
    }
    
    // Instagram 스토리 공유
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
    let data = Card(
        cardId: 1,
        cardName: "손흥민",
        cardImageUrl: "https://cloudfront-ap-northeast-1.images.arcpublishing.com/chosun/6PJ3YC3PFZSBE3BU36H6TGW7XM.jpg",
        cardType: .start,
        nationAttributeName: "대한민국",
        lineAttributeName: "LAFC",
        regionAttributeName: "Son"
    )
    
    private let instagramAppId = "826905676417975"
    @ObservedObject private var photoStore = StoryPhotoStore.shared
    
    public init() {}
    
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
                    RuinCardView(data: data)
                        .frame(width: 200, height: 260)
                }
                .frame(width: 245, height: 310)
                .background(LegacyColor.Background.normal)
                .clipShape(size: 30)
                
                Text("LEGACY")
                    .font(.bitFont(size: 40))
                    .foregroundColor(.white)
                
                Button("스토리 공유") {
                    captureAndShare()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
    
    // MARK: - 전체 화면 캡처 후 공유
    private func captureAndShare() {
        let controller = UIHostingController(rootView: self)
        controller.view.frame = UIScreen.main.bounds
        
        photoStore.capture(view: controller.view, size: UIScreen.main.bounds.size)
        
        photoStore.shareToInstagram(appId: instagramAppId)
    }
}
