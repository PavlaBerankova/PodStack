//
//  PodcastEpisodesListView.swift
//  PodStack
//
//  Created by Pavla Beránková on 31.12.2024.
//

import SwiftUI
import SwiftData

struct PodcastEpisodesListView: View {
    //    @Environment(\.modelContext) private var context
    //    @Query private var savedPodcast: [SavedPodcast]
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

//#Preview {
//    PodcastEpisodesListView(selectedPodcast: <#SavedPodcast#>)
//        .environmentObject(EpisodesViewModel())
//}
