//
//  PodcastExtApp.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

@main
struct PodStackApp
: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PodcastsViewModel())
        }
    }
}
