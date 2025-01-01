//
//  SelectedFolderDetailView.swift
//  PodStack
//
//  Created by Pavla Beránková on 25.12.2024.
//

import SwiftUI
import SwiftData

struct SelectedFolderDetailView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject private var model: EpisodesViewModel
    let folder: Folder

    var body: some View {
        NavigationStack {
            List {
                if let podcasts = folder.podcasts {
                    ForEach(podcasts, id: \.title) { podcast in
                            NavigationLink {
                                PodcastEpisodesListView(collectionId: podcast.collectionId)
                            } label: {
                                HStack {
                                    AsyncImage(url: URL(string: podcast.imageUrl ?? "")) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(8)
                                        } else if phase.error != nil {
                                            Color.red
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(8)
                                        } else {
                                            Color.blue
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(8)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text(podcast.title)
                                            .font(.title3)
                                            .foregroundStyle(.black)
                                        Text(podcast.artistName)
                                            .font(.footnote)
                                            .foregroundStyle(.gray.opacity(0.5))
                                    }
                                }
                            }
                    }
                }
            }
            .navigationTitle(folder.title)
        }
    }
}

#Preview {
    SelectedFolderDetailView( folder: Folder(title: "English", podcasts: [SavedPodcast(title: "Chumelenice", artistName: "Lucie", collectionId: 12345)]))
}
