//
//  Folder+Mock.swift
//  PodStack 
//
//  Created by Pavla Beránková on 14.04.2025.
//

import Foundation

extension Folder {
    static let mock: [Folder] = [
        Folder(
            title: "Test",
            podcasts: SavedPodcast.mock),
        Folder(
            title: "English",
            podcasts: SavedPodcast.mock)
    ]
}
