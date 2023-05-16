//
//  QuestionBoxView.swift
//  Hyoza
//
//  Created by HAN GIBAEK on 2023/05/09.
//

import SwiftUI

struct QuestionBoxView: View {
    private let persistenceController = PersistenceController.shared
    @Binding var easyQuestions: [Question]
    @Binding var hardQuestions: [Question]
    @Binding var isQuestionBoxViewTapped: Bool
    
    var body: some View {
            VStack {
                Text("오늘의 질문 꾸러미")
                    .font(.title)
                    .bold()
                    .foregroundColor(.textBlack)
                Button {
                    easyQuestions = persistenceController.filteredQuestion(which: .isNotChoosenAndEasy)
                    hardQuestions = persistenceController.filteredQuestion(which: .isNotChoosenAndHard)
                    self.isQuestionBoxViewTapped.toggle()
                } label: {
                    Image("questionBoxImage")
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
        let pc = PersistenceController.preview
        
        QuestionBoxView(easyQuestions: .constant(pc.easyQuestions), hardQuestions: .constant(pc.hardQuestions), isQuestionBoxViewTapped: .constant(false))
    }
}
