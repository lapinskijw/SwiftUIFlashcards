//
//  StudyView.swift
//  SDLFlashcards
//
//  Created by James Lapinski on 6/1/20.
//  Copyright © 2020 James Lapinski. All rights reserved.
//

import SwiftUI

struct StudyView: View {
    @State var flipped = false
    var flashcardSet: FlashcardSet
    var cardIndex = 0

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(self.flashcardSet.cards) { flashcard in
                        FlippinRectangle(answerText: flashcard.answer, questionText: flashcard.question)
                    }
                }
            }
            .navigationBarTitle(Text(self.flashcardSet.name), displayMode: .inline)
            .padding()
            .frame(width: geometry.size.width)
            .cornerRadius(8)
        }
    }
}

struct FlippinRectangle: View {
    var answerText: String
    var questionText: String
    @State var flipped = false

    var body: some View {
        HStack {
            Button(action: {
                self.flipped.toggle()
            }) {
                if flipped {
                    Text(answerText)
                        .rotation3DEffect(self.flipped ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x:CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                        .animation(.default)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.white)
                } else {
                    Text(questionText)
                        .rotation3DEffect(self.flipped ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x:CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                        .animation(.default)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.white)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300)
            .background(self.flipped ? Color.blue : Color.green)
            .rotation3DEffect(self.flipped ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x:CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            .animation(.default)
        }
    }
}
