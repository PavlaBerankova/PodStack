//
//  Episodes.swift
//  PodStack 
//
//  Created by Pavla Beránková on 31.12.2024.
//

import Foundation

struct EpisodesResponse: Codable {
    let resultCount: Int
    let results: [Episode]
}

struct Episode: Codable, Identifiable {
    var id: Int {
        trackId
    }
    let trackId: Int
    let trackName: String
    let description: String?
    let releaseDate: String
    let trackTimeMillis: Int?
    let episodeUrl: String?
    let artworkUrl60: String?
    let collectionName: String
}
