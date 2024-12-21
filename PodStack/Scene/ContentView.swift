//
//  ContentView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: PodcastsViewModel
    @EnvironmentObject private var modelTop: TopPodcastsViewModel
    @State private var searchText = String()

    var body: some View {
        NavigationStack {
            Text("Search: \(searchText)")
            topPodcasts
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            Task {
                model.searchText = searchText
                await model.fetchData()
            }
        }
        .onChange(of: searchText) { newValue in
            if newValue.isEmpty {
                model.searchText = "podcast"
                Task {
                    await model.fetchData()
                }
            }
        }
        .task {
            Task {
                await model.fetchData()
            }
        }
        .navigationTitle("PodStack")
    }
}

extension ContentView {
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
                        .frame(width: 100, height: 100)
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
                await model.fetchData()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PodcastsViewModel())
        .environmentObject(TopPodcastsViewModel())
}
