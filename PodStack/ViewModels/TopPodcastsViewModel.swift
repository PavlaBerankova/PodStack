//
//  TopPodcastsViewModel.swift
//  PodStack 
//
//  Created by Pavla Beránková on 17.12.2024.
//

import Foundation

@MainActor
class TopPodcastsViewModel: ObservableObject, @preconcurrency APIFetchable {
    @Published var topPodcasts: [TopPodcast] = []

    typealias PodcastType = TopPodcast
    typealias ResponseType = TopPodcastResponse
    var urlString: String = APIEndpoints.topPodcastsCz.url

    func getItems(from response: TopPodcastResponse) async -> [TopPodcast] {
        return response.feed.results
    }

    func loadPodcasts() async {
        do {
            topPodcasts = try await fetchData()
        } catch {
            print("Error loading podcasts: \(error)")
        }
    }
}
