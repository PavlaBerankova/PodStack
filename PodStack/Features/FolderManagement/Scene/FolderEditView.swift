//
//  EditFolderView.swift
//  PodStack 
//
//  Created by Pavla Beránková on 26.12.2024.
//

import SwiftUI

struct FolderEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Bindable var folder: Folder
    @State private var title = String()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Název složky", text: $title)
            }
            .navigationTitle("Název složky")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        folder.title = title
                        try? context.save()
                        dismiss()
                    } label: {
                        Text("Aktualizovat")
                    }
                    .disabled(title.isEmpty || title == folder.title)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Zrušit")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
        .onAppear {
            title = folder.title
        }
    }
}

#Preview {
    NavigationStack {
        FolderEditView(folder: Folder(title: "Test", podcasts: nil))
    }
}
