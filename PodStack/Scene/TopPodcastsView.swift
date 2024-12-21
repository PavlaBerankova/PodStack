//
//  TopPodcastsView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 17.12.2024.
//

import SwiftUI

struct TopPodcastsView: View {
    @EnvironmentObject private var model: TopPodcastsViewModel

    var body: some View {
        List(Array(model.topPodcasts.enumerated()), id: \.element.id) { index, podcast in
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
    TopPodcastsView()
        .environmentObject(TopPodcastsViewModel())
}
