//
//  ZoomPostPhotoView.swift
//  VK Client
//
//  Created by Regina Galishanova on 30.01.2021.
//

import UIKit

class ZoomPostPhotoView: UIView {
    let imageView: UIImageView!
    var startingFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
    let view = UIView()
    

    func setupViews() {
        backgroundColor = UIColor.white
        addSubview(imageView)

        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomImage)))
//        imageView.clipsToBounds = true
    }


    private func animatedImage() {
        imageView.backgroundColor = UIColor.red
        imageView.frame = startingFrame

        addSubview(imageView)

        UIView.animate(withDuration: 0.75) { () -> Void in
            let height = (self.view.frame.width / self.startingFrame.width) * self.startingFrame.height

            let y = self.view.frame.height / 2 - height / 2

            self.imageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
        }
    }

    @objc private func zoomImage(_ recognizer: UITapGestureRecognizer) {
        animatedImage()
    }
}

