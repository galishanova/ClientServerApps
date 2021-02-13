//
//  CustomPopAnimator.swift
//  VK Client
//
//  Created by Regina Galishanova on 02.02.2021.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey:.from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view) //возвр обратно с дестинейшн вью
        destination.view.frame = source.view.frame
        
        
        let translation = CGAffineTransform(translationX: 0, y: source.view.frame.height)
        let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
        destination.view.transform = translation.concatenating(scale)
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: 0, y: -source.view.frame.width / 2)

                let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
                source.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4) {

                source.view.transform = CGAffineTransform(translationX: 0, y: -source.view.frame.height)
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.75) {
                destination.view.transform = .identity //вернуть на свое место вью
                
            }
        } completion: { (isFinished) in
            let finishedAndNotCancelled = isFinished && !transitionContext.transitionWasCancelled // завершен и не был отменен
            
            if finishedAndNotCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            
            transitionContext.completeTransition(isFinished) //переход с экрана на экран завершен
        }


    }
    
}
