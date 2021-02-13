//
//  MyCommunitiesCell.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class MyCommunitiesCell: UITableViewCell {

    
    @IBOutlet weak var myCommunity: UILabel!
    @IBOutlet weak var myCommunityIcon: UIImageView!
    @IBOutlet weak var containerMyCommunityIcon: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerMyCommunityIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))


    }
    override func layoutSubviews() {
        containerMyCommunityIcon.clipsToBounds = false
        containerMyCommunityIcon.layer.shadowColor = UIColor.black.cgColor
        containerMyCommunityIcon.layer.shadowOpacity = 0.5
        containerMyCommunityIcon.layer.shadowOffset = CGSize.zero
        containerMyCommunityIcon.layer.shadowRadius = 8
        containerMyCommunityIcon.layer.shadowPath = UIBezierPath(roundedRect: containerMyCommunityIcon.bounds, cornerRadius: 10).cgPath
        containerMyCommunityIcon.layer.cornerRadius = containerMyCommunityIcon.frame.width / 2

        myCommunityIcon.clipsToBounds = true
        myCommunityIcon.layer.cornerRadius = myCommunityIcon.frame.width / 2

        containerMyCommunityIcon.addSubview(myCommunityIcon)
    }
    
    @IBAction func animate(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.containerMyCommunityIcon.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)

        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                self.containerMyCommunityIcon.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        }

}
