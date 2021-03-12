//
//  NetworkManager.swift
//  VK Client
//
//  Created by Regina Galishanova on 11.02.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    
    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        
        return session
    }()
    
    static let network = NetworkManager()
    
    private init() {
        
    }
    
    static func loadGroups(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    static func searchGroup(token: String, string: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": string,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
                
            print(json)
        }
    }
    
    static func loadFriends(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
//            "order": "hints",
//            "fields": "domain, sex, bdate, city, country, photo_200, contacts, education, online, relation, last_seen, status, universities",
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
                
            print(json)
        }
    }
    
    static func loadPhotos(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "photo_sizes": 0,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
                
            print(json)
        }
    }

    
}
