//
//  Community.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.02.2021.
//

import Foundation
import RealmSwift

class VKGroupResponse: Codable {
    var response: VKGroupItems
}

class VKGroupItems: Codable {
    var items: [VKGroup]
}

class VKGroup: Object, Codable {
    @objc dynamic var id: Double = 0.0
    @objc dynamic var name: String = ""
    @objc dynamic var photo_100: String = ""
    @objc dynamic var screen_name: String = ""
}

