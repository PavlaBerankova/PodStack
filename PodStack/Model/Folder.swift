//
//  Folder.swift
//  PodStack 
//
//  Created by Pavla Beránková on 18.12.2024.
//

import Foundation
import SwiftData

@Model
final class Folder {
    var title: String

    init(title: String) {
        self.title = title
    }
}
