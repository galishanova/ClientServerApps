//
//  MyFriendsController.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class MyFriendsController: UITableViewController, UISearchBarDelegate {
    
    var networkService: NetworkService!
    var friends: [Friend]!
    var selectedFriend: Friend!
    var selectedProfile: Friend!
    
    var friendsSectionTitles = [String]()
    var filteredFriendsSectionTitles = [String]()
    
    var filteredFriend: [Friend]!

    @IBOutlet weak var searchFriendBar: UISearchBar!
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchFriendBar.delegate = self
        
        networkService = NetworkService()
        friends = networkService.getFriends()
        
        filteredFriend = friends
        
        


        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        for friend in friends {
            let letter = friend.name.prefix(1)
            if friendsSectionTitles.contains(String(letter)) { continue }
            friendsSectionTitles.append(String(letter))
        }
            friendsSectionTitles.sort(by: <)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendsPhotos" {
            let destination = segue.destination as! PhotosViewController
            destination.friend = selectedFriend
        }
        if segue.identifier == "ShowProfile" {
            let destination = segue.destination as! ProfileViewController
            destination.friends = selectedProfile
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredFriendsSectionTitles[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return filteredFriendsSectionTitles.count
        } else {
            return friendsSectionTitles.count
        }
//        filteredFriendsSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        var tempArr = [Friend]()
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
        return tempArr.count
//        var tempArr = [Friend]()
//        for friend in friends {
//            if friend.name.prefix(1) == filteredFriendsSectionTitles [section] {
//                tempArr.append(friend)
//            }
//        }
//        return tempArr.count

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as? MyFriendsCell) {

            if searching {
                var tempArr = [Friend]()
                for friend in friends {
                    if friend.name.prefix(1) == filteredFriendsSectionTitles [indexPath.section] {
                        tempArr.append(friend)
                    }
                }
                cell.friendName.text = tempArr[indexPath.row].name
                cell.friendPhotoProfile.image = UIImage(named: tempArr[indexPath.row].image)
            } else {
                var tempArr = [Friend]()
                for friend in friends {
                    if friend.name.prefix(1) == friendsSectionTitles[indexPath.section] {
                        tempArr.append(friend)
                    }
                }
                cell.friendName.text = tempArr[indexPath.row].name
                cell.friendPhotoProfile.image = UIImage(named: tempArr[indexPath.row].image)
            }

            return cell
        }
        return UITableViewCell()
            
//            var tempArr = [Friend]()
//            for friend in friends {
//                if friend.name.prefix(1) == filteredFriendsSectionTitles[indexPath.section] {
//                    tempArr.append(friend)
//                }
//            }
//            cell.friendName.text = tempArr[indexPath.row].name
//            cell.friendPhotoProfile.image = UIImage(named: tempArr[indexPath.row].image)
//
//            return cell
//        }
//        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var tempArr = [Friend]()
        for friend in friends {
            if friend.name.prefix(1) == friendsSectionTitles[indexPath.section] {
                tempArr.append(friend)
            }
        }
//        var tempArr = [Friend]()
//        for friend in friends {
//            if friend.name.prefix(1) == filteredFriendsSectionTitles[indexPath.section] {
//                tempArr.append(friend)
//            }
//        }
//
        selectedFriend = tempArr[indexPath.row]
        performSegue(withIdentifier: "ShowFriendsPhotos", sender: self)
        
        selectedProfile = tempArr[indexPath.row]
        performSegue(withIdentifier: "ShowProfile", sender: self)
    }
    
    //поиск друзей
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriend = []

        if searchText == "" {
            searching = false
            filteredFriend = friends
            filteredFriendsSectionTitles = friendsSectionTitles
            self.tableView.reloadData()
        } else {
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
            self.tableView.reloadData()
        
        
//        filteredFriend = []
//        if searchText == ""{
//            filteredFriend = friends
//        }
//        for friend in friends{
//            if friend.name.lowercased().contains(searchText.lowercased()){
//                filteredFriend.append(friend)
//            }
//        }
//        self.tableView.reloadData()
        
        }
//}
//    @IBAction func showNavigationDidTap(_ sender: UITableViewCell){
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyBoard.instantiateViewController(withIdentifier: "PhotosViewController")
//
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//
}
//
//extension MyFriendsController:
//    UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return Animator(isDismissing: false)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        Animator(isDismissing: true)
//    }
//}




