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
    typealias ResponseType = FeedResponse
    var urlString: String = "https://rss.applemarketingtools.com/api/v2/cz/podcasts/top/25/podcasts.json"

    func getPodcasts(from response: FeedResponse) async -> [TopPodcast] {
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
