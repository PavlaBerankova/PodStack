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
