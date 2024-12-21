//
//  PodcastExtApp.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI
import SwiftData

@main
struct PodStackApp
: App {

    var body: some Scene {
        WindowGroup {
                MainView()
                    .environmentObject(PodcastsViewModel())
                    .environmentObject((TopPodcastsViewModel()))
        }
        .modelContainer(for: Folder.self)
    }

    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
