//
//  FetchError.swift
//  PodStack 
//
//  Created by Pavla Beránková on 23.12.2024.
//

import Foundation

enum FetchError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}
