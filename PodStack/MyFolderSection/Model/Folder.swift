//
//  Folder.swift
//  PodStack 
//
//  Created by Pavla Beránková on 18.12.2024.
//

import SwiftUI
import SwiftData

@Model
final class Folder {
    var title: String
    var podcasts: [SavedPodcast]?
    var image: Image {
        Image(systemName: "folder")
    }
    var podcastCount: Int {
        podcasts?.count ?? 0
    }

    var allSavedPodcastsCollectionId: [Int] {
           podcasts?.map { $0.collectionId } ?? []
       }

    init(title: String, podcasts: [SavedPodcast]?) {
        self.title = title
        self.podcasts = podcasts
    }
}

extension Folder {
    func getSavedPodcastsCollectionId() -> [Int] {
        var collectionIds = [Int]()

        if let podcasts = podcasts {
            collectionIds = podcasts.map { $0.collectionId }
        }
        print("Collection Ids from all saved podcastst: \(collectionIds)")
        return collectionIds
    }
}
