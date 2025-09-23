//
//  ResultView.swift
//  TranslationExample
//
//  Created by Francisco Miranda Soares on 22/09/25.
//

import SwiftUI

struct ResultView: View {
    
    var correctAnswers: Int
    var totalVerses: Int

    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            Image(systemName: "fireworks")
                .resizable()
                .scaledToFit()
                .frame(width: 147)
            Text("Parabéns!")
                .font(.largeTitle)
            Text("Você acertou \(correctAnswers)/\(totalVerses) cartas!")

            Button (action: {
                print(
                    "finalizou"
                )
                navigationPath.removeLast(navigationPath.count)
            }) {
                Text("Finalizar")
                    .padding()
            }
            .padding()
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ResultView(correctAnswers: 6, totalVerses: 6, navigationPath: .constant(NavigationPath()))
}
