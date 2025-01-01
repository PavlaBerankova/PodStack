//
//  NewFolderView.swift
//  PodStack
//
//  Created by Pavla Beránková on 21.12.2024.
//

import SwiftUI

struct AddFolderView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = String()
    @State private var podcasts = [SavedPodcast]()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Název složky", text: $title)
                Button("Vytvořit") {
                    let newFolder = Folder(title: title, podcasts: podcasts)
                    context.insert(newFolder)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty)
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
    AddFolderView()
}
