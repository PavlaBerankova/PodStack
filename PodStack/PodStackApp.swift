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

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Folder.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .environmentObject(PodcastsViewModel())
                    .environmentObject((TopPodcastsViewModel()))
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
