//
//  OpenCardView.swift
//  Hyoza
//
//  Created by HAN GIBAEK on 2023/05/12.
//

import SwiftUI

struct OpenCardView: View {
    @Environment(\.displayScale) var displayScale
    
    @State var imageToShareInQuestionCard: ImageWrapper? = nil
    
    @Binding var degree: Double
    @Binding var selectedQuestion: Question?
    
    var body: some View {
        if let selectedQuestion = selectedQuestion {
            if selectedQuestion.answer != nil{
                AnswerView(selectedQuestion: $selectedQuestion)
                    .rotation3DEffect(Angle(degrees: degree), axis: (0, 1, 0))
            } else {
                NoAnswerView(selectedQuestion: $selectedQuestion)
                    .rotation3DEffect(Angle(degrees: degree), axis: (0, 1, 0))
            }
        }
        //        GeometryReader { geo in
        //            if let selectedQuestion = selectedQuestion {
        //                VStack{
        //                    HStack {
        //                        CapsuleView(content: {
        //                            Text(selectedQuestion.difficultyString)
        //                                .font(.footnote)
        //                                .foregroundColor(.textOrange)
        //                                .padding([.leading, .trailing], 12)
        //                                .padding([.top, .bottom], 4)
        //                        }, capsuleColor: .backGroundLightOrange)
        //                        Spacer()
        //                        Text(Date().fullString)
        //                            .font(.footnote)
        //                            .foregroundColor(.tapBarDarkGray)
        //                        Spacer()
        //                        Button(action: {
        //                            Task {
        //                                let viewToRender = self.frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        //
        //                                guard let image = await viewToRender.render(scale: displayScale) else {
        //                                    return
        //                                }
        //                                imageToShareInQuestionCard = ImageWrapper(image: image)
        //                            }
        //                        }) {
        //                            Image(systemName: "square.and.arrow.up")
        //                                .foregroundColor(.textOrange)
        //                        }
        //                        .sheet(item: $imageToShareInQuestionCard) { imageToShareInQuestionCard in
        //                            ActivityViewControllerWrapper(items: [imageToShareInQuestionCard.image], activities: nil)
        //                        }
        //                    }
        //                    Spacer()
        //                    Text(selectedQuestion.wrappedQuestion)
        //                        .font(.title)
        //                        .foregroundColor(.textBlack)
        //                        .bold()
        //                    Spacer()
        //                    NavigationLink {
        //                        QnAView(data: selectedQuestion, isEditing: true)
        //                    } label: {
        //                        CapsuleView(content: {
        //                            Text("답변하기")
        //                                .bold()
        //                                .font(.title2)
        //                                .foregroundColor(.textWhite)
        //                                .padding([.top, .bottom], 20)
        //                                .frame(width: geo.size.width)
        //                        }, capsuleColor: .backGroundOrange)
        //                    }
        ////                    TempAnswerView(selectedQuestion: selectedQuestion)
        //
        //                }
        //                .rotation3DEffect(Angle(degrees: degree), axis: (0, 1, 0))
        //                .onAppear {
        //                    print(selectedQuestion.answer?.answer)
        //                }
        //            }
        //        }
    }
}

struct NoAnswerView: View {
    @Environment(\.displayScale) var displayScale
    @State var imageToShareInQuestionCard: ImageWrapper? = nil
    @Binding var selectedQuestion: Question?
    
    var body: some View {
        if let selectedQuestion = selectedQuestion {
            GeometryReader { geo in
                VStack{
                    HStack {
                        CapsuleView(content: {
                            Text(selectedQuestion.difficultyString)
                                .font(.footnote)
                                .foregroundColor(.textOrange)
                                .padding([.leading, .trailing], 12)
                                .padding([.top, .bottom], 4)
                        }, capsuleColor: .backGroundLightOrange)
                        Spacer()
                        Text(Date().fullString)
                            .font(.footnote)
                            .foregroundColor(.tapBarDarkGray)
                        Spacer()
                        Button(action: {
                            Task {
                                let viewToRender = self.frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
                                
                                guard let image = await viewToRender.render(scale: displayScale) else {
                                    return
                                }
                                imageToShareInQuestionCard = ImageWrapper(image: image)
                            }
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.textOrange)
                        }
                        .sheet(item: $imageToShareInQuestionCard) { imageToShareInQuestionCard in
                            ActivityViewControllerWrapper(items: [imageToShareInQuestionCard.image], activities: nil)
                        }
                    }
                    Spacer()
                    Text(selectedQuestion.wrappedQuestion)
                        .font(.title)
                        .foregroundColor(.textBlack)
                        .bold()
                    Spacer()
                    NavigationLink {
                        QnAView(data: selectedQuestion, isEditing: true)
                    } label: {
                        CapsuleView(content: {
                            Text("답변하기")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.textWhite)
                                .padding([.top, .bottom], 20)
                                .frame(width: geo.size.width)
                        }, capsuleColor: .backGroundOrange)
                    }
                    //                    TempAnswerView(selectedQuestion: selectedQuestion)
                    
                }
            }
        }
    }
}

struct AnswerView: View {
    @Binding var selectedQuestion: Question?
    
    var body: some View {
        if let question = selectedQuestion {
            if let answer = selectedQuestion?.answer {
                Text(question.wrappedQuestion)
                    .font(.title)
                    .foregroundColor(.textBlack)
                    .bold()
                Spacer()
                Text(answer.answerDetail)
            }
        }
    }
}

//struct TempAnswerView: View {
//    var selectedQuestion: Question?
//    var body: some View {
//        if selectedQuestion?.wrappedAnswer.answerDetail != nil {
//            Text(selectedQuestion?.wrappedQuestion ?? "")
//                .font(.title)
//                .foregroundColor(.textBlack)
//                .bold()
//            Spacer()
//            Text(selectedQuestion?.wrappedAnswer.answerDetail ?? "")
//        }
//    }
//}


struct OpenCardView_Previews: PreviewProvider {
    static var previews: some View {
        let pc = PersistenceController.preview
        OpenCardView(degree: .constant(90), selectedQuestion: .constant(pc.easyQuestions[0]))
        OpenCardView(degree: .constant(0), selectedQuestion: .constant(pc.easyQuestions[0]))
    }
}
