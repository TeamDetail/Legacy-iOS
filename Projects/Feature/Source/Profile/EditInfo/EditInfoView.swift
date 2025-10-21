import Domain
import SwiftUI
import FlowKit
import Shimmer
import Component
import Kingfisher

struct EditInfoView: View {
    @State private var showPhotoPicker: Bool = false
    @ObservedObject var viewModel: UserViewModel
    @Flow var flow
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("프로필 이미지")
                .font(.headline(.bold))
                .foreground(LegacyColor.Common.white)
            
            HStack(alignment: .bottom) {
                if let data = viewModel.image {
                    Image(uiImage: UIImage(data: data)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(size: 16)
                        .clipped()
                } else if let urlString = viewModel.userInfo?.imageUrl {
                    KFImage(URL(string: urlString))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(size: 16)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 200)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
                
                Spacer()
                
                AnimationButton {
                    showPhotoPicker = true
                } label: {
                    Text("이미지 변경")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .font(.caption1(.bold))
                        .foreground(LegacyColor.Purple.normal)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Purple.normal)
                        )
                }
            }
            
            Text("자기소개")
                .font(.headline(.bold))
                .foreground(LegacyColor.Common.white)
            
            VStack {
                Text("안녕하세요 팀 레거시입니다")
                    .font(.body2(.bold))
                    .foreground(LegacyColor.Common.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 12)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.top, 16)
        .overlay(alignment: .bottom) {
            AnimationButton {
                Task {
                    await viewModel.editProfile()
                }
            } label: {
                Text("변경사항 저장")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Status.positive)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Status.positive)
                    )
            }
            .disabled(viewModel.image == nil)
            .padding(.horizontal, 14)
            .padding(.bottom, 8)
        }
        .statusModal(
            message: viewModel.successMessage,
            statusType: .success
        ) {
            viewModel.successMessage = ""
            flow.pop()
            flow.pop()
        }
        .statusModal(
            message: viewModel.errorMessage,
            statusType: .failure
        ) {
            viewModel.errorMessage = ""
        }
        .backButton(title: "프로필 수정") {
            flow.pop()
        }
        .sheet(isPresented: $showPhotoPicker, onDismiss: {
            Task { await viewModel.editProfileImage() }
        }) {
            PhotoPicker(image: $viewModel.image)
        }
    }
}
