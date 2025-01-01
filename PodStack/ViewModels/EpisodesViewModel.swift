//
//  EpisodesViewModel.swift
//  PodStack 
//
//  Created by Pavla Beránková on 31.12.2024.
//

import Foundation
import SwiftUI

@MainActor
class EpisodesViewModel: ObservableObject, @preconcurrency APIFetchable {
    @Published var episodes: [Episode] = []

    typealias ResponseType = EpisodesResponse
    typealias ResponseData = Episode

    var urlString = String()

    func getItems(from response: EpisodesResponse) async -> [Episode] {
        return response.results
    }

    func loadDataEpisode(with collectionId: Int) async {

        guard let episodesURL = URL(string: "https://itunes.apple.com/lookup?id=\(collectionId)&media=podcast&entity=podcastEpisode&limit=10&country=US") else {
            print("Invalid url")
            return
        }

        print("Generated URL: \(episodesURL)")
        self.urlString = episodesURL.absoluteString

        do {
            episodes = try await fetchData()
            print("Found \(episodes.count) podcasts")
        } catch {
            print("Error searching podcasts: \(error)")
        }
    }

//    func buildEpisodeUrl(with collectionId: Int) async {
//        guard let episodesURL = buildURL(
//            baseURL: APIEndpoints.baseEpisodesUrl.url,
//            searchTerm: nil,
//            collectionId: collectionId
//        ) else {
//            print("Invalid url")
//            return
//        }
//
//        print("Generated URL: \(episodesURL)")
//        self.urlString = episodesURL
//
//        do {
//            episodes = try await fetchData()
//            print("Found \(episodes.count) podcasts")
//        } catch {
//            print("Error searching podcasts: \(error)")
//        }
//    }
}
