//
//  MyFolderView.swift
//  PodStack
//
//  Created by Pavla Beránková on 18.12.2024.
//

import SwiftUI
import SwiftData

struct MyFolderView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Folder.title) private var folders: [Folder]
    @State private var createNewFolder = false

    var body: some View {
        List {
            ForEach(folders) { folder in
                HStack {
                    folder.image
                    Text(folder.title)
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
            NewFolderView()
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    NavigationStack {
        MyFolderView()
    }
}
