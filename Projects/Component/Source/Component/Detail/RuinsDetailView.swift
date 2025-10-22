import SwiftUI
import UIKit
import CoreLocation
import Domain
import Kingfisher
import Shimmer

// MARK: - UIKit ScrollView Wrapper
struct UIKitScrollView<Content: View>: UIViewControllerRepresentable {
    let content: Content
    @Binding var scrollOffset: CGFloat
    @Binding var isExpanded: Bool
    
    init(scrollOffset: Binding<CGFloat>, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._scrollOffset = scrollOffset
        self._isExpanded = isExpanded
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scrollOffset: $scrollOffset, isExpanded: $isExpanded)
    }
    
    func makeUIViewController(context: Context) -> UIScrollViewViewController<Content> {
        let viewController = UIScrollViewViewController(rootView: content)
        viewController.scrollView.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ viewController: UIScrollViewViewController<Content>, context: Context) {
        viewController.hostingController.rootView = content
        viewController.hostingController.view.setNeedsLayout()
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        @Binding var scrollOffset: CGFloat
        @Binding var isExpanded: Bool
        
        init(scrollOffset: Binding<CGFloat>, isExpanded: Binding<Bool>) {
            self._scrollOffset = scrollOffset
            self._isExpanded = isExpanded
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.y
            
            DispatchQueue.main.async {
                self.scrollOffset = offset
                
                // 아래로 100pt 이상 스크롤하면 확장
                if offset > 100 && !self.isExpanded {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isExpanded = true
                    }
                }
                // 위로 스크롤해서 10pt 이하로 돌아오면 축소
                else if offset < 10 && self.isExpanded {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isExpanded = false
                    }
                }
            }
        }
    }
}

class UIScrollViewViewController<Content: View>: UIViewController {
    var scrollView: UIScrollView!
    var hostingController: UIHostingController<Content>!
    
    init(rootView: Content) {
        super.init(nibName: nil, bundle: nil)
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        hostingController = UIHostingController(rootView: rootView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(hostingController)
        view.addSubview(scrollView)
        scrollView.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

// MARK: - RuinsDetailView
public struct RuinsDetailView: View {
    public let data: RuinsDetailResponse
    public var onClose: (() -> Void)? = nil
    public let action: () -> Void
    public let onComment: (() -> Void)?
    public let commentData: [CommentResponse]?
    
    @Binding public var userLocation: CLLocation?
    
    @State private var scrollOffset: CGFloat = 0
    @State private var isExpanded: Bool = false
    
    private var dynamicHeight: CGFloat {
        isExpanded ? UIScreen.main.bounds.height * 0.75 : 400
    }
    
    private var canStartQuiz: Bool {
        guard let userLocation = userLocation else { return false }
        let ruinLocation = CLLocation(latitude: data.latitude, longitude: data.longitude)
        let distance = userLocation.distance(from: ruinLocation)
        return distance <= 50
    }
    
    public init(
        data: RuinsDetailResponse,
        commentData: [CommentResponse]?,
        onClose: (() -> Void)? = nil,
        action: @escaping () -> Void,
        onComment: (() -> Void)? = nil,
        userLocation: Binding<CLLocation?> = .constant(nil)
    ) {
        self.data = data
        self.commentData = commentData
        self.onClose = onClose
        self.action = action
        self.onComment = onComment
        self._userLocation = userLocation
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 8)
                .onTapGesture {
                    withAnimation { isExpanded.toggle() }
                }
            
            UIKitScrollView(scrollOffset: $scrollOffset, isExpanded: $isExpanded) {
                VStack(spacing: 16) {
                    RuinsDetailContent(
                        data: data,
                        onComment: { onComment?() }
                    )
                    .padding(.horizontal, 6)
                    .padding(.bottom, 14)
                    
                    if data.description.isEmpty {
                        Text("유적지 소개가 없어요!")
                            .font(.headline(.bold))
                            .foreground(LegacyColor.Label.normal)
                            .padding(.horizontal, 8)
                    } else {
                        Text(data.description)
                            .font(.body2(.medium))
                            .foreground(LegacyColor.Label.normal)
                            .padding(.horizontal, 8)
                        
                        LegacyDivider()
                    }
                    
                    if let commentData {
                        ForEach(commentData, id: \.self) { data in
                            CommentItem(data: data)
                        }
                    }
                    
                    Spacer(minLength: UIScreen.main.bounds.height * 0.3)
                }
            }
            .frame(height: dynamicHeight)
            .animation(.easeInOut(duration: 0.3), value: dynamicHeight)
            .clipShape(size: 24)
            
            AnimationButton {
                action()
            } label: {
                Text("퀴즈 풀고 탐험하기")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Blue.netural)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Blue.netural)
                    )
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 8)
        }
        .padding(6)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 24)
        .shadow(radius: 10)
        .padding(.horizontal, 4)
    }
}
