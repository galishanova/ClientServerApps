//
//  NetworkService.swift
//  VK Client
//
//  Created by Regina Galishanova on 30.12.2020.
//

import Foundation

class NetworkService {
    func getFriends() -> [Friend] {
        return [
            Friend(name: "Taylor", surename: "Swift", online: "online", city: "New York", image: "swift", allImages: ["swift2"]),
            Friend(name: "Leo", surename: "Messi", status: "never give up", image: "messi", allImages: ["messi2", "messi3"]),
            Friend(name: "Kylie", surename: "Jenner", city: "Los Angeles", work: "public person", image: "jenner", allImages: ["jenner2", "jenner3", "jenner4"]),
            Friend(name: "Dwayne", surename: "Johnson", online: "offline", city: "Washington", study: "univercity", work: "actor", image: "johnson", allImages: ["johnson2"]),
            Friend(name: "Ariana", surename: "Grande", status: "love :3", city: "Las Vegas", work: "singer", image: "grande", allImages: ["grande2"]),
            Friend(name: "Cristiano", surename: "Ronaldo", online: "offline", study: "university", work: "football player", image: "ronaldo", allImages: ["ronaldo2"]),
            Friend(name: "Conor", surename: "McGregor", status: "do what you like", online: "online", city: "Texas", study: "university", image: "conor", allImages: ["conor2", "conor3", "conor4"])
        ]
    }
    func getCommunities() -> [Community] {
        return [
            Community(name:"Apple", image: "apple"),
            Community(name:"Vkontakte", image: "vk"),
            Community(name:"iOS-developers", image: "ios dev"),
            Community(name:"World News", image: "news"),
            Community(name:"English language", image: "eng"),
            Community(name:"Fashion", image: "fashion"),
            Community(name: "Forbes", image: "forbes"),
            Community(name: "VK Music", image: "music vk"),
            Community(name: "Travel in Russia", image: "rus trav"),
            Community(name: "Sport", image: "sport")
        ]
    }
}
