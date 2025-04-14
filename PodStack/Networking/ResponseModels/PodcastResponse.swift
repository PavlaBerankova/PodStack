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
