//
//  FlashcardSet.swift
//  SDLFlashcards
//
//  Created by James Lapinski on 6/1/20.
//  Copyright © 2020 James Lapinski. All rights reserved.
//

import Foundation
import RealmSwift

class FlashcardSet: Object, Identifiable {
    let cards = RealmSwift.List<Flashcard>()
    @objc dynamic var name: String = ""
}

class Flashcard: Object, Identifiable {
    @objc dynamic var question: String = ""
    @objc dynamic var answer: String = ""
}
