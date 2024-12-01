//
//  PodcastsViewModel.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import Foundation
import SwiftUICore

class PodcastsViewModel: ObservableObject {
    @Published var podcasts = [Podcast]()

    @MainActor func fetchData() async {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?media=podcast&term=podcast&country=cz")
        urlComponents?.queryItems = [
            URLQueryItem(name: "media", value: "podcast"),
            URLQueryItem(name: "term", value: "podcast"),
            URLQueryItem(name: "country", value: "cz"),
            URLQueryItem(name: "limit", value: "8")
        ]
        let urlString = urlComponents?.url?.absoluteString
        // let urlString = "https://itunes.apple.com/search?term=\(searchText)"

        if let urlString = urlString {
            do {
                let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response")
                    return
                }

                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                self.podcasts = decodedResponse.results
            } catch {
                print("Error fetching data: \(error)")
            }
        } else {
            print("URL string is invalid")
        }
    }
}
