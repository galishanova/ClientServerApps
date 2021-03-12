//
//  UserPhotos.swift
//  VK Client
//
//  Created by Regina Galishanova on 20.02.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class UserPhotos: Object {
//    let photoDate: Double
    @objc dynamic var id: Double = 0.0
    @objc dynamic var ownerId: Double = 0.0
    @objc dynamic var photo_807: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var likes: Int = 0
//    let repost: Double
//    let sizes: Sizes


    convenience init(from json: JSON) {
        self.init()
//            self.photoDate = json["date"].doubleValue
        self.id = json["id"].doubleValue
        self.likes = json["likes"]["count"].intValue
        self.ownerId = json["owner_id"].doubleValue
    //            self.repost = json["repost"]["count"].doubleValue
        self.text = json["text"].stringValue
        self.photo_807 = json["photo_807"].stringValue
    }
}
