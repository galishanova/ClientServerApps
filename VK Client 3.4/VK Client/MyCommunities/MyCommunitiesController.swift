//
//  MyCommunitiesController.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class MyCommunitiesController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var communities: [VKGroup]? = []

    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var searchCommBar: UISearchBar!
    var filteredCommunities: [VKGroup]!
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        searchCommBar.delegate = self
        
        filteredCommunities = communities
        tableV.register(UINib(nibName: "MyCommunitiesCell", bundle: nil), forCellReuseIdentifier: "MyCommunitiesCell")
        
        tableV.delegate = self
        tableV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableV.reloadData()
        
        NetworkManager.loadGroups(token: Session.network.token) { [weak self] (groupResponse) in
            
            self?.communities = groupResponse.response.items
            self?.tableV.reloadData()

        }
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                communities?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
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
            filteredCommunities = communities
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
    
}



