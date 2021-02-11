//
//  FullScreenViewController.swift
//  VK Client
//
//  Created by Regina Galishanova on 31.01.2021.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let identifire = "FullScreenCell"
    var friends: [Friend]!
    var friend: Friend!
    var friendPhotos = [String]()
    var networkService: NetworkService!
    var indexPath : IndexPath!
    let countCell = 1
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "FullScreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifire)
                
        collectionView.performBatchUpdates(nil) { (result) in
            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkService = NetworkService()
        friends = networkService.getFriends()
    }

}

extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friendPhotos.append(friend.image)
        friendPhotos.append(contentsOf: friend.allImages)
        return friendPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as? FullScreenCollectionViewCell {
            cell.photoView.image = UIImage(named: friendPhotos[indexPath.row])
    

        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        print(frameCV)
        let widthCell = frameCV.width / CGFloat(countCell)
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
        
    
}
