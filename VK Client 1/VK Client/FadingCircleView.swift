//
//  fadingCircleView.swift
//  VK Client
//
//  Created by Regina Galishanova on 25.01.2021.
//

import UIKit

class FadingCircleView: UIView {
    
    let circle1 = UIView()
    let circle2 = UIView()
    let circle3 = UIView()
    var circleArray: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        circleArray = [circle1,circle2,circle3]
        
        for circle in circleArray {
            circle.frame = CGRect(x: -20, y: 5, width: 20, height: 20)
            circle.layer.cornerRadius = 10
            circle.backgroundColor = .white
            circle.alpha = 0
            
            addSubview(circle)
        }
    }
    func animate() {
        var delay: Double = 0
        for circle in circleArray {
            animateCircle(circle, delay: delay)
            delay += 0.2
        }
    }
    
    func animateCircle (_ circle: UIView, delay: Double) {
        UIView.animate(withDuration: 0.1, delay: delay, options: .curveLinear, animations: {
            circle.alpha = 1
            circle.frame = CGRect(x: 35, y: 5, width: 20, height: 20)
        }) { (completed) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                circle.frame = CGRect(x: 85, y: 5, width: 20, height: 20)
            }) { (completed) in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                    circle.alpha = 0
                    circle.frame = CGRect(x: 140, y: 5, width: 20, height: 20)
                }) { (completed) in
                    circle.frame = CGRect(x: -20, y: 5, width: 20, height: 20)
                    self.animateCircle(circle, delay: 0)
                }
            }
        }
    }

}
