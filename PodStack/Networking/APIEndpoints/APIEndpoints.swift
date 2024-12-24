//
//  APIEndpoints.swift
//  PodStack 
//
//  Created by Pavla Beránková on 24.12.2024.
//

import Foundation

enum APIEndpoints {
    case podcastsCz
    case topPodcastsCz

    var url: String {
        switch self {
        case .podcastsCz:
            "https://itunes.apple.com/search?media=podcast&term=podcast&country=cz"
        case .topPodcastsCz:
            "https://rss.applemarketingtools.com/api/v2/cz/podcasts/top/25/podcasts.json"
        }
    }
}
