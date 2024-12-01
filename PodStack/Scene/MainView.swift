//
//  MainView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = String()

    var body: some View {
        NavigationStack {
            Text("Vyhledat podcast \(searchText)")
            .navigationTitle("PodStack")
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    MainView()
}
