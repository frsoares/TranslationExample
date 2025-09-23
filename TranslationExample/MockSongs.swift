//
//  MockSongs.swift
//  TranslationExample
//
//  Created by Anne Auzier on 23/09/25.
//

import Foundation

struct Song: Identifiable {
    let id: Int
    let title: String
    let artist: String
    let verses: [String]
}

let songMock: [Song] = [
    Song(
        id: 1,
        title: "Shape of You",
        artist: "Ed Sheeran",
        verses: [
            "The club isn't the best place to find a lover",
            "So the bar is where I go",
            "Me and my friends at the table doing shots"
        ]
    ),
    Song(
        id: 2,
        title: "Imagine",
        artist: "John Lennon",
        verses: [
            "Imagine there's no heaven",
            "It's easy if you try",
            "No hell below us"
        ]
    ),
    Song(
        id: 3,
        title: "Bohemian Rhapsody",
        artist: "Queen",
        verses: [
            "Is this the real life?",
            "Is this just fantasy?",
            "Caught in a landslide, no escape from reality"
        ]
    )
]
