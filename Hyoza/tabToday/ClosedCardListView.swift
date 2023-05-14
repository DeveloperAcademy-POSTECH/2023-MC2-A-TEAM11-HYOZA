//
//  ClosedCardListView.swift
//  Hyoza
//
//  Created by HAN GIBAEK on 2023/05/12.
//

import SwiftUI

struct ClosedCardListView: View {
    @EnvironmentObject var persistenceController: PersistenceController
    var body: some View {
        VStack(spacing: 20) {
            Text("오늘의 질문을 골라주세요")
                .font(.title)
                .bold()
                .foregroundColor(.textBlack)
            Text("질문은 하루에 하나만 열어볼 수 있어요!")
                .font(.subheadline)
                .bold()
                .foregroundColor(.textLightGray)
            let easyQuestions = persistenceController.easyQuestions
            let hardQuestions = persistenceController.hardQuestions
            if easyQuestions.count >= 2 && hardQuestions.count >= 1 {
                closedCardView(question: easyQuestions[0], questionNumber: 1)
                closedCardView(question: hardQuestions[0], questionNumber: 2)
                closedCardView(question: easyQuestions[1], questionNumber: 3)
            }
        }
        .padding(20)
    }
    
    private func closedCardView(question: Question, questionNumber: Int) -> some View {
        var body: some View {
            CardView(backgroundColor: .cardLightOrange, cornerRadius: 15, shadowColor: .black.opacity(0.1), shadowRadius: 8){
                VStack{
                    Spacer()
                    HStack{
                        CapsuleView(content: {
                            Text(question.difficultyString)
                                .font(.footnote)
                                .foregroundColor(.textOrange)
                                .padding([.leading, .trailing], 12)
                                .padding([.top, .bottom], 4)
                        }, capsuleColor: .backGroundLightOrange)
                        Spacer()
                    }
                    Spacer()
                    Text("Q\(questionNumber)")
                        .font(.title)
                    Spacer()
                    Text("")
                    Spacer()
                }
            }
            .onTapGesture {
                persistenceController.addTimestamp(to: question)
                withAnimation(.easeInOut(duration: 0.5)) {
                    persistenceController.objectWillChange.send()
                }
            }
        }
        return body
    }
}

struct ClosedCardListView_Previews: PreviewProvider {
    static var previews: some View {
        let pc = PersistenceController.preview
        ClosedCardListView().environmentObject(pc)
    }
}
