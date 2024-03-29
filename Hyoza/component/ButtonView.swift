//
//  ButtonView.swift
//  Hyoza
//
//  Created by sei on 2023/05/16.
//

import SwiftUI

struct ButtonView: View {
    var buttonColor: Color = Color.buttonColor
    var content: String
    var action: (() -> Void)?
    
    var body: some View {
        if let action {
            Button {
                action()
            } label: {
                HStack {
                    Spacer()
                    Text(content).font(.system(size: 20))
                        .foregroundColor(.buttonTextColor)
                        .padding(10)
                        .padding(.vertical, 8)
                    Spacer()
                }
                .background(buttonColor.cornerRadius(100))
            }
            .buttonBorderShape(.capsule)
//            .padding(20)
            .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 4)
        } else {
            HStack {
                Spacer()
                Text(content).font(.system(size: 20))
                    .foregroundColor(.buttonTextColor)
                    .padding(10)
                    .padding(.vertical, 8)
                Spacer()
            }
            .background(buttonColor.cornerRadius(100))
//            .padding(20)
            .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 4)
        }
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        var selected = 3
        ButtonView(content: (selected < 2 ? "다음" : "시작하기"))
    }
}
