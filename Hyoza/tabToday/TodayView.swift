//
//  TodayView.swift
//  Hyoza
//
//  Created by 최명근 on 2023/05/07.
//
//
//
//  TodayView.swift
//  Hyoza
//
//  Created by 최명근 on 2023/05/07.

import SwiftUI
import CoreData

struct TodayView: View {
    
    @State var isQuestionBoxViewTapped: Bool = false
    @State var easyQuestions: [Question] = []
    @State var hardQuestions: [Question] = []
    @State var isContinueIconSmall: Bool = false
    @State var continueText: String? = nil
    @State var continueTextOpacity: Double = 1.0
    @State var isContinueIconAnimating: Bool = false
    @State var continuousDayCount: Int = 0
    @State var selectedQuestion: Question? = PersistenceController.shared.selectedQuestion
    @State var tempTextStorage: String? = nil
    @State var openDegree: Double = 90
    @State var closedDegree: Double = 0
    
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text(Date().dateOnlyString)
                        .font(.system(.footnote))
                    HStack {
                        Text("오늘의 질문")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.textBlack)
                        Spacer()
                        ContinueIconView(text: $continueText, textOpacity: $continueTextOpacity, continuousDayCount: $continuousDayCount)
                            .onTapGesture {
                                if !isContinueIconAnimating {
                                    makeCoutinueIconLargeAndSmall()
                                }
                            }
                    }
                }
                Spacer()
                ZStack {
                    if isQuestionBoxViewTapped {
                        CardView(cornerRadius: 16, shadowColor: .black.opacity(0.05), shadowRadius: 12) {
                            QuestionCardView(openDegree: $openDegree, closedDegree: $closedDegree, easyQuestions: $easyQuestions, hardQuestions: $hardQuestions, selectedQuestion: $selectedQuestion)
                        }
                    } else {
                        CardView(cornerRadius: 16, shadowColor: .black.opacity(0.05), shadowRadius: 12) {
                            QuestionBoxView(easyQuestions: $easyQuestions, hardQuestions: $hardQuestions, isQuestionBoxViewTapped: $isQuestionBoxViewTapped)
                        }
                        .onTapGesture {
                            self.isQuestionBoxViewTapped.toggle()
                        }
                    }
                }
                Spacer()
            }
            .padding(20)
            
        }
        .background(Color.backGroundWhite.ignoresSafeArea())
        .onAppear() {
            continuousDayCount = AttendanceManager().isAttending ? AttendanceManager().getAttendanceDay() : 0
            
            switch continuousDayCount {
            case 0:
                tempTextStorage = "작성을 시작해보세요!"
                continueText = tempTextStorage
            case 1...:
                tempTextStorage = "연속 작성 \(continuousDayCount)일째 돌파!"
                continueText = tempTextStorage
            default:
                tempTextStorage = "무언가 잘못됐어요 :("
                continueText = tempTextStorage
            }
            
            if !isContinueIconAnimating {
                self.isContinueIconAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    makeContinueIconSmall()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.isContinueIconAnimating = false
                    }
                }
            }
            if selectedQuestion != nil {
                closedDegree = -90
                openDegree = 0
                isQuestionBoxViewTapped.toggle()
            }
        }
        .onDisappear() {
            continueTextOpacity = 1
        }
    }
    
    private func makeContinueIconSmall() {
        self.continueTextOpacity = 0
        withAnimation(.easeInOut(duration: 0.7)) {
            self.continueText = nil
        }
    }
    
    private func makeContinueIconLarge() {
        withAnimation(.easeInOut(duration: 0.7)) {
            self.continueText = tempTextStorage
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.continueTextOpacity = 1
        }
    }
    
    private func makeCoutinueIconLargeAndSmall() {
        self.isContinueIconAnimating = true
        makeContinueIconLarge()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            makeContinueIconSmall()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.isContinueIconAnimating = false
            }
        }
    }
}

struct ContinueIconView: View {
    @Binding var text: String?
    @Binding var textOpacity: Double
    @Binding var continuousDayCount: Int
    
    var body: some View {
        CardView(cornerRadius: 16, shadowColor: .black.opacity(0.05), shadowRadius: 12) {
            HStack {
                switch continuousDayCount {
                case 1..<4:
                    Text("💛")
                case 4..<8:
                    Text("🧡")
                case 8..<15:
                    Text("❤️")
                case 15...:
                    Text("❤️‍🔥")
                default:
                    Text("🤍")
                }
                if let text {
                    Text(text)
                        .font(.caption)
                        .bold()
                        .opacity(textOpacity)
                }
            }
        }
//        .onAppear() {
//            continuousDayCount = AttendanceManager().isAttending ? AttendanceManager().getAttendanceDay() : 0
//        }
        
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
