//
//  SavedPodcast.swift
//  PodStack 
//
//  Created by Pavla Beránková on 25.12.2024.
//

import Foundation
import SwiftData

@Model
final class SavedPodcast {
    var title: String
    var artistName: String
    var imageUrl: String?
    var url: String?
    var collectionId: Int

    init(title: String, artistName: String, imageUrl: String? = nil, url: String? = nil, collectionId: Int) {
        self.title = title
        self.artistName = artistName
        self.imageUrl = imageUrl
        self.url = url
        self.collectionId = collectionId
    }
}
