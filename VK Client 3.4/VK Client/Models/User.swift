//
//  User.swift
//  VK Client
//
//  Created by Regina Galishanova on 15.02.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift



class User: Object {

    @objc dynamic var firstName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
//    let sex: Int
//    let online: Int
    @objc dynamic var domain: String = ""
    @objc dynamic var bdate: String = ""
    @objc dynamic var avatar: String = ""
//    let mobilePhone: String
//    let status: String
//    let lastSeen1: Date
//    let lastSeen2: Date
//    let city: String?
    @objc dynamic var name: String { return firstName + " " + lastName }
            
    
    convenience init(from json: JSON) {
        self.init()
        self.firstName = json["first_name"].stringValue
        self.id = json["id"].intValue
        self.lastName = json["last_name"].stringValue
//        self.sex = json["sex"].intValue
//        self.online = json["online"].intValue
        self.domain = json["domain"].stringValue
        self.bdate = json["bdate"].stringValue
        self.avatar = json["photo_200"].stringValue
//        self.mobilePhone = json["mobile_phone"].stringValue
//        self.status = json["status"].stringValue

//        let dateDouble = json["last_seen"].doubleValue
//        self.lastSeen1 = Date(timeIntervalSince1970: dateDouble)
//
//        let dateString = json["last_seen_txt"].stringValue
//        self.lastSeen2 = dateFormatter.date(from: dateString)!

//        self.city = json["city"]["title"].stringValue
    }
    
//    private var dateFormatter: DateFormatter = {
//        let df = DateFormatter()
//        df.dateFormat = "MMM d, hh:mm a"
//        df.timeZone = TimeZone(secondsFromGMT: 0)
//        
//        return df
//    }()
    
}
