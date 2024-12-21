//
//  ContentView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: PodcastsViewModel
    @State private var searchText = String()

    var body: some View {
        NavigationStack {
            Text("Search: \(searchText)")
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
            .searchable(text: $searchText)
        }
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

#Preview {
    ContentView()
        .environmentObject(PodcastsViewModel())
}
