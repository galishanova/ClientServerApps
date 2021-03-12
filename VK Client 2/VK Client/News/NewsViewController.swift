//
//  NewsViewController.swift
//  VK Client
//
//  Created by Regina Galishanova on 17.01.2021.
//

import UIKit
struct VKPost {
    
    let uswerName: String
    let userImageName: String
    let postImageName: String
    let numberOfLikes: String
    let numberOfShare: String
    let numberOfComments: String
    let numberOfViews: String
}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var table: UITableView!
    var models = [VKPost]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        models.append(VKPost(uswerName: "Jenner Kylie", userImageName: "jenner", postImageName: "jenner4", numberOfLikes: "6.4M", numberOfShare: "2.6K", numberOfComments: "2.3K", numberOfViews: "9.4M"))
        models.append(VKPost(uswerName: "McGregor Conor", userImageName: "conor", postImageName: "conor4", numberOfLikes: "2.6M", numberOfShare: "46K", numberOfComments: "863K", numberOfViews: "7.2M"))
        models.append(VKPost(uswerName: "Apple", userImageName: "apple", postImageName: "iphone12", numberOfLikes: "12K", numberOfShare: "2K", numberOfComments: "4K", numberOfViews: "24K"))
        models.append(VKPost(uswerName: "Travel Russia", userImageName: "rus trav", postImageName: "rus trav 2", numberOfLikes: "425", numberOfShare: "43", numberOfComments: "24", numberOfViews: "2K"))
        models.append(VKPost(uswerName: "Grande Ariana", userImageName: "grande", postImageName: "grande2", numberOfLikes: "2.6M", numberOfShare: "947K", numberOfComments: "376K", numberOfViews: "4M"))
        models.append(VKPost(uswerName: "Sport", userImageName: "sport", postImageName: "sport2", numberOfLikes: "836", numberOfShare: "56", numberOfComments: "359", numberOfViews: "32K"))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(with: models[indexPath.row])
        cell.newsController = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()

    var postImageView: UIImageView?
    
    func animateImageView(postImageView: UIImageView) {
        self.postImageView = postImageView
        
        if let startingFrame = postImageView.superview?.convert(postImageView.frame, to: nil) {

            postImageView.alpha = 0 //выносит фото
                
            blackBackgroundView.frame = self.view.frame //черный задний фон за изображением
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            let navBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (navigationController?.navigationBar.frame.height ?? 0.0)
            let navBarWidth = UIApplication.shared.statusBarFrame.size.height +
                (navigationController?.navigationBar.frame.width ?? 0.0)
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: navBarWidth, height: navBarHeight)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0

            if let keyWindow = UIApplication.shared.keyWindow { //спрятать tabbar & navbar
                keyWindow.addSubview(navBarCoverView)
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 100, width: 1000, height: 100)
                tabBarCoverView.backgroundColor = UIColor.black
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = postImageView.image
            zoomImageView.contentMode = .scaleAspectFill
//            zoomImageView.clipsToBounds = true //размер = размеру фото в таблице
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))

            UIView.animate(withDuration: 0.3) { () -> Void in
                //положение увеличенного изобр-я
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height) //размер изобр
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            }
        }
    }
    
    @objc func zoomOut() {
        if let startingFrame = postImageView!.superview?.convert(postImageView!.frame, to: nil) {

            UIView.animate(withDuration: 0.3) {
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
                
            } completion: { (didComplete) in
                
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                self.postImageView?.alpha = 1
            }

        }
    }
    
}


