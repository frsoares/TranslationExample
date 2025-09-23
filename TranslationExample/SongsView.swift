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
    @State var navigationPath = NavigationPath()
    var body: some View {
        
        
        NavigationStack(path: $navigationPath) {
            VStack(alignment: .leading, spacing: 16) {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(songs) { song in
                            NavigationLink(value: song) {
                                SongCard(song: song)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.mint))
            .navigationDestination(for: Song.self) { song in
                FlashCardView(song: song, navigationPath: $navigationPath)
            }
        }
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
