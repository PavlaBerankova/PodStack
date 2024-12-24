//
//  ContentView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct BrowsingView: View {
    @EnvironmentObject private var model: PodcastsViewModel
    @EnvironmentObject private var modelTop: TopPodcastsViewModel
    @State private var searchText = String()
    @State private var isSearching = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // Výsledky vyhledávání
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
                    await model.searchPodcast(term: searchText)
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
        List(model.podcasts, id: \.id) { item in
            if let podcastURL = item.collectionViewUrl {
                Link(destination: URL(string: podcastURL)!) {
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: item.artworkUrl60 ?? "")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                } else if phase.error != nil {
                                    Color.red
                                        .frame(width: 50, height: 50)
                                } else {
                                    Color.blue
                                        .frame(width: 50, height: 50)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(item.artistName ?? "Unknown")
                                    .font(.title3)
                                Text(item.collectionName ?? "No name")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
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

                AsyncImage(url: URL(string: podcast.artworkUrl100)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text(podcast.name)
                        .font(.headline)
                    Text(podcast.artistName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                .padding(.trailing)
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
