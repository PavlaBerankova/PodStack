//
//  APIFetchable+BuildURL.swift
//  PodStack 
//
//  Created by Pavla Beránková on 24.12.2024.
//

import Foundation

extension APIFetchable {
    func buildURL(baseURL: String, searchTerm: String?, limit: String = "10", collectionId: Int?) -> String? {
            var urlComponents = URLComponents(string: baseURL)

            urlComponents?.queryItems = [
                URLQueryItem(name: "media", value: "podcast"),
                URLQueryItem(name: "term", value: searchTerm),
               // URLQueryItem(name: "country", value: "cz"),
                URLQueryItem(name: "limit", value: limit),
                URLQueryItem(name: "id", value: String(collectionId ?? 0))
            ]

            return urlComponents?.url?.absoluteString
        }
}
