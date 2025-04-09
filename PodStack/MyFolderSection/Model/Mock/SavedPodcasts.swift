//
//  SavedPodcasts.swift
//  PodStack 
//
//  Created by Pavla Beránková on 09.04.2025.
//

import Foundation

struct SavedPodcasts {
    var savedPodcasts: [SavedPodcast]
}

extension SavedPodcasts {
    static let mock: SavedPodcasts = SavedPodcasts(
        savedPodcasts: [
            SavedPodcast(
                title: "Tech",
                artistName: "Kodeco",
                imageUrl: "https://itunes.apple.com/us/podcast/the-kodeco-podcast-for-app-developers-and-gamers/id773910890?mt=2&uo=4",
                url: "https://itunes.apple.com/us/podcast/the-kodeco-podcast-for-app-developers-and-gamers/id773910890?mt=2&uo=4",
                collectionId: 773910890,
                lastFiveEpisodes: Episodes.mock.episodes
            )
        ]
    )
}
