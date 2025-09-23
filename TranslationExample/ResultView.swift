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
        VStack (alignment: .center) {
            Image(systemName: "fireworks")
                .resizable()
                .scaledToFit()
                .frame(width: 147)
            Text("Parabéns!")
                .font(.largeTitle)
            Text("Você acertou \(correctAnswers)/\(totalVerses) cartas!")
                .font(.title3)
                .italic()

            Button (action: {
                navigationPath.removeLast(navigationPath.count)
            }) {
                Text("Finalizar")
                    .font(.title3)
                    .foregroundStyle(Color.black)
                    .padding()
            }
            .padding()
            .background {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mint)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ResultView(correctAnswers: 6, totalVerses: 6, navigationPath: .constant(NavigationPath()))
}
