//
//  MainView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var model: PodcastSearchViewModel

    var body: some View {
        TabView {
            NavigationStack {
                MyPodcastsView()
            }
            .tabItem {
                Label("Moje podcasty", systemImage: "square.grid.2x2")
            }

            NavigationStack {
                BrowsingHomeView()
            }
            .tabItem {
                Label("Prohlížení", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(BrowsingTopPodcastsViewModel())
        .environmentObject(PodcastSearchViewModel())
}
