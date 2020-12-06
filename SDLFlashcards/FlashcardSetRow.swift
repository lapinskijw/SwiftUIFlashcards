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
            Text("\(flashcardSet.cards.count) Cards")
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.blue)
        .cornerRadius(8)
    }
    
}
