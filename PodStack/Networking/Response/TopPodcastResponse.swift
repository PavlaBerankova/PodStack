//
//  TopPodcast.swift
//  PodStack 
//
//  Created by Pavla Beránková on 17.12.2024.
//

import Foundation

struct TopPodcastResponse: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let results: [TopPodcast]
}
