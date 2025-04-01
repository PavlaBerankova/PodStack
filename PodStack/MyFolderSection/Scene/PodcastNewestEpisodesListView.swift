//
//  PodcastLastFiveEpisodesListView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 08.01.2025.
//

import SwiftUI

struct PodcastNewestEpisodesListView: View {
    @EnvironmentObject private var model: EpisodesViewModel
    let folder: Folder

    var body: some View {
        NavigationStack {
            List {
                ForEach(model.dropPodcastTitle(isEpisodesCollection: true), id: \.id) { episode in
                    EpisodeRowView(episode: episode)
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
