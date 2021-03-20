//
//  NetworkManager.swift
//  VK Client
//
//  Created by Regina Galishanova on 11.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkManager {
    
    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        
        return session
    }()
    
    static let network = NetworkManager()
    
    private init() {
        
    }

    
    static func searchGroups(token: String, searchText: String, completion: @escaping (_ group: VKGroupResponse) -> ()) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": searchText,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in

            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let searchGroupResponse = try JSONDecoder().decode(VKGroupResponse.self, from: data)
                                            
                        completion(searchGroupResponse)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    //фотографии
    func getPhotosWithSwiftyJSON(token: String, ownerId: String, completion: ((Result<[UserPhotos], Error>) -> Void)? = nil) {
        let url = "https://api.vk.com"
        let path = "/method/photos.get"
        let params = [
            "access_token": token,
            "owner_id": ownerId,
            "album_id": "wall",
            "extended": 1,
//            "photo_sizes": 1,
            "v": "5.21"
        ] as [String : Any]
        
        NetworkManager.sessionAF.request(url + path, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
            switch response.result {

            case .success(let data):
                let json = JSON(data)
                let photoJSON = json["response"]["items"].arrayValue
                let photos = photoJSON.map { UserPhotos(from: $0) }
                                
                completion?(.success(photos))
                print(photos)

            case .failure(let error):
                print(error.localizedDescription)
                completion?(.failure(error))
            }
        })
    }
    
    
    //друзья
    func getFriendsWithSwiftyJSON(token: String, completion: ((Result<[User], Error>) -> Void)? = nil) {
        let url = "https://api.vk.com"
        let path = "/method/friends.get"
        let params = [
            "access_token": token,
            "order": "name",
            "fields": "domain, bdate, photo_200, city, online",
            "v": "5.21"
        ]

        NetworkManager.sessionAF.request(url + path, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
            switch response.result {

            case .success(let data):
                let json = JSON(data)
                let friendJSON = json["response"]["items"].arrayValue
                let friends = friendJSON.map { User(from: $0) }
                                
                completion?(.success(friends))
                print(friends)

            case .failure(let error):
                print(error.localizedDescription)
                completion?(.failure(error))
            }
        })
    }
    //группы
    static func loadGroups(token: String, completion: @escaping (_ group: VKGroupResponse) -> ()) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in

            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let groupResponse = try JSONDecoder().decode(VKGroupResponse.self, from: data)
                                                
                        completion(groupResponse)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
