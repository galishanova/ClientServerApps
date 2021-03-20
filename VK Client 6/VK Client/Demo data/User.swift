//
//  User.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class User: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    enum Gender {
        case male, female, notSpecified
    }
    
    struct UserData {
        var firstName: String
        var lastName: String
        var gender: Gender
        var birthday: Any
        var city: String
        var status: String
        var maritalStatus: String
        var education: String
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
