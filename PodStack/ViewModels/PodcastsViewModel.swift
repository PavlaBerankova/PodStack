//
//  PodcastsViewModel.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import Foundation
import SwiftUI

@MainActor
class PodcastsViewModel: ObservableObject, @preconcurrency APIFetchable {
    @Published var podcasts: [Podcast] = []

    typealias PodcastType = Podcast
    typealias ResponseType = Response
    var urlString: String = APIEndpoints.podcastsCz.url

    func getPodcasts(from response: Response) -> [Podcast] {
        return response.results
    }

    func loadPodcasts() async {
        do {
            podcasts = try await fetchData()
        } catch {
            print("Error loading podcasts: \(error)")
        }
    }

    func searchPodcast(term: String) async {
        print("Searching for: \(term)")
        guard let searchURL = buildURL(
            baseURL: "https://itunes.apple.com/search",
            searchTerm: term
        ) else {
            print("Invalid url")
            return
        }

        print("Generated URL: \(searchURL)")
        self.urlString = searchURL

        do {
            podcasts = try await fetchData()
            print("Found \(podcasts.count) podcasts")
        } catch {
            print("Error searching podcasts: \(error)")
        }
    }

    func resetToDefaultPodcasts() async {
           self.urlString = APIEndpoints.podcastsCz.url
           await loadPodcasts()
       }
}
