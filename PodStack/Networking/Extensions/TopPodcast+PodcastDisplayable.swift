//
//  TopPodcast+PodcastDisplayable.swift
//  PodStack 
//
//  Created by Pavla Beránková on 25.12.2024.
//

import Foundation

extension TopPodcast: PodcastDisplayable {
    var displayTitle: String {
        name
    }

    var displayArtist: String {
        artistName
    }

    var displayImageUrl: String? {
        artworkUrl100
    }

    var displayUrl: String? {
        url
    }

    var displayCollectionId: Int {
        Int(id) ?? 0
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
