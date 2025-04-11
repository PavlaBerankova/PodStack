//
//  FolderViewModel.swift
//  PodStack 
//
//  Created by Pavla Beránková on 11.04.2025.
//
import SwiftUI

final class FolderViewModel: ObservableObject {
    @Published var folderTitle: String = String() // název složky
    @Published var folderPodcasts: [SavedPodcast] = []
    @Published var selectedPodcast: (any PodcastDisplayable)? = nil
    @Published var selectedFolder: Folder? = nil
    @Published var isShowingAddFolderView: Bool = false
}
