//
//  MyFriendsController.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class MyFriendsController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var searchFriendBar: UISearchBar!
    
    var friends: [User]? = []
    var selectedFriend: User!
    var tempArrPhotoCollection: [UserPhotos]? = []

    
    var friendsSectionTitles = [String]()
    var filteredFriendsSectionTitles = [String]()
    
    var filteredFriend: [User]!

    var searching = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableV.register(UINib(nibName: "MyFriendsCell", bundle: nil), forCellReuseIdentifier: "MyFriendsCell")
        tableV.delegate = self
        tableV.dataSource = self
        
        searchFriendBar.delegate = self
        
        filteredFriend = friends
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableV.reloadData()

        DispatchQueue.main.async {
            NetworkManager.network.getFriendsWithSwiftyJSON(token: Session.network.token) { [weak self] (result) in
                guard let self = self else { return }
            
                switch result {

                case .success(let friendsArray):
                    self.friends = friendsArray
                    self.tableV.reloadData()
                
                case .failure(let error):
                    print(error)
                }
            }
        }

        if let friends = friends {

            //заголовки хедера
            for friend in friends {
                let letter = friend.name.prefix(1)
                if friendsSectionTitles.contains(String(letter)) { continue }
                friendsSectionTitles.append(String(letter))
            }
                friendsSectionTitles.sort(by: <)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendsPhotos" {
            let destination = segue.destination as! PhotosViewController
            destination.friend = selectedFriend
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return filteredFriendsSectionTitles.count
        } else {
            return friendsSectionTitles.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .darkGray

        let label = UILabel(frame: CGRect(x: 20, y: -5, width: view.frame.width, height: 40))

        if searching {
            label.text = filteredFriendsSectionTitles [section]
            label.font = .boldSystemFont(ofSize: 17)
            view.addSubview(label)
        } else {

            label.text = friendsSectionTitles[section]
            label.font = .boldSystemFont(ofSize: 17)
            view.addSubview(label)

        }

        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        var tempArr = [User]()
        if let friends = friends {
            if searching {
                for friend in friends {
                    if friend.name.prefix(1) == filteredFriendsSectionTitles [section] {
                        tempArr.append(friend)
                    }
                }
            } else {
                for friend in friends {
                    if friend.name.prefix(1) == friendsSectionTitles[section] {
                        tempArr.append(friend)
                    }
                }
            }
        }
        return tempArr.count
      
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as? MyFriendsCell) {
            
            var tempArr = [User]()
            if let friends = friends {
                if searching {
                    for friend in friends {
                        if friend.name.prefix(1) == filteredFriendsSectionTitles [indexPath.section] {
                            tempArr.append(friend)
                        }
                    }
                    cell.friendName.text = tempArr[indexPath.row].name
                    cell.downLoadImage(from: tempArr[indexPath.row].avatar)
                } else {
                    for friend in friends {
                        if friend.name.prefix(1) == friendsSectionTitles[indexPath.section] {
                            tempArr.append(friend)
                        }
                    }
                    cell.friendName.text = tempArr[indexPath.row].name
                    cell.downLoadImage(from: tempArr[indexPath.row].avatar)
                }
            }

            return cell
        }
        return UITableViewCell()

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var tempArr = [User]()
        if let friends = friends {

            for friend in friends {
                if friend.name.prefix(1) == friendsSectionTitles[indexPath.section] {
                    tempArr.append(friend)
                }
            }
        }

        selectedFriend = friends?[indexPath.row]
        performSegue(withIdentifier: "ShowFriendsPhotos", sender: self)
    }
    
    //поиск в списке друзей
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriend = []
        filteredFriendsSectionTitles = []

        if searchText == "" {
            searching = false
            filteredFriend = friends
            filteredFriendsSectionTitles = friendsSectionTitles
            self.tableV.reloadData()
        } else {
            if let friends = friends {

                for friend in friends {
                    if friend.name.lowercased().contains(searchText.lowercased()) {
                        filteredFriend.append(friend)
                    }
                }
                for friend in filteredFriend {
                        let letter = friend.name.prefix(1)
                        if filteredFriendsSectionTitles.contains(String(letter)) { continue }
                        filteredFriendsSectionTitles.append(String(letter))
                }
            }
            searching = true
            self.tableV.reloadData()
        }
            self.tableV.reloadData()
        
    }
}




