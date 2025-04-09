//
//  EpisodeRowView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 31.12.2024.
//

import SwiftUI

struct EpisodeRowDetailView: View {
    let episode: Episode

    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.timeAgo)
                .foregroundStyle(.secondary)
                .font(.caption)
                Text(episode.trackName)
                .lineLimit(3)
                .bold()

            Text(episode.description ?? "")
                .lineLimit(3)
                .font(.caption)
                .foregroundStyle(.secondary)
            if let trackDuration = episode.trackDuration {
                Text(String(trackDuration))
                    .foregroundStyle(.accent)
                    .font(.footnote)
                    .bold()
            }
        }
    }
}

#Preview {
    EpisodeRowDetailView(episode: Episodes.mock.episodes.first!)
}
