//
//  SwiftUIView.swift
//  Legacy-DesignSystem
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI

//MARK: 근데 분리할 필요 없어보임 일단 해놓는거
public struct PackButton: View {
    let title: String
    let description: String
    let credit: String
    let strokeColor: LegacyColorable
    let action: () -> Void
    
    public init(title: String, description: String, credit: String, strokeColor: LegacyColorable, action: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.credit = credit
        self.strokeColor = strokeColor
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.bitFont(size: 20))
                    .foreground(LegacyColor.Common.white)
                
                Text(description)
                    .font(.caption1(.extraBold))
                    .foreground(LegacyColor.Label.alternative)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                HStack {
                    Text(credit)
                        .foreground(LegacyColor.Yellow.netural)
                    Text("크레딧")
                        .foreground(LegacyColor.Common.white)
                }
                .font(.bitFont(size: 16))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 20)
            .padding(.horizontal, 18)
            .background(LegacyColor.Fill.normal)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2)
                    .foreground(strokeColor)
            }
            .clipShape(size: 20)
        }
    }
}

#Preview {
    PackButton(title: "삼국시대팩", description: "고구려&신라&백제특성카드가포함된 카드팩", credit: "300,000", strokeColor: LegacyColor.Blue.alternative) {}
}
