//
//  Group.swift
//  VK Client
//
//  Created by Regina Galishanova on 25.02.2021.
//

import Foundation


struct Group {
    let id: Int
    var name = ""
    var photo200 = ""

    init(id: Int) {
        self.id = id
    }
    
    init(json: [String : Any] ) {
        let id = json["id"] as! Int
        self.init(id: id)
        
        self.name = json["name"] as! String
        self.photo200 = json["photo_200"] as! String
    }
}

