//
//  PostsTableViewCell.swift
//  VK Client
//
//  Created by Regina Galishanova on 17.01.2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var containerPostImageView: UIView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet weak var likeButtonPost: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var numberOfViewPost: UILabel!
    
    var newsController: NewsViewController?
    var likes = [Int]()
    
    static let identifier = "PostTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
    func setupViews() {
        backgroundColor = UIColor.white


        postImageView.isUserInteractionEnabled = true
        postImageView.contentMode = .scaleAspectFill
        postImageView.layer.masksToBounds = true
        addSubview(postImageView)
//        postImageView.clipsToBounds = true


    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerPostImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animatePost)))
    }
    
    func configure(with model: VKPost) {
        
        self.userNameLabel.text = model.uswerName
        self.userImageView.image = UIImage(named: model.userImageName)
        self.postImageView.image = UIImage(named: model.postImageName)
        self.likesLabel.text = model.numberOfLikes
        self.commentLabel.text = model.numberOfComments
        self.shareLabel.text = model.numberOfShare
        self.numberOfViewPost.text = model.numberOfViews

    }
    override func layoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.borderWidth = 1
        
    }
    
    @objc func animatePost(_ sender: UITapGestureRecognizer) {
        newsController?.animateImageView(postImageView: postImageView)
        
    }
    
    @IBAction func btnLikeClick(_ sender: UIButton) {
        //like count
        if likeButtonPost.tag == 0 {
            likeButtonPost.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButtonPost.tag = 1
            
//            likes.append(tag)
//            self.likesLabel.text = "\(likes.count)"
        }
        else {
            likeButtonPost.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButtonPost.tag = 0
            
//            likes.removeLast()
//            self.likesLabel.text = "\(likes.count)"
            
        }
        //like lbl & btn animation
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.likeButtonPost.transform = .init(scaleX: 1.25, y: 1.25)
        }) { (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.likeButtonPost.transform = .identity
            })
        }
    }
    
}
