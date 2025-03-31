//
//  EpisodesViewModel.swift
//  PodStack 
//
//  Created by Pavla Beránková on 31.12.2024.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class EpisodesViewModel: ObservableObject, @preconcurrency APIFetchable {

// MARK: TEST COMBINE
    @Published var episodes: [Episode] = []
        private var cancellables = Set<AnyCancellable>()

    func fetchLastThreeEpisodesFolderPodcasts(with collectionsIds: [Int]) {
        
    }

        func fetchDataAllEpisodes(with collectionId: Int) {
            guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(collectionId)&media=podcast&entity=podcastEpisode&limit=1000&country=US") else {
                print("Invalid URL")
                return
            }

            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: EpisodesResponse.self, decoder: JSONDecoder())
                .map { $0.results }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error fetching episodes: \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] episodes in
                    self?.episodes = episodes
                })
                .store(in: &cancellables)
        }
//////////////////////////////////////////////////////////////////////////////////////////////

   // @Published var episodes: [Episode] = []

    typealias ResponseType = EpisodesResponse
    typealias ResponseData = Episode

    var urlString = String()

    func getItems(from response: EpisodesResponse) async -> [Episode] {
        return response.results
    }

//    func fetchDataAllEpisodes(with collectionId: Int) async {
//
//        guard let episodesURL = URL(string: "https://itunes.apple.com/lookup?id=\(collectionId)&media=podcast&entity=podcastEpisode&limit=1000&country=US") else {
//            print("Invalid url")
//            return
//        }
//
//        print("Generated URL: \(episodesURL)")
//        self.urlString = episodesURL.absoluteString
//
//        do {
//            // v metodě fetchData je obsažena metoda getItems -> [Episode], v tomto modelu je pouze definovaná
//            episodes = try await fetchData()
//            print("Found \(episodes.count) podcasts")
//        } catch {
//            print("Error searching podcasts: \(error)")
//        }
//    }

    func updateLastFiveEpisodes(for podcast: SavedPodcast) async {
        guard let episodesURL = URL(string: "https://itunes.apple.com/lookup?id=\(podcast.collectionId)&media=podcast&entity=podcastEpisode&limit=5&country=US") else {
            print("Invalid url")
            return
        }

        print("Generated URL: \(episodesURL)")
        self.urlString = episodesURL.absoluteString

        do {
            let newEpisodes = try await fetchData()
            // aktualizuje přímo SavedPodcast model
            podcast.lastFiveEpisodes = newEpisodes
        } catch {
            print("Error searching podcasts: \(error)")
        }
    }
}
