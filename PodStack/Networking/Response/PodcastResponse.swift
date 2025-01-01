//
//  Response.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import Foundation

struct PodcastResponse: Codable {
    let resultCount: Int
    let results: [Podcast]
}

struct Podcast: Codable, Identifiable {
    var id: Int {
        return collectionId
    }
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let artworkUrl60: String?
}
