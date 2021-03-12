//
//  AllCommunitiesController.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class AllCommunitiesController: UITableViewController, UISearchBarDelegate {
    
    var allCommunities: [VKGroup]!
    var searching = false
    
    
    @IBOutlet weak var searchAllCommBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchAllCommBar.delegate = self
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return allCommunities?.count ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommunityCell", for: indexPath) as? AllCommunitiesCell {
        
                cell.communityName.text = allCommunities[indexPath.row].name
                cell.downLoadImage(from: allCommunities[indexPath.row].photo_100)
            return cell
        }
        return UITableViewCell()
    }

    //searching in all communities
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NetworkManager.searchGroups(token: Session.network.token, searchText: searchText) { [weak self] (searchGroupResponse) in
            self?.allCommunities = searchGroupResponse.response.items
            self?.tableView.reloadData()
        }
        searching = true
        self.tableView.reloadData()
        
        if searchText == "" {
            allCommunities.removeAll()
            self.tableView.reloadData()
        }
        
        
    }
}
