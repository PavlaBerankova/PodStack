//
//  PodcastRowView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 25.12.2024.
//

import SwiftUI

struct BrowsingPodcastRowView: View {
    @ObservedObject var model = FolderFormViewModel()
    @Environment(\.modelContext) private
    var context

    var podcast: any PodcastDisplayable
    var folders: [Folder]?

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
                            model.selectedPodcast = podcast
                            model.isShowingAddFolderView = true
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
                                    model.selectedFolder = folder
                                    if let selectedPodcast = model.selectedPodcast {
                                        let savedPodcast = selectedPodcast.toSavedPodcast()

                                        if model.selectedFolder?.podcasts == nil {
                                            model.selectedFolder?.podcasts = [savedPodcast]
                                        } else {
                                            model.selectedFolder?.podcasts?.append(savedPodcast)
                                        }
                                    }
                                    try? context.save()
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
        .sheet(isPresented: $model.isShowingAddFolderView) {
            CreateFolderView()
        }
    }
}

#Preview {
    BrowsingPodcastRowView(
        podcast: Podcast.mock.first!,
        folders: [
            Folder(
                title: "English",
                podcasts: nil
            ),
            Folder(
                title: "Comedy",
                podcasts: nil
            )
        ]
    )
    .padding(.horizontal)
}
