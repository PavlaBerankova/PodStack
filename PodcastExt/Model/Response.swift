//
//  Response.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import Foundation

struct Response: Codable {
    var resultCount: Int
    var results: [Podcast]
}
