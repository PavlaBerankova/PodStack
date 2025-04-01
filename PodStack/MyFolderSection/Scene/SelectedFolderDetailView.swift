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
            if let podcasts = folder.podcasts {
                NavigationLink {
                    PodcastNewestEpisodesListView(folder: folder)
                } label: {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.accent)
                        Text("Nejnovější epizody")
                    }
                    .font(.title2)
                    .foregroundStyle(.black)
                    Spacer()
                }
                .padding()
                Divider()

                List {
                    ForEach(podcasts, id: \.title) { podcast in
                        NavigationLink {
                            PodcastEpisodesListView(collectionId: podcast.collectionId, podcastTitle: podcast.title)
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
                        .swipeActions(edge: .leading) {
                            if let podcastUrl = podcast.url {
                                Link(destination: URL(string: podcastUrl)!) {
                                    Image(systemName: "shareplay")
                                        .tint(Color.accentColor)
                                }
                            }
                        }
                    }

                }
                .listStyle(.plain)
                .navigationTitle(folder.title)
            }
        }
        .onAppear {
            print("FOLDER NAME: \(folder.title)")
            print("Collection IDs: \(folder.allSavedPodcastsCollectionId)")
        }
    }
}

#Preview {
    SelectedFolderDetailView(folder: Folder(
        title: "English",
        podcasts: [SavedPodcast(
            title: "Chumelenice",
            artistName: "Lucie",
            collectionId: 12345,
            lastFiveEpisodes: [Episode(
                trackId: 1,
                trackName: "Chumelenice",
                description: "Bla bla bla",
                releaseDate: "20.12.2024",
                trackTimeMillis: 1234,
                trackViewUrl: nil,
                artworkUrl600: nil,
                collectionName: "Lucie Petráková")
            ]
        )
        ]
    )
    )
}
