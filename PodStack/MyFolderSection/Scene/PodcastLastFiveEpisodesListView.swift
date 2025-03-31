//
//  PodcastLastFiveEpisodesListView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 08.01.2025.
//

import SwiftUI

struct PodcastLastFiveEpisodesListView: View {
    @EnvironmentObject private var model: EpisodesViewModel
    let folder: Folder
    let collectionsIds: [Int]

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
            .onAppear {
                model.fetchLastThreeEpisodesFolderPodcasts(with: folder.allSavedPodcastsCollectionId)
            }
        }
    }
}

//#Preview {
//    PodcastLastFiveEpisodesListView()
//}
