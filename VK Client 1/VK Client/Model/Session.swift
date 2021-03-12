//
//  Session.swift
//  VK Client
//
//  Created by Regina Galishanova on 07.02.2021.
//

import UIKit

class Session {
    static let network = Session()
    
    private init() {

    }
    
    var token = ""
    
    var userID = Int()
}
