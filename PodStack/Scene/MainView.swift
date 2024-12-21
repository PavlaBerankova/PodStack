//
//  MainView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = String()

    var body: some View {
        NavigationStack {
            TabView {
                TopPodcastsView()
                    .tabItem {
                        VStack {
                            Image(systemName: "rectangle.grid.2x2.fill")
                            Text("Prohlížení")
                        }
                    }

                Text("Moje složky")
                    .tabItem {
                        VStack {
                            Image(systemName: "folder")
                            Text("Moje složky")
                        }
                    }
                ContentView()
                    .tabItem {
                        Image(systemName: "info")
                        Text("Test")
                    }
            }
            .navigationTitle("PodStack")
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    MainView()
        .environmentObject(TopPodcastsViewModel())
        .environmentObject(PodcastsViewModel())
}
