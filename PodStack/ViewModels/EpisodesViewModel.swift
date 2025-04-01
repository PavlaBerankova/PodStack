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
    @Published var lastThreeEpisodes: [Episode] = []

    private var cancellables = Set<AnyCancellable>()

    func fetchLastThreeEpisodesFolderPodcasts(with collectionsIds: [Int]) {
        let publishers = collectionsIds.compactMap { collectionId -> AnyPublisher<[Episode], Never>? in
            guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(collectionId)&media=podcast&entity=podcastEpisode&limit=1000&country=US") else {
                print("Invalid URL")
                return nil
            }

            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: EpisodesResponse.self, decoder: JSONDecoder())
                .map { Array($0.results.prefix(4)) }  // Vezme jen 4 epizody, první index je vždy jen název podcastu
                .replaceError(with: [])  // Ošetří chybu a vrátí prázdné pole
                .eraseToAnyPublisher()
        }

        Publishers.MergeMany(publishers)
            .collect()  // Shromáždí všechny výsledky
            .receive(on: DispatchQueue.main)
            .sink { [weak self] episodesArray in
                self?.lastThreeEpisodes = episodesArray.flatMap { $0 } // Sloučí všechna pole do jednoho
            }
            .store(in: &cancellables)
    }

    func dropPodcastTitle(isEpisodesCollection: Bool = false) -> [Episode] {
        // enumerated() přidá indexy k prvkům -> [(index, value)]
        // dropFirst() odstraní první index, v prvním indexu je vždy pouze jen název podcastu, ne epizoda

        if isEpisodesCollection {
            return lastThreeEpisodes
                .enumerated()
                .filter { $0.offset % 4 != 0 }
                .map { $0.element }

        }
        return Array(episodes.enumerated().dropFirst().map { $0.element })
    }

    //    func fetchLastThreeEpisodesFolderPodcasts(with collectionsIds: [Int]) {
    //        for collectionsId in collectionsIds {
    //            guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(collectionsId)&media=podcast&entity=podcastEpisode&limit=1000&country=US") else {
    //                print("Invalid URL")
    //                return
    //            }
    //
    //            URLSession.shared.dataTaskPublisher(for: url)
    //                .map(\.data)
    //                .decode(type: EpisodesResponse.self, decoder: JSONDecoder())
    //                .map { $0.results.prefix(3) }
    //                .receive(on: DispatchQueue.main)
    //                .sink(receiveCompletion: { completion in
    //                    if case .failure(let error) = completion {
    //                        print("Error fetching episodes: \(error.localizedDescription)")
    //                    }
    //                }, receiveValue: { [weak self] episodes in
    //                    self?.lastThreeEpisodes.append(contentsOf: episodes)
    //                })
    //                .store(in: &cancellables)
    //        }
    //    }

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

    //    func updateLastFiveEpisodes(for podcast: SavedPodcast) async {
    //        guard let episodesURL = URL(string: "https://itunes.apple.com/lookup?id=\(podcast.collectionId)&media=podcast&entity=podcastEpisode&limit=5&country=US") else {
    //            print("Invalid url")
    //            return
    //        }
    //
    //        print("Generated URL: \(episodesURL)")
    //        self.urlString = episodesURL.absoluteString
    //
    //        do {
    //            let newEpisodes = try await fetchData()
    //            // aktualizuje přímo SavedPodcast model
    //            podcast.lastFiveEpisodes = newEpisodes
    //        } catch {
    //            print("Error searching podcasts: \(error)")
    //        }
    //    }
}
