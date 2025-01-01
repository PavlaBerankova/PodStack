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
    typealias ResponseType = PodcastResponse

    var urlString: String = APIEndpoints.podcastsCz.url

    func getItems(from response: PodcastResponse) async -> [Podcast] {
        return response.results
    }

//    func getPodcasts(from response: PodcastResponse) -> [Podcast] {
//        return response.results
//    }

    func loadPodcasts() async {
        do {
            podcasts = try await fetchData()
        } catch {
            print("Error loading podcasts: \(error)")
        }
    }

    func searchUrl(for term: String?) async {
        print("Searching for: \(String(describing: term))")
        guard let searchURL = buildURL(
            baseURL: APIEndpoints.baseSearchUrl.url,
            searchTerm: term,
            collectionId: nil
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
