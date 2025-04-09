//
//  EpisodeRowShortPictureView.swift
//  PodStack
//
//  Created by Pavla Beránková on 01.04.2025.
//

import SwiftUI

struct EpisodeRowPictureView: View {
    let episode: Episode
    let frameWidht: CGFloat = 90
    let frameHeight: CGFloat = 90
    let cornerRadius: CGFloat = 4

    var body: some View {
        HStack(alignment: .top) {
                    AsyncImage(url: URL(string: episode.artworkUrl600 ?? "")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: frameWidht, height: frameHeight)
                                .cornerRadius(cornerRadius)
                        } else if phase.error != nil {
                            Color.red
                                .frame(width: frameWidht, height: frameHeight)
                                .cornerRadius(cornerRadius)
                        } else {
                            Color.blue
                                .frame(width: frameWidht, height: frameHeight)
                                .cornerRadius(cornerRadius)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(episode.timeAgo)
                            .font(.footnote)
                            .bold()
                            .foregroundStyle(.secondary)
                        Text(episode.trackName)
                            .bold()
                        if let trackDuration = episode.trackDuration {
                            Text(trackDuration)
                                .foregroundStyle(.accent)
                                .bold()
                                .font(.footnote)
                        }
                    }
                }
    }
}

#Preview {
    EpisodeRowPictureView(episode: Episodes.mock.episodes[1])
}
