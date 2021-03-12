//
//  AllCommunitiesCell.swift
//  VK Client
//
//  Created by Regina Galishanova on 26.12.2020.
//

import UIKit

class AllCommunitiesCell: UITableViewCell {

    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var communityIcon: UIImageView!
    @IBOutlet weak var containerCommunityIcon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        containerCommunityIcon.clipsToBounds = false
        containerCommunityIcon.layer.shadowColor = UIColor.black.cgColor
        containerCommunityIcon.layer.shadowOpacity = 0.5
        containerCommunityIcon.layer.shadowOffset = CGSize.zero
        containerCommunityIcon.layer.shadowRadius = 8
        containerCommunityIcon.layer.shadowPath = UIBezierPath(roundedRect: containerCommunityIcon.bounds, cornerRadius: 10).cgPath
        containerCommunityIcon.layer.cornerRadius = containerCommunityIcon.frame.width / 2

        communityIcon.clipsToBounds = true
        communityIcon.layer.cornerRadius = communityIcon.frame.width / 2

        containerCommunityIcon.addSubview(communityIcon)
    }
    
    func downLoadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.communityIcon.image = uiImage
                }
                
            }
        }.resume()
    }
    
}
