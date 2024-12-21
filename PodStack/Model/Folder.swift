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
    var podcasts: [Podcast]?
    var image: Image {
        Image(systemName: "folder")
    }

    init(title: String, podcasts: [Podcast]) {
        self.title = title
        self.podcasts = podcasts
    }
}
