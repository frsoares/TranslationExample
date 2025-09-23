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

    @Binding var navigationPath: NavigationPath
    @State private var currentVerseIndex: Int = 0
    @State private var userInput: String = ""
    @State var correctAnswers: Int = 0
    @State private var translationText: String = ""

    var sourceLanguage: Locale.Language? = Locale.Language(identifier: "en-US")
    var targetLanguage: Locale.Language? = Locale.Language(identifier: "pt-BR")

    @State private var showResult: Bool = false
    @State private var showCompletionAlert: Bool = false

    @State private var feedbackSymbol: String?

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

            HStack {
                TextField("Digite a tradução aqui", text: $userInput)
                    .frame(width: 300)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.done)
                    .onSubmit {
                        checkAnswer()
                    }
                if let feedbackSymbol {
                    Image(systemName: feedbackSymbol)
                }
            }
            if showResult {
                Button {
                    goToNext()
                } label: {
                    Text("Próxima")
                        .padding(10)
                }
            }
            else {
                Button(action: {
                    checkAnswer()
                }, label: {
                    Text("Verificar")
                        .padding()
                })
                .disabled(userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .navigationDestination(isPresented: $showCompletionAlert) {
            ResultView(correctAnswers: correctAnswers, totalVerses: song.verses.count, navigationPath: $navigationPath)
        }
    }
    
    private func normalized(_ s: String) -> String {
        let lowered = s.lowercased()
        let folded = lowered.folding(options: .diacriticInsensitive, locale: .current)
        let trimmed = folded.trimmingCharacters(in: .whitespacesAndNewlines)
        let noPunct = trimmed.replacingOccurrences(of: "\\p{P}+", with: "", options: .regularExpression)
        return noPunct
    }

    private func goToNext() {
        userInput = ""
        translationText = ""
        showResult = false
        feedbackSymbol = nil
        if currentVerseIndex == song.verses.count - 1 {
            showCompletionAlert.toggle()
        } else {
            currentVerseIndex += 1
        }
    }

    private func checkAnswer() {
        let expected = normalized(translationText)
        let typed = normalized(userInput)
        guard !expected.isEmpty else { return }
        if typed == expected {
            print("A tradução foi certa")
            feedbackSymbol = "checkmark.circle.fill"
            showResult = true
        } else {
            print("A tradução foi errada")
            feedbackSymbol = "xmark.seal.fill"
            showResult = true
        }
    }
}

#Preview {
    FlashCardView(song: Song(id: 1, title: "Imagine", artist: "John Lennon", verses: ["Imagine there's no heaven", "It's easy if you try", "No hell below us"]), navigationPath: .constant(NavigationPath()))
}

