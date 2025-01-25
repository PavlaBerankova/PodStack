//
//  MyFolderView.swift
//  PodStack
//
//  Created by Pavla Beránková on 18.12.2024.
//

import SwiftUI
import SwiftData

struct MyFolderView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Folder.title) private var folders: [Folder]
    @State private var createNewFolder = false
    @State private var folderToEdit: Folder?

    var body: some View {
        List {
            ForEach(folders) { folder in
                NavigationLink(destination: SelectedFolderDetailView(folder: folder)) {
                    HStack {
                        folder.image
                            .foregroundStyle(Color.accentColor)
                        Text(folder.title)
                        Spacer()

                        Text(String(folder.podcastCount))
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                        folderToEdit = folder
                    } label: {
                        Label("Upravit", systemImage: "pencil")
                    }
                    .tint(.orange)
                }
            }

            .onDelete { indexSet in
                indexSet.forEach { index in
                    let selectedFolder = folders[index]
                    context.delete(selectedFolder)
                }
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    createNewFolder = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $createNewFolder) {
            AddFolderView()
                .presentationDetents([.medium])
        }
        .sheet(item: $folderToEdit) { folder in
            EditFolderView(folder: folder)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    NavigationStack {
        MyFolderView()
    }
}
