//
//  PhotosViewController.swift
//  VK Client
//
//  Created by Regina Galishanova on 28.12.2020.
//

import UIKit
import RealmSwift

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionV: UICollectionView!
    
    var token: NotificationToken?

//    var photos: [UserPhotos]? = []
    var friend: User!

    let countCellInCollect = 3
    let spacingBetweenCell = 3

    private let realmManager = RealmManager.shared

    var photos: Results<UserPhotos>?
//    {
//        let photos: Results<UserPhotos>? = realmManager?.getObjects()
//        return photos
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionV.register(UINib(nibName: "PhotosCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCell")
        
        collectionV.delegate = self
        collectionV.dataSource = self
        
        self.title = "\(friend.firstName)'s photos"
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        deleteAllRealmPhotoData()
        
        DispatchQueue.main.async {
            NetworkManager.network.getPhotosWithSwiftyJSON(token: Session.network.token, ownerId: String(self.friend.id)) { [weak self] (result) in
                guard let self = self else { return }
                switch result {

                case .success(let photosArray):
//                    self.photos = photosArray
                    print(photosArray)
                    self.savePhotoData(photosArray)
                    self.collectionV.reloadData()
                    
                case .failure(let error):
                    print(error)

                }
            }
        }
        
        pairPhotosCollectionsAndRealm()
        
        collectionV.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCell {
            
            if let photos = photos {
                cell.downLoadImage(from: photos[indexPath.row].photo_807)
                cell.likeLabel.text = String(photos[indexPath.row].likes)
                cell.photoController = self
            }

        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        print(frameCV)
        
        let widthCell = (frameCV.width - CGFloat(spacingBetweenCell) * CGFloat(countCellInCollect)) / CGFloat(countCellInCollect)
        
        let heightCell = widthCell
        
        return CGSize(width: widthCell, height: heightCell)
    }

    //полноэкранный просмотр коллекции фото друга
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()

    var userPhoto: UIImageView?
    
    func animateImageView(userPhoto: UIImageView) {

        self.userPhoto = userPhoto


        if let startingFrame = userPhoto.superview?.convert(userPhoto.frame, to: nil) {

            userPhoto.alpha = 0

            blackBackgroundView.frame = self.view.frame //черный задний фон за изображением
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)

            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 150)
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
            zoomImageView.image = userPhoto.image
            zoomImageView.contentMode = .scaleAspectFill
//            zoomImageView.clipsToBounds = true //размер = размеру фото в таблице
            view.addSubview(zoomImageView)

            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            navBarCoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            tabBarCoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))

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
        if let startingFrame = userPhoto!.superview?.convert(userPhoto!.frame, to: nil) {

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
                self.userPhoto?.alpha = 1
            }

        }
    }
    //saving data in realm
    func savePhotoData(_ photo: [UserPhotos]) {

        do {
            let realm = try Realm()

            print(realm.configuration.fileURL!)
            
            let oldPhotoData = realm.objects(UserPhotos.self)

            realm.beginWrite()
            
            realm.delete(oldPhotoData)

            realm.add(photo)

            try realm.commitWrite()
            
        } catch {
            print(error)
        }
    }
    
    func deleteAllRealmPhotoData() {
        do {
            let realm = try Realm()
            
            let photoData = realm.objects(UserPhotos.self)
            
            realm.beginWrite()
            
            realm.delete(photoData)
            
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
    }
    
    func pairPhotosCollectionsAndRealm() {
        guard let realm =  try? Realm() else { return }
        photos = realm.objects(UserPhotos.self)
        token = photos?.observe { [weak self] (changes: RealmCollectionChange) in
            guard self?.collectionV != nil else { return }
            switch changes {
            
            case .initial(let photos):
                print("Initialize \(photos.count)")
                self?.collectionV.reloadData()
                break
                
            case .update(let photos, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("""
                    New count \(photos.count)
                    Deletions \(deletions)
                    Insertions \(insertions)
                    Modifications \(modifications)
                    """
                    )
                self?.collectionV.performBatchUpdates({
                        
                    self?.collectionV.insertItems(at: insertions.map { IndexPath(item: $0, section: 0) })
                    self?.collectionV.deleteItems(at: deletions.map { IndexPath(item: $0, section: 0) })
                    self?.collectionV.reloadItems(at: modifications.map { IndexPath(item: $0, section: 0) })
                    
                }, completion: nil)
                break

            case .error(let error):
                print(error.localizedDescription)
                break
            }
        }
    }



//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(identifier: "FullScreenViewController") as! FullScreenViewController
//        vc.friend = friend
//        vc.indexPath = indexPath
//        self.navigationController?.pushViewController(vc, animated: true)
//
//    }

}

//extension PhotosViewController:
//    UIViewControllerTransitioningDelegate {
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return Animator(isDismissing: false)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return Animator(isDismissing: true)
//    }
//}
