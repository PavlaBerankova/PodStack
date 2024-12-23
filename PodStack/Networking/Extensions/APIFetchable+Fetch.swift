//
//  APIFetchable+Fetch.swift
//  PodStack 
//
//  Created by Pavla Beránková on 23.12.2024.
//

import Foundation

extension APIFetchable {
    func fetchData() async throws -> [PodcastType] {
        guard let url = URL(string: urlString) else {
            throw FetchError.invalidURL
        }

            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw FetchError.invalidResponse
                }

                let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: data)
                return await getPodcasts(from: decodedResponse)
            } catch {
                throw FetchError.decodingError
            }
    }
}
