//
//  Episode.swift
//  PodStack
//
//  Created by Pavla Beránková on 01.04.2025.
//

import Foundation

struct Episode: Codable, Identifiable {
    var id: Int {
        trackId
    }
    let trackId: Int
    let trackName: String
    let description: String?
    let releaseDate: String
    let trackTimeMillis: Int?
    let trackViewUrl: String? // link to Apple podcast
    let artworkUrl600: String?
    let collectionName: String

}

extension Episode {
    var trackDuration: String? {
        if let trackTimeMillis = trackTimeMillis {
            let totalSeconds = trackTimeMillis / 1000
            let minutes = (totalSeconds / 60) % 60
            let hours = totalSeconds / 3600

            if hours > 0 {
                return "\(hours)h \(minutes)min"
            } else {
                return "\(minutes)min"
            }
        }
        return nil
    }

    var timeAgo: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]

        guard let date = formatter.date(from: releaseDate) else { return "Neznámé datum" }

        let secondsAgo = Int(Date().timeIntervalSince(date))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        func formatMinutes(_ value: Int) -> String {
            if value == 1 { return "před 1 minutou" }
            return "před \(value) minutami"
        }

        func formatHours(_ value: Int) -> String {
            if value == 1 { return "před 1 hodinou" }
            return "před \(value) hodinami"
        }

        func formatDays(_ value: Int) -> String {
            if value == 1 { return "před 1 dnem" }
            return "před \(value) dny"
        }

        func formatWeeks(_ value: Int) -> String {
            if value == 1 { return "před 1 týdnem" }
            return "před \(value) týdny"
        }

        if secondsAgo < minute {
            return "před méně než minutou"
        } else if secondsAgo < hour {
            return formatMinutes(secondsAgo / minute)
        } else if secondsAgo < day {
            return formatHours(secondsAgo / hour)
        } else if secondsAgo < week {
            return formatDays(secondsAgo / day)
        } else if secondsAgo < 4 * week {
            return formatWeeks(secondsAgo / week)
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "cs_CZ")
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
    }
}
