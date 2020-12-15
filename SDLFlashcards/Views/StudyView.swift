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
    @State var cardIndex = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            FlippinRectangle(answerText: flashcardSet.cards[cardIndex].answer, questionText: flashcardSet.cards[cardIndex].question)
            HStack(alignment: .center, spacing: nil) {
                Button(action: {
                    if cardIndex > 0 {
                        cardIndex -= 1
                    }
                }) {
                    Text("Previous")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.body)
                }
                .buttonStyle(GradienButtonStyle(colors: [.darkRed, .lightRed]))
                Spacer()
                Button(action: {
                    if cardIndex < flashcardSet.cards.count - 1 {
                        cardIndex += 1
                    }
                }) {
                    Text("Next Card")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.body)
                }
                .buttonStyle(GradienButtonStyle(colors: [.darkGreen, .lightGreen]))
            }
            .padding([.horizontal], 10)
        }
    }
}

struct GradienButtonStyle: ButtonStyle {
    var colors: [Color]
    
    init(colors: [Color]) {
        self.colors = colors
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
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
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
            .background(self.flipped ? Color.blue : Color.green)
            .rotation3DEffect(self.flipped ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x:CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            .animation(.default)
            .cornerRadius(8)
            .padding([.horizontal], 10)
        }
        .padding([.horizontal], 20)
    }
}
