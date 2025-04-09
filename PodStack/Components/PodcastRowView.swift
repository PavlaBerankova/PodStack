//
//  PodcastRowView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 25.12.2024.
//

import SwiftUI

struct PodcastRowView<T: PodcastDisplayable>: View {
    @Environment(\.modelContext) var context
    @State private var selectedFolder: Folder? = nil

    var podcast: T
    var folders: [Folder]?
    var actionMenu: () -> Void
    var actionCreateFolder: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: podcast.displayImageUrl ?? "")) { phase in
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
                    Text(podcast.displayTitle)
                        .font(.title3)
                    Text(podcast.displayArtist)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Menu {
                    Section {
                        Button {
                            actionCreateFolder()
                        } label: {
                            HStack {
                                Text("Vytvořit novou složku")
                                Image(systemName: "folder.badge.plus")
                            }
                        }
                    }

                    // List of existing folders
                    Section {
                        if let folders = folders {
                            ForEach(folders) { folder in
                                Button {
                                    // method for add podcast to selected folder
                                    print("Folder: \(folder.title)")
                                    selectedFolder = folder
                                    let savedPodcast = podcast.toSavedPodcast()

                                    if selectedFolder?.podcasts == nil {
                                        selectedFolder?.podcasts = [savedPodcast]
                                    } else {
                                        selectedFolder?.podcasts?.append(savedPodcast)
                                    }

                                    try? context.save()
                                    actionMenu()
                                } label: {
                                    HStack {
                                        Text(folder.title)
                                        Image(systemName: "folder")
                                    }
                                }
                            }
                        }
                    }
                } label: {
                    Image(systemName: "rectangle.stack.badge.plus")
                        .font(.title2)
                        .foregroundStyle(.accent)
                }
            }
        }
    }
}

#Preview {
    PodcastRowView(
        podcast: Podcasts.mock.podcasts[1],
        folders: [
            Folder(
                title: "English",
                podcasts: nil
            ),
            Folder(
                title: "Comedy",
                podcasts: nil
            )
        ],
        actionMenu: { print("podcast added") },
        actionCreateFolder: { print("folder created") }
    )
    .padding(.horizontal)
}
