//
//  PodcastEpisodesListView.swift
//  PodStack
//
//  Created by Pavla Beránková on 31.12.2024.
//

import SwiftUI
import SwiftData

struct FolderPodcastListView: View {
    @EnvironmentObject private var model: EpisodesViewModel
    let collectionId: Int
    let podcastTitle: String

    var body: some View {
        NavigationStack {
            List {
                ForEach(model.dropPodcastTitle(), id: \.id) { episode in
                    if let episodeUrl = episode.trackViewUrl {
                        Link(destination: URL(string: episodeUrl)!) {
                            EpisodeRowDetailView(episode: episode)
                        }
                    }
                }
            }
            .navigationTitle(podcastTitle)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
        .onAppear {
            model.fetchDataAllEpisodes(with: collectionId)
        }
    }
}

#Preview {
    FolderPodcastListView(
        collectionId: Episode.mock.first!.trackId,
        podcastTitle: Episode.mock.first!.trackName
    )
        .environmentObject(EpisodesViewModel())
}
