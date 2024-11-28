//
//  PodcastsViewModel.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import Foundation

class PodcastsViewModel: ObservableObject {
    @Published var podcasts: [Podcast] = []

    func fetchData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=chumelenice&media=podcast") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                podcasts = decodedResponse.results
            }

        } catch {
            print("Error: \(error)")
        }
    }
}
