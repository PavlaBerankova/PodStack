//
//  PodcastDisplayable.swift
//  PodStack 
//
//  Created by Pavla Beránková on 25.12.2024.
//

import Foundation

extension Podcast: PodcastDisplayable {
    var displayTitle: String {
        collectionName
    }

    var displayArtist: String {
        artistName
    }

    var displayImageUrl: String? {
        artworkUrl100
    }

    var displayUrl: String? {
        collectionViewUrl
    }

    var displayCollectionId: Int {
        collectionId
    }

    func toSavedPodcast() -> SavedPodcast {
        return SavedPodcast(
            title: displayTitle,
            artistName: displayArtist,
            imageUrl: displayImageUrl,
            url: displayUrl,
            collectionId: displayCollectionId
        )
    }
}
