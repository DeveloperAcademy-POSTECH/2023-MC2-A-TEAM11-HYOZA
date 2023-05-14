//
//  QuestionBoxView.swift
//  Hyoza
//
//  Created by HAN GIBAEK on 2023/05/09.
//

import SwiftUI

struct QuestionBoxView: View {
    @Binding var isQuestionBoxViewTapped: Bool
    
    var body: some View {
            VStack {
                Text("오늘의 질문 꾸러미")
                    .font(.title)
                    .bold()
                    .foregroundColor(.textBlack)
                Button {
                    isQuestionBoxViewTapped = true
                } label: {
                    Image(systemName: "shippingbox.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.backGroundLightOrange)
                        .padding(30)
                }
            }
    }
}

struct QuestionBoxView_Previews: PreviewProvider {
    static var previews: some View {
//        let pc = PersistenceController.preview
        
        QuestionBoxView(isQuestionBoxViewTapped: .constant(false))
    }
}
