//
//  TopPodcastsViewModel.swift
//  PodStack 
//
//  Created by Pavla Beránková on 17.12.2024.
//

import Foundation

class TopPodcastsViewModel: ObservableObject {
    @Published var topPodcasts = [TopPodcast]()

    @MainActor func fetchData() async {
        let urlString = URL(string: "https://rss.applemarketingtools.com/api/v2/cz/podcasts/top/25/podcasts.json")

        if let urlString = urlString {
            do {
                let (data, response) = try await URLSession.shared.data(from: urlString)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response")
                    return
                }

                let decodedResponse = try JSONDecoder().decode(FeedResponse.self, from: data)
                self.topPodcasts = decodedResponse.feed.results
                print(urlString)
            } catch {
                print("Error fetching data: \(error)")
            }
        } else {
            print("URL string is invalid")
        }
    }
}
