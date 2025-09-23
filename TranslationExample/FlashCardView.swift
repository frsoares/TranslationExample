//
//  FlashCardView.swift
//  TranslationExample
//
//  Created by Francisco Miranda Soares on 22/09/25.
//

import SwiftUI
import Translation

struct FlashCardView: View {

    let song: Song
    let verseIndex: Int

//    @State var verseText: String = "When I find myself in times of trouble, Mother Mary comes to me"
    @State var translationText: String = ""

    var sourceLanguage: Locale.Language? = Locale.Language(identifier: "en-US")
    var targetLanguage: Locale.Language? = Locale.Language(identifier: "pt-BR")

    @State var showResult: Bool = false

    var body: some View {
        let verseText = song.verses[verseIndex]

        VStack {
            Text(showResult ? translationText : verseText)
                .translationTask(
                    source: sourceLanguage,
                    target: targetLanguage
                ) { session in
                    do {
                        let response = try await session.translate(verseText)
                        translationText = response.targetText
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                .foregroundStyle(.black)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
            }
            Button("Translate") {
                showResult.toggle()
            }
        }
    }
}

#Preview {
    FlashCardView(song: Song(id: 1, title: "Imagine", artist: "John Lennon", verses: [""]), verseIndex: 1)
}
