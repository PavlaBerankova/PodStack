//
//  Podcast.swift
//  PodStack 
//
//  Created by Pavla Beránková on 01.04.2025.
//

import Foundation

struct Podcast: Codable, Identifiable {
    var id: Int {
        return collectionId
    }
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let artworkUrl100: String?
}
