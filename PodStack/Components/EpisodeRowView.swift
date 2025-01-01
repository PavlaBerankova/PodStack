//
//  EpisodeRowView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 31.12.2024.
//

import SwiftUI

struct EpisodeRowView: View {
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

//#Preview {
//    EpisodeRowView(episode: Episode(
//        trackId: 1671348273,
//        releaseDate: "2024-12-09T13:25:00Z",
//        trackCount: 98,
//        trackTimeMillis: 3759,
//        trackViewUrl: "https://podcasts.apple.com/us/podcast/96-kolik-dostal-bachelor-p%C5%99edv%C3%A1d%C4%9B%C4%8Dky-vysava%C4%8D%C5%AF-a/id1671348273?i=1000681309477&uo=4",
//        trackName: "96. Kolik dostal Bachelor, předváděčky vysavačů a Troška revue",
//        collectionName: "Chumelenice",
//        description: "➡️ V černé části aka hrozivé nůši pravdy rozebíráme terapeutku veřejného prostoru a rant na Paľa Haberu\nKolik vykešoval Solfy za Bachelora?\nPamatujete na Vorwerk?\nJak bude vypadat koncentrák pro šovinisty?"))
//    .padding(.horizontal)
//}
