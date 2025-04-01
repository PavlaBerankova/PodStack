//
//  TopPodcast.swift
//  PodStack 
//
//  Created by Pavla Beránková on 01.04.2025.
//

import Foundation

struct TopPodcast: Codable, Identifiable {
    let artistName: String
    let id: String
    let name: String
    let kind: String
    let artworkUrl100: String
    let url: String?
}
