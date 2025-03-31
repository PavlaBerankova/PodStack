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

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(model.episodes.enumerated()), id: \.element.id) { index, episode in
                    if index != 0 {
                        EpisodeRowView(episode: episode)
                    }
                }
            }
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
