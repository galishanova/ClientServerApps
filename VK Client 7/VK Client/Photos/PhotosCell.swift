//
//  PhotosCell.swift
//  VK Client
//
//  Created by Regina Galishanova on 28.12.2020.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var containerUserPhoto: UIView!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    
    var likes = UserPhotos().likes
    let view = UIView()
    var photoController: PhotosViewController?
    
    
    override func setNeedsUpdateConfiguration() {

    }
    
    override func prepareForReuse() {
        userPhoto.image = nil
        likeLabel.text = ""
        containerUserPhoto = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerUserPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        userPhoto.isUserInteractionEnabled = true
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.clipsToBounds = true
        addSubview(userPhoto)
        
    }
    
    func downLoadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.userPhoto.image = uiImage
                }
            }
        }.resume()
    }
    
    @IBAction func btnLikeClick(_ sender: UIButton) {
        //like count
        if btnLike.tag == 0 {
            btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            btnLike.tag = 1
            
//            self.likeLabel.text = "\(likes)"
        }
        else {
            btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
            btnLike.tag = 0
            
//            self.likeLabel.text = "\(likes.count)"
            
        }
        //like lbl & btn animation
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.likeView.transform = .init(scaleX: 1.25, y: 1.25)
        }) { (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.likeView.transform = .identity
            })
        }
    }
    
    @objc func animate() {
        photoController?.animateImageView(userPhoto: userPhoto)

    }
}


