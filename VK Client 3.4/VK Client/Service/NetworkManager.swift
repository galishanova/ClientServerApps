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
    
////   поиск групп джсон
//    static func searchGroup(token: String, string: String) {
//        let baseURL = "https://api.vk.com"
//        let path = "/method/groups.search"
//
//        let params: Parameters = [
//            "access_token": token,
//            "q": string,
//            "v": "5.92"
//        ]
//
//        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
//            guard let json = response.value else { return }
//
//            print(json)
//        }
//    }
    
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
                        
//                        self.saveGroupData(groupResponse)
                        
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
            "v": "5.21"
        ] as [String : Any]
        
        NetworkManager.sessionAF.request(url + path, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
            switch response.result {

            case .success(let data):
                let json = JSON(data)
                let photoJSON = json["response"]["items"].arrayValue
                let photos = photoJSON.map { UserPhotos(from: $0) }
                
//                self.savePhotoData(photos)
                
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
            "fields": "domain, bdate, photo_200",
            "v": "5.21"
        ]

        NetworkManager.sessionAF.request(url + path, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
            switch response.result {

            case .success(let data):
                let json = JSON(data)
                let friendJSON = json["response"]["items"].arrayValue
                let friends = friendJSON.map { User(from: $0) }
                
//                self.saveUserData(friends)
                
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
                        
//                        self.saveGroupData(groupResponse)
                        
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
    
    //сохранение данных в реалм
//    func saveUserData(_ users: [User]) {
//
//        do {
//            let realm = try Realm()
//
//            print(realm.configuration.fileURL as Any)
//
//            realm.beginWrite()
//
////            realm.add(users)
//
//            try realm.commitWrite()
//
//        } catch {
//            print(error)
//
//            }
//        }
    
//    func savePhotoData(_ photo: [UserPhotos]) {
//
//        do {
//            let realm = try Realm()
//
//            realm.beginWrite()
//
//            realm.add(photo)
//
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//    }
    
//    func saveGroupData(_ group: [VKGroup]) {
//        
//        do {
//            let realm = try Realm()
//            
//            realm.beginWrite()
//            
//            realm.add(group)
//            
//            try realm.commitWrite()
//            
//        } catch {
//            print(error)
//        }
//    }
    

    
    
}
