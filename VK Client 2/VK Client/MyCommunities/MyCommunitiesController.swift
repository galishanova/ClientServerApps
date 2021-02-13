//
//  MyCommunitiesController.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class MyCommunitiesController: UITableViewController, UISearchBarDelegate {
    
    var communities = [Community] ()
    var filteredCommunities: [Community]!
    var searching = false
    
    @IBOutlet weak var searchCommBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCommBar.delegate = self
        
        filteredCommunities = communities
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return filteredCommunities.count
        } else {
            return communities.count
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCommunitiesCell", for: indexPath) as! MyCommunitiesCell
        if searching {
            cell.myCommunityIcon.image = UIImage(named: filteredCommunities[indexPath.row].image)
            cell.myCommunity.text = filteredCommunities[indexPath.row].name
        } else {
            cell.myCommunity.text = communities[indexPath.row].name
            cell.myCommunityIcon.image = UIImage(named: communities[indexPath.row].image)
        }
        return cell
    }
    //удаление сообщества из избранного
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
            communities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
     //добавление сообщества
    @IBAction func addCommunity(segue: UIStoryboardSegue) {
        if segue.identifier == "addCommunity" {
            guard let allCommunitiesController = segue.source as? AllCommunitiesController,
                  let indexPath = allCommunitiesController.tableView.indexPathForSelectedRow else { return }
            let community = allCommunitiesController.allCommunities[indexPath.row]
            if !communities.contains(community) {
                communities.append(community)
                tableView.reloadData()
                }
        }
    }
    //searching in my communities
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCommunities = []
        if searchText == "" {
            filteredCommunities = communities
            searching = false
            self.tableView.reloadData()
        } else {
            for community in communities {
                if community.name.lowercased().contains(searchText.lowercased()) {
                    filteredCommunities.append(community)
                }
            }
            searching = true
            self.tableView.reloadData()
        }
    }
    
}
//



