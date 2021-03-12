//
//  AllCommunitiesController.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class AllCommunitiesController: UITableViewController, UISearchBarDelegate {
    
    var networkService: NetworkService!
    var allCommunities: [Community]!
    var filteredAllCommunities: [Community]!
    var searching = false
    
    
    @IBOutlet weak var searchAllCommBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchAllCommBar.delegate = self
        
        networkService = NetworkService()
        allCommunities = networkService.getCommunities()
        
        filteredAllCommunities = allCommunities
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searching {
            return filteredAllCommunities.count
        } else {
            return allCommunities.count
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "communityCell", for: indexPath) as! AllCommunitiesCell
        
        if searching {
            cell.communityName.text = filteredAllCommunities[indexPath.row].name
            cell.communityIcon.image = UIImage(named: filteredAllCommunities[indexPath.row].image)
        } else {
            cell.communityName.text = allCommunities[indexPath.row].name
            cell.communityIcon.image = UIImage(named: allCommunities[indexPath.row].image)
        }
        
        return cell
    }

    //searching in all communities
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredAllCommunities = []
        if searchText == "" {
            filteredAllCommunities = allCommunities
            searching = false
            self.tableView.reloadData()
        } else {
            for community in allCommunities {
                if community.name.lowercased().contains(searchText.lowercased()) {
                    filteredAllCommunities.append(community)
                }
            }
            searching = true
            self.tableView.reloadData()
        }
    }
}
