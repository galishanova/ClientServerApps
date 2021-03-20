//
//  MyCommunitiesController.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit
import RealmSwift

class MyCommunitiesController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var searchCommBar: UISearchBar!
    
//    var communities: [VKGroup]? = []
    var filteredCommunities: [VKGroup]!
    var searching = false

    private let realmManager = RealmManager.shared

    var token: NotificationToken?
    var communities: Results<VKGroup>?
//    {
//        let communities: Results<VKGroup>? = realmManager?.getObjects()
//        return communities
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        filteredCommunities = communities
        tableV.register(UINib(nibName: "MyCommunitiesCell", bundle: nil), forCellReuseIdentifier: "MyCommunitiesCell")
        
        tableV.delegate = self
        tableV.dataSource = self
        searchCommBar.delegate = self
        
        pairGroupTableAndRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableV.reloadData()
        
        NetworkManager.loadGroups(token: Session.network.token) { [weak self] (groupResponse) in

            let tempArrGroup = groupResponse.response.items
//            self?.communities = tempArrGroup
            self?.saveGroupData(tempArrGroup)
            self?.tableV.reloadData()

        }
        
//        deleteAllRealmGroupsData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            if searching {
                return filteredCommunities?.count ?? 0
            } else {
                return communities?.count ?? 0
            }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MyCommunitiesCell.identifier, for: indexPath) as? MyCommunitiesCell {
            
                if let communities = communities {
                    if searching {
                        cell.downLoadImage(from: filteredCommunities[indexPath.row].photo_100)
                        cell.myCommunity.text = filteredCommunities[indexPath.row].name
                    } else {
                        cell.myCommunity.text = communities[indexPath.row].name
                        cell.downLoadImage(from: communities[indexPath.row].photo_100)
                    }
                }

            return cell
        }
        return UITableViewCell()
    }
    
    
    //удаление сообщества из избранного
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            if editingStyle == .delete {
//                communities?.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//    }
     //добавление сообщества
//    @IBAction func addCommunity(segue: UIStoryboardSegue) {
//        if segue.identifier == "addCommunity" {
//            guard let allCommunitiesController = segue.source as? AllCommunitiesController,
//                  let indexPath = allCommunitiesController.tableView.indexPathForSelectedRow else { return }
//            let community = allCommunitiesController.allCommunities[indexPath.row]
//            if !communities.contains(community) {
//                communities.append(community)
//                tableV.reloadData()
//                }
//        }
//    }
    //searching in my communities
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCommunities = []
        
            if let communities = communities {
                if searchText == "" {
        //            filteredCommunities = communities
                    searching = false
                    self.tableV.reloadData()
                } else {
                    for community in communities {
                        if community.name.lowercased().contains(searchText.lowercased()) {
                            filteredCommunities.append(community)
                        }
                    }
                    searching = true
                    self.tableV.reloadData()
                }
            }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    //saveing data in realm
    func saveGroupData(_ group: [VKGroup]) {
        
        do {
            let realm = try Realm()
            
            print(realm.configuration.fileURL as Any)

            let oldGroupData = realm.objects(VKGroup.self)
            
            realm.beginWrite()
            
            realm.delete(oldGroupData)

            realm.add(group)
            
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
    }
    
    func deleteAllRealmGroupsData() {
        do {
            let realm = try Realm()
            
            let groupsData = realm.objects(VKGroup.self)
            
            realm.delete(groupsData)
            
            print("All group's data in Realm is deleted")
            
        } catch {
            print(error)
        }
    }
    
    func pairGroupTableAndRealm() {
        guard let realm = try? Realm() else { return }
        communities = realm.objects(VKGroup.self)
        token = communities?.observe { [weak self] changes in
            
            guard (self?.tableV) != nil else { return }
            
            switch changes {
            
            case .initial(let communities):
                print("Initialize \(communities.count)")
                self?.tableV.reloadData()
                break
                
            case .update(let communities, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("""
                    New count \(communities.count)
                    Deletions \(deletions)
                    Insertions \(insertions)
                    Modifications \(modifications)
                    """
                    )
                
                self?.tableV.beginUpdates()
                        
                    self?.tableV.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                    self?.tableV.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                    self?.tableV.reloadRows(at: modifications.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                
                self?.tableV.endUpdates()
                
                break

            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    
}



