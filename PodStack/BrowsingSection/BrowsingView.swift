//
//  ContentView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI
import SwiftData


struct BrowsingView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Folder.title) private var folders: [Folder]
    @Query private var savedPodcast: [SavedPodcast]

    @EnvironmentObject private var model: PodcastsViewModel
    @EnvironmentObject private var modelTop: TopPodcastsViewModel
    @State private var searchText = String()
    @State private var isSearching = false

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
                        .font(.title)
                    topPodcasts
                }
            }
            .searchable(text: $searchText)
        }
        .onSubmit(of: .search) {
            Task {
                if !searchText.isEmpty {
                    isSearching = true
                    await model.searchUrl(for: searchText)
                   // await model.stringUrl(for term: searchText)
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
    }
}

extension BrowsingView {
    private var searchedPodcast: some View {
        List(model.podcasts, id: \.id) { podcast in
            if let podcastURL = podcast.collectionViewUrl {
                Link(destination: URL(string: podcastURL)!) {
                    PodcastRowView(
                        podcast: podcast,
                        folders: folders,
                        actionMenu: { print(savedPodcast.first) },
                        actionCreateFolder: { }
                    )
                }
            }
        }
        .listStyle(.plain)
    }

    private var topPodcasts: some View {
        List(Array(modelTop.topPodcasts.enumerated()), id: \.element.id) { index, podcast in
            HStack {
                Text(String(index + 1))
                    .font(.title2)

                PodcastRowView(
                    podcast: podcast,
                    folders: folders,
                    actionMenu: { print(savedPodcast.first) },
                    actionCreateFolder: { })
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
    BrowsingView()
        .environmentObject(PodcastsViewModel())
        .environmentObject(TopPodcastsViewModel())
}
