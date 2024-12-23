//
//  APIFetchable.swift
//  PodStack 
//
//  Created by Pavla Beránková on 23.12.2024.
//

import Foundation

protocol APIFetchable {
    associatedtype PodcastType: Codable
    associatedtype ResponseType: Codable
    var urlString: String { get }

    // metoda, která ví, jak získat podcasts z response
    func getPodcasts(from response: ResponseType) async -> [PodcastType]
}
