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
            Text(episode.releaseDate)
                .foregroundStyle(.secondary)
                .font(.caption)
                Text(episode.trackName)
                .bold()

            Text(episode.description ?? "")
                .lineLimit(2)
                .foregroundStyle(.secondary)
            if let trackDuration = episode.trackTimeMillis {
                Text(String(trackDuration))
                    .foregroundStyle(.accent)
                    .bold()
            }
        }
    }
}
