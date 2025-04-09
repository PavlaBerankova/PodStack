//
//  Episodes.swift
//  PodStack 
//
//  Created by Pavla Beránková on 09.04.2025.
//

import Foundation

struct Episodes: Codable {
    var episodes: [Episode]
}

extension Episodes {
    static let mock: Episodes = Episodes(
        episodes: [
            Episode(
                trackId: 1000677871277,
                trackName: "středo/věk/41",
                description: "Konečně se potkáváme, a to po dlouhé době (pokud vynecháme live event a první video díl). Oba tyhle speciály slaví úspěch, ale i tak, sejít se takhle komorně, a dát si trojku s klobásama a hořčicí v kelímku (která už od revoluce stojí 5 korun) má něco do sebe. \n\nZačali jsme tak nějak nečekaně bydlením, chvíli jsme řešili, jestli vůbec nahráváme, a pak jsme klasicky přesedlali na Apple a jeho vize do budoucna, zabrousili jsme na spánek, náš funkční věk, problémy se spaním a jiné neduhy. \n\nHonza si klasicky dělal zápisky, nicméně když se odpojil, tak mu pár témat chybí. Nicméně podcast jsme uzavřeli diskusí nad Slastí. Jako snad každej z české internetové bubliny.",
                releaseDate: "2024-11-22T07:10:06Z",
                trackTimeMillis: 11023000,
                trackViewUrl: "https://podcasts.apple.com/us/podcast/st%C5%99edo-v%C4%9Bk-41/id1528298310?i=1000677871277&uo=4",
                artworkUrl600: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts211/v4/75/94/97/759497b5-59d1-0e05-1cca-6bb6e24aab22/mza_16524036566395417111.jpg/600x600bb.jpg",
                collectionName: "středo/věk"
            ),
            Episode(
                trackId: 1000678196823,
                trackName: "How to Read Code",
                description: "In the first full-length episode of this season, we go back to basics as Senior iOS Dev Mani Ramezan takes us through, step by step, how to come up to speed on a large code base. Whether you’re just starting a new role or beginning to contribute to a new open source project, listen along to learn some useful tips.\n\n\n\n\n[Subscribe in Apple Podcasts] [Listen in Spotify] [RSS Feed]\n\nInterested in sponsoring a podcast episode? Check out our Advertise With Kodeco page to find out how!\n\nShow Notes\n\nTune in as Mani, Suz, Jenn and Dru start off talking about how to read a code base and venture off into a bevy of advice for newer devs. Listen all the way to the end to learn what Mani thinks human developers, even brand new ones, can do that AI that cannot.\n\nSome highlights:\n\n\n\n* Start with a bug, so you have a meaningful goal to guide your exploration.\n\n* Struggling at step one: setting up the build environment? Improve the process, then document for the next dev.\n\n* It’s OK to not know all the things. Start by treating each library as a black box.  Wait to learn it until you need to.\n\n\n\nMentioned in This Episode\n\n\n\n* Check out Simon B. Støvring’s Swift package to build a dependency graph.\n\n* Learn how to make a pull request.\n\n* Use Xcode’s View debugger to see how a code base fits together.\n\n* GitHub Copilot, now available for Xcode, is currently Mani’s favorite AI coding assistant. Proceed with caution and do not enter proprietary code or user data.\n\n* Come chat with us on Kodeco’s Discord, where Mani’s a moderator! We never answer tech questions with just a link — we’ll always explain!\n\n\n\nLook at Jenn’s Debugging Buddy!\n\nContact Mani and the Hosts\n\n\n\n* Mani on LinkedIn\n\n* Mani on GitHub\n\n* Mani on Mastodon\n\n* Suz on X/Twitter\n\n* Jenn on LinkedIn\n\n* \n\n* Dru on Mastodon\n\n* Email the Podcast Team\n\n\n\nFollow Kodeco\n\n\n\n* Kodeco on LinkedIn\n\n* Kodeco on X/Twitter\n\n* Kodeco on Facebook\n\n\n\nWhere to Go From Here?\n\nWe hope you enjoyed this episode of our podcast. Be sure to subscribe in Apple Podcasts or Spotify to get notified when the next episode comes out.\n\nHoping to learn more about a particular aspect of mobile development or life and work as a dev? Please write in and tell us and we’ll do our best to make that happen! Write in too if you yourself would like to be a guest or your have a particular gue...",
                releaseDate: "2024-11-25T17:35:51Z",
                trackTimeMillis: 1862000,
                trackViewUrl: "https://podcasts.apple.com/us/podcast/kodeco-podcast-meet-the-show-podcast-v2-s3-e0/id773910890?i=1000675280451&uo=4",
                artworkUrl600: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts112/v4/e7/78/a3/e778a390-dd5f-16dd-f478-fa9488006fb5/mza_4718249148664515510.png/600x600bb.jpg",
                collectionName: "The Kodeco Podcast: For App Developers and Gamers"
            )
        ]
    )
}
