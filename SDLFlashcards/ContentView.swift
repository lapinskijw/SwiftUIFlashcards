//
//  ContentView.swift
//  SDLFlashcards
//
//  Created by James Lapinski on 6/1/20.
//  Copyright © 2020 James Lapinski. All rights reserved.
//

import SwiftUI
import RealmSwift

var cardsToSave: [Flashcard] = []
let realm = try! Realm()

struct ContentView: View {
    @State var showingCreateSet = false
    @State var showingStudyView = false
    @ObservedObject var flashcardSets = BindableResults(results: realm.objects(FlashcardSet.self))

    var body: some View {
        NavigationView {
            List(flashcardSets.results) { flashcardSet in
                NavigationLink(destination: StudyView(flashcardSet: flashcardSet)) {
                    Text(flashcardSet.name)
                }
            }
            .navigationBarTitle("Flashcard Sets", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showingCreateSet.toggle()
            }, label: {
                Text("Add Set")
            })).sheet(isPresented: $showingCreateSet) {
                CreateFlashCardSetView()
            }
        }
    }
}

struct CreateFlashCardSetView: View {
    @State var showCreateSetView = true
    @State var questionText: String = ""
    @State var answerText: String = ""
    @State var nameText: String = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("NAME")) {
                    HStack {
                        Text("Name:")
                        .frame(maxHeight: .infinity)
                        TextField("Enter set name", text:self.$nameText)
                        .frame(maxHeight: .infinity)
                    }
                }

                Section(header: Text("NEW CARD")) {
                    VStack(alignment: .center, spacing: 5) {
                        HStack(alignment: .center, spacing: 5) {
                            Text("Question:")
                            .frame(maxHeight: .infinity)
                            TextField("Enter question", text:self.$questionText)
                            .frame(maxHeight: .infinity)
                        }

                        HStack(alignment: .bottom, spacing: 5) {
                            Text("Answer:")
                            .frame(maxHeight: .infinity)
                            TextField("Enter answer", text:self.$answerText)
                            .frame(maxHeight: .infinity)
                        }
                    }
                }
                Section(header: CustomHeader(name: "", color: Color(red: 255.0/255.0, green: 250.0/255, blue: 240.0/255.0).opacity(0.1))) {
                    Button(action: {
                        appendCard(questionText: self.questionText, answerText: self.answerText)
                        self.questionText = ""
                        self.answerText = ""
                    }) {
                        Text("ADD FLASHCARD TO SET")
                            .foregroundColor(Color.blue)
                            .fontWeight(.bold)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color.clear)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Create New Set", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showCreateSetView.toggle()
                saveFlashcardSet(nameText:self.nameText)
            }, label: {
                Text("Save")
            }))
        }
    }
}

func saveFlashcardSet(nameText: String) {
    if cardsToSave.isEmpty {
        return
    }

    let flashcardSet = FlashcardSet()
    flashcardSet.name = nameText
    flashcardSet.cards.append(objectsIn: cardsToSave)

    realm.beginWrite()
    realm.add(flashcardSet)
    try! realm.commitWrite()
}

func appendCard(questionText: String, answerText: String) {
    let flashcard = Flashcard()
    flashcard.question = questionText
    flashcard.answer = answerText
    cardsToSave.append(flashcard)
}

struct CustomHeader: View {
    let name: String
    let color: Color

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                Spacer()
            }
            Spacer()
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(color)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        CreateFlashCardSetView()
    }
}
