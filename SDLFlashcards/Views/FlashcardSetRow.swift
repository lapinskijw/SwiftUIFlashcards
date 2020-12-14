//
//  FlashcardSetRow.swift
//  SDLFlashcards
//
//  Created by James Lapinski on 12/4/20.
//  Copyright © 2020 James Lapinski. All rights reserved.
//

import Foundation
import SwiftUI

struct FlashcardSetRow: View {
    var flashcardSet: FlashcardSet
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(flashcardSet.name)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
            Text("\(flashcardSet.cards.count) Cards")
                .font(.system(size: 20))
                .foregroundColor(.white)
            Spacer()
            HStack(alignment: .center) {
                NavigationLink(destination: StudyView(flashcardSet: flashcardSet)) {
                    Image("settings")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
                Spacer()
                NavigationLink(
                    destination: StudyView(flashcardSet: flashcardSet),
                    label: {
                        Text("START")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                    })
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 25, alignment: .leading)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 140, alignment: .leading)
        .background(Color.blue)
        .cornerRadius(8)
    }
    
}
