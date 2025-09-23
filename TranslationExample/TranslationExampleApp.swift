//
//  TranslationExampleApp.swift
//  TranslationExample
//
//  Created by Francisco Miranda Soares on 22/09/25.
//

import SwiftUI

@main
struct TranslationExampleApp: App {
    var body: some Scene {
        WindowGroup {
            FlashCardView(song: Song(id: 1, title: "Imagine", artist: "John Lennon", verses: ["Imagine there's no heaven", "It's easy if you try","No hell below us"]), verseIndex: 1)
        }
    }
}
