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
    @Query private var folders: [Folder]
    @State private var titleFolder = String()
    @State private var showFormFolder = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(folders) { folder in
                    Text(folder.title)
                        .font(.largeTitle)
                }
            }
            Button {
                titleFolder = "Test"
                addItem()
            } label: {
                Text("Přidat položku")
            }
            .navigationTitle("Moje složky")

        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    showFormFolder = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showFormFolder) {
            VStack {
                TextField("Název složky", text: $titleFolder)
                HStack {
                    Button("Zrušit", role: .cancel) {
                        titleFolder = String()
                        showFormFolder = false
                    }
                    Button("Přidat složku", role: .none) {
                        addItem()
                        print(folders)
                        showFormFolder = false
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newFolder = Folder(title: titleFolder)
            modelContext.insert(newFolder)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(folders[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyFolderView()
    }
}
