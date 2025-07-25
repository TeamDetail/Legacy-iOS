import Kingfisher
import SwiftUI
import Shimmer
import Domain

public struct CryingView: View {
    let wrongNumbers: [Int]
    let action: () -> Void
    let dismiss: () -> Void
    
    public init(
        dismiss: @escaping () -> Void,
        wrongNumbers: [Int],
        action: @escaping () -> Void
    ) {
        self.wrongNumbers = wrongNumbers
        self.action = action
        self.dismiss = dismiss
    }
    
    public var body: some View {
        LegacyModalView(dismiss) {
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(icon: .crying)
                
                Text("문제를 맞추지 못했어요...")
                    .font(.title2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text("\(wrongNumbers.map { "\($0 + 1)번" }.joined(separator: ", ")) 문제의 답이 잘못되었어요.\n다시 도전해보세요!")
                    .font(.headline(.medium))
                    .foreground(LegacyColor.Label.alternative)
                    .multilineTextAlignment(.center)
                
                Button {
                    withAnimation(.spring()) {
                        action()
                    }
                } label: {
                    Text("다시 도전하기")
                        .frame(width: 245, height: 40)
                        .font(.body1(.bold))
                        .foreground(LegacyColor.Blue.netural)
                        .background(LegacyColor.Fill.netural)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 2)
                                .foreground(LegacyColor.Blue.netural)
                        )
                }
                
                Spacer()
            }
            .frame(width: 370, height: 640)
            .clipShape(size: 20)
            .padding(.horizontal, 16)
            .background(LegacyColor.Background.normal)
        }
    }
}
