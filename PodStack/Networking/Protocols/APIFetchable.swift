//
//  APIFetchable.swift
//  PodStack 
//
//  Created by Pavla Beránková on 23.12.2024.
//

import Foundation

protocol APIFetchable {
    associatedtype ResponseData: Codable
    associatedtype ResponseType: Codable

    var urlString: String { get }
    func getItems(from response: ResponseType) async -> [ResponseData]
}
