//
//  MainView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var model: PodcastsViewModel

    var body: some View {
        TabView {
            myFolderTab
            browsingTab
        }
    }
}

extension MainView {
    private var myFolderTab: some View {
        NavigationStack {
            MyFolderView()
        }
        .tabItem {
            VStack {
                Image(systemName: "square.grid.2x2")
                Text("Moje složky")
            }
        }
    }

    private var browsingTab: some View {
        NavigationStack {
            BrowsingView()
        }
        .tabItem {
            VStack {
                Image(systemName: "magnifyingglass")
                Text("Prohlížení")
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(TopPodcastsViewModel())
        .environmentObject(PodcastsViewModel())
}
