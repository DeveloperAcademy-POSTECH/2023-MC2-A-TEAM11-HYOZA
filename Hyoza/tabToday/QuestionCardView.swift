//
//  QuestionCardView.swift
//  Hyoza
//
//  Created by HAN GIBAEK on 2023/05/09.
//

import SwiftUI

struct QuestionCardView: View, Animatable {
    
    init(isOpen: Bool) {
        rotation = isOpen ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    var body: some View {
        ZStack {
            if rotation < 90 {
                // 열려있을 때
                OpenCardView()
            } else {
                // 닫혀있을 때
                ClosedCardListView()
                    .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
            }
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
}


struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.preview
        QuestionCardView(isOpen: true).environmentObject(persistenceController)
        QuestionCardView(isOpen: false).environmentObject(persistenceController)
    }
}

