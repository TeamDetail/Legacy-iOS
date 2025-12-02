//
//  SoundSettingView.swift
//  Feature
//
//  Created by 김은찬 on 12/2/25.
//

import SwiftUI
import Component

struct SoundSettingView: View {
    @State private var isSoundOn = UserDefaults.isBgmEnabled
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("사운드")
                .font(.heading2(.bold))
                .foreground(LegacyColor.Common.white)
                .padding(.horizontal, 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("배경 음악 켜기")
                        .font(.body1(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text("앱 사용 중에 배경 음악을 재생합니다.")
                        .font(.caption1(.medium))
                        .foreground(LegacyColor.Label.netural)
                }
                
                Spacer()
                
                Toggle("", isOn: bindingForToggle())
                    .labelsHidden()
                    .tint(LegacyColor.Primary.normal)
            }
            .padding()
            .background(LegacyColor.Background.normal)
            .clipShape(size: 20)
        }
    }
}

private extension SoundSettingView {
    func bindingForToggle() -> Binding<Bool> {
        Binding(
            get: { UserDefaults.isBgmEnabled },
            set: { newValue in
                UserDefaults.isBgmEnabled = newValue
                isSoundOn = newValue
                
                if newValue {
                    SoundPlayer.shared.mainSound()
                } else {
                    SoundPlayer.shared.stop()
                }
            }
        )
    }
}
