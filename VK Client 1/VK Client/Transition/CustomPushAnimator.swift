//
//  CustomPushAnimator.swift
//  VK Client
//
//  Created by Regina Galishanova on 02.02.2021.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey:.from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: 0, y: -source.view.frame.height)
  
        
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) { //start screen
                let translation = CGAffineTransform(translationX: 0, y: source.view.frame.height)
   
                
                let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
//                let rotation = CGAffineTransform(rotationAngle: 0)
                source.view.transform = translation.concatenating(scale)
                print(source.view.transform)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.75) {//end screen
                let translation = CGAffineTransform(translationX: 0 , y: -source.view.frame.height / 2)
//                let rotation = CGAffineTransform(rotationAngle: 0)
                let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
                destination.view.transform = translation.concatenating(scale)
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                destination.view.transform = .identity //вернуть на свое место вью
                
            }
        } completion: { (isFinished) in
            let finishedAndNotCancelled = isFinished && !transitionContext.transitionWasCancelled // завершен и не был отменен
            
            if finishedAndNotCancelled {
                source.view.transform = .identity
            }
            
            transitionContext.completeTransition(isFinished) //переход с экрана на экран завершен
        }


    }
    
}
