//
//  MainView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var model: PodcastsViewModel

    var body: some View {
        TabView {
            NavigationStack {
                MyPodcastsView()
            }
            .tabItem {
                Label("Moje podcasty", systemImage: "square.grid.2x2")
            }

            NavigationStack {
                BrowsingView()
            }
            .tabItem {
                Label("Prohlížení", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(TopPodcastsViewModel())
        .environmentObject(PodcastsViewModel())
}
