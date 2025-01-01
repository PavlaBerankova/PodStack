//
//  PodcastDispleayable.swift
//  PodStack 
//
//  Created by Pavla Beránková on 25.12.2024.
//

import Foundation

protocol PodcastDisplayable: Identifiable {
    var displayTitle: String { get }
    var displayArtist: String { get }
    var displayImageUrl: String? { get }
    var displayUrl: String? { get }
    var displayCollectionId: Int { get }

    func toSavedPodcast() -> SavedPodcast
}
