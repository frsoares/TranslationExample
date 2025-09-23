//
//  SongsView.swift
//  TranslationExample
//
//  Created by Francisco Miranda Soares on 22/09/25.
//

import SwiftUI

//struct Song: Identifiable {
//    let id = UUID()
//    let title: String
//    let artist: String
//    let cardsCount: Int
//}

struct SongsView: View {
    let songs = songMock
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(songs) { song in
                        SongCard(song: song)
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemMint))
    }
}

struct SongCard: View {
    let song: Song
    
    var body: some View {
        VStack(spacing: 6) {
            Text("\(song.verses.count) versos")
                .font(.caption)
                .italic()
                .foregroundColor(.black.opacity(0.7))
            
            Text("\(song.title) - \(song.artist)")
                .font(.body)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(Color(.white))
        .cornerRadius(16)
    }
}

#Preview {
    SongsView()
}
