//
//  MainView.swift
//  PodcastExt
//
//  Created by Pavla Beránková on 28.11.2024.
//

import SwiftUI

enum TabSection: String, CaseIterable {
    case myFolders = "Moje složky"
    case search = "Prohlížení"
}

struct MainView: View {
    @EnvironmentObject private var model: PodcastsViewModel
    @State private var selectedTab: TabSection = .myFolders

    var body: some View {
        NavigationStack {
            VStack {
                pickerSection
                switch selectedTab {
                case .myFolders:
                    MyFolderView()
                case .search:
                    BrowsingView()
                }
            }
            .padding(.horizontal)
            Spacer()
                .navigationTitle("PodStack")
        }
    }
}

extension MainView {
    private var pickerSection: some View {
        Picker("Vyber sekci", selection: $selectedTab) {
            ForEach(TabSection.allCases, id: \.self) { section in
                Text(section.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    MainView()
        .environmentObject(TopPodcastsViewModel())
        .environmentObject(PodcastsViewModel())
}
