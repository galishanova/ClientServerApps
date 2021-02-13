//
//  ZoomUserPhoto.swift
//  VK Client
//
//  Created by Regina Galishanova on 28.01.2021.
//

import UIKit

class ZoomUserPhoto: UIViewController {
    let startingFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
    let userPhoto = PhotosCell.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPhoto.isUserInteractionEnabled = true
        userPhoto.backgroundColor = UIColor.red
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.clipsToBounds = true
        userPhoto.image = UIImage(named: friend.name)
    
        userPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoom)))
    }
    
    @objc func zoom() {
        userPhoto.backgroundColor = UIColor.red
        userPhoto.frame = startingFrame
        
        view.addSubview(userPhoto)
        
        UIView.animate(withDuration: 0.75) { () -> Void in
            let height = (self.view.frame.width / self.startingFrame.width) * self.startingFrame.height

            let y = self.view.frame.height / 2 - height / 2

            self.userPhoto.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
        }
    }
    
    
}
