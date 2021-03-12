//
//  Form.swift
//  VK Client
//
//  Created by Regina Galishanova on 14.02.2021.
//

import UIKit
import SwiftyJSON

struct UserData {
    let firstName: String
    let lastName: String
    let bday: String
    let city: String
    let domain: String
    let userId: String
    let education: String
    let online: String
    let avatar: String
}

struct CommunityData {
    let name: String
    let avatar: String
}

struct Photos {
    let photo: String
    let likesCount: Int
    let repostsCount: Int
    let photoDate: Int
}
