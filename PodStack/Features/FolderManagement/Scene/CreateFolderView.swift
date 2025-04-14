//
//  NewFolderView.swift
//  PodStack
//
//  Created by Pavla Beránková on 21.12.2024.
//

import SwiftUI

struct CreateFolderView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @ObservedObject var model = FolderFormViewModel()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Název složky", text: $model.folderTitle)
                Button("Vytvořit") {
                    let newFolder = Folder(title: model.folderTitle, podcasts: model.folderPodcasts)
                    context.insert(newFolder)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(model.folderTitle.isEmpty)
            }
            .navigationTitle("Nová složka")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateFolderView()
}
