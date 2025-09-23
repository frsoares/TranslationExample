//
//  FlashCardView.swift
//  TranslationExample
//
//  Created by Francisco Miranda Soares on 22/09/25.
//

import SwiftUI
import Foundation
import Translation

struct FlashCardView: View {

    let song: Song

    @State private var currentVerseIndex: Int
    @State private var userInput: String = ""
    @State var correctAnswers: Int = 0
    
//  @State var verseText: String = "When I find myself in times of trouble, Mother Mary comes to me"
    @State private var translationText: String = ""

    var sourceLanguage: Locale.Language? = Locale.Language(identifier: "en-US")
    var targetLanguage: Locale.Language? = Locale.Language(identifier: "pt-BR")

    @State private var showResult: Bool = false
    @State private var showCompletionAlert: Bool = false

    init(song: Song, verseIndex: Int) {
        self.song = song
        self._currentVerseIndex = State(initialValue: verseIndex)
    }

    var body: some View {
        let verseText = song.verses[currentVerseIndex]

        VStack(spacing: 30) {
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
            .id(verseText)
            
            TextField("Digite a tradução aqui", text: $userInput)
                .frame(width: 300)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .onSubmit {
                    checkAnswer()
                }

            Button("Verificar") {
                checkAnswer()
            }
            .disabled(userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
    
    private func normalized(_ s: String) -> String {
        let lowered = s.lowercased()
        let folded = lowered.folding(options: .diacriticInsensitive, locale: .current)
        let trimmed = folded.trimmingCharacters(in: .whitespacesAndNewlines)
        let noPunct = trimmed.replacingOccurrences(of: "\\p{P}+", with: "", options: .regularExpression)
        return noPunct
    }
    
    private func checkAnswer() {
        let expected = normalized(translationText)
        let typed = normalized(userInput)
        guard !expected.isEmpty else { return }
        if typed == expected {
            if currentVerseIndex < song.verses.count {
                currentVerseIndex += 1
                userInput = ""
                showResult = false
                translationText = ""
                correctAnswers += 1
                print("A tradução foi certa")
            } else {
                showCompletionAlert = true
            }
        } else {
            userInput = ""
            translationText = ""
            print("A tradução foi errada")
        }
    }
}

#Preview {
    FlashCardView(song: Song(id: 1, title: "Imagine", artist: "John Lennon", verses: ["Imagine there's no heaven"]), verseIndex: 0)
}

