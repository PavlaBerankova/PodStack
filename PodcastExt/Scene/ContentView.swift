//
//  ContentView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = PodcastsViewModel()

    var body: some View {
        NavigationStack {
            List(model.podcasts, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                    Text(item.artistName)
                    Text(item.collectionViewUrl)
                    AsyncImage(url: URL(string: item.artworkUrl100)) { image in
                        image.error(Image(systemName: "exclamationmark.triangle.fill"))
                        .resizable()
                        .frame(width: 100, height: 100)
                    }
                }
            }
        }
        .task {
            await model.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
