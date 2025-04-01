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
                ForEach(model.dropPodcastTitle(), id: \.id) { episode in
                    EpisodeRowDetailView(episode: episode)
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
