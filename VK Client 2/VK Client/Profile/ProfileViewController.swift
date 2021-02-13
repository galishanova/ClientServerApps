//
//  ProfileViewController.swift
//  VK Client
//
//  Created by Regina Galishanova on 07.02.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    
    var friends: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        profileImage.image = UIImage(named: friends.image)
        nameLabel.text = friends.name
        surnameLabel.text = friends.surename
        statusLabel.text = friends.status
        onlineLabel.text = friends.online
        cityLabel.text = friends.city
        studyLabel.text = friends.study
        workLabel.text = friends.work
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    override func viewWillAppear(_ animated: Bool) {

        self.title = "\(friends.name)'s profile"
        
    }
    
    func layoutSubviews() {

    }
    
    
    


}
