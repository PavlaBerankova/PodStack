//
//  ContentView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI
import SwiftData

struct BrowsingHomeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Folder.title) private var folders: [Folder]
    @Query private var savedPodcast: [SavedPodcast]

    @EnvironmentObject private var model: PodcastSearchViewModel
    @EnvironmentObject private var modelTop: BrowsingTopPodcastsViewModel
    @State private var searchText = String()
    @State private var isSearching = false
    @State private var createFolderIsPresented: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if !searchText.isEmpty && isSearching {
                    Text("Výsledky vyhledávání")
                        .padding([.leading, .top])
                        .bold()
                        .font(.title)
                    searchedPodcast
                } else {
                    Text("TOP 25")
                        .padding([.leading, .top])
                        .bold()
                        .font(.title2)
                    topPodcasts
                }
            }
            .searchable(text: $searchText)
        }
        .navigationTitle("PodStack")
        .onSubmit(of: .search) {
            Task {
                if !searchText.isEmpty {
                    isSearching = true
                    await model.searchUrl(for: searchText)
                }
            }
        }
        .onChange(of: searchText) { newValue in
            if newValue.isEmpty {
                searchText = String()
                isSearching = false
                Task {
                    await model.resetToDefaultPodcasts()
                }
            }
        }
        .sheet(isPresented: $createFolderIsPresented) {
            CreateFolderView()
        }
    }
}

extension BrowsingHomeView {
    private var searchedPodcast: some View {
        List(model.podcasts, id: \.id) { podcast in
            if let podcastURL = podcast.collectionViewUrl {
                Link(destination: URL(string: podcastURL)!) {
                    BrowsingPodcastRowView(
                        podcast: podcast,
                        folders: folders
                    )
                }
            }
        }
        .listStyle(.plain)
    }

    private var topPodcasts: some View {
        List(Array(modelTop.topPodcasts.enumerated()), id: \.element.id) { index, podcast in
            if let topPodcastUrl = podcast.url {
                Link(destination: URL(string: topPodcastUrl)!) {
                    HStack {
                        Text(String(index + 1))
                            .font(.title2)

                        BrowsingPodcastRowView(
                            podcast: podcast,
                            folders: folders
                        )
                    }
                }
            }
        }
        .listStyle(.plain)
        .task {
            Task {
                await modelTop.loadPodcasts()
            }
        }
    }
}

#Preview {
    BrowsingHomeView()
        .environmentObject(PodcastSearchViewModel())
        .environmentObject(BrowsingTopPodcastsViewModel())
}
